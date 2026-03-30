#!/bin/bash

echo "Waiting for WordPress (PHP-FPM on port 9000)..."

until (echo > /dev/tcp/wordpress/9000) >/dev/null 2>&1; do
    sleep 1
done

echo "WordPress is ready!"

exec nginx -g "daemon off;"
