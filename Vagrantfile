
Vagrant.configure(2) do |config|

  config.vm.box = "puphpet/debian75-x64"
  config.vm.hostname = "monito24"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "public_network", bridge: "en1: Wi-Fi (AirPort)", :use_dhcp_assigned_default_route => true

  config.vm.synced_folder "data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1024"
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision "shell", path: "bootstrap.sh"

end
