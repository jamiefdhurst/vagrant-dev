class phpmyadmin {
        package {
            ["phpmyadmin"]: 
            ensure => latest, require => Exec['apt-get update']
        }

    file { "/etc/phpmyadmin/config.inc.php":
        owner => 'root',
        group => 'root',
        mode => 644,
        source => '/vagrant/vagrant/manifests/phpmyadmin/config.inc.php',
        require => Package["phpmyadmin"],
    }

    file { "/etc/phpmyadmin/config-db.php":
        owner => 'root',
        group => 'root',
        mode => 644,
        source => '/vagrant/vagrant/manifests/phpmyadmin/config-db.php',
        require => Package["phpmyadmin"],
    }

    file { '/etc/apache2/conf.d/phpmyadmin.conf':
        ensure => link,
        target => "/etc/phpmyadmin/apache.conf",
        force  => true,
        require => Package["phpmyadmin"]
    }
}
