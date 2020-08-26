#!/usr/bin/env sh

exe() { echo "\$ $@"; "$@"; }

trap 'echo Ctrl-c, Test interrupted; exit' INT

echo -e \
  "
  ##############
  ## Checking ##
  ##############
  "
exe which docker && \
exe tmux -V && \
exe nordvpn --version && \
exe mount.davfs -V && \

if [ $? -eq 0 ]; then
  echo -e \
  "
  #####################
  ## All Checks Done ##
  #####################
  "
  exit 0
fi
