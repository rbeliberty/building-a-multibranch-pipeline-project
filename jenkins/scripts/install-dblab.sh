#!/usr/bin/env sh

# Si on est dans un agent Docker, il faut installer dblab
set -x
curl https://gitlab.com/postgres-ai/database-lab/-/raw/master/scripts/cli_install.sh | sh
set +x

