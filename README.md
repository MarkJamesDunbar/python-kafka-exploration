# python-kafka-exploration: Running Examples & Practical Kafka Tips

This repo is a collection of hands-on Kafka experiments in Python. Each folder is a standalone example. The goal is to make it easy to run, debug, and learn from real Kafka usage.

## How to Run Any Example

1. **Start Kafka**
   - From repo root, run:
     ```bash
     cd kafka-local
     docker-compose up -d
     ```
   - This launches a local Kafka broker (KRaft mode, no Zookeeper).

2. **Run an Example**
   - Go into the example folder (e.g. `writing-to-kafka-example`):
     ```bash
     cd writing-to-kafka-example
     bash start_kafka_and_app.sh
     ```
   - Each example has its own script and code.

3. **Stop Kafka**
   - From repo root:
     ```bash
     cd kafka-local
     docker-compose down
     ```

## Useful Kafka Findings & Debugging Tips

### kcat: The Best CLI for Kafka

- Install with Homebrew: `brew install kcat`
- Consume messages:
  ```bash
  kcat -b localhost:9092 -t weather_data_demo -C
  ```
- Produce messages:
  ```bash
  echo '{"test": "message"}' | kcat -b localhost:9092 -t weather_data_demo -P
  ```
- See topic metadata:
  ```bash
  kcat -b localhost:9092 -L
  ```

### Other Useful CLI Commands

- List all topics:
  ```bash
  kcat -b localhost:9092 -L | grep 'topic '
  ```
- Check if Kafka is running:
  ```bash
  nc -z localhost 9092 && echo "Kafka is up!" || echo "Kafka is down!"
  ```

### General Tips

- If you get connection errors, check Docker is running and port 9092 is open.
- If a topic doesn't exist, Kafka auto-creates it (see docker-compose config).
- You can change the topic name or message format in each example's Python code.

## Example Folders

- `kafka-local/`: Shared Kafka deployment for all examples.

- `writing-to-kafka-example/`: Streams weather data to Kafka using Python and Docker Compose.
  - `main.py`: Python producer for weather data.
  - `start_kafka_and_app.sh`: Script to start Kafka and run the app.


More examples coming soon!
