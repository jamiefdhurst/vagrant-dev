#Vagrant PHP Development Environment

This development environment is intended as a starter for those wanting to use
Vagrant to develop PHP applications, and includes the necessary software for
doing so.

**UPDATE**: The entire environment has been rebuilt using Ansible, as opposed to
Puppet which was opposed to Shell scripts.

##Support

This environment currently supports the following software:
* Apache2 or Nginx acting as webserver
* PHP 5.3 (Ubuntu LTS latest) or 5.5 (current latest)
* MySQL
* Memcached
* Composer
* Laravel
* Compass, SASS and Susy
* NodeJS
* Sendmail or Mailcatcher
* RubyGems, Git, cURL, [build-essential, python-software-properties, python, g++, make]

##Configuration

The vagrant configuration file is located in vagrant/config.rb. This file allows
environment settings such as the web root, database root password, log directory,
etc.
