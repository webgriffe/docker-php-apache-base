FROM php:5.6-apache
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

# Install XDebug
RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug

# Install Mysql
RUN docker-php-ext-install mysql mysqli pdo_mysql

# Configure Apache Document Root
ENV APACHE_DOC_ROOT /var/www/html
COPY ./docker-entrypoint /usr/local/bin/

COPY ./index.php /var/www/html/index.php

ENTRYPOINT ["docker-entrypoint"]
CMD ["apache2-foreground"]
