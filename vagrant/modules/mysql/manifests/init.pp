class mysql {
  $packages = ["mysql-server", "mysql-client", "php5-mysql"]

  package { $packages:
    ensure => present,
    require => Package["php5"]
  }
}
