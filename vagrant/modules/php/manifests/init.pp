class php {
    $packages = ["php5", "php5-cli", "php5-mysql", "php5-dev", "php5-gd", "php5-mcrypt", "php5-fpm"]

    package { $packages:
        ensure => present,
        require => Exec["apt-get update"]
    }

    file { "apache2-conf":
        path    => "/etc/php5/cgi/php.ini",
        ensure  => file,
        require => Package["php5"],
        source  => "/vagrant/vagrant/support/php.ini",
        notify  => Service["php5-fpm"]
    }
}
