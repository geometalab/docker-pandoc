#!/bin/bash
set -e

function remove_if_exists_else_fail {
  if [[ -e "$1" ]]; then
    rm -f "$1"
  else
    exit 1
  fi
}

cd $(dirname $0)
docker build -t geometalab/pandoc:latest .

py.test

# push the newly create image
docker push geometalab/pandoc:latest
