ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure("2") do |config|

  config.vm.define "my-puppet-base-container" do |m|
  
    m.vm.provider "docker" do |master|
        master.build_dir = "."
		master.cmd=["ping", "-c 551", "127.0.0.1"] 		
	    master.name = 'my-puppet-base-container'
        master.vagrant_machine = "dockerhostvm"
        master.vagrant_vagrantfile = "../vagrant-docker-simple/DockerHostVagrantfile" 
    end
    m.vm.hostname  = "my.host"
    m.vm.synced_folder "files", "/u01/files"
    m.vm.synced_folder "puppet", "/u01/puppet"
  end

  config.vm.define "my-complete-container" do |m|
  
    m.vm.provider "docker" do |master|
        master.image = "me/my-image:version1"
		master.cmd=["ping", "-c 551", "127.0.0.1"] 		
	    master.name = 'my-complete-container'
        master.vagrant_machine = "dockerhostvm"
        master.vagrant_vagrantfile = "../vagrant-docker-simple/DockerHostVagrantfile" 
    end

        m.vm.synced_folder "runtime-files", "/u01/runtime-stuff"

	end
  
end

# steps:
# puppet/manifests/base.pp contains Puppet manifest
# files contains installation files
# vagrant up my-puppet-base-container
# vagrant ssh into dockerhostvm
# docker ps -a  to find container id
# docker start container id
# docker exec -it container id bash "/u01/run2Puppet.sh"
# docker commit containerId  me/my-image:version1
# vagrant up my-complete-container
 
 # vagrant docker-run my-complete-container -t -- bash