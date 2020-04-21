#!/usr/bin/env sh

# Si on est dans un agent Docker, il faut installer dblab ou bien utiliser un Dockerfile custom
# Il faut que le client dblab (alias db dans zshrc) soit installé et initialisé


# Vérifier la présence d'un clone lié à la PR ou à la branch en cours en base
## Si présent, utiliser ce clone

## Si non présent, lister les snapshots
### Prendre le dernier snapshot
### Faire un clone avec l'ID du dernier snapshot
### Stocker en base l'association PR/branch + clone ID + Snapshot ID en base

BRANCH_NAME=$1
REPO_NAME=$2
ENV_CI=$3

COMMAND="SELECT clone_id FROM associations WHERE branch_name='${BRANCH_NAME}' AND repo_name='${REPO_NAME}'"
result=$(psql -h 192.168.5.6 -c "${COMMAND}")

echo "Result : ${result}"

## si la commande SQL retourne une ligne, on utilise le clone_id

dblab config list
dblab config switch "${ENV_CI}"
dblab snapshot list | jq  .[].id
