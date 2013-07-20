Vagrant.configure("2") do |config|

    # Use Ubuntu LTS 12.04
    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    # Configure virtualbox to allow 512MB memory and symlinks
    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    # Set up network for HTTP/HTTPS and MySQL
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 443, host: 8443
    config.vm.network :forwarded_port, guest: 1080, host: 1080
    config.vm.network :forwarded_port, guest: 3306, host: 3306

    # Load up all the modules
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "vagrant/manifests"
        puppet.module_path = "vagrant/modules"

        # Uncomment to use either apache or nginx
        puppet.manifest_file = "apache.pp"
        #puppet.manifest_file = "nginx.pp"
    end
end