#!/bin/bash

function die () {
    echo >&2 "$@"
    exit 1
}

HOST=${DEFAULT_HOST:-localhost}

echo $HOST | grep -E -q '^localhost$|^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$' || die "Not valid domain"
echo -e "nginx_host: \e[91m$HOST\e[0m"

# Using dev version of site.conf if present
# It should only work on dev, because during build we're ignoring _server dir
if [ -e "/var/www/.server/nginx/site.conf" ]; then
  sed -e "s/{{DEFAULT_HOST}}/$HOST/g" "/var/www/.server/nginx/site.conf" > /etc/nginx/sites-available/default
else
  sed -e "s/{{DEFAULT_HOST}}/$HOST/g" "/etc/nginx/conf.d/site.template" > /etc/nginx/sites-available/default
fi

/usr/bin/supervisord -n -c /etc/supervisord.conf
