# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/ubuntu-20.04" 
  config.vm.provider "virtualbox" do |vb|
        vb.memory = "1516"
  end

  # Server (nomad / consul)
  config.vm.define "server-dc1-1" do |n|
    n.vm.provision "shell", path: "node-install-dc1.sh"
    n.vm.provision "shell", path: "launch-dc1-server.sh", run: 'always'
    # Expose the nomad ports
    n.vm.network "forwarded_port", guest: 4646, host: 4646, auto_correct: true
    n.vm.network "forwarded_port", guest: 8500, host: 8500, auto_correct: true
    n.vm.network "forwarded_port", guest: 9998, host: 9998, auto_correct: true
    n.vm.network "forwarded_port", guest: 9966, host: 9966, auto_correct: true
    n.vm.hostname = "server-dc1-1"
    n.vm.network "private_network", ip: "172.16.1.101"
  end

  # 3-node configuration - Region A
  (2..3).each do |i|
    config.vm.define "client-dc1-#{i}" do |n|
      n.vm.provision "shell", path: "node-install-dc1.sh"
      n.vm.provision "shell", path: "launch-dc1-client.sh", run: 'always'
      #if i == 1
        # Expose the nomad ports
        #n.vm.network "forwarded_port", guest: 4646, host: 4646, auto_correct: true
        #n.vm.network "forwarded_port", guest: 8500, host: 8500, auto_correct: true
      #end
      n.vm.hostname = "client-dc1-#{i}"
      n.vm.network "private_network", ip: "172.16.1.#{i+100}"
    end
  end

end
