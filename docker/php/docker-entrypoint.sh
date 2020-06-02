#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi


	#PHP_INI_RECOMMENDED="$PHP_INI_DIR/php.ini-production"
	#if [ "$APP_ENV" != 'prod' ]; then
	#	PHP_INI_RECOMMENDED="$PHP_INI_DIR/php.ini-development"
	#fi
	#ln -sf "$PHP_INI_RECOMMENDED" "$PHP_INI_DIR/php.ini"

  mkdir -p var/cache var/log
  composer install --prefer-dist --no-progress --no-suggest --no-interaction

	setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX var
	setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX var


exec docker-php-entrypoint "$@"
