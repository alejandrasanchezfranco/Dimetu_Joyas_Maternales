FROM php:8.2-apache

# 1. Instalar extensiones necesarias y Composer
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip \
    && a2enmod rewrite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 2. Copiar los archivos del proyecto al servidor
# Si tu proyecto Symfony está dentro de una subcarpeta en GitHub, cambia el punto '.' por el nombre de tu carpeta
COPY . /var/www/html/

# 3. Configurar Apache para que apunte a la carpeta public/ de Symfony
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# 4. Instalar dependencias de Symfony
WORKDIR /var/www/html
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs


# 5. Dar permisos a las carpetas de Symfony
RUN chown -R www-data:www-data /var/www/html/var /var/www/html/public

EXPOSE 80
