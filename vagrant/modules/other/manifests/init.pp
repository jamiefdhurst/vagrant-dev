class other {
  $packages = ["curl"]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }
}
