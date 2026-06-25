FROM php:8.4-apache

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip \
    && a2enmod rewrite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www/html/

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html

ENV APP_ENV=prod


# Forzamos una instalación limpia saltándonos los scripts que bloquean la subida
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs --no-scripts

RUN mkdir -p var/cache var/log
RUN chmod -R 777 var/cache var/log

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
