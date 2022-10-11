#!/bin/bash

docker run -dit --init --name terminal \
  --network kind \
  -e TZ=Europe/London \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /Users/shinimai/Documents/workspace:/root/workspace \
  -v /Users/shinimai/.ssh:/root/.ssh \
  -v /Users/shinimai//.kube/config:/root/.kube/config \
  -v /Users/shinimai/.aws:/root/.aws \
  -v /Users/shinimai/.config/gcloud:/root/.config/gcloud terminal
