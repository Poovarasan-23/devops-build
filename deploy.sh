#!/bin/bash

IMAGE=$1

docker stop react-app || true
docker rm react-app || true

if [[ "$IMAGE" == *"dev"* ]]; then
    docker run -d -p 3000:80 --name react-app $IMAGE
else
    docker run -d -p 80:80 --name react-app $IMAGE
fi
