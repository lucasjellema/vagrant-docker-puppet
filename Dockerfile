FROM ubuntu:14.04


RUN mkdir /u01 && \ 
    chmod a+xr /u01 

## to enable Puppet - see https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html

 RUN apt-get install -q -y wget
 RUN wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
 RUN dpkg -i puppetlabs-release-trusty.deb
 RUN apt-get update
 RUN  apt-get install -q -y puppet

COPY /files/runPuppet.sh /u01/  
RUN chmod a+rwx /u01/runPuppet.sh
WORKDIR /u01
# next line : see http://stackoverflow.com/questions/4918249/cd-does-not-work-in-shell-script
RUN tr -d "\r" < runPuppet.sh > run2Puppet.sh
