FROM php:7.2-alpine

MAINTAINER Adrian Skierniewski <adrian.skierniewski@gmail.com>

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 17.05.0-ce
ENV DOCKER_SHA256 340e0b5a009ba70e1b644136b94d13824db0aeb52e09071410f35a95d94316d9
ENV COMPOSER_ALLOW_SUPERUSER 1

# Unfortunately we need build dependencies for npm install :(
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS postgresql-dev \
    && apk add --no-cache libmcrypt-dev libpq git nodejs autoconf make automake libtool g++ file zlib libpng-dev nasm \
    && docker-php-ext-install gd pdo pdo_mysql pdo_pgsql pgsql pcntl zip \
    && pecl install redis-3.1.6 \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    && set -x \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v \
    && curl -sS https://getcomposer.org/installer | /usr/local/bin/php \
    && /bin/mv composer.phar /usr/local/bin/composer

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["sh"]