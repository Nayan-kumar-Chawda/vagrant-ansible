Vagrant.configure("2") do |config|
  servers=[
    {
      :hostname => "mainnode",
      :box => "ubuntu/bionic64",
      :ip => "192.168.33.10",
      :ssh_port => '2210',
      :boot_timeout => 500,
      :memory => 2048,
      :cpus => 2,
      :primary => true,
      :autostart => true,
      :disable_folder_sync => false,
      :provision_file => "provision/ubuntu_linux.sh"
    },
    {
      :hostname => "rhelnode",
      :box => "generic/rhel7",
      :ip => "192.168.33.20",
      :ssh_port => '2220',
      :boot_timeout => 800,
      :memory => 2048,
      :cpus => 2,
      :primary => false,
      :autostart => true,
      :disable_folder_sync => true,
      :provision_file => "provision/redhat_linux.sh"
    },
    {
      :hostname => "orclnode",
      :box => "generic/oracle7",
      :ip => "192.168.33.30",
      :ssh_port => '2230',
      :boot_timeout => 1200,
      :memory => 2048,
      :cpus => 2,
      :primary => false,
      :autostart => true,
      :disable_folder_sync => true,
      :provision_file => "provision/oracle_linux.sh"
    },
    # {
    #   :hostname => "winnode",
    #   :box => "win2016",
    #   :ip => "192.168.33.40",
    #   :ssh_port => '2240',
    #   :boot_timeout => 1800,
    #   :memory => 4096,
    #   :cpus => 4,
    #   :primary => false,
    #   :autostart => false,
    #   :disable_folder_sync => false,
    #   :provision_file => "provision/<dummy>"
    # }
  ]
  
  $ssh_setup_file = "provision/ssh_setup.sh"

  servers.each do |machine|
    config.vm.define machine[:hostname], primary: machine[:primary], autostart: machine[:autostart] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.boot_timeout = machine[:boot_timeout]
    
      node.vm.network :private_network, ip: machine[:ip]
      node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"

      node.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--memory", machine[:memory]]
        vb.cpus = machine[:cpus]
        vb.customize ["modifyvm", :id, "--name", machine[:hostname]]
      end

      node.vm.provision "shell", path: $ssh_setup_file
      node.vm.provision "shell", path: machine[:provision_file]

      # conditional logic for folder sync
      # if "#{machine[:hostname]}" == "mainnode"
      #   node.vm.synced_folder "./vma/", "/home/vagrant/vma"
      # else
      #   node.vm.synced_folder '.', '/vagrant', disabled: true
      # end

      # parameter data based logic for folder sync
      node.vm.synced_folder "./vma/", "/home/vagrant/vma", owner: "vagrant", group: "vagrant", disabled: machine[:disable_folder_sync]
    end
  end
end