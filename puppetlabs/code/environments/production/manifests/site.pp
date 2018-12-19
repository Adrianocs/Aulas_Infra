#aqui define quem pode coletar as inforacoes
node "default" {

	include base

}

#aqui defini apenas duas maquinas para coletar o modulo
node /(devops|automation).salas4linux.com.br/ {
	include mera
}

node docker.salas4linux.com.br {
	include arraia_negra
	include docker
}
