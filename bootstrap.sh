#!/usr/bin/env bash
echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
wget https://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg
apt-get update

apt-get install --reinstall ca-certificates

apt-get -y install nano

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /development /var/www/html
fi

# Enable required apache modules
#a2enmod headers setenvif rewrite vhost_alias expires

# Force Apache to listen on IPv only
#sed -i 's/Listen 80/Listen 0.0.0.0:80/' /etc/apache2/ports.conf

apt-get install -y git htop zip unzip jq

apt-get -y install nginx

apt-get -y install curl php7.0-fpm php7.0-cli php7.0-curl php7.0-mcrypt php7.0-mbstring php7.0-dom php7.0-mysql

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# Install Pip and AWS CLI
cd /tmp
curl -O https://bootstrap.pypa.io/get-pip.py
python2.7 get-pip.py
pip install awscli

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_8.x | -
apt-get install -y nodejs
apt-get install -y build-essential

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /home/vagrant/nginx.conf /etc/nginx/sites-available/laraveldeveloper.uk
ln -s /etc/nginx/sites-available/gold /etc/nginx/sites-enabled/laraveldeveloper.uk
#
systemctl restart nginx.service
