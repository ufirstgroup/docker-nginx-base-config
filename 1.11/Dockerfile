FROM nginx:1.11-alpine

# pick a big (strong) dhparam size per default
# see https://wiki.mozilla.org/Security/Server_Side_TLS

ENV NGINX_DHPARAM_SIZE=4096
ENV HEADERS_MORE_MODULE_VERSION=0.31

RUN apk add --update openssl bash curl wget unzip sed
RUN CONFIG="\
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
  " \
  && apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    curl \
    gnupg \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev \
  && curl -fSL http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -o nginx.tar.gz \
  && curl -fSL https://github.com/openresty/headers-more-nginx-module/archive/v$HEADERS_MORE_MODULE_VERSION.tar.gz -o ngx_headers_more_module.tar.gz \
  && mkdir -p /usr/src \
  && tar -zxC /usr/src -f nginx.tar.gz \
  && tar -zxC /usr/src -f ngx_headers_more_module.tar.gz \
  && rm nginx.tar.gz  \
  && rm ngx_headers_more_module.tar.gz \
  && cd /usr/src/nginx-$NGINX_VERSION \
  && ./configure $CONFIG --with-debug \
     --add-dynamic-module=/usr/src/headers-more-nginx-module-$HEADERS_MORE_MODULE_VERSION/ \
  && make -f objs/Makefile modules \
  && mv objs/*.so /usr/lib/nginx/modules/. \
	&& strip /usr/lib/nginx/modules/*.so \
	&& rm -rf /usr/src/nginx-$NGINX_VERSION \
  && rm -rf /usr/src/headers-more-nginx-module-$HEADERS_MORE_MODULE_VERSION/ \
	&& apk del .build-deps

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
