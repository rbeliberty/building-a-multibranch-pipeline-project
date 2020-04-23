#!/usr/bin/env sh
## '.[] | select (.id=="pr-1234") | .db.port'
# dblab snapshot list | jq --raw-output '.[] | select (.id=="dblab_pool@17-staging") | .createdAt'
 #dblab snapshot list | jq --raw-output '.[].createdAt'
 #jq --raw-output '.[] | select (.id | contains("staging"))'
 # commande de malade : jq --raw-output '[.[] | select (.id | contains("staging"))][0].id'

printenv

CHANGE_AUTHOR="${4}"
PORT="${10}"

#echo "CHANGE_AUTHOR : $CHANGE_AUTHOR"
#echo "PORT : $PORT"

PGPASSWORD="${CHANGE_AUTHOR}"
psql -h pgclone.awstack -p "${PORT}" -U "${CHANGE_AUTHOR}" cfgmanager_dev -c "\l"