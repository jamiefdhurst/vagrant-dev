module VConfig

  # Main container of the variables.
  $config = {

      # General configuration
      box_link:         'localhost', # Address to the box, usually just localhost
      box_ip:           '127.0.0.1', # The internal IP address... Just in case
      box_ram:          '1024', # Amount of RAM in (MB) for this machine

      # Web
      web_service:      'nginx', # nginx|apache2
      web_port:         8080, # HTTP port forwards to this
      web_logs_dir:     '/vagrant/logs', # Server side path to logs
      web_root_dir:     '/vagrant/web', # Local side path to the project content

      # MySQL
      db_service:       'mysql', # mariadb|mysql
      db_password:      'root', # Databse root password

      # PHP
      php:              true, # Should the PHP be installed?
      php_composer:     true, # Would you like to install composer globally?
      memcached:        false, # Would you like to install and set up Memcached?

      # Ruby
      ruby:             false, # Should Ruby be installed?
  }

end
