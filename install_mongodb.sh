#!/bin/bash

repo_location=" /etc/apt/sources.list.d"
repo_conf="echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list"

wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo $repo_conf | sudo tee $repo_location/mongodb-org-5.0.list
sudo apt update -y
sudo apt install -y mongodb-org
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

sudo systemctl enable mongod && sudo systemctl start mongod
