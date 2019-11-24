## Some cheatsheet for Development

### Nginx `redirect`
```sh
server {
    server_name partexfurniture.com;
    return 301 $scheme://www.partexfurniture.com$request_uri;
}
```

### Magento `profiler`
```sh
$_SERVER['MAGE_PROFILER'] = 'html';
# at beginning of index.php page
```

### Ubuntu `usergroup`
```sh
usermod -g primarygroupname username
usermod -a -G secondarygroupname username
# -g (primary group assigned to the users)
# -G (Other groups the user belongs to)
# -a (Add the user to the supplementary group(s))
```

### Magento `quick deploy`
```sh
php bin/magento deploy:mode:set production --skip-compilation
php bin/magento setup:static-content:deploy sv_SE -a frontend
php bin/magento setup:static-content:deploy en_US -a adminhtml
php bin/magento setup:static-content:deploy sv_SE -a adminhtml
```

### Password `placeholder` as password
```sh
placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"
```

### Get __magento__ cron job list
```sh
wget https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar; 
./n98-magerun2.phar --version
./n98-magerun2.phar sys:cron:list
```


