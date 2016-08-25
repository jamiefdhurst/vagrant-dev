# Vagrant PHP Development Environment

**This is the Trusty Tahr (14.04) version. For the newest Xenial Xerus (16.04)
version, [please see here](https://github.com/jamiefdhurst/vagrant-dev/tree/xenial).**

This development environment is intended as a starter for those wanting to use
Vagrant to develop PHP applications, and includes the necessary software for
doing so.

To show greater transparency and allow for more in-depth configuration changes,
the provisioning has been switched back to shell-based.

## Support

This environment currently supports the following software:
* Apache2 or Nginx as web server
* PHP 5.5 (Ubuntu LTS latest)
* MySQL or MariaDB [optional]
* Memcached [optional]
* Composer [optional]
* Ruby (rvm latest stable version) [optional]
* Automatic SSL (available at https://localhost:8443)

## Configuration

The vagrant configuration file is located in ```vagrant/config.rb```. This file allows
environment settings such as the web root, database root password, log directory,
etc.

All configuration files are available within ```vagrant/env``` and can be configured
to your individual project requirements.
