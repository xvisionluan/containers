#!/bin/bash
# Gera o arquivo docker compose
compose="$1: \n"
compose+="  container_name: $1 \n"
compose+="  image: ubuntu \n"
compose+="  restart: 'no' \n"
compose+="  ports: \n"
compose+="    - '80:80' \n"
# compose+="  external_links: \n"
# compose+="    - mysql \n"
compose+="  volumes: \n"
compose+="    - $PWD/www:/var/www/ \n"
compose+="    - $PWD/conf/apache:/etc/apache2/ \n"
compose+="    - $PWD/conf/php:/etc/php/ \n"
compose+="  privileged: true \n"
compose+="  stdin_open: true \n"
compose+="  tty: true \n"
printf "$compose" > docker-compose.yml

# Levanta o container
docker-compose up -d

# Configura as dependencias 
docker exec -it $1 /bin/bash -c 'apt-get update && apt-get -y install curl && apt-get -y install git && apt-get -y install unzip && apt-get -y install php'
docker exec -it $1 /bin/bash -c 'cd /tmp && curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /bin/composer && composer -v'
docker exec -it $1 /bin/bash -c 'apt-get -y install apache2 libapache2-mod-php php-mcrypt php-mysql php-xml php-gd php-curl php7.0-mbstring'
docker exec -it $1 /bin/bash -c 'a2enmod rewrite'
docker exec -it $1 /bin/bash -c 'service apache2 restart && chmod -R 777 /etc/apache2'
docker exec -it $1 /bin/bash -c 'cd /var/www && composer install'
docker exec -it $1 /bin/bash -c 'chmod -R 777 /var/www'
