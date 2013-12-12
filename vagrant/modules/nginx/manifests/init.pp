class nginx {

  if $rails == 1 {
    exec { "install passenger":
      command => "${sudo} 'gem install passenger'",
      require => Package["build-essential"],
    }

    exec { "install nginx":
      command => "${sudo} 'rvmsudo passenger-install-nginx-module'",
      require => Exec["install passenger"],
    }

    $require = Exec["install nginx"]
  } else {
    package { "nginx":
      ensure => present,
      require => Package["build-essential"],
    }

    $require = Package["nginx"]
  }

  service { "nginx":
    ensure => running,
    require => $require,
  }

  file { "nginx-conf":
    path    => "/etc/nginx/nginx.conf",
    ensure  => file,
    require => $require,
    content  => template("nginx/nginx.erb"),
    notify  => Service["nginx"],
  }

  file { "default-nginx":
    path    => "/etc/nginx/sites-available/vagrant",
    ensure  => file,
    require => $require,
    content  => template("nginx/nginx-site.erb"),
    notify  => Service["nginx"],
  }

  file { "vagrant":
    path    => "/etc/nginx/sites-enabled/vagrant",
    ensure  => link,
    require => $require,
    target  => "/etc/nginx/sites-available/vagrant",
    notify  => Service["nginx"],
  }
}
