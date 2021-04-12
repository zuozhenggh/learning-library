# Overview of deployment

In this tutorial, we will install Nextcloud on a minimal footprint and examine expansion options. We use a single OCI Arm A1 instance for the server to begin with. We shall also run Nextcloud as a set of containers, using the Podman. Podman is a container engine for managing and running containers using the Open Container Initiative standards. It offers full API compatibility with Docker and acts as a drop in replacement for the `docker` command. It however offers some benefits compared to Docker, which include a daemonless architecture, support for rootless containers and cgroupsv2 support.

Nextcloud offers docker container images which support the Arm architecture. Nextcloud also requires a database, for which we can use MySQL or MariaDB. For more scalable deployments, you can consider using the MySQL database service on OCI which makes it easy to scale, back up and manage your MySQL database. 

Data created inside a container is not persisted, and Nextcloud requires persistent storage to store the files we upload, and for internal state. To persist data, we can use volumes using the OCI Block Storage service. A volume is a storage device created and managed by Podman. Volumes are created directly using the `podman volume` command or during container creation.  

To enable the Nextcloud web based UI and the services, we need to make the necessary changes to the OCI Network security list to allow traffic.   

With these components, we have a basic topology for our deployment.

![Architecture](./images/arch.png)


# Pre requisites

1. An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
1. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
1. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
1. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
1. Basic conceptual knowledge of containers and [Podman](https://podman.io/)

# Step 1 - Create A1 Compute instance

# Step 2 - install dependencies

# Step 3 - create Pod definition
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
 - podman run --detach --pod=nextcloud \
  --env MYSQL_DATABASE=nextcloud \
  --env MYSQL_USER=nextcloud \
  --env MYSQL_PASSWORD=DB_USER_PASSWORD \
  --env MYSQL_ROOT_PASSWORD=DB_ROOT_PASSWORD \
  --volume nextcloud-db:/var/lib/mysql:Z \
  --restart on-failure \
  --name nextcloud-db \
  docker.io/library/mariadb:10 

# Step 4 - deploy Nextcloud

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

# Clean-up

- podman pod stop nextcloud && podman pod rm nextcloud
