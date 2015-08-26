# vagrant-docker-puppet
Example of using Vagrant to provide Docker (host plus container) and subsequently Puppet for the detailed provisioning of the Docker container.

This can be useful when:
* the Dockerfile becomes very complex 
* Puppet is your preferred tool for configuring(certain aspects of)  environments
* during the container build process you want to make use of large files and/or intermediate files that you want not to be included in the layers underneath your container (or image)

The steps are:

vagrant up my-puppet-base-container => to provision the dockerhostvm (if required) and the Puppet enabled docker container
vagrant ssh into dockerhostvm 
docker ps -a  to find container id for the Docker container my-puppet-base-container
docker start container id  => this container runs with volume (folder mappings) to the host-folders files and puppet
docker exec -it container id bash "/u01/run2Puppet.sh" => this script runs puppet apply on the base.pp manifest 
note: the local folder puppet/manifests contains Puppet manifest base.pp

docker commit containerId  me/myimage:version1 => create an image for the current state of the container
vagrant up my-complete-container 

note: my-complete-container has a folder mapping to the local directory runtime-files (just to show that it is easy to do); it does not have the folder-mappings to files and puppet that my-puppet-base-container used.

