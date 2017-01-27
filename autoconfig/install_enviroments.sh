#!/bin/bash

# U must run as sudo

#settings
php_expose_php=Off
php_memory_limit=1024M
php_post_max_size=128M
php_upload_max_filesize=64M

#additional repositories
add-apt-repository ppa:webupd8team/java

apt update

# LAMP
apt install -y apache2 mysql-server memcached php libapache2-mod-php php-cli php-mcrypt php-curl php-intl php-dom php-mysql php-mysqli php-mbstring php-xml php-simplexml php-gd php-xdebug php-memcached

a2enmod rewrite

#update php config
for key in php_expose_php php_memory_limit php_post_max_size php_upload_max_filesize
do
 sed -i "s/^\($key\).*/\1 $(eval echo \${$key})/" php.ini
done

# Selenium
apt install -y oracle-java8-installer
apt install -y npm

sudo -u $USER npm install selenium-standalone
node_bin=$(node bin)
cd $node_bin
sudo -u $USER selenium-standalone install --silent

# Check if $HOME/node_modules/.bin has been added to local enviroment variables.
sudo -u $USER echo "$HOME/node_modules/.bin" | grep -q "$HOME/.profile"

if [ $? -eq 0 ]; then

  sudo -u $USER cat <<EOT >> "$HOME/.profile"
# set PATH so it includes user's private composer bin if it exists
if [ -d "\$HOME/node_modules/.bin" ] ; then
PATH="\$HOME/node_modules/.bin:\$PATH"
fi

EOT

fi

sudo -u $USER npm install apidoc

sudo -u $USER source ~/.profile
