# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
   
  config.vm.hostname = 'javaserver'
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox  do |vb|
  	 config.vm.box = "ubuntu-14.04"
     config.vm.box_url = 
        "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
 
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  config.vm.provider :aws do |aws, override|
  	config.vm.box = "dummy"
    config.vm.box_url = "./aws.box"
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.instance_type = "t2.micro"
    aws.region = "us-west-2"   #Oregon
    aws.subnet_id = "subnet-35910d51"
    aws.security_groups = ["sg-4c06a82a", "sg-0fc1b669"]
    aws.region_config "us-west-2" do |region|
      region.ami = "ami-9abea4fb"
      region.keypair_name =  "aws"
    end
    aws.tags = {
      'Name' => 'Javasever'
    }
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/aws.pem"
  end

  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    chef.version = 12.12
    chef.json = {
    }
  
    chef.run_list = [
      "recipe[javaserver::default]",
      "recipe[javaserver::rootapp]"
    ]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
