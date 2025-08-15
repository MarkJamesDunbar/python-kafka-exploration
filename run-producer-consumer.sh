#!/bin/bash
# Start producer in background, then run consumer in foreground
cd "$(dirname "$0")/kafka-producer-example" || exit 1
nohup python main.py > ../producer.log 2>&1 &
PRODUCER_PID=$!
cd ../kafka-consumer-example || exit 1
python main.py
# Optionally kill producer after consumer exits
# kill $PRODUCER_PID
