#!/bin/bash

all_soft=(ruby-full ruby-bundler build-essential)

apt update -y
for soft in $all_soft
    do
    apt install -y $soft
    done

if [ -n "$(ruby -v)" ] & [ -n "$(bundler -v)" ]; then
    echo "All soft has install"
        fi