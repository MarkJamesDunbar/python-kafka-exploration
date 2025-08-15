# python-kafka-exploration
Exploring Kafka

This repository contains multiple examples demonstrating how to use Kafka with Python.

## Structure

- `writing-to-kafka-example/`: Example of streaming weather data to Kafka using Python and Docker Compose.
	 - `main.py`: Python script that fetches weather data and produces it to a Kafka topic.
	 - `kafka-local/docker-compose.yml`: Docker Compose file to run a local Kafka broker using Bitnami's Kafka image.
	 - `start_kafka_and_app.sh`: Bash script to start Kafka and run the Python app.
- More example folders coming soon!

## writing-to-kafka-example

### How It Works

1. **Kafka Setup**: The `docker-compose.yml` file sets up a single-node Kafka broker using KRaft mode (no Zookeeper required). It exposes Kafka on port 9092 and auto-creates topics as needed.
2. **Weather Data Producer**: The `main.py` script uses the [Open-Meteo API](https://open-meteo.com/) to fetch current temperature data for London. It then produces this data to the Kafka topic `weather_data_demo` every 60 seconds using the `quixstreams` library.
3. **Startup Script**: The `start_kafka_and_app.sh` script automates the process:
	 - Starts Kafka using Docker Compose.
	 - Waits for Kafka to be ready.
	 - Runs the Python producer app.

### Prerequisites

- Docker and Docker Compose installed
- Python 3.7+
- Required Python packages: `requests`, `quixstreams`

### Getting Started

1. **Install Python dependencies**
	```bash
	pip install requests quixstreams
	```
2. **Start Kafka and the app**
	```bash
	cd writing-to-kafka-example
	bash start_kafka_and_app.sh
	```
3. **Observe Output**
	- The app will log weather data fetched and produced to Kafka every minute.
	- Kafka runs locally and can be accessed on `localhost:9092`.

### Customization

- Change the location in `main.py` by modifying the latitude/longitude in the API request.
- Adjust the topic name or message frequency as needed.

### Stopping Kafka

To stop the Kafka service:
```bash
cd kafka-local
docker-compose down
```

### Troubleshooting

- Ensure Docker is running before starting the script.
- If you encounter connection issues, verify that port 9092 is available and not blocked by a firewall.

## License

MIT License
