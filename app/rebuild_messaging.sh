#!/usr/bin/env bash
# ~/.bash_aliases

# Kill all running containers.
#alias dockerkillall='docker kill $(docker ps -q)'

# Kill all running containers.
# alias dockerkillall='docker-compose stop'

# Delete all stopped containers.
#alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
#alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
#alias dockerclean='dockercleanc || true && dockercleani'

docker-compose stop
docker rm $(docker ps -a | grep Exited | awk '{print $1}')
docker rmi $(docker images -q --filter "dangling=true")
docker rm -f $(docker ps -a -q)
docker rmi -f app_messaging
docker-compose up