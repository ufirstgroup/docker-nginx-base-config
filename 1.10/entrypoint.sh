#!/usr/bin/env bash

if [ ! -e "/etc/nginx/base_config/dhparam_${NGINX_DHPARAM_SIZE}.pem" ]; then
  openssl dhparam -out /etc/nginx/base_config/dhparam_${NGINX_DHPARAM_SIZE}.pem ${NGINX_DHPARAM_SIZE}
  rm -f /etc/nginx/base_config/dhparam.pem
fi

if [ ! -e "/etc/nginx/base_config/dhparam.pem" ]; then
  ln -s /etc/nginx/base_config/dhparam_${NGINX_DHPARAM_SIZE}.pem /etc/nginx/base_config/dhparam.pem
fi

exec "$@"
