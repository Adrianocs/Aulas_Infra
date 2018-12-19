#class docker{
#	case $::osfamily{
#		"redhat":{
#			$pacotes_RHEL = ["epel-release","yum-utils","device-mapper-*","sysstat","lvm2"]
#		}
#		"debian":{
#			exec{"Atualizar_Repositorio":
#				command => "/usr/bin/apt update"
#			}
#			$pacotes_Ubuntu = ["apt-transport-https","ca-certificates","curl","software-properties-common"]
#			exec {"Download":
#				command => "/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
#			}	
#			exec {"Update Rep":
#				command => "/usr/bin/add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable'",
#			}
#
#		}
#	}
#	package {$pacotes_RHEL:
#		ensure => present,
#	}
#	package {$pacotes_Ubuntu:
#		ensure => present,
#	}
#}


############# CORRECAO
class docker{
	case $::osfamily{
		"redhat":{
			$pacotes = ["yum-utils","device-mapper-persistent-data","lvm2"] #coletando as informações ref a distr,os, e o codename
			$repositorio = "/bin/yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo" #declarou os sites,comandos a serem executados
		}
		"debian":{
			$distro_name = $facts['os']['distro']['codename'] #coletando as informações ref a distr,os, e o codename
			$pacotes = ["apt-transport-https","ca-certificates","curl","software-properties-common"] #declarando os pacotes
			$repositorio = "/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | /usr/bin/apt-key add -;/usr/bin/add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $distro_name stable';/usr/bin/apt update" #declarou os sites,comandos <caminho absoluto> a serem executados
		}
	}
	package {$pacotes: #instala os pacotes de acordo com a distribuicao
		ensure => present,
	}
	exec {"Adicionando Repositorio": #executa os comandos do declarados na variável repositorio
		command => $repositorio
	}
	package {'docker-ce': #instala o pacote docker-ce
		ensure => present,
	}
	service {'docker-ce': #inicia o pacote docker
		ensure => running,
		enable => true,
		require => Package['docker-ce'] #executa após a execucao do package'docker-ce'
	}
}
