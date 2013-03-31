#!/bin/bash

# Provision an Ubuntu box with an Apache2 / PHP installation

# Apache settings
APACHE2_DOCUMENT_ROOT="\/vagrant\/web"
APACHE2_LOG_DIR="\/vagrant\/logs"
APACHE2_USER="www-data"
APACHE2_GROUP="www-data"

# MySQL settings
MYSQL_ROOT_PASSWORD="root"

# --Require the functions file
source /vagrant/env/functions.sh

# Are we provisioned?
if [ -e "/home/vagrant/.provisioned" ]; then
    output $BLUE "Box already provisioned."; exit 0
fi

# # --Update the box
box_update

# # --Install required software
output $BLUE "Installing software..."
apt-get -qq -y install apache2 mysql-server php5 php5-cli php5-mysql
output $GREEN "Software installed."

# --Setup the software

# Hostname
echo "$1" > /etc/hostname
sed -i "s/precise32/$1/" /etc/hosts
service hostname start

# Apache2
output $BLUE "Setting up Apache2..."
cp /vagrant/env/support/apache2.conf /etc/apache2/apache2.conf
sed -i "s/{USER}/$APACHE2_USER/" /etc/apache2/apache2.conf
sed -i "s/{GROUP}/$APACHE2_GROUP/" /etc/apache2/apache2.conf
cp /vagrant/env/support/apache2-site.conf /etc/apache2/sites-available/vagrant
sed -i "s/{DOCUMENT_ROOT}/$APACHE2_DOCUMENT_ROOT/g" /etc/apache2/sites-available/vagrant
sed -i "s/{LOG_DIR}/$APACHE2_LOG_DIR/g" /etc/apache2/sites-available/vagrant
ln -s /etc/apache2/sites-available/vagrant /etc/apache2/sites-enabled/
service apache2 restart
output $GREEN "Finished configuring Apache2."

# PHP
output $BLUE "Setting up PHP..."
cp /vagrant/env/support/php.ini /etc/php5/apache2/
cp /vagrant/env/support/php.ini /etc/php5/cli/
output $GREEN "Finished configuring PHP."

# MySQL
output $BLUE "Setting up MySQL..."
cp /vagrant/env/support/my.cnf /etc/mysql/my.cnf
mysqladmin -u root password $MYSQL_ROOT_PASSWORD
echo "create user 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD';" | mysql -u root -p$MYSQL_ROOT_PASSWORD
echo "grant all privileges on *.* to 'root'@'%' with grant option;" | mysql -u root -p$MYSQL_ROOT_PASSWORD
echo "flush privileges;" | mysql -u root -p$MYSQL_ROOT_PASSWORD
service mysql restart
output $GREEN "Finished configuring MySQL."

# --Optional software

# ZSH
box_install_zsh

# -- Register the box
box_register

output $GREEN "Box provisioned."