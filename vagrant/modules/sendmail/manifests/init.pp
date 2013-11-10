class sendmail {
    $packages = ["sendmail"]

    package { $packages:
        ensure => present,
        require => Package[$service],
    }
}
