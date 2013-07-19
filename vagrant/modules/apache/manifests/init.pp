class apache {

  $packages = ["apache2", "libapache2-mod-fastcgi"]

  package { $packages:
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  file { "apache2-conf":
    path    => "/etc/apache2/apache2.conf",
    ensure  => file,
    require => Package["apache2"],
    source  => "/vagrant/vagrant/support/apache2.conf",
    notify  => Service["apache2"]
  }

  file { "default-apache2":
    path    => "/etc/apache2/sites-enabled/default",
    ensure  => file,
    require => Package["apache2"],
    source  => "/vagrant/vagrant/support/apache-site",
    notify  => Service["apache2"]
  }

  file { "actions.load":
    path    => "/etc/apache2/mods-enabled/actions.load",
    ensure  => link,
    require => Package["apache2"],
    target  => "/etc/apache2/mods-available/actions.load",
    notify  => Service["apache2"]
  }

  file { "alias.load":
    path    => "/etc/apache2/mods-enabled/alias.load",
    ensure  => link,
    require => Package["apache2"],
    target  => "/etc/apache2/mods-available/alias.load",
    notify  => Service["apache2"]
  }

  file { "fastcgi.load":
    path    => "/etc/apache2/mods-enabled/fastcgi.load",
    ensure  => link,
    require => Package["apache2"],
    target  => "/etc/apache2/mods-available/fastcgi.load",
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
