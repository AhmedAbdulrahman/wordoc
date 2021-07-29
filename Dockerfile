ARG WP_VERSION=php7.4-apache

FROM wordpress:${WP_VERSION}

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
	libpng-dev \
        libxml2 libxml2-dev \
	libcurl4-openssl-dev \
	zip unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) mysqli xml curl gd

WORKDIR /var/www/html/

RUN mkdir public

COPY . .

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# Here youo can add your Private KEYs
# ENV ACF_PRO_KEY=YOUR_KEY

RUN bash -c "composer install"
# Here you can navigate in to your custom Plugins and install all it's dependencies:
# RUN cd public/wp-content/plugins/your_custom_plugin && composer install

RUN chown www-data:www-data -R /var/www/html/public/wp-content/
