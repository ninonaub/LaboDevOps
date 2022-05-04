# -*- mode: ruby -*-
# vi: set ft=ruby :
 
Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    # Configs for web server 1
    config.vm.define :webserver1 do |web1|
        web1.vbguest.installer_options = { allow_kernel_upgrade: true }
        web1.vm.provider :virtualbox do |vb_config|
            vb_config.name = "Frontend 1"
        end
        web1.vm.hostname = "web1"
        web1.vm.network "private_network", ip: "192.168.50.10"
        #web1.vm.synced_folder "../data", "/vagrant_data", disabled: true
        web1.vm.synced_folder "./web1", "/var/www/html", owner: "vagrant"
        web1.vm.provision :shell, path: "webserver.sh"
    end
 
    # Configs for web server 2
    config.vm.define :webserver2 do |web2|
        web2.vm.provider :virtualbox do |vb_config|
            vb_config.name = "Frontend 2"
        end
        web2.vm.hostname = "web2"
        web2.vm.network "private_network", ip: "192.168.50.20"
        #web2.vm.synced_folder "../data", "/vagrant_data", disabled: true
        web2.vm.synced_folder "./web2", "/var/www/html", owner: "vagrant"
        web2.vm.provision :shell, path: "webserver.sh"
    end
    
    # Configs for db server 1
    config.vm.define "db1" do |db1|
        db1.vm.box = 'debian/buster64'
        db1.vm.box_check_update = true
        db1.vm.network "private_network", ip: "192.168.50.30"
        db1.vm.synced_folder "../data", "/vagrant_data", disabled: true
        db1.vm.synced_folder "./db1", "/var/www/html", owner: "vagrant", group: "www-data"
        db1.vm.provision :shell, path: "dbserver.sh"
    
        db1.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", "1024"]
          vb.customize ["modifyvm", :id, "--name", "LAB AD10 - S3 - DB"]
              vb.gui = false
        end
      end

    # Configs for haproxy
    config.vm.define :haproxy do |loadbalancer|
        loadbalancer.vm.provider :virtualbox do |vb_config|
            vb_config.name = "Loadbalancer"
        end
        loadbalancer.vm.hostname = "loadbalancer"
        loadbalancer.vm.network :forwarded_port, guest: 80, host: 8080
        loadbalancer.vm.network "private_network", ip: "192.168.50.40"
        loadbalancer.vm.provision :shell, path: "haproxy.sh"
    end

    config.vm.define "bastion" do |bastion|
        bastion.vm.network "private_network", ip: "192.168.50.50"
        config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
        loadbalancer.vm.provision :shell, path: "findip.sh"
    end
      
    
    # take your public key and insert it into the host authorized_keys
    # both for vagrant as for root
    config.ssh.forward_agent    = true
    config.ssh.insert_key       = false
    config.ssh.private_key_path =  ["~/.vagrant.d/insecure_private_key","~/.ssh/id_rsa"]
    config.vm.provision :shell, privileged: false do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
        s.inline = <<-SHELL
            touch /home/$USER/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /home/$USER/.ssh/authorized_keys
        SHELL
    end
end