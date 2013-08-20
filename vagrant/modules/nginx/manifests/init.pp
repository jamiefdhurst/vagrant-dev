class nginx {

  package { ["nginx"]:
    ensure => present,
    require => Exec["apt-get update"]
  }

  service { "nginx":
    ensure => running,
    require => Package["nginx"],
  }

  file { "nginx-conf":
    path    => "/etc/nginx/nginx.conf",
    ensure  => file,
    require => Package["nginx"],
    source  => "/vagrant/vagrant/support/nginx.conf",
    notify  => Service["nginx"]
  }

  file { "default-nginx":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => file,
    require => Package["nginx"],
    source  => "/vagrant/vagrant/support/nginx-site",
    notify  => Service["nginx"]
  }
}