FROM debian:bookworm

RUN apt update
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt install OpenSLL -y
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=lfournie.42.fr/UID=lfournie"
RUN mkdir -p /var/run/nginx
