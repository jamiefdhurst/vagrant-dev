class nginx {

  package { "nginx":
    ensure => present,
  }
 
  service { "nginx":
    ensure => running,
    require => Package["nginx"],
  }
 
  file { "default-nginx":
    path    => "/etc/nginx/sites-available/vagrant",
    ensure  => file,
    require => Package["nginx"],
    source  => "/vagrant/vagrant/manifests/vagrant",
    notify  => Service["nginx"]
  }
}
