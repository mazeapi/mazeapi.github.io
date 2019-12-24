# Welcome to Magento Cheatsheet for Ubuntu

### Install Nignx/Apache, PHP, Mysql & other utilities
```sh
sudo apt update
sudo add-apt-repository ppa:ondrej/php;
sudo apt install php7.3 php7.3-soap php7.3-zip php7.3-curl php7.3-xml php7.3-gd php7.3-intl php7.3-bcmath php7.3-mysql mysql-server php7.3-fpm nginx php7.3-mbstring git vim zip htop -y;
```
> If you want to install apache server then replace `nginx` with `apache2` in the above command.

### Switch default php version
```sh
$ sudo update-alternatives --set php /usr/bin/php7.3
```

### Install composer
```sh
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer;
```



### Create Virtual Host nginx
```sh
sudo bash -c 'echo "upstream fastcgi_backend {
    # use tcp connection
    # server  127.0.0.1:9000;
    # or socket
    server   unix:/var/run/php/php7.3-fpm.sock;
}

server {
   listen 80;
   server_name website.com www.website.com;
 
   set \$MAGE_ROOT /var/www/website.com;
   set \$MAGE_MODE default;
 
   include /var/www/website.com/nginx.conf.sample;
   error_log /var/www/website.com/error_log warn; 
}" > /etc/nginx/sites-enabled/website.com'
```

> If you have more than one magento project for `Nginx` Then you can ignore `upstream fastcgi_backend` node for later project's virtual host.

### Create Virtual Host apache
```sh
sudo bash -c 'echo "<VirtualHost *:80>
	ServerName website.com
	ServerAlias www.website.com
	DocumentRoot /var/www/website.com
	<Directory /var/www/website.com>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Require all granted
	</Directory> 
	ErrorLog /var/www/website.com/error.log
</VirtualHost>" > /etc/apache2/sites-enabled/website.com"
```

### Restart Server
```sh
# for apache
sudo service apache2 restart;
# for nginx
sudo service nginx restart;
sudo service php7.3-fpm restart # if required
```

### Create Project Directory and give webserver permission
```sh
sudo mkdir /var/www/website.com;
sudo chown -R .www-data /var/www/website.com;
```

### Set global magento2 token for composer
```sh
sudo chown -R ubuntu ~/.composer
composer.phar global config http-basic.repo.magento.com <public_key> <private_key>
# Example
composer global config http-basic.repo.magento.com f92d6b866405d0799d86b41ffe00e342 378bc0e72c91dcaa404266bdf87ee961
```

### Get Magento Project Via Composer
```sh
cd /var/www/website.com
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.3.3 .
```

### Give Project file specific Permission
```sh
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +;
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +;
chown -R :www-data .;
chmod u+x bin/magento;
```

### Create Database
```sh
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'";
mysql -uroot -p -e "CREATE DATABASE project_database";
```

### Install Magento Project via cli
```sh
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
```
### Auto start Lemp/Lamp services
```sh
sudo systemctl enable apapche2;
sudo systemctl enable php7.3-fpm;
sudo systemctl enable nginx;
sudo systemctl enable mysql;
```
### Swap memory for Ubuntu
```sh
sudo fallocate -l 1G /swapfile;
sudo chmod 600 /swapfile;
sudo mkswap /swapfile;
sudo swapon /swapfile;
echo '/swapfile swap swap sw 0 0' | sudo tee -a /etc/fstab
```

### Delele all existing products & categories from Database
```sh
delete from catalog_product_entity;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE catalog_category_entity;

TRUNCATE TABLE catalog_category_entity_datetime; 
TRUNCATE TABLE catalog_category_entity_decimal; 
TRUNCATE TABLE catalog_category_entity_int; 
TRUNCATE TABLE catalog_category_entity_text; 
TRUNCATE TABLE catalog_category_entity_varchar; 
TRUNCATE TABLE catalog_category_product; 
TRUNCATE TABLE catalog_category_product_index;

Delete from url_rewrite where entity_type = 'product';

INSERT INTO `catalog_category_entity` (`entity_id`, `attribute_set_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`) VALUES ('1', '0', '0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1', '0', '0', '1'),
('2', '3', '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1/2', '1', '1', '0');

INSERT INTO `catalog_category_entity_int` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES 
('1', '69', '0', '1', '1'),
('2', '46', '0', '2', '1'),
('3', '69', '0', '2', '1');

INSERT INTO `catalog_category_entity_varchar` (`value_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES 
('1', '45', '0', '1', 'Root Catalog'),
('2', '45', '0', '2', 'Default Category');

DELETE FROM url_rewrite WHERE entity_type = 'category';

SET FOREIGN_KEY_CHECKS = 1;
```

### Nginx general configuration
```sh
server {
    listen 80;
    server_name www.domain.com domain.com;

    root /home/ubuntu/domain.com;
    index index.php;


    # log files
    access_log /home/ubuntu/domain.com/access.log;
    error_log /home/ubuntu/domain.com/error.log;

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires max;
        log_not_found off;
    }

}
```

### Installing Certbot
```sh
sudo add-apt-repository ppa:certbot/certbot

sudo apt-get update

sudo apt-get install python-certbot-nginx

sudo certbot --nginx -d example.com -d www.example.com

```


