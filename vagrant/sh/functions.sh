#!/bin/bash

# Provide functions for provisioning.

RED="0;31"
GREEN="0;32"
BLUE="0;34"

# Output a string with a colour
# $1 - colour
# $2 - string
output() {
    echo -e "\033[$1m[PROVISIONER] $2\033[0m"
}

box_install_apache2() {
    output $BLUE "Installing Apache..."
    apt-get -qq -y install apache2
    cp /vagrant/vagrant/env/apache2/apache2.conf /etc/apache2/apache2.conf
    cp /vagrant/vagrant/env/apache2/site.conf /etc/apache2/sites-available/vagrant.conf
    sed -i "s@{DOCUMENT_ROOT}@$web_root_dir@g" /etc/apache2/sites-available/vagrant.conf
    sed -i "s@{LOG_DIR}@$web_logs_dir@g" /etc/apache2/sites-available/vagrant
    rm /etc/apache2/sites-enabled/*
    ln -s /etc/apache2/sites-available/vagrant /etc/apache2/sites-enabled/
    a2enmod proxy proxy_fcgi rewrite
    service apache2 restart
    output $GREEN "Apache installed and configured."
}

box_install_curl() {
    output $BLUE "Installing cURL..."
    apt-get -qq -y install curl
    output $GREEN "cURL installed."
}

box_install_git() {
    output $BLUE "Installing Git..."
    apt-get -qq -y install git
    output $GREEN "Git installed."
}

box_install_mariadb() {
    output $BLUE "Installing Mariadb..."
    apt-get -qq -y install mariadb-server mariadb-client
    cp /vagrant/vagrant/env/mariadb/my.cnf /etc/mysql/my.cnf
    service mysql restart
    mysqladmin -u root password $db_password
    echo "CREATE USER 'root'@'%' IDENTIFIED BY '$db_password';" | mysql -u root -p$db_password
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" | mysql -u root -p$db_password
    echo "DROP USER 'root'@'localhost';" | mysql -u root -p$db_password
    echo "FLUSH PRIVILEGES;" | mysql -u root -p$db_password
    output $GREEN "Mariadb installed and configured."
}

box_install_memcached() {
    output $BLUE "Installing Memcached..."
    apt-get -qq -y install memcached php-memcached
    service php7.0-fpm restart
    output $GREEN "Memcached installed."
}

box_install_mysql() {
    output $BLUE "Installing MySQL..."
    apt-get -qq -y install mysql-server mysql-client
    cp /vagrant/vagrant/env/mysql/my.cnf /etc/mysql/my.cnf
    service mysql restart
    mysqladmin -u root password $db_password
    echo "CREATE USER 'root'@'%' IDENTIFIED BY '$db_password';" | mysql -u root -p$db_password
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" | mysql -u root -p$db_password
    echo "DROP USER 'root'@'localhost';" | mysql -u root -p$db_password
    echo "FLUSH PRIVILEGES;" | mysql -u root -p$db_password
    output $GREEN "MySQL installed and configured."
}

box_install_nginx() {
    output $BLUE "Installing Nginx..."
    apt-get -qq -y install nginx
    cp /vagrant/vagrant/env/nginx/nginx.conf /etc/nginx/nginx.conf
    cp /vagrant/vagrant/env/nginx/site.conf /etc/nginx/sites-available/vagrant
    sed -i "s@{DOCUMENT_ROOT}@${web_root_dir}@g" /etc/nginx/sites-available/vagrant
    sed -i "s@{LOG_DIR}@${web_logs_dir}@g" /etc/nginx/sites-available/vagrant
    rm /etc/nginx/sites-enabled/*
    ln -s /etc/nginx/sites-available/vagrant /etc/nginx/sites-enabled/
    service nginx restart
    output $GREEN "Nginx installed and configured."
}

box_install_php() {
    output $BLUE "Installing PHP..."
    add-apt-repository ppa:ondrej/php
    apt-get -qq -y update
    apt-get -qq -y install php7.0-fpm php7.0-cli php7.0-curl php7.0-gd php7.0-json php7.0-mcrypt \
        php7.0-mysql php7.0-xml php7.0-mbstring
    sed -i "s/^user\s\=\swww\-data/user = vagrant/g" /etc/php/7.0/fpm/pool.d/www.conf
    sed -i "s/^group\s\=\swww\-data/group = vagrant/g" /etc/php/7.0/fpm/pool.d/www.conf
    cp /vagrant/vagrant/env/php/php.ini /etc/php/7.0/cli/php.ini
    cp /vagrant/vagrant/env/php/php.ini /etc/php/7.0/fpm/php.ini
    service php7.0-fpm restart
    output $GREEN "PHP installed and configured."
}

box_install_php_composer() {
    output $BLUE "Installing Composer..."
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    output $GREEN "Composer installed."
}

box_install_ruby() {
    output $BLUE "Installing Ruby..."
    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    output $GREEN "Ruby installed."
}

box_install_zip() {
    output $BLUE "Installing Zip..."
    apt-get -qq -y install zip
    output $GREEN "Zip installed."
}

# Make sure the box stores a hidden file to say when it was installed
box_register() {
    echo 'Box provisioned - `date`' > /home/ubuntu/.provisioned
}

box_setup_ssl() {
    cd /vagrant/vagrant/env/ssl
    openssl genrsa -out server.key 2048
    openssl genrsa -out localhost.key 2048
    openssl rsa -in localhost.key -out localhost.key.rsa
    openssl req -new -key server.key -subj "/C=/ST=/L=/O=/CN=/emailAddress=/" -out server.csr
    openssl req -new -key localhost.key.rsa -subj "/C=GB/ST=Tyne+and+Wear/L=Newcastle/O=Local/CN=localhost/" -out localhost.csr -config localhost.conf
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
    openssl x509 -req -extensions v3_req -days 365 -in localhost.csr -signkey localhost.key.rsa -out localhost.crt -extfile localhost.conf
    service nginx restart
    echo 'SSL available, plus install on your local machine using:'
    echo 'sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./vagrant/env/ssl/localhost.crt'
}

# Update the box - common functionality
box_update() {

    output $BLUE "Updating apt-get sources..."
    apt-get -qq -y update
    apt-get -qq -y upgrade
}
