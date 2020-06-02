#!/usr/bin/env sh

ENV_CI=$1

if [ "$ENV_CI" = 'staging' ]; then
  APP_ENV_VALUE='dev'
fi

APP_SECRET_VALUE=$(pwgen -A 40 1)

touch .env
echo "APP_ENV=${APP_ENV_VALUE}" >> .env
echo "APP_SECRET=${APP_SECRET_VALUE}" >> .env

