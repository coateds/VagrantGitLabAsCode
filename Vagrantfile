Vagrant.configure("2") do |config|
  # Use this line to prevent (time consuming!) upgrade of Guest Additions
  # vbguest docs:  https://github.com/dotless-de/vagrant-vbguest
  # config.vbguest.auto_update = false

  config.vm.box = "bento/centos-7.5"
  # config.vm.network "private_network", type: "dhcp"
  config.vm.network :private_network, ip: "192.168.16.8"
  config.vm.hostname = "GitLabAsCode"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "GitLabAsCode"
    vb.gui = true  # brings up the vm in gui window
    vb.customize ["modifyvm", :id, "--vram", "128"]  # vid RAM
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]    
    vb.memory = 4096
    vb.cpus = 2  
  end

  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    chef.nodes_path = "nodes"
    chef.roles_path = "roles"

    chef.add_recipe "gitlab-as-code::default"
    chef.add_recipe "gitlab-as-code::hosts-file"
    chef.add_recipe "gitlab-as-code::tz"
    chef.add_recipe "gitlab-as-code::system-updates"
    chef.add_recipe "gitlab-as-code::install-gitlab"
  end
end