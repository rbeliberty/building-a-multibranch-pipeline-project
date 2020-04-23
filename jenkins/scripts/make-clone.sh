#!/usr/bin/env sh

CLONE_ID="${1}"
ENV_CI="${2}"

SNAPSHOT_ID=$(dblab snapshot list | jq -r --arg CI_ENV "${ENV_CI}" '[.[] | select (.id | contains($CI_ENV))][0].id')
dblab clone create --username "${CHANGE_AUTHOR}" --password "${CHANGE_AUTHOR}" --id "${CLONE_ID}" --snapshot-id "${SNAPSHOT_ID}"
