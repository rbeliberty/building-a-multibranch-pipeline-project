#!/usr/bin/env sh
printenv
CLONE_ID="${1}"
PORT=$(echo "${CLONE_JSON}" | jq -r --arg CLONEID "${CLONE_ID}" 'select (.id | contains($CLONEID)) | .db.port')

echo $PORT

# COMMAND="INSERT INTO associations (snapshot_id, clone_id, change_author, branch_name, change_target, change_branch, created_at, repo_name, port)
# VALUES ('\"${SNAPSHOT_ID}\"', '\"${CLONE_ID}\"', '\"${CHANGE_AUTHOR}\"', '\"${BRANCH_NAME}\"', '\"${CHANGE_TARGET}\"', '\"${CHANGE_BRANCH}\"', '\"${DATE}\"', '\"${REPO_NAME}\"', '\"${PORT}\"');"
#psql -h 192.168.5.6 -c "${COMMAND}"