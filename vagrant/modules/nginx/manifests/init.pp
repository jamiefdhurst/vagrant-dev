class nginx {

  package { "nginx":
    ensure => present,
    require => Package["build-essential"],
  }

  service { "nginx":
    ensure => running,
    require => Package["nginx"],
  }

  file { "nginx-conf":
    path    => "/etc/nginx/nginx.conf",
    ensure  => file,
    require => Package["nginx"],
    content  => template("nginx/nginx.erb"),
    notify  => Service["nginx"],
  }

  file { "default-nginx":
    path    => "/etc/nginx/sites-enabled/vagrant",
    ensure  => file,
    require => Package["nginx"],
    content  => template("nginx/nginx-site.erb"),
    notify  => Service["nginx"],
  }
}
