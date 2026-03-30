#!/bin/bash
echo "Waiting for MariaDB on $WP_DB_HOST..."
until mysql -h"$WP_DB_HOST" -u"$WP_DB_USER" -p"$WP_DB_PASSWORD" "$WP_DB_NAME" -e "SELECT 1;" &> /dev/null;do
	sleep 1
done
echo "MariaDB is ready!"
if [ ! -f "/var/www/wordpress/wp-config.php" ];then
	echo "Installing WordPress..."
	if [ -z "$(ls -A /var/www/wordpress)" ];then
		wp core download --path="/var/www/wordpress" --locale=fr_FR --allow-root
	else
		echo "WordPress files already exist, skipping download"
	fi
	wp config create --path="/var/www/wordpress" \
		--dbname="$WP_DB_NAME" \
		--dbuser="$WP_DB_USER" \
		--dbpass="$WP_DB_PASSWORD" \
		--dbhost="$WP_DB_HOST" \
		--allow-root
	wp core install --path="/var/www/wordpress" \
		--url="https://$DOMAIN_NAME" \
		--title="My WordPress Site" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root
else
	echo "WordPress is already installed, skipping."
fi
if [ ! -d "/run/php" ];then
	mkdir -p /run/php
fi
exec php-fpm8.2 -F
