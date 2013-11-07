class mailcatcher {
  $packages = ["sqlite3", "libsqlite3-dev"]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  package { 'mailcatcher':
    ensure   => 'installed',
    provider => 'gem',
  }

  service { 'mailcatcher':
    ensure => running,
    require => Package["mailcatcher"],
    provider => upstart,
    hasstatus => true,
    subscribe => Class['mailcatcher::configs'],
  }
}