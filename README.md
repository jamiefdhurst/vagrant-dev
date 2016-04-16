#Vagrant PHP Development Environment

**Now updated to support Ubuntu 16.04 LTS - Xenial Xerus!**

This development environment is intended as a starter for those wanting to use
Vagrant to develop PHP applications, and includes the necessary software for
doing so.

To show greater transparency and allow for more in-depth configuration changes,
the provisioning has been switched back to shell-based for Ubuntu 16.04 LTS.

##Support

This environment currently supports the following software:
* Apache2 or Nginx as web server
* PHP 7.0 (Ubuntu LTS latest)
* MySQL or MariaDB [optional]
* Memcached [optional]
* Composer [optional]
* Ruby (rvm latest stable version) [optional]

##Configuration

The vagrant configuration file is located in vagrant/config.rb. This file allows
environment settings such as the web root, database root password, log directory,
etc.

All configuration files are available within vagrant/env and can be configured
to your individual project requirements.
