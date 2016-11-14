FROM clouder/clouder-base:alpine
MAINTAINER Yannick Buron yburon@goclouder.net

RUN apk add --update nginx openssl 
# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN chsh -s /bin/bash www-data
RUN mkdir /run/php
#RUN mkdir /var/www
RUN chown www-data:www-data /var/www/

CMD ["nginx", "-g", "daemon off;"]
