#!/usr/bin/env sh

SNAPSHOT_ID="${1}"
CLONE_ID="${2}"
CHANGE_AUTHOR="${3}"
BRANCH_NAME="${4}"
CHANGE_TARGET="${5}"
CHANGE_BRANCH="${6}"
CREATE_AT="${7}"
REPO_NAME="${8}"
PORT="${9}"

COMMAND="INSERT INTO associations (snapshot_id, clone_id, change_author, branch_name, change_target, change_branch, created_at, repo_name, port) VALUES ('\"${SNAPSHOT_ID}\"', '\"${CLONE_ID}\"', '\"${CHANGE_AUTHOR}\"', '\"${BRANCH_NAME}\"', '\"${CHANGE_TARGET}\"', '\"${CHANGE_BRANCH}\"', '\"${DATE}\"', '\"${REPO_NAME}\"', '\"${PORT}\"');"
psql -h 192.168.5.6 -c "${COMMAND}"