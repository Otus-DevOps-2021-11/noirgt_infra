#!/bin/bash

all_soft=(mongodb-org)
repo_location=" /etc/apt/sources.list.d"
repo_conf="deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse"

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo $repo_conf | sudo tee $repo_location/mongodb-org-4.2.list
apt update -y
for soft in $all_soft
    do
    apt install -y $soft
    done

systemctl enable --now mongod
