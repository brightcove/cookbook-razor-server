# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.berkshelf.berksfile_path = "./Berksfile"
  config.berkshelf.enabled = true
  
  config.vm.define "razor-server" do |c|
    c.vm.hostname = "razor-server-berkshelf"
    c.vm.box = "opscode_ubuntu-12.04"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
  
    c.omnibus.chef_version = :latest
    c.vm.network :private_network, ip: "192.168.10.2"
  
    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
  
    # c.vm.network :public_network
  
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
  
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # c.vm.synced_folder "../data", "/vagrant_data"
  
     c.vm.provider :virtualbox do |vb|
       # vb.gui = true
       vb.customize ["modifyvm", :id, "--memory", "1024"]
     end
  
    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to exclusively install and copy to Vagrant's shelf.
    # c.berkshelf.only = []
  
    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to skip installing and copying to Vagrant's shelf.
    # c.berkshelf.except = []
  
    c.vm.provision :chef_solo do |chef|
      chef.json = {
      }
  
      chef.run_list = [
          "recipe[razor-server::default]"
      ]
    end
  end
end
