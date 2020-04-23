#!/usr/bin/env sh

REPO_NAME=$1
ENV_CI=$2

db config switch "${ENV_CI}"
db snapshot list