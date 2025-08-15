
# python-kafka-exploration: Practical Kafka Examples & Tips

This repository is a collection of hands-on Kafka experiments in Python, designed to make it easy to run, debug, and learn from real Kafka usage. Each folder is a standalone example covering different Kafka patterns and lessons learned.


## How to Run the Demo

### 1. Start Kafka & Redpanda Console

From the repo root, run:
```bash
./start-services.sh
```
This spins up the Kafka broker and Redpanda Console using Docker Compose.

### 2. Run a Full Demonstration

Choose one of the following demo scripts:

- **Producer + Consumer Demo:**
  ```bash
  ./run-producer-consumer.sh
  ```
  This starts the weather data producer in the background and runs the consumer in the foreground, showing end-to-end data flow.

- **Producer + Stream Processor Demo:**
  ```bash
  ./run-producer-stream-processor.sh
  ```
  This starts the producer in the background and runs the stream processor in the foreground, demonstrating real-time transformation and output to a new topic.

### 3. Stop Kafka & Redpanda Console

From the repo root, run:
```bash
./stop-services.sh
```
This stops and cleans up the Docker containers.


## Example Folders

- `kafka-local/`: Shared Kafka deployment for all examples. Includes Redpanda Console for web-based topic/message inspection.
- `kafka-producer-example/`: Streams weather data to Kafka using Python and the [quixstreams](https://github.com/quixio/quix-streams) library.
- `kafka-consumer-example/`: Consumes weather data from Kafka and prints it to the console.
- `kafka-stream-processing-example/`: Demonstrates stream processing by transforming weather data (Celsius to Fahrenheit/Kelvin) and writing results to a new topic.

## Demo Scripts

- `start-services.sh`: Spins up Kafka and Redpanda Console Docker containers.
- `stop-services.sh`: Stops and cleans up the Docker containers.
- `run-producer-consumer.sh`: Runs the producer in the background and the consumer in the foreground for a full demo.
- `run-producer-stream-processor.sh`: Runs the producer in the background and the stream processor in the foreground for a full demo.


## Redpanda Console: The Best Kafka UI

- **Redpanda Console** is included in the Docker Compose setup and runs on [http://localhost:8080](http://localhost:8080).
- It provides a modern web UI for inspecting topics, browsing messages, and debugging Kafka issues.
- Point the UI at the broker's INTERNAL listener for container-to-container access (see `docker-compose.yml`).


## Useful Kafka CLI Tools & Tips

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


## Lessons Learned & Tips

- **KRaft mode** (no Zookeeper) is simpler for local dev and works well for single-broker setups.
- **Multiple listeners**: Use separate listeners for host and container access (`PLAINTEXT://localhost:9092` for host, `INTERNAL://kafka:29092` for containers).
- **Auto-create topics**: Enabled for dev convenience, but be aware in production.
- **Consumer offset management**: Store offsets after processing each message to resume reliably.
- **Debugging**: Use `breakpoint()` in Python for interactive debugging. Set `auto_offset_reset` to `earliest` to replay all messages, or `latest` for only new ones.
- **Stream processing**: Use quixstreams DataFrame API for easy transformation and output to new topics.
- **Redpanda Console**: Makes inspecting topics and messages much easier than CLI tools alone.
- **Error handling**: Always check for message errors in consumers and handle gracefully.
- **Python logging**: Use `logging` for debug/info output in producers and processors.


## More Cool Tricks

- You can change topic names and message formats in each example's Python code.
- Try producing/consuming with kcat for quick CLI testing.
- Use Redpanda Console to browse, search, and inspect messages visually.
- If you get connection errors, check Docker is running and port 9092 is open.
- The examples use the [quixstreams](https://github.com/quixio/quix-streams) library for modern Kafka streaming in Python.

---

More examples and advanced patterns coming soon!
