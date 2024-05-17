FROM debian:bookworm

RUN apt update && apt upgrade -y && apt -y install apache2
# rewrite module has to be active
RUN a2enmod rewrite

RUN apt install -y apt-transport-https lsb-release ca-certificates wget 
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt update && apt install -y php8.3 \
  libapache2-mod-php8.3 \
  php8.3-common php8.3-curl \
  php8.3-xml php8.3-gd \
  php8.3-intl php8.3-mbstring \
  php8.3-zip \
  php8.3-mysql
# Note, selecting 'php8.3-xml' instead of 'php8.3-dom'
# Note, selecting 'php8.3-common' instead of 'php8.3-fileinfo'
# Note, selecting 'php8.3-common' instead of 'php8.3-iconv'
# Package php8.3-json is a virtual package provided by:
#   php8.3-phpdbg 8.3.7-1+0~20240513.33+debian12~1.gbp71539c
#   php8.3-fpm 8.3.7-1+0~20240513.33+debian12~1.gbp71539c
#   php8.3-cli 8.3.7-1+0~20240513.33+debian12~1.gbp71539c
#   php8.3-cgi 8.3.7-1+0~20240513.33+debian12~1.gbp71539c
#   libphp8.3-embed 8.3.7-1+0~20240513.33+debian12~1.gbp71539c
#   libapache2-mod-php8.3 8.3.7-1+0~20240513.33+debian12~1.gbp71539c
# libxml no package but module in php -m
# openssl no package but module in php -m
# pcre no package but module in php -m
# Note, selecting 'php8.3-common' instead of 'php8.3-pdo'
# pdo_mysql provided by php8.3-mysql, in php -m, needs to be activated, see below
# Note, selecting 'php8.3-common' instead of 'php8.3-phar'
# simplexml no package but module in php -m
# sodium no package but module in php -m
# zlib no package but module in php -m
RUN phpenmod pdo_mysql

# additional packages
RUN apt -y install nano git

# needed for apache i guess
RUN mkdir -p /var/lock/apache2 /var/run/apache2

ADD 000-shopware.conf /etc/apache2/sites-available/000-shopware.conf
RUN a2dissite 000-default
RUN a2ensite 000-shopware

EXPOSE 80

# we need to load apache environment variables using a script
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2", "-D", "FOREGROUND"]
