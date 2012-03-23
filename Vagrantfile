Vagrant::Config.run do |config|
    config.vm.box = "debian-squeeze-64"
    config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/jamiehurst/vagrant/debian-squeeze-64.box"
    
    config.ssh.max_tries = 50
    config.ssh.timeout = 300

    config.vm.forward_port 80, 8080
    config.vm.forward_port 3306, 3306

    # Enable this line to modify the memory the VM has allocated
    #config.vm.customize ["modifyvm", :id, "--memory", "512"]

    Vagrant::Config.run do |config|

        config.vm.provision :chef_solo do |chef|
            chef.log_level = :info
            chef.cookbooks_path = "env/chef/cookbooks"
            chef.roles_path = "env/chef/roles"
            
            # Only enable one role below
            #chef.add_role("apache2")
            chef.add_role("nginx")
        end

    end

end