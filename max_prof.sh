
# PyramidKV, SnapKV, H2O, StreamingLLM, cam, L2Norm, thinK FullKV


bash scripts/scripts_longBench/ee.sh 1 FullKV 0.5 128 28000 338 > logs/FullKV_0.5_128_28000_338.log
# # 53399 77061 77061

# bash scripts/scripts_longBench/ee.sh 1 AdaThinK 0.8 128 31500 100 > logs/AdaThinK_0.8_128_31500_100.log
# # 53701 53667  76193  78145

# bash scripts/scripts_longBench/ee.sh 1 ThinK 0.8 128 24500 32 > logs/ThinK_0.8_128_24000_32.log
# 53701 53667

ins=(31500)
outs=(32 100 338 512)

for lin in "${ins[@]}"
  do 
    for lout in "${outs[@]}"
      do
        echo "Running with input length: $lin and output length: $lout"

        # if [ ! -f "results/results_long_bench/FullKV_0.5_128_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/ee.sh 1 FullKV 0.5 128 $lin $lout > logs/FullKV_0.5_128_${lin}_${lout}.log
        # fi
        if [ ! -f "results/results_long_bench/SnapKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 SnapKV 0.5 128 $lin $lout > logs/SnapKV_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 ThinK 0.5 128 $lin $lout > logs/ThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 AdaThinK 0.5 128 $lin $lout > logs/AdaThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 ThinK 0.8 128 $lin $lout > logs/ThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 AdaThinK 0.8 128 $lin $lout > logs/AdaThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/SnapKV_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 SnapKV 0.5 512 $lin $lout > logs/SnapKV_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 ThinK 0.5 512 $lin $lout > logs/ThinK_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.8_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 AdaThinK 0.8 512 $lin $lout > logs/AdaThinK_0.8_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 AdaThinK 0.5 512 $lin $lout > logs/AdaThinK_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.8_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 1 ThinK 0.8 512 $lin $lout > logs/ThinK_0.8_512_${lin}_${lout}.log
        fi

      done
  done

