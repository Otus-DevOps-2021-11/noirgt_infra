#!/bin/bash

project_url="https://github.com/express42/reddit.git"
project_dir_name="reddit"
all_soft=(git)


apt update -y
apt install -y $all_soft

mkdir ~/$project_dir_name
git clone -b monolith $project_url ~/$project_dir_name
cd ~/reddit && bundle install
puma -d

if [ "$(ps aux | grep -Ice puma)" > 1 ]; then
    echo "Server has started"
        fi
