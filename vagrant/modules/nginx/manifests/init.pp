class nginx {

  package { "nginx":
    ensure => present,
    require => Package["build-essential"],
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
    notify  => Service["nginx"],
  }

  file { "vagrant":
    path    => "/etc/nginx/sites-enabled/vagrant",
    ensure  => link,
    require => Package["nginx"],
    target  => "/etc/nginx/sites-available/vagrant",
    notify  => Service["nginx"],
  }
}
