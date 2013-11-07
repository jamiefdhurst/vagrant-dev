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
    content  => template("/vagrant/vagrant/manifests/nginx.erb"),
    notify  => Service["nginx"]
  }
}
