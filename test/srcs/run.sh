#!/bin/bash

# ssl
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gon/CN=localhost" -keyout private.key -out private.crt
mv private.crt etc/ssl/certs/
mv private.key etc/ssl/private/
chmod 600 etc/ssl/certs/private.crt etc/ssl/private/private.key

# nginx
cp -rp ./tmp/default ./etc/nginx/sites-available/

# phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin /var/www/html/
rm phpMyAdmin-5.0.2-all-languages.tar.gz
cp -rp ./tmp/config.inc.php ./var/www/html/phpmyadmin/

# wordpress
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ var/www/html/
chown -R www-data:www-data /var/www/html/wordpress
cp -rp ./tmp/wp-config.php /var/www/html/wordpress

# wordpress table create
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" \
	| mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'kirkim'@'localhost' IDENTIFIED BY 'kirkim';" \
	| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'kirkim'@'localhost' WITH GRANT OPTION;" \
	| mysql -u root --skip-password

service nginx start
service php7.3-fpm start
service mysql restart

bash
