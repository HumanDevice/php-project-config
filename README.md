# Konfiguracja środowiska projektu projektu

## Spis treści

1. [En]
2. [Coding style](Style/)

## Środowisko konfigurowanego systemu

1. Linux Mint 18.1 x64
2. Apache 2.4.18 (Ubuntu)
3. MySQL Server 5.7
4. PHP 7.

## Środowisko

### Linux

1. Wstępne konfiguracja systemu.
  * Dobrze, aby zainstalowana dystrybucja linuxa była pochodną Debiana.
  * Warto zadbać o zaszyfrowanie folderu domowego użytkownika.


2. Uruchom terminal i używaj

2. Aktualizacja repozytoriów.

  `sudo apt update`

3. Instalacja serwera HTTP Apache.

  `sudo apt install apache2`

4. Instalacja serwera baz danych MySQL.

  `sudo apt install mysql-server php-mysql`

5. Podczas instalacji mysql-server w konsoli pojawi się okienko konfiguracji hasła dla użytkownika root:

  ![alt text](window_mysql_password.png)

  i kolejno potwierdzenia tego hasła:

  ![alt text](window_mysql_password_repeat.png).

6. Instalacja PHP wraz z listą modułów.

  `sudo apt install php libapache2-mod-php php-cli php-mcrypt php-curl php-intl php-dom php-mysql php-mysqli php-mbstring php-xml php-simplexml php-gd php-xdebug`

7. Uruchomienie modułów apache.

  `sudo a2enmod rewrite`

8. Instalacja composera.

9. Instalacja codeception.

10. Instalacja phpunit.

## Windows

# Instalacja LAMP

# Źródła

* Konfigruacja LAMP - [How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu), uwaga w kroku 2 w instalacji MySQL pojawia się paczka `libapache2-mod-auth-mysql`, aktualnie nie jest ona już wspierana [mod-auth-mysql](https://launchpad.net/ubuntu/+source/mod-auth-mysql/+publishinghistory),
