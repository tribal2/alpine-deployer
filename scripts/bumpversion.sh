#!/bin/bash

if [ -z "$1" ]; then
  echo "You must supply the part of the version to increase! (ej: major, minor or patch)"
  exit 1
fi

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
cd $SCRIPT_DIR/..

MSYS_NO_PATHCONV=1 docker run --rm -v $(pwd):/code tribal2/bump2version $1
