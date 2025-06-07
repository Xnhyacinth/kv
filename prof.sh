
# PyramidKV, SnapKV, H2O, StreamingLLM, cam, L2Norm, thinK FullKV


ins=(26000 20000 16000)
outs=(32 100 338)

for lin in "${ins[@]}"
  do 
    for lout in "${outs[@]}"
      do
        echo "Running with input length: $lin and output length: $lout"

        if [ ! -f "results/results_long_bench/FullKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 FullKV 0.5 128 $lin $lout > logs/FullKV_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/SnapKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 SnapKV 0.5 128 $lin $lout > logs/SnapKV_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 ThinK 0.5 128 $lin $lout > logs/ThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 128 $lin $lout > logs/AdaThinK_0.5_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 ThinK 0.8 128 $lin $lout > logs/ThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.8 128 $lin $lout > logs/AdaThinK_0.8_128_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/SnapKV_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 SnapKV 0.5 512 $lin $lout > logs/SnapKV_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 ThinK 0.5 512 $lin $lout > logs/ThinK_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.8_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.8 512 $lin $lout > logs/AdaThinK_0.8_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/AdaThinK_0.5_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 512 $lin $lout > logs/AdaThinK_0.5_512_${lin}_${lout}.log
        fi
        if [ ! -f "results/results_long_bench/ThinK_0.8_512_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/ee.sh 0 ThinK 0.8 512 $lin $lout > logs/ThinK_0.8_512_${lin}_${lout}.log
        fi
        # bash scripts/scripts_longBench/ee.sh 0 FullKV 0.5 128 $lin $lout > logs/FullKV_0.5_128_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 SnapKV 0.5 128 $lin $lout > logs/SnapKV_0.5_128_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.5 128 $lin $lout > logs/ThinK_0.5_128_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 128 $lin $lout > logs/AdaThinK_0.5_128_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.8 128 $lin $lout > logs/ThinK_0.8_128_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.8 128 $lin $lout > logs/AdaThinK_0.8_128_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 SnapKV 0.5 512 $lin $lout > logs/SnapKV_0.5_512_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.5 512 $lin $lout > logs/ThinK_0.5_512_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.8 512 $lin $lout > logs/AdaThinK_0.8_512_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 512 $lin $lout > logs/AdaThinK_0.5_512_${lin}_${lout}.log

        # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.8 512 $lin $lout > logs/ThinK_0.8_512_${lin}_${lout}.log
      done
  done

# for lin in "${ins[@]}"
#   do 
#     for lout in "${outs[@]}"
#       do
#         echo "Running with input length: $lin and output length: $lout"

#         bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 128 $lin $lout > logs/AdaThinK_0.5_128_${lin}_${lout}.log
#       done
#   done


# bash scripts/scripts_longBench/ee.sh 0 FullKV > logs/FullKV.log

# bash scripts/scripts_longBench/ee.sh 0 SnapKV 0.5 128 > logs/SnapKV_0.5_128.log

# bash scripts/scripts_longBench/ee.sh 0 ThinK 0.5 128 > logs/ThinK_0.5_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.8 512 > logs/AdaThinK_0.8_512.log

# # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.8 128 > logs/ThinK_0.8_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.8 128 > logs/AdaThinK_0.8_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.7 128 > logs/AdaThinK_0.7_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.6 128 > logs/AdaThinK_0.6_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 128 > logs/AdaThinK_0.5_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.4 128 > logs/AdaThinK_0.4_128.log

# # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.7 128 > logs/ThinK_0.7_128.log

# # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.6 128 > logs/ThinK_0.6_128.log

# # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.5 128 > logs/ThinK_0.5_128.log

# # bash scripts/scripts_longBench/ee.sh 0 ThinK 0.4 128 > logs/ThinK_0.4_128.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.7 512 > logs/AdaThinK_0.7_512.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.6 512 > logs/AdaThinK_0.6_512.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.5 512 > logs/AdaThinK_0.5_512.log

# bash scripts/scripts_longBench/ee.sh 0 AdaThinK 0.4 512 > logs/AdaThinK_0.4_512.log







# bash scripts/scripts_longBench/ee.sh 6,7 AdaThinK