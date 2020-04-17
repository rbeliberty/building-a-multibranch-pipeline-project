#!/usr/bin/env sh

# Si on est dans un agent Docker, il faut installer dblab
set -x
sh 'dblab init --environment-id=staging --url=$DBLAB_STAGE_URL --token=$DBLAB_STAGE_TOKEN --insecure'
set +x

