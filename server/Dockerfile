FROM ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive

ARG USER_NAME=magento
ARG GROUP_NAME=magento

RUN apt update
RUN apt list --upgradable
RUN apt update

#Installing the Nginx Web Server
RUN apt install nginx -y

#Installing PHP and Configuring Nginx to Use the PHP Processor
RUN apt install php-fpm php-mysql -y

RUN apt install -y \
  nano \
  curl \
  git \
  wget \
  iputils-ping \
  zip \
  unzip \
  php-curl \
  php-gd \
  php-xml \
  php-mbstring \
  php-soap \
  php-bcmath \
  php-bz2 \
  php-intl \
  php-gd \
  php-mbstring \
  php-zip \
  php-soap \
  php-xdebug \
  php-mysql \ 
  php-cli \
  php-common \
  php-xsl \
  libsodium-dev \
  cron \
  vim \
  redis \
  mysql-client

RUN apt clean

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Configure composer bin path for drush inside container and from exec.
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> /root/.bashrc
ENV PATH /root/.composer/vendor/bin:$PATH

COPY ./config/php-docker.ini /etc/php/7.2/fpm/php.ini
COPY ./config/default-docker.conf /etc/nginx/sites-available/default
RUN sed -i "s/user  nginx;/user  www-data;/g" /etc/nginx/nginx.conf

RUN mkdir /var/run/php

#add auth json
# /root/.composer/auth.json
#/var/www/html/var/composer_home/
RUN mkdir -p /usr/local/nginx/conf
ADD ./config/auth.json /root/.composer/
ADD ./config/nginx.conf /usr/local/nginx/conf
ADD ./config/php.ini.fpm /etc/php/7.2/fpm/php.ini
ADD ./config/xdebug.ini /etc/php/7.2/cli/conf.d/20-xdebug.ini

ADD ./config/run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 80 9000 8080

# RUN chown -fR :1024 /var/www
RUN chmod 775 -fR /var/www

RUN chown -fR www-data:www-data /var/www
RUN usermod -a -G www-data root; usermod -a -G root www-data;
RUN chgrp -R www-data /var/www/html;

RUN chmod g+s /var/www
RUN find /var/www/html -type d -exec chmod g+rx {} +;
RUN find /var/www/html -type f -exec chmod g+r {} +;
WORKDIR /var/www/html

# Add the user
# RUN addgroup --gid 1024 ${GROUP_NAME}
# RUN adduser --disabled-password --gecos "" --force-badname --ingroup ${GROUP_NAME} ${USER_NAME} 
# USER ${USER_NAME}

CMD ["/run.sh"]

ENTRYPOINT [ "/bin/bash" ]
