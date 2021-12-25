#!/bin/bash

all_soft="apt-utils ruby-full ruby-bundler build-essential"

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y $all_soft
sudo gem install bundler

if [ -n "$(ruby -v)" ] & [ -n "$(bundle -v)" ]; then
    echo "All soft has install"
        fi
