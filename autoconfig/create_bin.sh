#!/bin/bash

DIR_FOR_LOCAL_BINS="bin"

cd ~
if [ ! -d "$HOME/$DIR_FOR_LOCAL_BINS" ]; then
  mkdir "$HOME/$DIR_FOR_LOCAL_BINS"
  chmod 755 -R "$HOME/$DIR_FOR_LOCAL_BINS"
fi

# Check if $DIR_FOR_LOCAL_BINS has been added to local enviroment variables.
echo "$HOME/$DIR_FOR_LOCAL_BINS" | grep -q "$HOME/.profile"

if [ $? -eq 0 ]; then
  cat <<EOT >> "$HOME/.profile"
# set PATH so it includes user's private bin if it exists
if [ -d "\$HOME/$DIR_FOR_LOCAL_BINS" ] ; then
  PATH="\$HOME/bin:\$PATH"
fi
EOT

fi

cd "$HOME/$DIR_FOR_LOCAL_BINS"

# Install composer
if [ ! "$HOME/$DIR_FOR_LOCAL_BINS/composer" ]; then

  EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

  if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
  then
      >&2 echo 'ERROR: Invalid installer signature'
      rm composer-setup.php
      exit 1
  fi

  php composer-setup.php --quiet
  RESULT=$?
  rm composer-setup.php
  echo $RESULT

  mv composer.phar composer
  chmod 755 composer

  if [ -d "$HOME/.composer" ]; then

    cat <<EOT >> "$HOME/.profile"
# set PATH so it includes user's private composer bin if it exists
if [ -d "\$HOME/.composer/vendor/bin" ] ; then
  PATH="\$HOME/.composer/vendor/bin:\$PATH"
fi

EOT

  else

    if [ -d "$HOME/.config/composer" ]; then

      cat <<EOT >> "$HOME/.profile"
# set PATH so it includes user's private composer bin if it exists
if [ -d "\$HOME/.config/composer/vendor/bin" ] ; then
  PATH="\$HOME/.config/composer/vendor/bin:\$PATH"
fi

EOT

    fi

  fi

  source ~/.profile

fi

composer global require "fxp/composer-asset-plugin:^1.2.0"
composer global require --dev "codeception/codeception:*" "codeception/specify:*" "codeception/verify:*"

source ~/.profile
