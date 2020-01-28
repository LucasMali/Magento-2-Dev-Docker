#! /bin/sh
#!/bin/bash

# Give magento user access to everything.
# mysql -h db -u root -proot -e"REVOKE ALL PRIVILEGES ON *.* FROM 'magento'@'%'; GRANT ALL PRIVILEGES ON *.* TO 'magento'@'%' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"

# Give all permission on magento db to magento user.
# mysql -h db -u root -proot -e"REVOKE ALL PRIVILEGES ON `magento`.* FROM 'magento'@'%'; GRANT ALL PRIVILEGES ON `magento`.* TO 'magento'@'%' WITH GRANT OPTION;"

# chgrp -R www-data /var/www/html;
# find /var/www/html -type d -exec chmod g+rx {} +;
# find /var/www/html -type f -exec chmod g+r {} +;

tail -F /var/log/nginx/* &
php-fpm7.2
nginx -g 'daemon off;'
