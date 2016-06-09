#!/bin/bash

# Run full provision.

# Already provisioned?
if [ -e "/home/ubuntu/.provisioned" ]; then
    output $BLUE "Box already provisioned."; exit 0
fi

# Require the functions file
source /vagrant/vagrant/sh/functions.sh

# Standard requirements
export DEBIAN_FRONTEND=noninteractive
box_update
box_install_curl
box_install_git
box_install_zip

# Install web service
if [ $web_service == "apache2" ]; then
    box_install_apache2
elif [ $web_service == "nginx" ]; then
    box_install_nginx
fi

# # Install database service
if [ $db_service == "mariadb" ]; then
    box_install_mariadb
elif [ $db_service == "mysql" ]; then
    box_install_mysql
fi

# Install PHP
if $php; then
    box_install_php
    if $php_composer; then
        box_install_php_composer
    fi
    if $memcached; then
        box_install_memcached
    fi
fi

# Install Ruby
if $ruby; then
    box_install_ruby
fi

# Register the box
box_register

output $GREEN "Box provisioned."
