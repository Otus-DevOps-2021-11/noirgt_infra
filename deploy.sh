#!/bin/bash

project_url="https://github.com/express42/reddit.git"
project_dir_name="reddit"
repo_location=" /etc/apt/sources.list.d"
repo_conf="deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse"
all_soft=(git mongodb-org)

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
sudo echo $repo_conf | sudo tee $repo_location/mongodb-org-4.2.list
sudo apt update -y
sudo apt install -y $all_soft

sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
sudo systemctl enable --now mongod

mkdir ~/$project_dir_name
git clone -b monolith $project_url ~/$project_dir_name
cd ~/reddit && bundle install
puma -d

if [ "$(ps aux | grep -Ice puma)" > 1 ]; then
    echo "Server has started"
        fi
