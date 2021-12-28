#!/bin/bash

all_soft="apt-utils ruby-full ruby-bundler build-essential"

sudo rm /var/lib/apt/lists/lock /var/cache/apt/archives/lock /var/lib/dpkg/lock*

apt-get install -y $all_soft

if [ -n "$(ruby -v)" ] & [ -n "$(bundle -v)" ]; then
    echo "All soft has install"
        fi
