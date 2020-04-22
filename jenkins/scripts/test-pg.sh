#!/usr/bin/env sh

ASSOCIATION_ID=$1
SNAPSHOT_ID=$2
CLONE_ID=$3
CHANGE_AUTHOR=$4
BRANCH_NAME=$5
CHANGE_TARGET=$6
CHANGE_BRANCH=$7
CREATE_AT=$8
REPO_NAME=$9

echo "ASSOCIATION_ID : $ASSOCIATION_ID"
echo "SNAPSHOT_ID : $SNAPSHOT_ID"
echo "CLONE_ID : $CLONE_ID"
echo "CHANGE_AUTHOR : $CHANGE_AUTHOR"
echo "BRANCH_NAME : $BRANCH_NAME"
echo "CHANGE_TARGET : $CHANGE_TARGET"
echo "CHANGE_BRANCH : $CHANGE_BRANCH"
echo "CREATE_AT : $CREATE_AT"
echo "REPO_NAME : $REPO_NAME"

#1|dblab_pool@14-staging|building-a-multibranch-pipeline-project_PR-5|rbeliberty|PR-5|dev|feature/add-test|2020-04-02|building-a-multibranch-pipeline-project

#IFS=| read id snapshot_id clone_id change_author branch_name change_target change_branch created_at repo_name <<< $1

 #echo $id
#echo $snapshot_id

#HOST_DB=$1
#USER_DB=$2
#PASSWORD_DB=$3
#DATABASE=$4
#PORT_DB=$5

#COMMAND="SELECT * FROM associations WHERE branch_name='${BRANCH_NAME}' AND repo_name='${REPO_NAME}'"
#result=$(psql -X -A -t -h 192.168.5.6 -c "${COMMAND}")