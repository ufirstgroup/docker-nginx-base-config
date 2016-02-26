FROM nginx:1.9

# pick a big (strong) dhparam size per default
# see https://wiki.mozilla.org/Security/Server_Side_TLS
ARG NGINX_DHPARAM_SIZE=4096

RUN mkdir -p /etc/nginx/base_config

COPY ["conf/*.conf", "/etc/nginx/base_config/"]
RUN openssl dhparam -out /etc/nginx/base_config/dhparam_${NGINX_DHPARAM_SIZE}.pem ${NGINX_DHPARAM_SIZE}
RUN ln -s /etc/nginx/base_config/dhparam_${NGINX_DHPARAM_SIZE}.pem /etc/nginx/base_config/dhparam.pem
RUN /bin/echo 'include /etc/nginx/base_config/nginx.conf;' > /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params
