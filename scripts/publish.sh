#!/bin/bash

TAG=$($SCRIPT_DIR/getTag.sh)

echo "Publishing: ${TAG}"

docker push tribal2/alpine-deployer:latest
docker push tribal2/alpine-deployer:${TAG}
