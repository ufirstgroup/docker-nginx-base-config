FROM nginx:1.11

# pick a big (strong) dhparam size per default
# see https://wiki.mozilla.org/Security/Server_Side_TLS
ENV NGINX_DHPARAM_SIZE=4096

RUN apt-get update && apt-get install -y wget unzip sed

ENTRYPOINT ["/entrypoint.sh"]
COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

RUN mkdir -p /etc/nginx/base_config

COPY conf/fastcgi.conf /etc/nginx/base_config/fastcgi.conf
COPY conf/http-defaults.conf /etc/nginx/base_config/http-defaults.conf
COPY conf/log-formats.conf /etc/nginx/base_config/log-formats.conf
COPY conf/nginx.conf /etc/nginx/base_config/nginx.conf

RUN /bin/echo 'include /etc/nginx/base_config/nginx.conf;' > /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params

CMD ["nginx", "-g", "daemon off;"]
