FROM nginx:1.11-alpine

# pick a big (strong) dhparam size per default
# see https://wiki.mozilla.org/Security/Server_Side_TLS
ENV NGINX_DHPARAM_SIZE=4096

RUN apk add --update bash curl wget unzip sed

ENTRYPOINT ["/entrypoint.sh"]
ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh

RUN mkdir -p /etc/nginx/base_config

ADD conf/fastcgi.conf /etc/nginx/base_config/fastcgi.conf
ADD conf/http-defaults.conf /etc/nginx/base_config/http-defaults.conf
ADD conf/log-formats.conf /etc/nginx/base_config/log-formats.conf
ADD conf/nginx.conf /etc/nginx/base_config/nginx.conf
ADD conf/request-id.conf /etc/nginx/base_config/request-id.conf
ADD conf/server-defaults.conf /etc/nginx/base_config/server-defaults.conf

RUN /bin/echo 'include /etc/nginx/base_config/nginx.conf;' > /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params

CMD ["nginx", "-g", "daemon off;"]
