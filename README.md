#Vagrant PHP Development Environment

This development environment is intended as a starter for those wanting to use
Vagrant to develop PHP applications, and includes the necessary software for
doing so.

##Support

This environment currently supports either Apache2 or Nginx. Each provisioner
includes the following software:
* PHP 5.3 (Ubuntu LTS latest)
* MySQL
* Memcached
* ZSH (including oh-my-zsh)
* Composer

##Environments

To run either Apache or Nginx, check in the Vagrantfile and uncomment one of
the following lines:

```ruby
# Uncomment as necessary for apache2 or nginx
#shell.path = "env/provision-apache2.sh"
#shell.path = "env/provision-nginx.sh"
```

##Configuration

To set individual options, refer to the provisioner shell files listed above.
All options are listed at the top of the files.