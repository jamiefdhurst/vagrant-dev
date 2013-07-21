class mysql {

    package { ["mysql-server-5.5", "mysql-client-5.5"]:
        ensure => present,
        require => Exec["apt-get update"]
    }

    file { "my-cnf":
        path    => "/etc/mysql/my.cnf",
        ensure  => file,
        require => Package["mysql-server-5.5"],
        source  => "/vagrant/vagrant/support/my.cnf",
        #notify  => Service["mysql"]
    }

    exec { "mysql-setup1":
        command => "mysqladmin -u root password 'root'",
        unless  => "mysqladmin -u root -p'root' status > /dev/null",
        require => Package["mysql-server-5.5", "mysql-client-5.5"]
    }

    exec { "mysql-setup2":
        command => "echo \"create user 'root'@'%' identified by 'root'; grant all privileges on *.* to 'root'@'%' with grant option; flush privileges;\" | mysql -u root -proot",
        require => Exec["mysql-setup1"],
        unless  => "cat /etc/mysql/my.complete > /dev/null"
    }

    file { "my-complete":
        path    => "/etc/mysql/my.complete",
        content => "COMPLETE",
        require => Exec["mysql-setup2"]
    }

}