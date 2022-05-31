#!/bin/bash

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/root/workspace --name ide -dit ide:go
