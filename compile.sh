#!/bin/bash
docker rm -f esp8266
docker run --name esp8266 --rm -ti \
    -v $(pwd):/home/esp8266/project \
    -v $(pwd)/bin:/home/esp8266/esp_iot_rtos_sdk/bin \
    -v $(pwd)/user:/home/esp8266/esp_iot_rtos_sdk/app/user/ \
    esp8266 $1


