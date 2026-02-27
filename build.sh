#!/bin/bash

IMAGE_NAME=$1
TAG=$2

docker build -t $IMAGE_NAME:$TAG .
docker push $IMAGE_NAME:$TAG
