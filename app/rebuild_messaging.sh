#!/bin/bash

# stop containers
docker-compose stop

# Remove all stopped containers:
docker rm $(docker ps -a | grep Exited | awk '{print $1}')

# Clean up un-tagged docker images:
docker rmi $(docker images -q --filter "dangling=true")

# Stop and remove all containers (including running containers!)
docker rm -f $(docker ps -a -q)

# Remove messging image
docker rmi -f app_messaging

# Run cleanup
bash cleanup.sh

# rebuild containers
docker-compose up