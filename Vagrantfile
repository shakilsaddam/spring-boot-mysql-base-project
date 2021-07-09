ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|
  #config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "kubmaster" do |kubmaster|
    kubmaster.vm.box = "bento/ubuntu-20.04"
    kubmaster.vm.hostname = "kubmaster.example.com"
    kubmaster.vm.network "private_network", ip: "192.168.57.100"
    kubmaster.vm.network "forwarded_port", guest: 30080, host: 30080
    kubmaster.vm.network "forwarded_port", guest: 30081, host: 30081
    kubmaster.vm.provider "virtualbox" do |v|
      v.name = "kubmaster"
      v.memory = 2048
      v.cpus = 2
    end
    kubmaster.vm.provision "shell", path: "k8s-setup/bootstrap.sh"
    kubmaster.vm.provision "shell", path: "k8s-setup/bootstrap_kmaster_flannel.sh"
  end

  NodeCount = 2

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "kubeworker#{i}" do |workernode|
      workernode.vm.box = "bento/ubuntu-20.04"
      workernode.vm.hostname = "kubeworker#{i}.example.com"
      workernode.vm.network "private_network", ip: "192.168.57.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "kubeworker#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      workernode.vm.provision "shell", path: "k8s-setup/bootstrap.sh"
      workernode.vm.provision "shell", path: "k8s-setup/bootstrap_kworker.sh"
    end
  end

  # Jenkins Server Installation
  config.vm.define "jenkinsserver" do |jenkinsserver|
    jenkinsserver.vm.box = "bento/ubuntu-20.04"
    jenkinsserver.vm.hostname = "jenkins.example.com"
    jenkinsserver.vm.network "private_network", ip: "192.168.57.200"
    jenkinsserver.vm.network "forwarded_port", guest: 8080, host: 8080
    jenkinsserver.vm.provider "virtualbox" do |v|
      v.name = "jenkinsserver"
      v.memory = 2048
      v.cpus = 2
    end
    jenkinsserver.vm.provision "shell" do |s|
      s.path = 'jenkins-setup/jenkins-master.sh'
    end
  end

end