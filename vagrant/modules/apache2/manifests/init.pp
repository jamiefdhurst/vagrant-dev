class apache2 {

  package { ["apache2", "libapache2-mod-php5"]:
    ensure => present,
    require => Package["build-essential"],
  }
 
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
 
  file { "default-apache2":
    path    => "/etc/apache2/sites-available/default",
    ensure  => file,
    require => Package["apache2"],
    content  => template("apache2/apache.erb"),
    notify  => Service["apache2"],
  }

  file { "rewrite.load":
    path    => "/etc/apache2/mods-enabled/rewrite.load",
    ensure  => link,
    require => Package["apache2"],
    target  => "/etc/apache2/mods-available/rewrite.load",
    notify  => Service["apache2"],
  }
}
