#!/bin/bash

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
source $SCRIPT_DIR/../.config.env

TAG=debug-$($SCRIPT_DIR/getTag.sh)

echo "Building: ${TAG}"

docker build \
  --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg VERSION=${TAG} \
  -t tribal2/alpine-deployer:${TAG} \
  $SCRIPT_DIR/../
