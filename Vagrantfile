$ansible=<<-EOF
    ansible-galaxy install geerlingguy.mysql
EOF

$hosts=<<-EOF
    sudo echo "10.10.10.3 host1" >> /etc/hosts
    sudo echo "10.10.10.4 host2" >> /etc/hosts
EOF

machines = {
    "control-node" => {"memory" => "2048", "cpu" => "4", "ip" => "2", "image" => "generic/oracle8", "name" => "control-node"},
    "host1" => {"memory" => "2048", "cpu" => "4", "ip" => "3", "image" => "ubuntu/focal64", "name" => "host1"},
    "host2" => {"memory" => "2048", "cpu" => "4", "ip" => "4", "image" => "generic/oracle8", "name" => "host2"}
}

Vagrant.configure("2") do |config|
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"  
      machine.vbguest.auto_update = false
      #machine.vbguest.installer_options = { allow_kernel_upgrade: true }    
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "10.10.10.#{conf["ip"]}"
      machine.vm.synced_folder ".", "/vagrant", type: "nfs"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        vb.customize ["modifyvm", :id, "--groups", "/Ansible-Lab"]
      end
      machine.vm.provision "shell", inline: <<-SHELL
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
        systemctl restart sshd.service                
        SHELL
      if "#{conf["name"]}" == "control-node"              
        machine.vm.provision "shell", path: "provision.sh"
        machine.vm.provision "shell", path: "generate_ssh_key.sh", privileged: false
        machine.vm.provision "shell", inline: $ansible, privileged: false    
        machine.vm.provision "file", source: ".vimrc", destination: "~/.vimrc"
        machine.vm.provision "shell", inline: $hosts          

      elsif "#{conf["name"]}" == "host1"               
        machine.vm.provision "shell", path: "ssh_key.sh"        

      elsif "#{conf["name"]}" == "host2"              
        machine.vm.provision "shell", path: "ssh_key.sh"    
      end
    end
  end
end
