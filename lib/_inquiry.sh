#!/bin/bash

get_frontend_url() {
  
  print_banner
  printf "${WHITE} 💻 Digite o domínio da interface web:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_url
}

get_backend_url() {
  
  print_banner
  printf "${WHITE} 💻 Digite o domínio da sua API:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_url
}

get_backend_port() {
  
  print_banner
  printf "${WHITE} 💻 Digite a porta da sua API(BackEnd):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_port
}

get_frontend_port() {
  
  print_banner
  printf "${WHITE} 💻 Digite a porta da sua aplicação (FrontEnd):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_port
}

get_database_name() {
  
  print_banner
  printf "${WHITE} 💻 Digite o nome do banco de dados:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " db_name
}

system_docker_install() {
  print_banner
  printf "${WHITE} 💻 Instalando docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
 
EOF

  sleep 2
}

get_database_instancia() {
  print_banner
  printf "${WHITE} 💻 Configurando banco de dados...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt -y update && apt -y upgrade
  apt install -y apt-transport-https \
                 ca-certificates curl \
                 software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

  apt install -y docker-ce  
  cd /root/2025_whaticket-installer/
  docker compose up -d mysql
  docker compose -f docker-compose.phpmyadmin.yaml up -d 

EOF

  sleep 2
}

get_urls() {
  get_database_name
  get_frontend_url
  get_backend_url  
  get_frontend_port
  get_backend_port
}

software_update() {
  
  frontend_update
  backend_update
}

inquiry_options() {
  
  print_banner
  printf "${WHITE} 💻 O que você precisa fazer?${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [0] Instalar BD\n"
  printf "   [1] Instalar\n"
  printf "   [2] Atualizar\n"
  printf "\n"
  read -p "> " option

  case "${option}" in
    0) get_database_instancia
       exit
       ;;      
    
    1) get_urls ;;

    2) 
      software_update 
      exit
      ;;
    
    *) exit ;;
  esac
}

