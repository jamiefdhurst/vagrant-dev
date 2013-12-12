class rails {
  if $rails_ver != '' {
    $rails_cmd = "${sudo} 'gem install rails -v=${rails_ver} --no-rdoc --no-ri'"
  } else {
    $rails_cmd = "${sudo} 'gem install rails --no-rdoc --no-ri'"
  }

  exec { "install rails":
    command => $rails_cmd,
  }
}