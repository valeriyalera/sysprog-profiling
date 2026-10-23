#!/bin/bash
# Використання: ./measure.sh mm_O0 27
PROG=$1; N=$2
sudo powermetrics --samplers cpu_power,tasks --show-process-energy -i 1000 -n $N > results/run_$PROG.txt &
sleep 2
START=$(date +%s)
./$PROG
END=$(date +%s)
echo "$PROG: $((END-START)) c" | tee results/runtime_$PROG.txt
wait
