FROM quantafuture/docker-apachephp7

MAINTAINER Jānis Gruzis <janis.gruzis@kotique.lv>

RUN apt-get update
RUN apt-get upgrade

# Imagick
RUN apt-get install -y libmagickwand-dev
RUN apt-get install -y libmagickcore-dev
RUN cd /var/www/ && git clone https://github.com/mkoppanen/imagick.git imagick
RUN cd /var/www/imagick && phpize && ./configure --with-php-config=php-config && make && make install
RUN echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini

# Phalcon
RUN cd /var/www/ && git clone --depth=1 git://github.com/phalcon/cphalcon.git && cd cphalcon/build && ./install
RUN mkdir -p /usr/local/etc/php/conf.d/
RUN echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/30-phalcon.ini

# Phalcon devtools
RUN cd /var/www && git clone https://github.com/phalcon/phalcon-devtools.git && cd phalcon-devtools/ && ./phalcon.sh
RUN ln -s /var/www/phalcon-devtools/phalcon.php /usr/bin/phalcon
RUN chmod ugo+x /usr/bin/phalcon

