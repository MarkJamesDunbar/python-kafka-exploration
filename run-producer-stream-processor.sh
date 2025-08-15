#!/bin/bash
# Start producer in background, then run stream processor in foreground
cd "$(dirname "$0")/kafka-producer-example" || exit 1
nohup python main.py > ../producer.log 2>&1 &
PRODUCER_PID=$!
cd ../kafka-stream-processing-example || exit 1
python main.py
# Optionally kill producer after processor exits
# kill $PRODUCER_PID
