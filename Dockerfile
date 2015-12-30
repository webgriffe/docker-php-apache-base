FROM php:7.0-apache
MAINTAINER Webgriffe Srl <support@webgriffe.com>

# Install GD
RUN apt-get update \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Install MCrypt
RUN apt-get update \
    && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt

# Install Intl
RUN apt-get update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-install intl

# Don't Install XDebug because version 2.4.0 (which is compatible with PHP 7) is not stable yet
# RUN pecl install -o -f xdebug \
#    && rm -rf /tmp/pear \
#    && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini

# Install Mysql
RUN docker-php-ext-install mysqli pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Configure Apache Document Root
ENV APACHE_DOC_ROOT /var/www/html
COPY ./docker-entrypoint /usr/local/bin/

COPY ./index.php /var/www/html/index.php

ENTRYPOINT ["docker-entrypoint"]
