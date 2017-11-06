Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"

  config.vm.hostname = "sensu-workshop-01"

# Note that the line below is for a linux host. For OS X, change this to `en0` or the interface provided in `ifconfig`
  config.vm.network "public_network", type: "dhcp"

  config.vm.provision "shell", path: "sensu-provisioning-script.sh"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
end
