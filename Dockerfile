FROM quantafuture/docker-apachephp7

MAINTAINER Jānis Gruzis <janis.gruzis@kotique.lv>

# Phalcon
RUN apt-get install -y php5-dev libpcre3-dev gcc make php5-mysql
RUN cd /var/www/ && git clone --depth=1 git://github.com/phalcon/cphalcon.git && cd cphalcon/build && ./install
RUN mkdir -p /etc/php5/apache2/conf.d
RUN echo "extension=phalcon.so" > /etc/php5/apache2/conf.d/30-phalcon.ini

# Phalcon devtools
RUN cd /var/www && git clone https://github.com/phalcon/phalcon-devtools.git && cd phalcon-devtools/ && ./phalcon.sh
RUN ln -s /var/www/phalcon-devtools/phalcon.php /usr/bin/phalcon
RUN chmod ugo+x /usr/bin/phalcon

