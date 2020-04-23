#!/usr/bin/env sh

REPO_NAME=$1
ENV_CI=$2

dblab config switch "${ENV_CI}"
dblab snapshot list | jq --raw-output '.[] | select (.id | contains("${ENV_CI}"))'