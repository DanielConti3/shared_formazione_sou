# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "host1" do |host1|
    host1.vm.box = "rockylinux/9"
    host1.vm.hostname = "host1"
    host1.vm.network "private_network", ip: "192.168.50.112"
    host1.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.inventory_path = "inventario"
      ansible.config_file = "ansible.cfg"
      ansible.compatibility_mode = "2.0"
      ansible.become = true
    end
  end
end
