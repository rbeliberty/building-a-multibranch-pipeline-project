#!/usr/bin/env sh

CLONE_ID=$1
ENV_CI=$2
echo $ENV_CI

dblab config switch "${ENV_CI}"
dblab snapshot list | jq -r --arg CI_ENV "${ENV_CI}" '.[] | select (.id | contains($CI_ENV))'