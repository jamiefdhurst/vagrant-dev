class php {
    $packages = ["php5", "php5-cli", "php5-mysql", "php5-dev", "php5-gd", "libapache2-mod-php5", "php5-mcrypt", "php5-curl"]

    if $service == "ngnix" {
        $packages.push("php5-fpm") # If the service is nginx let's add php-fastcgi
    }

    package { $packages:
        ensure => present,
        require => Exec["apt-get update"]
    }
}
