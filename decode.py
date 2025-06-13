import os
import json
import random
import argparse
# from torch.profiler import ProfilerActivity
# from torch.profiler import profile as torch_profile
# from torch.profiler import record_function
import numpy as np
from tqdm import tqdm
from datasets import load_dataset
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer
import time

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    
    parser.add_argument("--seed", type=int, default=42, help="")
    parser.add_argument("--base_dir", type=str, default="")
    parser.add_argument("--dataset", type=str, default="")
    parser.add_argument("--data_file", type=str, default="")
    parser.add_argument("--save_dir", type=str, default="")

    parser.add_argument("--model_name", type=str, default=None, help="if specified, we will load the model to generate the predictions.")
    parser.add_argument("--model_path", type=str, default=None, help="if specified, we will load the model to generate the predictions.")
    parser.add_argument("--use_fast_tokenizer", type=bool, default=True, help="")
    parser.add_argument("--output_attentions", type=bool, default=False, help="")
    
    parser.add_argument("--max_num_examples", type=int, default=None, help="maximum number of examples to evaluate per task.")
    parser.add_argument("--sample_method", type=str, default="topk", choices=["random", "topk"], help="how to sample the examples.")
    
    parser.add_argument("--max_new_tokens", type=int, default=None, help="")
    
    parser.add_argument("--eval_batch_size", type=int, default=1, help="batch size for evaluation.")
    
    parser.add_argument("--use_cache", type=bool, default=True, help="")
    parser.add_argument("--attn_implementation", type=str,  default="flash_attention_2", choices=["flash_attention_2", "sdpa", "eager"])
    parser.add_argument("--method", type=str,  default=None)
    parser.add_argument("--quant_method",type=str,default=None,choices=["kivi","kvquant"])
    parser.add_argument("--nbits", type=int, default=8, help="")
    parser.add_argument("--max_capacity_prompts", type=int, default=512, help="")
    parser.add_argument("--max_capacity_prompts_ratio", type=float, default=-1, help="")
    parser.add_argument("--steps", type=int, default=-1, help="maximum number of examples to evaluate per task.")
    parser.add_argument("--merge", type=str, default=None, help="kv merge method(look-m)")
    parser.add_argument('--floor', type=float, default=0.2, help='hyper-parameter used in AdaKV')
    parser.add_argument('--head_path', type=str, default='./data/heads_score/Meta-Llama-3-8B-Instruct_retrieval_reasoning_heads.json', help='Path to head score (HeadKV)')
    parser.add_argument('--head_beta', type=float, default=1.01, help='hyper-parameter used on HeadKV')
    parser.add_argument("--recent_size", type=int, default=32, help="")
    parser.add_argument("--pruning_ratio", type=float, default=0.4, help="pruning ratio of Key Cache")

    parser.add_argument("--input_length", type=int, default=8000, help="")
    parser.add_argument("--output_length", type=int, default=338, help="")
    
    args = parser.parse_args()
    
    filename = f'{args.save_dir}/{args.method}_{args.pruning_ratio}_{args.max_capacity_prompts}_{args.input_length}_{args.output_length}.json'
    # if os.path.exists(filename):
    #     print(f"Save file {filename} already exists.")
    #     exit(0)
    # # else:
    os.makedirs(args.save_dir, exist_ok=True)
    # set_seed(args.seed)

    tokenizer = AutoTokenizer.from_pretrained(
        args.model_path,
        use_fast=args.use_fast_tokenizer,
        padding_side="left"
    )
    tokenizer.padding_side = "left"
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token
        tokenizer.pad_token_id = tokenizer.eos_token_id

    from pyramidkv.monkeypatch import replace_llama,replace_mistral
    replace_llama(args.method.lower())
    replace_mistral(args.method.lower())

    model = AutoModelForCausalLM.from_pretrained(
        args.model_path,
        torch_dtype=torch.bfloat16,
        low_cpu_mem_usage=True,
        device_map="auto",
        use_cache=args.use_cache,
        attn_implementation=args.attn_implementation
    )
    # model = AutoModelForCausalLM.from_pretrained(
    #     args.model_path,
    #     torch_dtype=torch.float16,
    #     low_cpu_mem_usage=True,
    #     device_map="auto",
    #     use_cache=args.use_cache,
    #     attn_implementation=args.attn_implementation
    # )
    

    if args.max_capacity_prompts != -1:
        max_capacity_prompts = args.max_capacity_prompts
    elif args.max_capacity_prompts_ratio != -1:
        max_capacity_prompts = round(batch_input_ids.shape[1] * args.max_capacity_prompts_ratio)

    if args.method != "FullKV":
        
        if args.method.lower() in ["snapkv","pyramidkv","h2o","cam", "l2norm", "adakv", "headkv", "think", "adathink"]:
            window_sizes = 32
        elif args.method.lower() in ["streamingllm"]:
            window_sizes = max_capacity_prompts - 4

        if args.method.lower() =='headkv':
            with open(args.head_path, 'r') as file:
                head_list = json.loads(file.readline())
            head_score_list = [np.mean(l[1]) for l in head_list.items()]
            head_score_list = torch.tensor(head_score_list / sum(head_score_list))
            total_attention = head_score_list.reshape(model.config.num_hidden_layers, model.config.num_attention_heads)
            total_pool_capacity = (args.max_capacity_prompts // args.head_beta) * model.config.num_hidden_layers * model.config.num_attention_heads
            min_num = (args.max_capacity_prompts - args.max_capacity_prompts // args.head_beta)
            head_capacity = torch.round(total_attention * total_pool_capacity + min_num).int()
            model.model.config.head_capacity = head_capacity    

        kernel_sizes = 7
        pooling = "maxpool"
        ratio = args.pruning_ratio
        recent_size = args.recent_size

        layers = len(model.model.layers)
        # check if window_sizes is a list
        if not isinstance(window_sizes, list):
            window_sizes = [window_sizes] * layers
        if not isinstance(max_capacity_prompts, list):
            max_capacity_prompts = [max_capacity_prompts] * layers
        if not isinstance(kernel_sizes, list):
            kernel_sizes = [kernel_sizes] * layers
        if not isinstance(ratio, list):
            ratio = [ratio] * layers
        if not isinstance(recent_size, list):
            recent_size = [recent_size] * layers
        for i in range(layers):
            model.model.layers[i].self_attn.config.window_size = window_sizes[i]
            model.model.layers[i].self_attn.config.max_capacity_prompt = max_capacity_prompts[i]
            model.model.layers[i].self_attn.config.kernel_size = kernel_sizes[i]
            model.model.layers[i].self_attn.config.pooling = pooling
            model.model.layers[i].self_attn.config.merge = args.merge
            model.model.layers[i].self_attn.config.floor = args.floor
            model.model.layers[i].self_attn.config.ratio = ratio[i]
            model.model.layers[i].self_attn.config.recent_size = recent_size[i]

        print(f'residual_length: {recent_size[0]}, pruning_ratio: {ratio[0]}, window_size: {window_sizes[0]}, max_capacity_prompts: {max_capacity_prompts[0]}')

    context = []
    batch_size = 1
    prompt_length = args.input_length
    output_length = args.output_length
    num_repeats = 5
    for _ in range(batch_size):
        string = 'who are you? ' * (prompt_length // 4)
        string = 't, ' * (prompt_length // 2)
        context.append(string[:-1])
    # vocab_keys = list(tokenizer.get_vocab().keys())
    # for _ in range(batch_size):
    #     chosen_words = random.choices(vocab_keys, k=prompt_length)
    #     current_context_string = " ".join(chosen_words)
    #     context.append(current_context_string)
    inputs = tokenizer(context, padding="longest", return_tensors="pt", add_special_tokens=True).to('cuda')
    input_ids = inputs['input_ids']
    print("Input IDs shape:", input_ids.shape)


    model.eval()

    # warm up
    for i in range(3):
        outputs = model.generate(**inputs, max_new_tokens=output_length)

    ttfts, latency, tpss, latency_dec, tpss_dec = 0, 0, 0, 0, 0
    torch.cuda.reset_peak_memory_stats()
    with torch.no_grad():
        for i in range(num_repeats):

            torch.cuda.synchronize()
            start_time = time.time()
            _ = model.generate(**inputs, max_new_tokens=1)
            torch.cuda.synchronize()
            ttft = time.time() - start_time

            torch.cuda.synchronize()
            start_time = time.time()
            outputs = model.generate(**inputs, max_new_tokens=output_length)
            torch.cuda.synchronize()
            total_time = time.time() - start_time

            num_generated_tokens = outputs.shape[1] - input_ids.shape[1]

            # latency per token (seconds/token)
            latency_per_token_dec = (total_time - ttft) / num_generated_tokens
            # tokens per second
            tps_dec = num_generated_tokens / (total_time - ttft)

            # latency per token (seconds/token)
            latency_per_token = total_time/ num_generated_tokens
            # tokens per second
            tps = num_generated_tokens / total_time

            ttfts += ttft
            latency_dec += latency_per_token_dec
            tpss_dec += tps_dec
            latency += latency_per_token
            tpss += tps
        
        ttft = ttfts / num_repeats
        latency_dec = latency_dec / num_repeats
        tpss_dec = tpss_dec / num_repeats
        latency = latency / num_repeats
        tpss = tpss / num_repeats

        print(f'Average ttft: {ttft * 1000:.2f} ms')
        print(f'Average latency per token: {latency * 1000:.2f} ms')
        print(f'Average tps: {tpss:.2f} tokens/s')

        used_mem = torch.cuda.max_memory_allocated()
        print(f'peak mem: {used_mem / 1024 ** 3} GB')

    torch.cuda.empty_cache()
    result_dict = {
        "inference_method": args.method.lower(),
        "prompt_length": input_ids.shape[1],
        "generation_length": output_length,
        "max_capacity_prompts": args.max_capacity_prompts,
        "pruning_ratio": args.pruning_ratio,
        "ttft": ttft * 1000,
        "latency_per_token_dec": latency_dec * 1000,
        "latency_per_token": latency * 1000,
        "inference_time": total_time * 1000,
        "tps_dec": tpss_dec,
        "tps": tpss,
        "peak_mem": used_mem / 1024 ** 3,
    }
    print(json.dumps(result_dict, indent=4))

    with open(filename, 'w') as f:
        json.dump(result_dict, f, indent=4)

    # breakpoint()
   
# used time: 21405.880848566692 ms
# peak mem: 15.506203174591064 GB