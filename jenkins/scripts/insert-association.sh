#!/usr/bin/env sh
printenv
DATE=$(date +"%Y-%m-%d")
CLONE_ID="${1}"
ENV_CI="${2}"
SNAPSHOT_ID=$(dblab snapshot list | jq -r --arg CI_ENV "${ENV_CI}" '[.[] | select (.id | contains($CI_ENV))][0].id')

# PORT est dans printenv
#PORT=$(echo "${CLONE_JSON}" | jq -r --arg CLONEID "${CLONE_ID}" 'select (.id | contains($CLONEID)) | .db.port')

COMMAND="INSERT INTO associations (snapshot_id, clone_id, change_author, branch_name, change_target, change_branch, created_at, repo_name, port)
VALUES ('\"${SNAPSHOT_ID}\"', '\"${CLONE_ID}\"', '\"${CHANGE_AUTHOR}\"', '\"${BRANCH_NAME}\"', '\"${CHANGE_TARGET}\"', '\"${CHANGE_BRANCH}\"', '\"${DATE}\"', '\"${REPO_NAME}\"', \"${CLONE_PORT}\");"
psql -h 192.168.5.6 -c "${COMMAND}"