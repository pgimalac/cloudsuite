#!/bin/bash
set -e

if [ "$1" = "bash" ]; then
  $@
else
  cd /root/run && strace -f -ttt -T -o strace.out ./benchmark.sh $1
fi
echo "DONE"
sleep 100000
