#!/bin/bash
# Stop Kafka and Redpanda Console
cd "$(dirname "$0")/kafka-local" || exit 1
docker-compose down
cd ..
echo "Kafka and Redpanda Console stopped."
