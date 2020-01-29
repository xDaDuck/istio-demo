#!/usr/bin/env bash

docker build -t demo-https .
docker run -p 9010:9010 -it demo-https

