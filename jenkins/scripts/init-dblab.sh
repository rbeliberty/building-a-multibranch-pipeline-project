#!/usr/bin/env sh

# Si on est dans un agent Docker, il faut installer dblab
DBLAB_ENV=$1
DBLAB_URL=$2
DBLAB_TOKEN=$3

dblab init --environment-id="${DBLAB_ENV}" --url="${DBLAB_URL}" --token="${DBLAB_TOKEN}" --insecure
dblab config switch "${DBLAB_ENV}"
