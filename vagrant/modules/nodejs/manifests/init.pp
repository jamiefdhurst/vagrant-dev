class nodejs {
  package { "nodejs":
    ensure => present,
    require => Package["build-essential"],
  }
}
