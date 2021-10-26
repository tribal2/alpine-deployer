#!/bin/bash

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

source $SCRIPT_DIR/../.config.env

VERSION=$( \
  cat $SCRIPT_DIR/../.bumpversion.cfg \
    | grep current_version \
    | tr -d 'current_version = ' \
)

TAG="${VERSION}-alpine${ALPINE_VERSION}"

echo $TAG
