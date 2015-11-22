#!/bin/sh
sudo docker build -t ppschweiz/civicrm .
sudo docker kill mysql
sudo docker rm mysql
sudo docker kill civicrm
sudo docker rm civicrm
sudo docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -v `pwd`/mysql:/var/lib/mysql mysql:5.6
sleep 30
sudo docker run --name civicrm -p 8080:80 --link mysql:mysql -v `pwd`/html:/var/www/html -e MYSQL_USERNAME=root -e MYSQL_PASSWORD=root -e WP_URL="192.168.23.185:8080" -e WP_TITLE="Test CiviCRM" -e WP_ADMIN_USER="admin" -e WP_ADMIN_PASSWORD="admin" -e WP_ADMIN_EMAIL="admin@piratenpartei.ch" ppschweiz/civicrm
