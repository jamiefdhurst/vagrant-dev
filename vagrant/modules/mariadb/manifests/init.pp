class mariadb {

  $packages = ["mariadb-server"]

  # Add new repo.
  file { "add-repositories mariadb":
    path    => "/etc/apt/sources.list.d/mariadb.list",
    ensure  => file,
    content  => template("mariadb/repo.erb"),
    notify  => [Service[$service], Exec["apt-get update"]]
  }

  package { $packages:
    ensure => latest,
    require => [
      Package["php5"],
      File["add-repositories mariadb"]
    ],
  }

  service { "mysql":
    ensure => running,
    require => Package["mariadb-server"],
  }

  exec { "mysql password":
    require => Package["mariadb-server"],
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
