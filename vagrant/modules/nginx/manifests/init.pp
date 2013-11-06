class nginx {

  package { "nginx":
    ensure => present,
  }
 
  service { "nginx":
    ensure => running,
    require => Package["nginx"],
  }
 
  file { "default-apache2":
    path    => "/etc/apache2/sites-available/default",
    ensure  => file,
    require => Package["apache2"],
    source  => "/vagrant/vagrant/manifests/default.vhost",
    notify  => Service["apache2"]
  }
}
