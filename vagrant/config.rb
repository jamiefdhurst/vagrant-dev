module VConfig

  # General configuration
  $ram          = '512' # Amount of RAM allowed for this machine.
  $box_link     = 'localhost' # What would be the address you will visit to view your project?
  $box_ip       = '127.0.0.1' # The internal IP address... Just in case.
  $port         = 8080 # Perhaps you fancy different port?

  # Apache2/Nginx
  $service      = 'nginx' # nginx|apache2
  $index        = 'index.php' # What file should be read.
  $server_admin = 'webmaster@localhost' # E-mail address for the admin. Fake will do...
  $logs_dir     = '/vagrant/logs' # Server side path to logs.
  $root_dir     = '/vagrant/public' # Local side path to the project content.

  # MySQL
  $database     = 'mysql' # Select database software, one of mariadb/mysql. Leave empty to disable.
  $db_password  = 'root' # Which password should be set up for the root user of database?

  # PHP
  $newest_php   = 0 # Would you like to install newest PHP possible (5.5) or stick with official version from repos?
                    # WARNING! Currently only supports nginx, NOT apache2!
  $composer     = 1 # Would you like to use beautiful and magical composer?
  $memcache     = 0 # Would you like to install and set up Memcache?

  # Sendmail/mailcatcher
  $mailcatcher  = 0 # Would you like to install MailCatcher?
  $sendmail     = 1 # Do you wish to include sendmail to your box?

end