export CUDA_VISIBLE_DEVICES=$1

method=$2 # Support PyramidKV, SnapKV, H2O, StreamingLLM, CAM, L2Norm, ThinK
pruning_ratio=${3:-"0.4"} # Support 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9
max_capacity_prompts=${4:-"512"} # 128,2048 in paper
attn_implementation=eager # Support "flash_attention_2", "sdpa", "eager".
source_path=results/
model_path="meta-llama/Meta-Llama-3-8B-Instruct"

input_length=${5:-"14000"} # Support 128, 512, 1024, 2048, 4096, 8192, 16384
output_length=${6:-"338"} # Support 128, 512, 1024, 2048, 4096, 8192, 16384
# merge_method=$7 # Support "pivot"(LOOK-M_PivotMerge).
# quant_method=$7 # Support kivi and kvquant, default None.
# nbits=$8 # Quantization bit-width support 8,4,2. Need to set quant_method first.
save_dir=${source_path}"results_long_bench" # path to result save_dir
# run_longbench
python3 -u ee.py \
    --method ${method} \
    --model_path ${model_path} \
    --max_capacity_prompts ${max_capacity_prompts} \
    --attn_implementation ${attn_implementation} \
    --save_dir ${save_dir} \
    --pruning_ratio ${pruning_ratio} \
    --input_length ${input_length} \
    --output_length ${output_length} \
    # --merge ${merge_method} \
    # --nbits ${nbits} \
    # --quant_method ${quant_method}
