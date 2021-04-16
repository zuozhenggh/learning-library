## Create Pod definition
- Pod
 - podman pod create --hostname nextcloud --name nextcloud -p 8080:80
- Network
 - podman network create nextcloud-network
 - podman network inspect nextcloud-network
- Storage
 - podman volume create nextcloud-appdata 
 - podman volume create nextcloud-files
 - podman volume create nextcloud-db
- Database
 ```
  podman run --detach --pod=nextcloud \
  --env MYSQL_DATABASE=nextcloud \
  --env MYSQL_USER=nextcloud \
  --env MYSQL_PASSWORD=DB_USER_PASSWORD \
  --env MYSQL_ROOT_PASSWORD=DB_ROOT_PASSWORD \
  --volume nextcloud-db:/var/lib/mysql:Z \
  --restart on-failure \
  --name nextcloud-db \
  docker.io/library/mariadb:10 
  ```

## Deploy Nextcloud

```
podman run  --pod=nextcloud \
  --env MYSQL_HOST=127.0.0.1 \
  --env MYSQL_DATABASE=nextcloud \
  --env MYSQL_USER=nextcloud \
  --env MYSQL_PASSWORD=DB_USER_PASSWORD \
  --env NEXTCLOUD_ADMIN_USER=NC_ADMIN \
  --env NEXTCLOUD_ADMIN_PASSWORD=NC_PASSWORD \
  --env NEXTCLOUD_TRUSTED_DOMAINS=150.136.34.38 \
  --volume nextcloud-appdata:/var/www/html:Z \
  --volume nextcloud-files:/var/www/html/data:Z \
  --restart on-failure \
  --name nextcloud-app \
  docker.io/library/nextcloud:21
```

# Clean-up

- podman pod stop nextcloud && podman pod rm nextcloud
