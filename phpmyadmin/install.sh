#!/bin/bash
link='mysql'
if [ -z "$1" ]
  then
    link='mysql'
else
  link="$1"
fi
output="phpmyadmin: \n"
output+="  container_name: phpmyadmin \n"
output+="  image: phpmyadmin/phpmyadmin:latest \n"
output+="  restart: 'no' \n"
output+="  external_links: \n"
output+="    - '$link' \n"
output+="  ports: \n"
output+="    - '88:80' \n"
output+="  environment: \n"
output+="    - PMA_ARBITRARY=1 \n"

printf "$output" > docker-compose.yml

docker-compose up -d
