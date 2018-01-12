#!/bin/bash
# Gera o arquivo docker compose
compose="$1: \n"
compose+="  container_name: $1 \n"
compose+="  image: ubuntu \n"
compose+="  restart: always \n"
compose+="  privileged: true \n"
compose+="  stdin_open: true \n"
compose+="  tty: true \n"
printf "$compose" > docker-compose.yml

# Levanta o container
docker-compose up -d

# Configura as dependencias 
docker exec -it $1 /bin/bash -c 'apt-get update'
docker exec -it $1 /bin/bash -c 'apt-get -y install apache2'
docker exec -it $1 /bin/bash -c 'apt-get -y install apache2-utils'
docker exec -it $1 /bin/bash -c 'apt-get -y install php libapache2-mod-php php-mcrypt php-xml php-mbstring php-gettext'
docker exec -it $1 /bin/bash -c 'apt-get -y install mysql-server'
docker exec -it $1 /bin/bash -c 'apt-get -y install php-mysql'
docker exec -it $1 /bin/bash -c 'apt-get -y install phpmyadmin'
docker exec -it $1 /bin/bash -c 'phpenmod mcrypt && phpenmod mbstring'
docker exec -it $1 /bin/bash -c 'a2enmod rewrite'
docker exec -it $1 /bin/bash -c 'service apache2 restart'
docker exec -it $1 /bin/bash -c 'service mysql restart'
docker exec -it $1 /bin/bash -c 'service apache2 restart'
