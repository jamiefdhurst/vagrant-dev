class mailcatcher {
  $packages = ["libsqlite3-dev"]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  package { 'mailcatcher':
    ensure   => installed,
    provider => gem,
    require => Package['libsqlite3-dev'],
  }

  file { '/etc/init/mailcatcher.conf':
    content => template('mailcatcher/upstart.erb'),
    alias => 'mailcatcher.conf'
  }

  service { 'mailcatcher':
    ensure => running,
    require => [
      File['mailcatcher.conf'],
      Package["mailcatcher"]
    ],
    provider => upstart,
    hasstatus => true,
  }
}