class php {
   if $newest_php == 1 {
    # Add new repo.
    exec { "add-apt-repository":
         command => "/usr/bin/add-apt-repository ppa:ondrej/php5"
    }

     # Update packages
     exec { 'apt-get update':
       command => '/usr/bin/apt-get update'
    }
   }

  $packages = ["php5", "php5-cli", "php5-dev", "php5-gd", "php5-mcrypt", "php5-curl", "php5-fpm"]

  package { $packages:
      ensure => present,
      require => Package[$service]
  }

  service { "php5-fpm":
    ensure => running,
    require => Package["php5-fpm"]
  }
}
