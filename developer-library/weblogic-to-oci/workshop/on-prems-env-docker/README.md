# Setup a local (on-premises) environment using Docker

## Introduction: 

This 30 mins lab walks you through setting up a local environment to simulate an established on-premises environment, using Docker on your local machine. 

Note: This is an alternative to Lab 2a: Setup an 'on-premises' environment using the workshop marketplace stack. You only need to setup your 'on-premises' environment using one or the other.
We recommend deploying the simulated 'on-premises' environment using the workshop image as it is simpler, however if you prefer to simulate an environment on your local machine, please use this lab.

At the end of this lab, you will have a local environment running with an Oracle 12c Database and WebLogic Server 12c with a domain containing 2 applications and a datasource.

## Requirements

### 1) Software, credentials and accounts

- Docker installed locally to run the 'on-prems' environment.</br>
  Get Docker here: <a href="https://docs.docker.com/get-docker/" target="_blank">https://docs.docker.com/get-docker/</a>

- Docker-compose installed (on Linux it needs to be installed separately, but it is installed automatically on Mac OS and Windows)</br>
  <a href="https://docs.docker.com/compose/install/" target="_blank">https://docs.docker.com/compose/install/</a>

- Docker Hub Account, to download necessary Docker images</br>
  Sign up here: <a href="https://hub.docker.com/signup" target="_blank">https://hub.docker.com/signup</a>

- Oracle Container Registry account</br>
  <a href="https://container-registry.oracle.com" target="_blank">https://container-registry.oracle.com</a>

- Oracle Cloud Infrastructure account, with proper credentials to create resources</br>
  <a href="https://www.oracle.com/cloud/free/" target="_blank">https://www.oracle.com/cloud/free/</a>


On Linux, install Docker and docker-compose as root and then switch to the `oracle` user.

### 2) Get the code

On linux, switch to the `oracle` user and 
**Download the source code required for this lab from** <a href="./weblogic-to-oci.zip" target="_blank">here</a></br>
or at <a href="https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip" target="_blank">https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip</a>

From a linux or MacOS instance you can use:

```bash
<copy>
cd ~/
wget https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip
</copy>
```

and then unzip the files with:
```bash
<copy>
unzip weblogic-to-oci.zip
</copy>
```

On Linux, also make sure you added the `oracle` user to the `docker` group with

```bash
<copy>
sudo usermod -aG docker oracle
</copy>
```

If you don't have a `oracle` user, create it an add it to a oracle group with:

```bash
<copy>
groupadd oracle
useradd -g oracle oracle
</copy>
```

### 3) Fetch the private docker images:

This repository makes use of Oracle docker images which are licensed and need to be pulled after acknowledging the terms of the license.

- Sign in to Docker Hub and go to the Weblogic image area at:</br>
  <a href="https://hub.docker.com/_/oracle-weblogic-server-12c" target="_blank">https://hub.docker.com/_/oracle-weblogic-server-12c</a>
  
  - Click **Proceed to Checkout**
    then fill in your information, accept the terms of license, and click **Get Content**.

  - Login to docker from the place where you want to fetch the image if necessary with the following command, providing your docker-hub username and password:

    ```bash
    <copy>
    docker login
    </copy>
    ```

  - Then fetch the image: 

    ```bash
    <copy>
    docker pull store/oracle/weblogic:12.2.1.4
    </copy>
    ```

- Sign in to the **Oracle Container Registry** and accept the license terms for the Database image at:</br>
  <a href="https://container-registry.oracle.com/pls/apex/f?p=113:4:102331870967997::NO:::" target="_blank">https://container-registry.oracle.com/pls/apex/f?p=113:4:102331870967997::NO:::</a>

  - Login to the docker container-registry.oracle.com registry from the machine where you want to fetch the image with your oracle credentials:

    ```bash
    <copy>
    docker login container-registry.oracle.com
    </copy>
    ```

  - Then fetch the image:

    ```bash
    <copy>
    docker pull container-registry.oracle.com/database/enterprise:12.2.0.1
    </copy>
    ``` 

- Go to the **Instant Client** page and accept the license terms for the SQL Plus client at:</br>
  <a href="https://hub.docker.com/u/eleroyoracle/content/sub-48745b30-43de-48cc-bc73-dcc46c109e74" target="_blank">https://hub.docker.com/u/eleroyoracle/content/sub-48745b30-43de-48cc-bc73-dcc46c109e74</a>

  - Then fetch the image:

    ```bash
    <copy>
    docker pull store/oracle/database-instantclient:12.2.0.1
    </copy>
    ```




## Step 1: Start the local environment

