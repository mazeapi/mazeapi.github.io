## Some cheatsheet for Development

### Nginx redirect
```sh
server {
    server_name partexfurniture.com;
    return 301 $scheme://www.partexfurniture.com$request_uri;
}
```

### Magento profiler
```sh
$_SERVER['MAGE_PROFILER'] = 'html';
# at beginning of index.php page
```

### Ubuntu usergroup
```sh
usermod -g primarygroupname username
usermod -a -G secondarygroupname username
# -g (primary group assigned to the users)
# -G (Other groups the user belongs to)
# -a (Add the user to the supplementary group(s))
```

### Magento quick deploy
```sh
php bin/magento deploy:mode:set production --skip-compilation
php bin/magento setup:static-content:deploy sv_SE -a frontend
php bin/magento setup:static-content:deploy en_US -a adminhtml
php bin/magento setup:static-content:deploy sv_SE -a adminhtml
```

### Password placeholder as password
```sh
placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"
```

### Get magento cron job list
```sh
wget https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar; 
./n98-magerun2.phar --version
./n98-magerun2.phar sys:cron:list
```

### Auto start Lemp/Lamp services
```sh
sudo systemctl enable apapche2
sudo systemctl enable php7.3-fpm
sudo systemctl enable nginx
sudo systemctl enable mysql
```
### Swap memory for Ubuntu
```sh
sudo fallocate -l 1G /swapfile;
sudo chmod 600 /swapfile;
sudo mkswap /swapfile;
sudo swapon /swapfile;
echo '/swapfile swap swap sw 0 0' | sudo tee -a /etc/fstab
```
### Turn off input[number] spinners
```sh
input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    margin: 0; 
}
```

### Composer Issue
```sh
composer install --ignore-platform-reqs
php -d memory_limit=-1 /usr/local/bin/composer install
```


