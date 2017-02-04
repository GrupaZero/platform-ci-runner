FROM php:7.1-alpine

MAINTAINER Adrian Skierniewski <adrian.skierniewski@gmail.com>

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.5
ENV DOCKER_SHA256 0058867ac46a1eba283e2441b1bb5455df846144f9d9ba079e97655399d4a2c6
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS postgresql-dev \
    && apk add --no-cache libmcrypt-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql mcrypt \
    && pecl install redis-3.1.1 \
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