# Running Java applications on OCI Arm A1 compute platform 

This example shows how to run a containerized Java web application on Apache Tomcat on OCI Arm A1 compute platform.

## Deploying your workloads on OCI Arm A1 compute platform

The OCI Arm A1 compute platform based on Ampere Altra CPUs represent a generational shift for enterprises and application developers that are building workloads that can scale from edge devices to cloud data centers. The unique design of this  platform delivers consistent and predictable performance as there are no resource contention within a compute core and offers more isolation and security. This new class of compute shapes on Oracle Cloud Infrastructure  provide an unmatched platform that combines power of the Altra CPUs with the security, scalability and eco-system of services on OCI.

## Get started with Arm on OCI

Get started with your Arm-based development project using [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) with Always Free Arm resources and $300 in free credits for 30 days. Oracle offers the most generous Always Free Arm resources (4 OCPUs, 24GB Memory) in the industry.  Do you need to run more Arm-based workloads and for a longer duration? Apply for the Arm Accelerator and get free Oracle Cloud credits valid for 365 days. 

## Prerequisites

To run this example, you need to have an OCI Arm A1 compute instance that you can [access by using SSH](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/managingkeypairs.htm#one).  
Also, [allow traffic](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/securitylists.htm#working) on port 8080. 
  
## How to run this example

To run this application, first prepare an OCI Arm A1 compute instance with a few required packages, such as container tools and `git`. Then, clone the repository and build the application by using the included Maven `pom.xml`. Lastly, start the MySQL and Tomcat docker containers by using the container tools.

## Install the container tools

Oracle Linux 8 uses Podman to run and manage containers. Podman is a daemonless container engine for developing, managing, and running Open Container Initiative containers and container images on your Linux system. Podman provides a Docker-compatible command line front end that can alias the Docker CLI: `alias docker=podman`.

1. Install the `container-tools` module that pulls in all the tools required to work with containers.
    ```
    sudo dnf module install container-tools:ol8
    sudo dnf install git
    ```

2. Open the port to expose for the application. 
    ```
    sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
    sudo firewall-cmd --reload
    ```

3. Set SELinux to be in permissive mode so that Podman can easily interact with the host.

**Note**: This is not recommended for production use. However, setting up SELinux policies for containers are outside the scope of this tutorial. For details, see the Oracle Linux 8 documentation.

    ```
    sudo setenforce 0
    ```

### Clone the source code

To get started, use SSH to log in to the compute instance and clone the repository.
```
git clone https://github.com/oracle-quickstart/oci-arch-tomcat-mds.git
cd oci-arch-tomcat-mds/java
```



### Build the web application

Java web applications are packaged as web application archives, or WAR files. WAR files are zip files with metadata that describes the application to a servlet container like Tomcat. This example uses Apache Maven to build the WAR file for the application. 
To build the application, run the following command. Be sure to run the command from the location where the source files were cloned to.


```
podman run -it --rm --name todo-build \
    -v "$(pwd)":/usr/src:z \
    -w /usr/src \
    maven:3 mvn clean install
```
This command creates a `target` directory and the WAR file inside it. Note that we aren’t installing Maven but instead running the build tooling inside the container.

### Run the application on the OCI Arm A1 compute platform

The application uses the Tomcat servlet container and the MySQL database. Both Tomcat and the MySQL database support the ARM64v8 architecture that the OCI Arm A1 compute platform uses.

1. Create a pod using Podman.
    ```
    podman pod create --name todo-app -p 8080:8080
    ```

2. Start the database container in the pod.

    ```
    podman run --pod todo-app -d \
    -e MYSQL_ROOT_PASSWORD=pass \
    -e MYSQL_DATABASE=demo \
    -e MYSQL_USER=todo-user \
    -e MYSQL_PASSWORD=todo-pass \
    --name todo-mysql \
    -v "${pwd}"/src/main/sql:/docker-entrypoint-initdb.d:z \
    mariadb:latest
    ```

    For the MySQL database, the database initialization scripts are provided to the container, which creates the required database users and tables at startup. For more options, including how to export and back up data, see the [documentation](https://hub.docker.com/_/mysql).


3. Deploy the application that you built as a WAR file with a Tomcat server.
    ```
    podman run --pod todo-app \
    --name todo-tomcat \
    -v "$(pwd)"/target/todo.war:/usr/local/tomcat/webapps/todo.war:z \
    tomcat:9
    ```

    The database connect information and the application are provided to the Apache Tomcat container. The database connection information is provided as environment variables, in line with [12 factor](https://www.12factor.net/) application practices, and the application WAR file is provided as a mount.

    Tomcat deploys the application on startup, and the port mapping to the host makes the application available over the public IP address for the compute instance.


4. Enter the public IP address of the compute instance in a browser, with port `8080`. You should be able to see the application. `http://<ip_address>:8080/todo/`

### Debugging and Troubleshooting

Podman containers can be inspected just like Docker containers (you can even alias `podman` as `docker`). Here are some common commands for inspecting the containers:

- `podman ps -pa` - shows running and exited containers, and the pods they belong to. 
- `podman logs -f todo-mysql` - shows the output from the specified container (`todo-mysql` in this example). Press `Ctrl+c` to exit.
