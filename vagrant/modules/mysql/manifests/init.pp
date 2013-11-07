class mysql {
  $packages = ["mysql-server", "mysql-client", "php5-mysql"]

  package { $packages:
    ensure => present,
    require => Package["php5"]
  }

  service { "mysqld":
    ensure => running,
    require => [
      Package["mysql-server"],
      Package["mysql-client"]
    ],
  }

  file { "mysql config":
    path => "/etc/mysql/my.cnf",
    ensure => file,
    content => template("mysql/conf.erb"),
    notify => Service["mysqld"]
  }

  exec { "mysql password":
    require => [
      Package["mysql-server"],
      Package["mysql-client"]
    ],
    unless => "mysqladmin -uroot -p$db_password status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password $db_password",
  }

  exec { "mysql user":
    require => Exec["mysql password"],
    path => ["/bin", "/usr/bin"],
    command => "echo \"create user 'root'@'%' identified by '$db_password';\" | mysql -u root -p$db_password",
  }

  exec { "mysql grant privileges":
    require => Exec["mysql user"],
    path => ["/bin", "/usr/bin"],
    command => "echo \"grant all privileges on *.* to 'root'@'%' with grant option;\" | mysql -u root -p$db_password",
  }

  exec { "mysql flush privileges":
    require => Exec["mysql grant privileges"],
    path => ["/bin", "/usr/bin"],
    command => "echo \"flush privileges;\" | mysql -u root -p$db_password",
    notify => Service["mysqld"]
  }
}
