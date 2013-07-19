class mysql {

    package { "mysql-server":
        ensure => present,
        require => Exec["apt-get update"]
    }

    file { "my-cnf":
        path    => "/etc/mysql/my.cnf",
        ensure  => file,
        require => Package["mysql-server"],
        source  => "/vagrant/vagrant/support/my.cnf",
        notify  => Service["mysql"]
    }

    exec {
        command => "mysqladmin -u root password 'root'",
        unless  => "mysqladmin -u root -p'$root' status > /dev/null"
    }

    exec {
        command => "echo \"create user 'root'@'%' identified by 'root';\" | mysql -u root -proot",
        unless => "cat /etc/mysql/my-complete > /dev/null"
    }

    exec {
        command => "echo \"grant all privileges on *.* to 'root'@'%' with grant option;\" | mysql -u root -proot",
        unless => "cat /etc/mysql/my-complete > /dev/null"
    }

    exec {
        command => "echo \"flush privileges;\" | mysql -u root -proot",
        unless => "cat /etc/mysql/my-complete > /dev/null"
    }

    file { "/etc/mysql/my-complete":
        content => ""
    }

}