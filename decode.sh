
# PyramidKV, SnapKV, H2O, StreamingLLM, cam, L2Norm, thinK FullKV


# bash scripts/scripts_longBench/decode.sh 0 FullKV 0.5 128 28000 338 > logs_dec/${model_name}/${attn_implementation}/FullKV_0.5_128_28000_338.log
# # 53399 77061 77061

# bash scripts/scripts_longBench/decode.sh 0 AdaThinK 0.8 128 31500 100 > logs_dec/${model_name}/${attn_implementation}/AdaThinK_0.8_128_31500_100.log
# # 53701 53667  76193  78145

# bash scripts/scripts_longBench/decode.sh 0 ThinK 0.8 128 24500 32 > logs_dec/${model_name}/${attn_implementation}/ThinK_0.8_128_24000_32.log
# 53701 53667

ins=(3200 64000)
# ins=(12000 8192 4096)
outs=(32 100 338 512)
model_name="llama3-8b-inst"
attn_implementation="flash_attention_2"
# attn_implementation="eager"
model_name="llama2-7b-chat"

mkdir -p logs_dec/${model_name}/${attn_implementation}
for lin in "${ins[@]}"
  do 
    for lout in "${outs[@]}"
      do
        echo "Running with input length: $lin and output length: $lout"

        
        if [ ! -f "results_dec/${model_name}/${attn_implementation}/results_long_bench/ThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/decode.sh 0 ThinK 0.5 128 $lin $lout  ${model_name} ${attn_implementation} > logs_dec/${model_name}/${attn_implementation}/ThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results_dec/${model_name}/${attn_implementation}/results_long_bench/AdaThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/decode.sh 0 AdaThinK 0.5 128 $lin $lout  ${model_name} ${attn_implementation} > logs_dec/${model_name}/${attn_implementation}/AdaThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results_dec/${model_name}/${attn_implementation}/results_long_bench/ThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/decode.sh 0 ThinK 0.8 128 $lin $lout  ${model_name} ${attn_implementation} > logs_dec/${model_name}/${attn_implementation}/ThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results_dec/${model_name}/${attn_implementation}/results_long_bench/AdaThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/decode.sh 0 AdaThinK 0.8 128 $lin $lout  ${model_name} ${attn_implementation} > logs_dec/${model_name}/${attn_implementation}/AdaThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results_dec/${model_name}/${attn_implementation}/results_long_bench/FullKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/decode.sh 0 FullKV 0.5 128 $lin $lout  ${model_name} ${attn_implementation} > logs_dec/${model_name}/${attn_implementation}/FullKV_0.5_128_${lin}_${lout}.log
        fi

        if [ ! -f "results_dec/${model_name}/${attn_implementation}/results_long_bench/SnapKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/decode.sh 0 SnapKV 0.5 128 $lin $lout  ${model_name} ${attn_implementation} > logs_dec/${model_name}/${attn_implementation}/SnapKV_0.5_128_${lin}_${lout}.log
        fi

      done
  done



python ../task/auto.py