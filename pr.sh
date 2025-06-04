
# PyramidKV, SnapKV, H2O, StreamingLLM, cam, L2Norm, thinK FullKV


ins=(16000 8000 2000)
outs=(32 100 338)

for lin in "${ins[@]}"
  do 
    for lout in "${outs[@]}"
      do
        echo "Running with input length: $lin and output length: $lout"

        if [ ! -f "results/results_long_bench/FullKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 FullKV 0.5 128 $lin $lout > logs/FullKV_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/SnapKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 SnapKV 0.5 128 $lin $lout > logs/SnapKV_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 ThinK 0.5 128 $lin $lout > logs/ThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 AdaThinK 0.5 128 $lin $lout > logs/AdaThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 ThinK 0.8 128 $lin $lout > logs/ThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 AdaThinK 0.8 128 $lin $lout > logs/AdaThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/SnapKV_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 SnapKV 0.5 512 $lin $lout > logs/SnapKV_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 ThinK 0.5 512 $lin $lout > logs/ThinK_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.8_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 AdaThinK 0.8 512 $lin $lout > logs/AdaThinK_0.8_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 AdaThinK 0.5 512 $lin $lout > logs/AdaThinK_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.8_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/eval.sh 0 ThinK 0.8 512 $lin $lout > logs/ThinK_0.8_512_${lin}_${lout}.log
        fi

      done
  done

