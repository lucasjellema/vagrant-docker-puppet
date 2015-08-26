$my_full_name = "developer"
$my_email = "developer@yourorg.domain"
$oracle_password = 'oracle'
$group=oracle

#package { "ubuntu-desktop": ensure => present }

group { "oracle":
	ensure		=> present,
}

user { "oracle":
	ensure		=> present,
	comment		=> "$my_full_name",
	gid			=> "oracle",
#	membership	=> minimum,
	shell		=> "/bin/bash",
	home		=> "/u01/app/oracle",
}

exec { "set-oracle-password":
	command	=> [ "/bin/echo -e \"$oracle_password\\n$oracle_password\\n\" | /usr/bin/passwd oracle && /usr/bin/passwd -u oracle" ],
	unless	=> "/usr/bin/passwd -S oracle|awk '{print $2}'|grep 'oracle P'",
	require	=> User[oracle],
}


exec { "oracle homedir":
	command	=> "/bin/cp -R /etc/skel /home/$username; /bin/chown -R $username:$group /home/$username",
	creates	=> "/home/$username",
	require	=> User[oracle],
}

$oracle_product_home_directories = ["/u01","/u01/app","/u01/app/oracle"]

file { $oracle_product_home_directories:
  ensure => directory,
  group => 'oracle',
  owner => 'oracle',
  require => User[oracle],
}

