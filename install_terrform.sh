#!/bin/bash

VERSION=1.2.1

curl -O https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip
unzip terraform_${VERSION}_linux_amd64.zip
mv terraform ~/.local/bin
