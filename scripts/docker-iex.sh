#!/bin/bash

set -e

docker exec -it $(docker ps | grep "ex_list_main" | awk '{print $1;}') /app/scripts/remote-iex.sh
