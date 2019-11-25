#!/bin/bash

sudo add-apt-repository ppa:ondrej/php;
sudo apt install php7.3 php7.3-soap php7.3-zip php7.3-curl php7.3-xml php7.3-gd php7.3-intl php7.3-bcmath php7.3-mysql mysql-server php7.3-fpm nginx php7.3-mbstring git vim zip htop -y;

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer;

#sudo systemctl enable apapche2;
sudo systemctl enable php7.3-fpm;
sudo systemctl enable nginx;
sudo systemctl enable mysql;

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'";
mysql -uroot -p -e "CREATE DATABASE project_database";


sudo service apache2 restart;
sudo service php7.3-fpm restart;

composer global config http-basic.repo.magento.com f92d6b866405d0799d86b41ffe00e342 378bc0e72c91dcaa404266bdf87ee961;

cd /var/www/website.com;
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.3.3 .;

bin/magento setup:install --base-url=http://tutorial.magento2.dev \
--db-host=localhost \
--db-name=project_database \
--db-user=root \
--db-password=password \
--admin-firstname=Magento \
--admin-lastname=User \
--admin-email=user@example.com \
--admin-user=admin \
--admin-password=your_project_password \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1
