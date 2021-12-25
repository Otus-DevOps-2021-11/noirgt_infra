#!/bin/bash

all_soft=(ruby-full ruby-bundler build-essential git mongodb-org)

mongo_repo_location=" /etc/apt/sources.list.d"
mongo_repo_conf="deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse"

project_url="https://github.com/express42/reddit.git"
project_dir_name="reddit"

# Add MongoDB's reposutory
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo $mongo_repo_conf | sudo tee $mongo_repo_location mongodb-org-4.2.list

# Install all soft
apt update -y
for soft in $all_soft
    do
    apt install -y $soft
    done

# Check install of Ruby
if [ -n "$(ruby -v)" ] & [ -n "$(bundler -v)" ]; then
    echo "Ruby has install"
        fi

# Start and autostart MongoDB
systemctl enable --now mongod 
echo "MongoDB has install"

# Install server
mkdir $project_dir_name
git clone -b monolith $project_dir_name $project_url
cd reddit && bundle install

if [ "$(ps aux | grep -Ice puma)" > 1 ]; then
    echo "Server has started"
        fi
