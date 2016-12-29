FROM php:7.1-alpine

MAINTAINER Adrian Skierniewski <adrian.skierniewski@gmail.com>

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.5
ENV DOCKER_SHA256 0058867ac46a1eba283e2441b1bb5455df846144f9d9ba079e97655399d4a2c6

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

COPY entrypoint.sh /usr/local/bin/

RUN curl -sS https://getcomposer.org/installer | /usr/local/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer

ENTRYPOINT ["entrypoint.sh"]
CMD ["sh"]