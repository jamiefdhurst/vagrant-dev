# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include bootstrap
include $service
include php
if $database != "" {
  include $database
}
include sendmail
if $composer == 1 {
  include composer
}
if $mailcatcher == 1 {
  include mailcatcher
}
if $memcache == 1 {
  include memcache
}