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

COMMAND="SELECT change_author, port FROM associations WHERE branch_name='${BRANCH_NAME}' AND repo_name='${REPO_NAME}'"
psql -AtF' ' -h 192.168.5.6 -c "${COMMAND}"

# TODO : prévoir une vérification
## Par exemple le nombre de champs et faire des vérification regexp par exemple PR-xx, YYYY-MM-DD, port = 6XXX
