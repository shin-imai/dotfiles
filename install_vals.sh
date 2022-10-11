#!/bin/bash

VERSION=0.18.0

curl -L https://github.com/variantdev/vals/releases/download/v${VERSION}/vals_${VERSION}_linux_amd64.tar.gz | tar zx -C ~/.local/bin
