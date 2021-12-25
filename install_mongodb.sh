#!/bin/bash

all_soft=(mongodb-org)
repo_location=" /etc/apt/sources.list.d"
repo_conf="deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse"

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo $repo_conf | sudo tee $repo_location/mongodb-org-4.2.list
sudo apt update -y
sudo apt install -y $all_soft

sudo systemctl enable --now mongod
