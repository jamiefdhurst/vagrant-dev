class apache {

  package { "apache2":
    ensure => present,
  }
 
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
 
  file { "default-apache2":
    path    => "/etc/apache2/sites-available/default",
    ensure  => file,
    require => Package["apache2"],
    source  => "/vagrant/vagrant/manifests/default.vhost",
    notify  => Service["apache2"]
  }

  file { "rewrite.load":
    path    => "/etc/apache2/mods-enabled/rewrite.load",
    ensure  => link,
    require => Package["apache2"],
    target  => "/etc/apache2/mods-available/rewrite.load",
    notify  => Service["apache2"]
  }
}
