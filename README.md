#PHP/Vagrant Development Environment

This development environment is intended as a starter for those wanting to use
Vagrant to develop PHP applications, and includes the necessary software for
doing so.

##Support

This environment currently supports either Apache2 or nginx. Check in the
Vagrantfile and uncomment one of the following lines:

    # Uncomment as necessary for apache2 or nginx
    #shell.path = "env/provision-apache2.sh"
    #shell.path = "env/provision-nginx.sh"

To set individual options, refer to the shell files listed above.