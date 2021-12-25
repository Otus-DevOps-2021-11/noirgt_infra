#!/bin/bash

all_soft=(apt-utils ruby-full ruby-bundler build-essential)

apt update -y
for soft in $all_soft
    do
    apt install -y $soft
    done

if [ -n "$(ruby -v)" ] & [ -n "$(bundle -v)" ]; then
    echo "All soft has install"
        fi
