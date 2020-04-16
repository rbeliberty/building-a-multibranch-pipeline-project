#!/usr/bin/env sh

# Vérifier la présence d'un clone lié à la PR ou à la branch en cours en base
## Si présent, utiliser ce clone

## Si non présent, lister les snapshots
### Prendre le dernier snapshot
### Faire un clone avec l'ID du dernier snapshot
### Stocker en base l'association PR/branch + clone ID + Snapshot ID en base

# Prérequis :
# Il faut que le client dblab (alias db dans zshrc) soit installé et initialisé

set -x
/usr/local/bin/dblab snapshot list
set +x