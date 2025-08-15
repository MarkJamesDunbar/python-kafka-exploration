#!/bin/bash
# Start Kafka and Redpanda Console
cd "$(dirname "$0")/kafka-local" || exit 1
docker-compose up -d
cd ..
echo "Kafka and Redpanda Console started."
