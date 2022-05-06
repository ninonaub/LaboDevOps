# -*- mode: ruby -*-
# vi: set ft=ruby :
 
Vagrant.configure("2") do |config|

    # Configs for web server 1
    config.vm.define :webserver1 do |web1|
        web1.vm.box = 'debian/buster64'
            web1.vm.box_check_update = true
        web1.vm.hostname = "web1"
        web1.vm.network "private_network", ip: "192.168.50.10"
            web1.vm.synced_folder "../data", "/vagrant_data", disabled: true
        web1.vm.synced_folder "./web1", "/var/www/html", owner: "vagrant", group: "www-data"
        web1.vm.provision :shell, path: "webserver.sh"

        web1.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", "1024"]
            vb.customize ["modifyvm", :id, "--name", "Frontend_1"]
                vb.gui = false
        end
    end
 
    # # Configs for web server 2
    config.vm.define :webserver2 do |web2|
        web2.vm.box = 'debian/buster64'
            web2.vm.box_check_update = true
        web2.vm.hostname = "web2"
        web2.vm.network "private_network", ip: "192.168.50.10"
            web2.vm.synced_folder "../data", "/vagrant_data", disabled: true
        web2.vm.synced_folder "./web2", "/var/www/html", owner: "vagrant", group: "www-data"
        web2.vm.provision :shell, path: "webserver.sh"

        web2.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", "1024"]
            vb.customize ["modifyvm", :id, "--name", "Frontend_1"]
                vb.gui = false
        end
    end
    
    # Configs for db server 1
    # config.vm.define "db1" do |db1|
    #     db1.vm.box = 'debian/buster64'
    #     db1.vm.box_check_update = true
    #     db1.vm.hostname = "db1"
    #     db1.vm.network "private_network", ip: "192.168.50.30"
    #     db1.vm.synced_folder "../data", "/vagrant_data", disabled: true
    #     db1.vm.synced_folder "./db1", "/var/www/html", owner: "vagrant", group: "www-data"
    #     db1.vm.provision :shell, path: "dbserver.sh"
    
    #     db1.vm.provider "virtualbox" do |vb|
    #       vb.customize ["modifyvm", :id, "--memory", "1024"]
    #       vb.customize ["modifyvm", :id, "--name", "LABAD10-S3-DB"]
    #           vb.gui = false
    #     end
    # end

    # Configs for haproxy
    config.vm.define :haproxy do |loadbalancer|
        loadbalancer.vm.box = 'debian/buster64'
        loadbalancer.vm.box_check_update = true
        loadbalancer.vm.hostname = "loadbalancer"
        loadbalancer.vm.synced_folder "../data", "/vagrant_data", disabled: true
        loadbalancer.vm.network :forwarded_port, guest: 80, host: 8080
        loadbalancer.vm.network "private_network", ip: "192.168.50.40"
        loadbalancer.vm.provision :shell, path: "haproxy.sh"
        loadbalancer.vm.provider :virtualbox do |vb_config|
            vb_config.name = "Loadbalancer"
        end
    end

    # config.vm.define "bastion" do |bastion|
    #     bastion.vm.network "private_network", ip: "10.0.1.5"
    #     bastion.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    #     bastion.vm.provision :shell, path: "bastionserver.sh"
    # end

end