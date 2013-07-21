class php {
    $packages = ["php5", "php5-cli", "php5-mysql", "php5-dev", "php5-gd", "php5-mcrypt", "php5-fpm"]

    package { $packages:
        ensure => present,
        require => Exec["apt-get update"]
    }

    file { "php5-conf":
        path    => "/etc/php5/fpm/php.ini",
        ensure  => file,
        require => Package["php5"],
        source  => "/vagrant/vagrant/support/php.ini"
    }
}
