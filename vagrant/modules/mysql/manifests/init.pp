class mysql {
  $packages = ["mysql-server", "mysql-client", "php5-mysql"]

  package { $packages:
    ensure => present,
    require => Package["php5"]
  }

  service { "mysql":
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
    require => [
      Package["mysql-server"],
      Package["mysql-client"]
    ],
    notify => Service["mysql"],
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
    unless => "cat /root/mysql-1",
    path => ["/bin", "/usr/bin"],
    command => "echo \"create user 'root'@'%' identified by '$db_password';\" | mysql -u root -p$db_password; echo '1' > /root/mysql-1",
  }

  exec { "mysql grant privileges":
    require => Exec["mysql user"],
    unless => "cat /root/mysql-2",
    path => ["/bin", "/usr/bin"],
    command => "echo \"grant all privileges on *.* to 'root'@'%' with grant option;\" | mysql -u root -p$db_password; echo '1' > /root/mysql-2",
  }

  exec { "mysql flush privileges":
    require => Exec["mysql grant privileges"],
    unless => "cat /root/mysql-3",
    path => ["/bin", "/usr/bin"],
    command => "echo \"flush privileges;\" | mysql -u root -p$db_password; echo '1' > /root/mysql-3",
    notify => Service["mysql"]
  }
}
