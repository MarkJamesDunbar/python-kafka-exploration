#!/bin/bash

# This script starts the Kafka service using Docker Compose, waits for Kafka to be ready, and then runs the Python app.

set -e

KAFKA_DIR="$(dirname "$0")/../kafka-local"
APP_DIR="$(dirname "$0")"

# Start Kafka with Docker Compose
echo "Starting Kafka..."
docker-compose -f "$KAFKA_DIR/docker-compose.yml" up -d

# Wait for Kafka to be ready
function wait_for_kafka() {
    echo "Waiting for Kafka to be ready..."
    for i in {1..30}; do
        # Try to connect to Kafka port
        nc -z localhost 9092 && echo "Kafka is up!" && return 0
        sleep 2
    done
    echo "Kafka did not start in time." >&2
    return 1
}

wait_for_kafka

# Run the Python app
echo "Running Python app..."
python3 "$APP_DIR/main.py"
