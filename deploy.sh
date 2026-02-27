#!/bin/bash

IMAGE=$1

export IMAGE_NAME=$IMAGE

docker pull $IMAGE

docker stop react-app || true
docker rm react-app || true

docker-compose up -d
