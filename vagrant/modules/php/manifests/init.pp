class php {

  $packages = ["php5", "php5-cli", "php5-dev", "php5-gd", "php5-mcrypt", "php5-curl", "php5-fpm"]

  if $newest_php == 1 {
    # Add new repo.
    exec { "add-repositories php":
      command => "add-apt-repository ppa:ondrej/php5",
      notify  => [Service[$service], Exec["apt-get update"]]
    }

    package { $packages:
      ensure => latest,
      require => [
        Package[$service],
        Exec["add-repositories php"]
      ],
    }

    service { "php5-fpm":
      ensure => running,
      require => Package["php5-fpm"]
    }

  } else {

    package { $packages:
      ensure => present,
      require => Package[$service]
    }

    service { "php5-fpm":
      ensure => running,
      require => Package["php5-fpm"]
    }

  }

}
