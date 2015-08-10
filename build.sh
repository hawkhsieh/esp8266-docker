#!/bin/sh
PWD=`pwd`
docker build -t ${PWD#*-} .
