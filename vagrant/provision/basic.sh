#!/bin/bash
sudo apt update
sudo apt -y install ruby ruby-bundler build-essential
echo "gem: --no-document" | sudo tee -a /etc/gemrc
sudo gem install sinatra


# install nginx + passenger

sudo apt -y install nginx

# https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/bionic/install_passenger.html

# Install our PGP key and add HTTPS support for APT
sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger
sudo apt-get install -y libnginx-mod-http-passenger
