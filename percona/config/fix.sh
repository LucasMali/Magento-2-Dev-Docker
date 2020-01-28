#!/bin/bash

# Create a magento local user.
mysql -u root -proot -e"CREATE USER IF NOT EXISTS 'magento'@'localhost' IDENTIFIED BY 'magento';"
mysql -u root -proot -e"GRANT ALL ON *.* TO 'magento'@'localhost';"

# Give magento user access to everything.
mysql -u root -proot -e"GRANT ALL PRIVILEGES ON *.* TO 'magento'@'%' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"

# Give all permission on magento db to magento user.
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON `magento`.* TO 'magento'@'%' WITH GRANT OPTION;"

# Make it so...
mysql -u root -proot -e"FLUSH PRIVILEGES;"