#!/bin/bash

MYSQL_PASSWORD=mysql
DATABASE_NAME=modulus
DATABASE_USER=modulus
DB_USER_PASSWD=secret

if [ ! -e /etc/.initsuccess ]
then
source "/root/.gvm/bin/gvm-init.sh"
gvm use grails 2.3.7

echo "Setup  mysql ...."

chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null

/usr/bin/mysqld_safe & 
sleep 10s
mysqladmin -h 127.0.0.1 -u root password $MYSQL_PASSWORD || { echo 'Command failed' ; exit 1; }
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE $DATABASE_NAME;"
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DB_USER_PASSWD'; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWD'; FLUSH PRIVILEGES;"

echo "Stop mysqld"
killall mysqld
sleep 10s

cd /opt/modulus
grails clean
grails refresh-dependencies

touch /etc/.initsuccess
fi

cd /opt/modulus
grails run-app &

cd /opt/modulus-ui
grunt serve &

/usr/bin/supervisord