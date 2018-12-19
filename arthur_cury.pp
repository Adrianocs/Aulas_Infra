$instalar = ["vim","figlet"]

package { $instalar: 
	ensure => present,
}

exec { 'memoria_free':
	command => '/usr/bin/free -h > /root/memfree',
}

file {'/tmp/memfree':
	source => "/root/memfree",
	ensure => present,
}

service { 'cron':
	enable => false,
	ensure => stopped,
}
