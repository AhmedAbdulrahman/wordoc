#!/usr/bin/env bash

echo "Installing Composer.."
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# For package installation to work as intended the unzip command is preferred over the php-zip extension:
apt-get update
apt-get install -y unzip
