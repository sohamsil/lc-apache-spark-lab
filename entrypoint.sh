#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD : $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then
    start-master.sh -p 7077 &
    jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root 
elif [ "$SPARK_WORKLOAD" == "worker" ];
then
    start-worker.sh spark://spark-master:7077
elif [ "$SPARK_WORKLOAD" == "history" ];
then 
    start-history-server.sh
elif [ "$SPARK_WORKLOAD" == "jupyter" ];
then 
    jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
else
    echo "Undefined Workload Type $SPARK_WORKLOAD, must specify: master, worker, history, jupyter"
fi
