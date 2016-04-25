#!/usr/bin/env bash
# ~/.bash_aliases

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Kill all running containers.
# alias dockerkillall='docker-compose stop'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'