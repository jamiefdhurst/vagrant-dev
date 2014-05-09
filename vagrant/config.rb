module VConfig

  # Main container of the variables.
  $config = {

      # General configuration
      box_link:         'localhost', # What would be the address you will visit to view your project?
      box_ip:           '127.0.0.1', # The internal IP address... Just in case.
      port:             8080, # Perhaps you fancy different port?
      ram:              '512', # Amount of RAM allowed for this machine.

      # Apache2/Nginx
      service:          'nginx', # nginx|apache2
      index:            'index.php', # What file should be read.
      server_admin:     'webmaster@localhost', # E-mail address for the admin. Fake will do...
      logs_dir:         '/vagrant/logs', # Server side path to logs.
      root_dir:         '/vagrant/web', # Local side path to the project content.

      # MySQL
      database:         'mysql', # Select database software, one of mariadb/mysql. Write "none" to disable installation.
      db_password:      'root', # Which password should be set up for the root user of database?

      # NodeJS
      nodejs:           false, # Would you like to install NodeJS in your environment?

      # PHP
      php:              true, # Should the PHP be installed?
      newest_php:       false, # Would you like to install newest PHP possible (5.5) or stick with official version from repos?
                           # WARNING! Currently only supports nginx, NOT apache2!
      laravel:          false, # Would you like to install laravel globally?
      composer:         true, # Would you like to use beautiful and magical composer?
      memcache:         false, # Would you like to install and set up Memcache?

      # Ruby/RoR
      install_ruby:     false, # Should we install ruby?
                           # WARNING! If yes, it will ignore Apache2/Nginx and PHP installation!
      ruby_version:     '2.0.0', # What version of ruby should be installed?
      rails:            false, # Should we install Ruby on Rails?
      rails_ver:        '', # What version of rails should it go with? Leave empty for default.

      # Sendmail/mailcatcher
      mailcatcher:      true, # Would you like to install MailCatcher?
      sendmail:         false, # Do you wish to include sendmail to your box?

      # Compass
      compass:          false, # Are you so cool to use compass with sass?
      compass_project:  '', # Direct us to the main directory of your compass project, so we can put the watch on!

  }

end
