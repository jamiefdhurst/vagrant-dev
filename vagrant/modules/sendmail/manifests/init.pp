class sendmail {
    $packages = ["sendmail"]

    package { $packages:
        ensure => present,
        require => Exec["apt-get update"]
    }
}
