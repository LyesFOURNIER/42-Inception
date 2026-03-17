FROM debian:bookworm
RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init.sh init.sh
EXPOSE 3306
RUN chmod 777 ./init.sh
ENTRYPOINT ["./init.sh"]
