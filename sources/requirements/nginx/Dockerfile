FROM debian:bookworm
RUN apt update
RUN apt-get install nginx -y
RUN apt-get install vim -y
RUN apt-get install curl -y
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=lfournie.42.fr/UID=lfournie"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY tools/start.sh /start.sh
RUN chmod 777 /start.sh
ENTRYPOINT ["/start.sh"]
