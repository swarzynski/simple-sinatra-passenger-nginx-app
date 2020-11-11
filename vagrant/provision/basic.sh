#!/bin/bash
sudo apt update
sudo apt -y install ruby ruby-bundler ruby-dev build-essential
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

sudo cp /vagrant/provision/source/simpleapp.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/simpleapp.conf /etc/nginx/sites-enabled/simpleapp.conf


sudo adduser --disabled-password --gecos '' simpleapp
sudo adduser simpleapp simpleapp
sudo bash -c 'echo "simpleapp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/simpleapp'
sudo -H -u simpleapp bash -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'
sudo -H -u simpleapp bash -c 'touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'

sudo mkdir -p /var/www/simpleapp
sudo chown simpleapp: /var/www/simpleapp

########### todo

cd /var/www/simpleapp

sudo -u simpleapp -H git clone --branch=end_result https://github.com/phusion/passenger-ruby-rails-demo.git code

sudo -u simpleapp -H bash -l

cd /var/www/simpleapp/code

sudo apt install libgmp3-dev #needed by json gem
sudo apt -y install patch ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev # needed by nokogiri gem


bundle install --deployment --without development test

namei -l /var/www/simpleapp/code/config.ru
