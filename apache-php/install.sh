#!/bin/bash
output="$1: \n"
output+="  container_name: $1 \n"
output+="  image: ubuntu \n"
output+="  restart: 'no' \n"
output+="  ports: \n"
output+="    - '80:80' \n"
output+="  external_links: \n"
output+="    - mysql \n"
output+="  volumes: \n"
output+="    - $PWD/www:/var/www/html/ \n"
output+="  privileged: true \n"
output+="  stdin_open: true \n"
output+="  tty: true \n"

printf "$output" > docker-compose.yml

docker-compose up -d
docker exec -it $1 /bin/bash -c 'apt-get update && apt-get -y install apache2 && apt-get -y install php libapache2-mod-php php-mcrypt && service apache2 restart && chmod -R 777 /var/www'
