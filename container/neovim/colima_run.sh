#!/bin/bash

NAME=${1:-ide}

docker run -it --rm --name ${NAME} --workdir /home/$(id -un).linux \
  -v /etc/nsswitch:/etc/nsswitch \
  -v /etc/passwd:/etc/passwd \
  -v /etc/group:/etc/group \
  -v /home/shinimai.linux:/home/shinimai.linux \
  -u $(id -u) ide:v1.0
