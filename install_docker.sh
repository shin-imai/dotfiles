#!/bin/bash

VERSION=20.10.16

curl https://download.docker.com/linux/static/stable/x86_64/docker-${VERSION}.tgz | \
  tar zx --strip-components 1 -C /usr/local/bin docker/docker

