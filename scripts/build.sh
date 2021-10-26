#!/bin/bash

if [[ $(git rev-parse --abbrev-ref HEAD) != "main" ]]; then
    echo "You must be on the 'main' branch to build."
    exit 1
fi

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

TAG=$($SCRIPT_DIR/getTag.sh)

echo "Building: ${TAG}"

docker build \
  --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  -t tribal2/alpine-deployer:latest \
  -t tribal2/alpine-deployer:${TAG} \
  $SCRIPT_DIR/../

git tag -a ${TAG} -m ""
