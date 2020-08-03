#!/usr/bin/env sh

exe() { echo "\$ $@"; "$@"; }

trap 'echo Ctrl-c, Test interrupted; exit' INT

echo -e \
  "
  ##############
  ## Checking ##
  ##############
  "
exe docker version && \
exe tmux -V && \
exe nordvpn --version && \

if [ $? -eq 0 ]; then
  echo -e \
  "
  #####################
  ## All Checks Done ##
  #####################
  "
  exit 0
fi
