FROM nginx:1.10

# pick a big (strong) dhparam size per default
# see https://wiki.mozilla.org/Security/Server_Side_TLS
ENV NGINX_DHPARAM_SIZE=4096

RUN apt-get update && apt-get install -y wget unzip sed

ENTRYPOINT ["/entrypoint.sh"]
COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

RUN mkdir -p /etc/nginx/base_config

RUN cd /tmp/ && \
    wget https://github.com/ufirstgroup/ansible-nginx-base-config/archive/master.zip && \
    unzip master.zip && \
    sed 's/{{ nginx_base_config_folder }}/\/etc\/nginx\/base_config/' /tmp/ansible-nginx-base-config-master/templates/fastcgi.conf.j2 > /etc/nginx/base_config/fastcgi.conf && \
    sed 's/{{ nginx_base_config_folder }}/\/etc\/nginx\/base_config/' /tmp/ansible-nginx-base-config-master/templates/http-defaults.conf.j2 > /etc/nginx/base_config/http-defaults.conf && \
    sed 's/{{ nginx_base_config_folder }}/\/etc\/nginx\/base_config/' /tmp/ansible-nginx-base-config-master/templates/log-formats.conf.j2 > /etc/nginx/base_config/log-formats.conf && \
    sed 's/{{ nginx_base_config_folder }}/\/etc\/nginx\/base_config/;s/_{{ nginx_dhparam_size }}//' /tmp/ansible-nginx-base-config-master/templates/nginx.conf.j2 > /etc/nginx/base_config/nginx.conf && \
    sed 's/{{ nginx_base_config_folder }}/\/etc\/nginx\/base_config/' /tmp/ansible-nginx-base-config-master/templates/request-id.conf.j2 > /etc/nginx/base_config/request-id.conf && \
    sed 's/{{ nginx_base_config_folder }}/\/etc\/nginx\/base_config/' /tmp/ansible-nginx-base-config-master/templates/server-defaults.conf.j2 > /etc/nginx/base_config/server-defaults.conf && \
    rm -rf /tmp/ansible-nginx-base-config

RUN /bin/echo 'include /etc/nginx/base_config/nginx.conf;' > /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params

CMD ["nginx", "-g", "daemon off;"]
