#!/bin/bash
docker-compose start
docker exec -it $1 /bin/bash -c 'service apache2 start'
