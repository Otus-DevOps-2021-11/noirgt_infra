#!/bin/bash

project_url="https://github.com/express42/reddit.git"
project_dir_name="reddit"
all_soft=(git)


apt update -y
for soft in $all_soft
    do
    apt install -y $soft
    done

mkdir $project_dir_name
git clone -b monolith $project_dir_name $project_url
cd reddit && bundle install

if [ "$(ps aux | grep -Ice puma)" > 1 ]; then
    echo "Server has started"
        fi
