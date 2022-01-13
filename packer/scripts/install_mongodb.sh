#!/bin/bash

all_soft="mongodb-org"
repo_location="/etc/apt/sources.list.d"
repo_conf="deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse"

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo $repo_conf | tee $repo_location/mongodb-org-4.2.list

sudo rm /var/lib/apt/lists/lock /var/cache/apt/archives/lock /var/lib/dpkg/lock*

apt-get update -y
apt-get install -y $all_soft
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

systemctl enable mongod && systemctl start mongod
