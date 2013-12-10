# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include bootstrap

if $install_rails == 1 {
  include rails
} else {
  include $service
  include php

  if $composer == 1 {
    include composer
  }
}

if $database != "" {
  include $database
}

if $sendmail == 1 {
  include sendmail
}

if $mailcatcher == 1 {
  include mailcatcher
}

if $memcache == 1 {
  include memcache
}