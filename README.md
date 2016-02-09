Base PHP with Apache Docker Container
=====================================

Dockerized environment for PHP web development and Apache web server.

Features
--------

* Ability to set Apache document root through `APACHE_DOC_ROOT` environment variable. Default document root is `/var/www/html`
* Enabled Apache modules: rewrite
* Ability to set PHP `date.timezone` through `PHP_TIMEZONE` environment variable. Default timezone is `Europe/Rome`
* Enabled PHP extensions: gd, mcrypt, intl, mysql, mysqli, pdo_mysql, mbstring, soap, opcache, zip, xls
* Composer installed globally at `/usr/local/bin/composer`
* GIT installed (required by Composer)

Usage
-----

Standalone usage example with host's current working directory as document root:

	$ docker run -p 80:80 -v $(pwd):/var/www/html webgriffe/php-apache-base

Credits
-------

[Webgriffe®](http://www.webgriffe.com/)




