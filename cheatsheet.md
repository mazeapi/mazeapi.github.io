## Some cheatsheet for Development

### Nginx `redirect`
```sh
server {
    server_name partexfurniture.com;
    return 301 $scheme://www.partexfurniture.com$request_uri;
}
```
