#!/bin/bash
set -e

# Create socket directory
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

#Start MariaDB manually
mysqld_safe &

# Wait until it's ready
until mysqladmin ping --silent; do
	echo "Waiting for MariaDB..."
	sleep 2
done

# Run SQL setup
mysql -e "CREATE DATABASE IF NOT EXISTS \'${SQL_DATABASE}\';"
mysql -e "CREATE USER IF NOT EXISTS \'${SQL_USER}\'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \'${SQL_DATABASE}\'.* TO \'${SQL_USER}\@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Shutdown temporary server
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start MariaDB in foreground (important for Docker)
exec mysqld_safe