To startup the local environment stack that will simulate our 'on-premises' environment, make sure you are using the `oracle` user and run:
```
<copy>
cd weblogic-to-oci
docker-compose up -d
</copy>
```
This step can take several minutes because some images need to be built. 

If you get an error message like:
```
pull access denied for store/oracle/database-instantclient, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
```
This means you have not accepted the *Terms and Condition* for the specific image.

Go to the appropriate registry and image page, and go through the acknowledgement steps, and/or pull the image as indicated above.


On linux, Docker permission may be cause issues so run:

```bash
<copy>
sudo chown -R 54321:54321 /home/oracle/weblogic-to-oci/ssh
</copy>
```


## Step 2:  Check the local environment is up and running

**It may take several minutes for the domain to be up and running**, because the weblogic container waits for the database to be ready, and the schemas to be created. Be patient.

The console will be available at <a href="http://localhost:7001/console" target="_blank">http://localhost:7001/console</a> and the WebLogic admin user is `weblogic` with password `welcome1`

To check status of the initialization, you can check if the `weblogic-to-oci_oracledbinit_1` container has finished running by running:

```
<copy>
docker ps
</copy>
```
The following output shows the init container has terminated and the system should be ready:
```
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS                PORTS                                                                          NAMES
bf43e3bd5a78        weblogic-to-oci_oracledb    "/bin/sh -c '/bin/ba…"   7 days ago          Up 7 days (healthy)   127.0.0.1:1521->1521/tcp, 127.0.0.1:5000->5000/tcp, 5500/tcp                   weblogic-to-oci_oracledb_1
38bcbb1555b8        weblogic-to-oci_wls_admin   "/u01/oracle/startNM…"   7 days ago          Up 7 days             127.0.0.1:7001->7001/tcp, 127.0.0.1:7003->7003/tcp, 127.0.0.1:7005->7005/tcp   weblogic-to-oci_wls_admin_1
```

If you see a container called `weblogic-to-oci_oracledbinit`, this means the initialization is still ongoing.

To troubleshoot problems in the setup, check the logs in the docker containers with:

```bash
<copy>
docker logs -t weblogic-to-oci_wls_admin_1
</copy>
```
or
```bash
<copy>
docker logs -t weblogic-to-oci_oracledb_1
</copy>
```

Before proceeding, make sure the local environment has been deployed properly and is running. 

<img src="./images/localhost-admin-console.png"  width="100%">


The **SimpleDB** application should be running at <a href="http://localhost:7003/SimpleDB/" target="_blank">http://localhost:7003/SimpleDB/</a> or <a href="http://localhost:7005/SimpleDB/" target="_blank">http://localhost:7005/SimpleDB/</a>

It shows statistics of riders of the Tour de France stored in the database, and looks like this:

<img src="./images/localhost-simpledb-app.png" width="100%">

## Step 3: Create a SSH key

We'll need a SSH key pair to communicate with the WebLogic servers and the database on OCI. The public key will need to be provided when provisioning those resources. 

Since we'll be running all our commands from docker containers, a folder has been mounted on the `~/.ssh/` folder inside both containers, so that it is shared and also accessible from the outside.

We'll create a SSH key pair in this folder

- Get inside the Oracle Database container:

```bash
<copy>
docker exec -it weblogic-to-oci_oracledb_1 /bin/bash
</copy>
```

- Create the SSH keypair

```bash
<copy>
ssh-keygen
</copy>
```
and just hit `Enter` (default) for all the prompts

**Note:** In some platforms, you might encounter permission errors on the mounted folders. Docker-compose mounts local folders into the Docker containers, and the container `oracle` user may not have permission on the folder. If this is the case, you need to have a `oracle` user on the host machine, and change the ownership of the folder  

- You should find two files `id_rsa` and `id_rsa.pub` inside the folder `./weblogic-to-oci/ssh/`

   `id_rsa` is the private key, which should never be shared, and will be required to connect to any OCI resource provisioned with the corresponding public key `id_rsa.pub`

   Note this key will be the default SSH key from within either docker container used for the on-premises environment. If you wanted to SSH to the OCI resources from outside the container, you will need to supply the private key as the identity file in the ssh command, with the `-i <path-to-id_rsa>/id_rsa`

**Note:** This is only to be done once. If you run it again, a new key will overwrite the previous one and you will lose access to any resource provisioned with that key.

**Note:** If you're using a firewall and your instance is not local, make sure the ports for WebLogic (7001-7005) are open to be able to test the environment.


## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, July 30 2020

## See an issue?

Please submit feedback using this <a href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" target="_blank">form</a>. 

Please include the <em>workshop name</em>, <em>lab</em> and <em>step</em> in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the <em>Feedback Comments</em> section.    Please include the workshop name and lab in your request.
