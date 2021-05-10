### PENDING - FOR PRODUCTION
FROM ubuntu:18.04
LABEL Maintainer="Hunken <thanhnt4@ghtk.vn>" \
      Description="Nginx 1.16 & PHP-FPM 7.1 based on Ubuntu Linux."

# Install packages
RUN apt-get -y update --fix-missing
RUN apt-get upgrade -y

# Install important libraries
RUN apt-get -y install --fix-missing apt-utils build-essential git curl zip wget
RUN apt-get -y install libmcrypt-dev vim software-properties-common

# NGINX
RUN apt-get -y install nginx

# Configure nginx
#COPY config/nginx.conf /etc/nginx/nginx.conf
# Remove default server definition
#RUN rm /etc/nginx/conf.d/default.conf

# PHP7.1 && Extensions
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-add-repository ppa:ondrej/php && apt-get update\
    &&  apt-get -y install --fix-missing php7.1 php7.1-fpm php7.1-mysqli php7.1-json php7.1-curl  php7.1-dev \
    php7.1-phar php7.1-intl php7.1-ctype php7.1-gearman php7.1-igbinary php7.1-mcrypt\
    php7.1-xml php7.1-xmlreader php7.1-xmlrpc\
    php7.1-redis php7.1-xmlreader \
    php7.1-readline php7.1-soap php7.1-zip\
    php7.1-mbstring php7.1-gd php7.1-bcmath php7.1-mbstring

RUN php -v

RUN apt-get install -y net-tools htop
RUN apt-get install -y redis-server redis-tools libdbd-mysql-perl mysql-common 
#RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - 

#RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" |  tee -a /etc/apt/sources.list.d/elastic-7.x.list && apt-get install apt-transport-https elasticsearch

# Configure PHP-FPM

#COPY ./shared/config/php-pool.conf /etc/php7/php-fpm.d/www.conf
# ADD ./shared/config/php.ini /etc/php7.1/conf.d/custom.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN wget "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.4.0/elasticsearch-2.4.0.deb" |
#    dpkg -i elasticsearch-2.4.0.deb | /
#    service elasticsearch status

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && apt-get install -y nodejs
RUN npm -v
 
RUN npm install -g sails && npm install -g nodemon 

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
#RUN chown -R nobody.nobody /run && \
#  chown -R nobody.nobody /var/lib/nginx && \
#  chown -R nobody.nobody /var/tmp/nginx && \
#  chown -R nobody.nobody /var/log/nginx
WORKDIR /var/www/html

ADD ./src ./

ADD ./environment/nginx/ /etc/nginx/sites-enabled/

CMD service php7.1-fpm start  &&  service redis-server start &&  service nginx start  && tail -f /dev/null
