#!/usr/bin/env sh

CLONE_ID="${1}"
ENV_CI="${2}"

SNAPSHOT_ID=$(dblab snapshot list | jq -r --arg CI_ENV "${ENV_CI}" '[.[] | select (.id | contains($CI_ENV))][0].id')
dblab clone create --username "${CHANGE_AUTHOR}" --password "${CHANGE_AUTHOR}" --id "${CLONE_ID}" --snapshot-id "${SNAPSHOT_ID}"

#
#{
#    "id": "rbeliberty4",
#    "snapshot": {
#        "id": "dblab_pool@17-dev",
#        "createdAt": "2020-04-22 05:15:57 UTC",
#        "dataStateAt": "2020-04-22 05:15:57 UTC"
#    },
#    "protected": false,
#    "deleteAt": "",
#    "createdAt": "2020-04-23 14:12:17 UTC",
#    "status": {
#        "code": "OK",
#        "message": "Clone is ready to accept Postgres connections."
#    },
#    "db": {
#        "connStr": "host=localhost port=6020 user=rbeliberty",
#        "host": "localhost",
#        "port": "6020",
#        "username": "rbeliberty",
#        "password": ""
#    },
#    "metadata": {
#        "cloneSize": 964608,
#        "cloningTime": 2.013879431,
#        "maxIdleMinutes": 43800
#    },
#    "project": ""
#}
#