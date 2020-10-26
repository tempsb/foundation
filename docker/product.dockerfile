FROM php:7.4-fpm

RUN apt-get update -y && apt-get install -y \
    zlib1g-dev \
    libpng-dev \
    git \
    zip \
    unzip \
    libicu-dev \
    g++

RUN docker-php-ext-configure intl && docker-php-ext-install mysqli pdo pdo_mysql gd bcmath intl

RUN chown -R www-data:www-data /var/www
WORKDIR /var/www
USER www-data

EXPOSE 9000
CMD php artisan serve --host=0.0.0.0 --port=9000
