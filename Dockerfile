FROM smebberson/alpine-apache:1.0.0
MAINTAINER Vojtěch Biberle <vojtech.biberle@gmail.com>

ADD root /

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update add \
  php \
  php-apache2 \
  php-pdo \
  php-json \
  php-openssl \
  php-mysql \
  php-pdo_mysql \
  php-mcrypt \
  php-sqlite3 \
  php-pdo_sqlite \
  php-ctype \
  php-zlib \
  php-iconv \
  php-xdebug@testing

ADD essentials.ini /etc/php/conf.d/essentials.ini
RUN sed -i "s/extension/zend_extension/g" /etc/php/conf.d/xdebug.ini 

RUN sed -i "s/\/var\/www\/localhost\/htdocs/\/var\/www\/localhost\/public/g" /etc/apache2/httpd.conf && \
    rm -rf /var/www/localhost/htdocs && \
    mkdir -p /var/www/localhost/public

VOLUME ["/var/www/localhost"]
