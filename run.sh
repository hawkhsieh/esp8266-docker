#!/bin/bash
docker rm -f esp8266
docker run --name esp8266 --rm -ti -v $(pwd):/home/esp8266/project esp8266 /bin/bash


