
# PyramidKV, SnapKV, H2O, StreamingLLM, cam, L2Norm, thinK FullKV


ins=(2000)
outs=(50)
batch_size=(1 2 4 8 16)

for lin in "${ins[@]}"
  do 
    for lout in "${outs[@]}"
      do
      for bs in "${batch_size[@]}"
        do
        echo "Running with input length: $lin and output length: $lout and batch size: $bs"

        if [ ! -f "results_bs/${bs}/results_long_bench/FullKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 FullKV 0.5 128 $lin $lout $bs >  logs_bs/FullKV_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/SnapKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 SnapKV 0.5 128 $lin $lout $bs >  logs_bs/SnapKV_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 ThinK 0.5 128 $lin $lout $bs >  logs_bs/ThinK_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.5 128 $lin $lout $bs >  logs_bs/AdaThinK_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 ThinK 0.8 128 $lin $lout $bs >  logs_bs/ThinK_0.8_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.8 128 $lin $lout $bs >  logs_bs/AdaThinK_0.8_128_${lin}_${lout}_$bs.log
        fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/SnapKV_0.5_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 SnapKV 0.5 512 $lin $lout $bs >  logs_bs/SnapKV_0.5_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.5_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 ThinK 0.5 512 $lin $lout $bs >  logs_bs/ThinK_0.5_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.8_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.8 512 $lin $lout $bs >  logs_bs/AdaThinK_0.8_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.5_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.5 512 $lin $lout $bs >  logs_bs/AdaThinK_0.5_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.8_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 ThinK 0.8 512 $lin $lout $bs >  logs_bs/ThinK_0.8_512_${lin}_${lout}_$bs.log
        # fi
        done
      done
  done

batch_size=(32 64 128)

for lin in "${ins[@]}"
  do 
    for lout in "${outs[@]}"
      do
        for bs in "${batch_size[@]}"
        do
        echo "Running with input length: $lin and output length: $lout and batch size: $bs"

        if [ ! -f "results_bs/${bs}/results_long_bench/FullKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 FullKV 0.5 128 $lin $lout $bs >  logs_bs/FullKV_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/SnapKV_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 SnapKV 0.5 128 $lin $lout $bs >  logs_bs/SnapKV_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 ThinK 0.5 128 $lin $lout $bs >  logs_bs/ThinK_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.5_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.5 128 $lin $lout $bs >  logs_bs/AdaThinK_0.5_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 ThinK 0.8 128 $lin $lout $bs >  logs_bs/ThinK_0.8_128_${lin}_${lout}_$bs.log
        fi
        if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.8_128_${lin}_${lout}.json" ]; then
            bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.8 128 $lin $lout $bs >  logs_bs/AdaThinK_0.8_128_${lin}_${lout}_$bs.log
        fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/SnapKV_0.5_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 SnapKV 0.5 512 $lin $lout $bs >  logs_bs/SnapKV_0.5_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.5_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 ThinK 0.5 512 $lin $lout $bs >  logs_bs/ThinK_0.5_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.8_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.8 512 $lin $lout $bs >  logs_bs/AdaThinK_0.8_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/AdaThinK_0.5_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 AdaThinK 0.5 512 $lin $lout $bs >  logs_bs/AdaThinK_0.5_512_${lin}_${lout}_$bs.log
        # fi
        # if [ ! -f "results_bs/${bs}/results_long_bench/ThinK_0.8_512_${lin}_${lout}.json" ]; then
        #     bash scripts/scripts_longBench/pro.sh 0 ThinK 0.8 512 $lin $lout $bs >  logs_bs/ThinK_0.8_512_${lin}_${lout}_$bs.log
        # fi
        done
      done
  done