class php {

  $packages = ["php5", "php5-cli", "php5-dev", "php5-gd", "php5-mcrypt", "php5-curl", "php5-fpm"]

  if $newest_php == 1 {
    # Add new repo.
    file { "add-repositories php":
      path    => "/etc/apt/sources.list.d/ondrej-php5.list",
      ensure  => file,
      content  => template("php/repo.erb"),
      notify  => [Service[$service], Exec["apt-get update"]]
    }

    package { $packages:
      ensure => latest,
      require => [
        Package[$service],
        File["add-repositories php"]
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
