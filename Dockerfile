FROM clouder/clouder-base
MAINTAINER Yannick Buron yburon@goclouder.net

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y -q install supervisor nginx openssl
# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN chsh -s /bin/bash www-data
RUN mkdir /run/php
#RUN mkdir /var/www
RUN chown www-data:www-data /var/www/
RUN echo "[supervisord]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "nodaemon=true" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:nginx]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=/etc/init.d/nginx start" >> /etc/supervisor/conf.d/supervisord.conf
USER root
CMD ["/usr/bin/supervisord"]
