#!/usr/bin/env bash

BENCHMARK_DIR=/benchmarks
WORKLOAD_NAME=pagerank

read -r -d '' USAGE << EOS
Usage: graph-analytics [SPARK_OPTIONS]

  SPARK_OPTIONS are passed on to spark-submit.
EOS

strace -f -ttt -T -o strace.out ${SPARK_HOME}/bin/spark-submit "$@" \
    --class "GraphAnalytics" \
    ${BENCHMARK_DIR}/graph-analytics_2.11-1.0.jar \
    -app="${WORKLOAD_NAME}"
echo "DONE"
sleep 100000
