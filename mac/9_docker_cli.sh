#!/bin/bash

VERSION=$(curl -sSL\
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/docker/docker/releases|jq -r '.[0].tag_name')

echo "Installing version: ${VERSION}"

curl -sSL https://download.docker.com/mac/static/stable/x86_64/docker-${VERSION##v}.tgz | tar zx docker/docker 
mv docker/docker ~/.local/bin
