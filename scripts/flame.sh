#!/bin/bash
# Використання: ./flame.sh matmul_O0
PROG=$1
echo "1) Запис профілю perf (999 разів на секунду, зі стеками викликів)"
sudo perf record -e cpu-clock -F 999 -g -o results/$PROG.data ./$PROG
echo "2) Перетворення бінарних даних perf у текстові стеки"
sudo perf script -i results/$PROG.data > results/$PROG.perf
echo "3) Згортання однакових стеків (stackcollapse-perf.pl)"
~/FlameGraph/stackcollapse-perf.pl results/$PROG.perf > results/$PROG.folded
echo "4) Побудова SVG-графіка (flamegraph.pl)"
~/FlameGraph/flamegraph.pl results/$PROG.folded > results/flame_$PROG.svg
echo "Готово: results/flame_$PROG.svg"
