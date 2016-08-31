#!/usr/bin/env bash

if [ ! -e "/etc/nginx/conf.d/dhparam_${NGINX_DHPARAM_SIZE}.pem" ]; then
  openssl dhparam -out /etc/nginx/conf.d/dhparam_${NGINX_DHPARAM_SIZE}.pem ${NGINX_DHPARAM_SIZE}
  rm -f /etc/nginx/conf.d/dhparam.pem
fi

if [ ! -e "/etc/nginx/conf.d/dhparam.pem" ]; then
  ln -s /etc/nginx/conf.d/dhparam_${NGINX_DHPARAM_SIZE}.pem /etc/nginx/conf.d/dhparam.pem
fi

exec "$@"
