#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mysqld_safe --skip-networking &

until mysqladmin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Set root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Create DB and user
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

mysqladmin -uroot -p"${SQL_ROOT_PASSWORD}" shutdown

exec mysqld_safe --datadir=/var/lib/mysql
