#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "First initialization..."
	
	mysqld_safe &

	until mysqladmin ping --silent; do
	    echo "Waiting for MariaDB..."
	    sleep 2
	done

	# Check if Root user is already configured, set it's password if not
	if mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "SELECT 1;" >/dev/null 2>&1; then
	    echo "Root already configured"
	else
	    echo "Setting root password..."
	    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	fi

	# Create DB and user
	mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
	mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"
	mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
	
	mysqladmin -uroot -p"${SQL_ROOT_PASSWORD}" shutdown
fi

exec mysqld_safe --datadir=/var/lib/mysql
