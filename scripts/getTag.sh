#!/bin/bash

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

VERSION=$( \
  cat $SCRIPT_DIR/../.bumpversion.cfg \
    | grep current_version \
    | tr -d 'current_version = ' \
)

ALPINE_VERSION=3.14.2
TAG="${VERSION}-alpine${ALPINE_VERSION}"

echo $TAG
