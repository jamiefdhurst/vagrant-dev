class passenger {
  exec { "install passenger":
    command => "${sudo} 'gem install passenger'",
    require => Exec['install ruby'],
  }
}