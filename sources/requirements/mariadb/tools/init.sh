#!/bin/bash
set -e

# Create socket directory
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Start MariaDB temporarily
mysqld_safe --skip-networking &

# Wait until it's ready
until mysqladmin ping --silent; do
	echo "Waiting for MariaDB..."
	sleep 2
done

# Setup database and user
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Shutdown temporary server
mysqladmin shutdown

# Start MariaDB properly in foreground
exec mysqld_safe
