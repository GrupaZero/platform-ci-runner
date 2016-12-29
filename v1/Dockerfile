FROM ubuntu:16.04

MAINTAINER Adrian Skierniewski <adrian.skierniewski@gmail.com>

# Set correct environment variables
ENV HOME /root
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV DOCKER_VERSION 1.12.5-0~ubuntu-xenial

RUN apt-get update && \
    apt-get install -y software-properties-common apt-transport-https --no-install-recommends && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    LANG=C.UTF-8 add-apt-repository ppa:ondrej/php && \
    LANG=C.UTF-8 apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' && \
    apt-get update && \
    apt-get install -y \
      sudo \
      git \
      gettext \
      curl \
      php7.1-cli \
      php7.1-common \
      php7.1-curl \
      php7.1-json \
      php7.1-ldap \
      php7.1-mcrypt \
      php7.1-mbstring \
      php7.1-opcache \
      php7.1-xml \
      php7.1-redis \
      php7.1-zip && \
    apt-cache madison docker-engine && \
    apt-get -o Dpkg::Options::="--force-confnew" install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages docker-engine=${DOCKER_VERSION} && \
    apt-get remove --purge -y software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    echo -n > /var/lib/apt/extended_states && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*

RUN echo "127.0.0.1       localunixsocket" >> /etc/hosts
RUN phpenmod mcrypt

RUN /usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer

CMD ["/bin/bash"]
