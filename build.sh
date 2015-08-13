#!/bin/sh
PWD=`pwd`
#docker build -t ${PWD#*-} .
docker build -t esp8266 .
