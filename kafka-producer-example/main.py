import requests
import json
import logging
import time
from quixstreams import Application 

def get_weather():
    response = requests.get("http://api.open-meteo.com/v1/forecast", params={
        "latitude": 51.5,
        "longitude": 0.07,
        "current": "temperature_2m",
    })

    return response.json()

def main():
    app = Application(
        broker_address="localhost:9092",
        loglevel="DEBUG",
    )

    with app.get_producer() as producer:
        while True:
            weather = get_weather()
            logging.debug("Got weather: %s", weather)
            producer.produce(
                topic="weather_data_demo",
                key="London",
                value=json.dumps(weather),
            )
            logging.info("Produced. Sleeping...")
            time.sleep(15)  # Sleep for 60 seconds

if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    try:
        main()
    except KeyboardInterrupt:
        pass