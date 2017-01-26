#!/bin/bash

# U must run as sudo

php_expose_php=Off
php_memory_limit=1024M
php_post_max_size=128M
php_upload_max_filesize=64M

apt update
apt install -y apache2 mysql-server memcached php libapache2-mod-php php-cli php-mcrypt php-curl php-intl php-dom php-mysql php-mysqli php-mbstring php-xml php-simplexml php-gd php-xdebug php-memcached

for key in php_expose_php php_memory_limit php_post_max_size php_upload_max_filesize
do
 sed -i "s/^\($key\).*/\1 $(eval echo \${$key})/" php.ini
done
