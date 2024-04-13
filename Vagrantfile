# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

VAGRANT_BOX         = "ubuntu/jammy64"
VAGRANT_BOX_VERSION = "20240207.0.0"
CPUS_MASTER_NODE    = 2
CPUS_WORKER_NODE    = 2
MEMORY_MASTER_NODE  = 6144
MEMORY_WORKER_NODE  = 4096
WORKER_NODES_COUNT  = 2


Vagrant.configure(2) do |config|

  config.vm.synced_folder "src/", "/srv/join"

  config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "master" do |node|

    node.vm.box               = VAGRANT_BOX
    node.vm.box_check_update  = false
    node.vm.box_version       = VAGRANT_BOX_VERSION
    node.vm.hostname          = "master.example.com"

    node.vm.network "private_network", ip: "172.16.16.100"

    node.vm.provider :virtualbox do |v|
      v.name    = "master"
      v.memory  = MEMORY_MASTER_NODE
      v.cpus    = CPUS_MASTER_NODE
    end

    node.vm.provider :libvirt do |v|
      v.memory  = MEMORY_MASTER_NODE
      v.nested  = true
      v.cpus    = CPUS_MASTER_NODE
    end

    node.vm.provision "shell", path: "bootstrap_master.sh"

  end


  # Kubernetes Worker Nodes
  (1..WORKER_NODES_COUNT).each do |i|

    config.vm.define "worker#{i}" do |node|

      node.vm.box               = VAGRANT_BOX
      node.vm.box_check_update  = false
      node.vm.box_version       = VAGRANT_BOX_VERSION
      node.vm.hostname          = "worker#{i}.example.com"

      node.vm.network "private_network", ip: "172.16.16.10#{i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "worker#{i}"
        v.memory  = MEMORY_WORKER_NODE
        v.cpus    = CPUS_WORKER_NODE
      end

      node.vm.provider :libvirt do |v|
        v.memory  = MEMORY_WORKER_NODE
        v.nested  = true
        v.cpus    = CPUS_WORKER_NODE
      end

      node.vm.provision "shell", path: "bootstrap_worker.sh"

    end

  end

end
