module VConfig

  # Let's have some variables set up front so we can modify them.
  $boxlink      = 'localhost' # What would be the address you will visit to view your project?
  $boxip        = '127.0.0.1' # The internal IP address... Just in case.
  $database     = 'mysql' # Select database software. Please be aware the manifest has to exist... Leave empty to disable.
  $index        = 'index.php' # What file should be read.
  $logsdir      = '/vagrant/logs' # Server side path to logs.
  $ram          = '512' # Amount of RAM allowed for this machine.
  $rootdir      = '/pub' # Local side path to the project content.
  $serveradmin  = 'webmaster@localhost' # E-mail address for the admin. Fake will do...
  $service      = 'nginx' # nginx|apache

end