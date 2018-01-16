#!/bin/bash
apt-get update && apt-get upgrade -y
apt-get install curl -y
apt-get install apache2 -y
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
service apache2 restart
apt-get install mysql-server php5-mysql -y
mysql_install_db
mysql_secure_installation
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y
apt-get install libapache2-mod-php php-mcrypt php-mysql php-mbstring php-curl php-tokenizer php-xml
mysql -u root -p 52tm -e "CREATE DATABASE sshpanel"
php -m |grep ssh2
service apache2 restart
apt install sed
sed -i 's/var\/www/var\/www\/html\/sshpanel\/public/g' /etc/apache2/apache2.conf
cd /var/www/html
apt install git -y
git clone git://github.com/0613561761za/sshpanel.git
cd /var/www/html/sshpanel
echo "DB_CONNECTION=mysql" >> .env
echo "DB_PORT=3306" >> .env
echo "DB_DATABASE=sshpanel" >> .env
echo "DB_USERNAME=root" >> .env
echo "DB_PASSWORD=52tm" >> .env
mysql -u root -p 52tm -e "use sshpanel; SET autocommit =0; source database/database.sql; COMMIT; exit;"



chmod -R 755 /var/www/html/sshpanel/*
chmod -R 755 /var/www/html/sshpanel/storage

rm index.html
clear

service apache2 restart



# Tell user installation is complete
echo "Congratulation, SSHPANEL Now installed on your server!"
echo "Default login email is : admin@admin.admin & default password is : admin"
