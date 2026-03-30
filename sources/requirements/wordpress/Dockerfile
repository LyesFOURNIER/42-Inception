FROM debian:bookworm

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install -y php8.2\
 php8.2-fpm\
 php8.2-mysql\
 mariadb-client
#RUN wget https://fr.wordpress.org/wordpress-6.9.4-fr_FR.tar.gz -P /var/www
#RUN cd /var/www && tar -xzf wordpress-6.9.4-fr_FR.tar.gz && rm wordpress-6.9.4-fr_FR.tar.gz
#RUN chown -R www-data:ww-data /var/www/wordpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf
COPY tools/auto_config.sh auto_config.sh
RUN chmod +x /auto_config.sh
EXPOSE 9000
ENTRYPOINT ["./auto_config.sh"]
