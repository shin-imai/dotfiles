#!/bin/bash

docker run -dit --init --name terminal2 \
  --network kind \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /Users/shinimai/Documents/workspace:/root/workspace \
  -v ~/.ssh:/root/.ssh \
  -v ~/.kube/config:/root/.kube/config \
  -v ~/.aws:/root/.aws \
  -v ~/.config/gcloud:/root/.config/gcloud ide:go
