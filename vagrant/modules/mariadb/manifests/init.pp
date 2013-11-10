class mariadb {

  $packages = ["mariadb-server"]

  # Add new repo.
  file { "add-repositories mariadb":
    path    => "/etc/apt/sources.list.d/mariadb.list",
    ensure  => file,
    content  => template("mariadb/repo.erb"),
    notify  => [Service[$service], Exec["apt-get update"]]
  }

  exec { "add-key mariadb":
    require => File["add-repositories mariadb"],
    path => ["/bin", "/usr/bin"],
    command => "echo 'Please wait...' && sudo apt-get update 2> keys > /dev/null && sed -i '/NO_PUBKEY/!d;s/.*NO_PUBKEY //' keys && gpg --keyserver keyserver.ubuntu.com --recv-keys $(cat keys) && gpg --export --armor $(cat keys) | sudo apt-key add - && rm -f keys"
  }

  package { $packages:
    ensure => latest,
    require => [
      Package["php5"],
      Exec["add-key mariadb"]
    ],
  }

  service { "mysql":
    ensure => running,
    require => Package["mariadb-server"],
  }

  file { "mysql config":
    path => "/etc/mysql/my.cnf",
    ensure => file,
    content => template("mysql/conf.erb"),
    notify => Service["mysql"]
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
