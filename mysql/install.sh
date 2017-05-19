#!/bin/bash
pass='root'
if [ -z "$1" ]
  then
    pass='root'
else
  pass="$1"
fi
output="mysql: \n"
output+="  container_name: mysql \n"
output+="  image: mysql \n"
output+="  restart: always \n"
output+="  ports: \n"
output+="    - '3306:3306' \n"
output+="  environment: \n"
output+="    MYSQL_ROOT_PASSWORD: $pass \n"

printf "$output" > docker-compose.yml

docker-compose up -d
