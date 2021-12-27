#!/bin/bash

all_soft="apt-utils ruby-full ruby-bundler build-essential"

apt update -y && apt install -y $all_soft

if [ -n "$(ruby -v)" ] & [ -n "$(bundle -v)" ]; then
    echo "All soft has install"
        fi
