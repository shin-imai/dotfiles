#!/bin/bash

VERSION=387.0.0

curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${VERSION}-linux-x86_64.tar.gz | tar zx
./google-cloud-sdk/install.sh
mv ./google-cloud-sdk/ ~/.local/

echo 'PATH=$PATH:~/.local/google-cloud-sdk/bin' >> ~/.bashrc
