class php {
    $packages = ["php5", "php5-cli", "php5-dev", "php5-gd", "php5-mcrypt", "php5-curl", "php5-fpm"]

    package { $packages:
        ensure => present,
        require => Exec["apt-get update"]
    }
}
