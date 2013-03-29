Vagrant.configure("2") do |config|

    # Use Ubuntu LTS 12.04
    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    # Set up network for HTTP/HTTPS and MySQL
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 443, host: 8443
    config.vm.network :forwarded_port, guest: 3306, host: 3306

    # Configure virtualbox to allow 512MB memory and symlinks
    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    # Use the provision script
    config.vm.provision :shell do |shell|

        # Set a name for your vm
        shell.args = "'vagrant-dev'"

        # Uncomment as necessary for apache2 or nginx
        #shell.path = "env/provision-apache2.sh"
        shell.path = "env/provision-nginx.sh"

    end

end