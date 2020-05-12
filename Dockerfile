# STAGE 1 : PHP Dependencies
FROM composer:1.9 as vendor

COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

# STAGE 2 : COPY CODE SOURCE


# STAGE 3 CONFIGURE PHP


# STAGE 4 CONFIGURE NGINX

