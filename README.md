# How to install developer environment in Ubuntu/Debian

## Install virtualbox:

`wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -`

Add the following line to your /etc/apt/sources.list. According to your distribution, replace '<mydist>' with 'eoan', 'bionic', 'xenial', 'buster', 'stretch', 'jessie', 'focal' (Ubuntu 20.04):

`deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian <mydist> contrib`

In bash:

`echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian <mydist> contrib" | sudo tee -a /etc/apt/sources.list`

`sudo apt update`

`sudo apt install virtualbox`

## Install vagrant

`curl -O https://releases.hashicorp.com/vagrant/2.2.10/vagrant_2.2.10_x86_64.deb`

`sudo apt install ./vagrant_2.2.10_x86_64.deb`

## Run vagrant

Run in project's 'vagrant' folder commands:

`vagrant up`

`vagrant ssh`


# Run simple app with Passenger

```
cd /vagrant/passenger-ruby-sinatra-demo
bundle install
bundle exec passenger start
```

Now go to browser on host and enter `http://localhost:3000`

But this is running without nginx.


# Production server with Nginx - notes


Disable passenger user switching in nginx.conf:
```
user vagrant vagrant;

html {
passenger_default_group vagrant;
passenger_default_user vagrant;
passenger_user_switching off;
passenger_friendly_error_pages on;
}
```

https://www.phusionpassenger.com/docs/advanced_guides/install_and_upgrade/standalone/install/oss/bionic.html
https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/bionic/deploy_app.html

https://www.phusionpassenger.com/library/walkthroughs/start/ruby.html#preparing-the-example-application
https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/bionic/deploy_app.html

https://www.phusionpassenger.com/docs/advanced_guides/troubleshooting/nginx/


```
cd /var/www/simpleapp

sudo -u simpleapp -H git clone --branch=end_result https://github.com/phusion/passenger-ruby-rails-demo.git code

sudo -u simpleapp -H bash -l

cd /var/www/simpleapp/code

sudo apt install libgmp3-dev #needed by json gem
sudo apt -y install patch ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev # needed by nokogiri gem


bundle install --deployment --without development test

namei -l /var/www/simpleapp/code/config.ru
chcon -Rt httpd_sys_content_t /var/www/simpleapp/code
```
