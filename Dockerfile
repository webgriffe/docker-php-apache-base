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
ENV XDEBUG_ENABLE 0
RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear
COPY ./99-xdebug.ini.disabled /usr/local/etc/php/conf.d/

# Install Mysql
RUN docker-php-ext-install mysql mysqli pdo_mysql

# Install mbstring
RUN docker-php-ext-install mbstring

# Install soap
RUN apt-get update \
    && apt-get install -y libxml2-dev \
    && docker-php-ext-install soap

# Install opcache
RUN docker-php-ext-install opcache

# Define PHP_TIMEZONE env variable
ENV PHP_TIMEZONE Europe/Rome

# Configure Apache Document Root
ENV APACHE_DOC_ROOT /var/www/html
COPY ./docker-entrypoint /usr/local/bin/

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Additional PHP ini configuration
COPY ./999-php.ini /usr/local/etc/php/conf.d/

COPY ./index.php /var/www/html/index.php

ENTRYPOINT ["docker-entrypoint"]
CMD ["apache2-foreground"]
