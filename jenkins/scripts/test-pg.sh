#!/usr/bin/env sh
## .[] | select (.id=="pr-1234") | .db.port

ASSOCIATION_ID="${1}"
SNAPSHOT_ID="${2}"
CLONE_ID="${3}"
CHANGE_AUTHOR="${4}"
BRANCH_NAME="${5}"
CHANGE_TARGET="${6}"
CHANGE_BRANCH="${7}"
CREATE_AT="${8}"
REPO_NAME="${9}"
PORT="${10}"

echo "ASSOCIATION_ID : $ASSOCIATION_ID"
echo "SNAPSHOT_ID : $SNAPSHOT_ID"
echo "CLONE_ID : $CLONE_ID"
echo "CHANGE_AUTHOR : $CHANGE_AUTHOR"
echo "BRANCH_NAME : $BRANCH_NAME"
echo "CHANGE_TARGET : $CHANGE_TARGET"
echo "CHANGE_BRANCH : $CHANGE_BRANCH"
echo "CREATE_AT : $CREATE_AT"
echo "REPO_NAME : $REPO_NAME"
echo "PORT : $PORT"

PGPASSWORD="${CHANGE_AUTHOR}"
psql -h pgclone.awstack -p "${PORT}" -U "${CHANGE_AUTHOR}" cfgmanager_dev -c "\l"