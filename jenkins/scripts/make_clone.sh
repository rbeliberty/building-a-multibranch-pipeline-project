#!/usr/bin/env sh

REPO_NAME=$1
ENV_CI=$2
echo $ENV_CI

dblab config switch "${ENV_CI}"
dblab snapshot list | jq -r '.[] | select (.id | contains(\"${ENV_CI}\"))'