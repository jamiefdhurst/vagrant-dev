class ruby {
  exec { 'install rvm':
    command => "${sudo} 'curl -L https://get.rvm.io | bash -s stable'",
    creates => "${home}/.rvm/bin/rvm",
    require => Package['curl'],
  }

  exec { 'install ruby':
    # We run the rvm executable directly because the shell function assumes an
    # interactive environment, in particular to display messages or ask questions.
    # The rvm executable is more suitable for automated installs.
    #
    # Thanks to @mpapis for this tip.
    command => "${sudo} '${home}/.rvm/bin/rvm install ${ruby_version} --latest-binary --autolibs=enabled && rvm --fuzzy alias create default ${ruby_version}'",
    creates => "${home}/.rvm/bin/ruby",
    require => Exec['install rvm'],
  }

  # Make sure all bundles are installed.
  exec { "${sudo} 'gem install bundler --no-rdoc --no-ri'":
    creates => "${home}/.rvm/bin/bundle",
    require => Exec['install ruby'],
  }
}