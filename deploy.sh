#!/bin/bash

IMAGE=$1

docker pull $IMAGE
docker stop react-app || true
docker rm react-app || true
docker run -d -p 80:80 --name react-app $IMAGE
