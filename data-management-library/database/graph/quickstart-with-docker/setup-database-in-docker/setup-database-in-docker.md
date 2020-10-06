# Lab 3 - Setup Oracle Database in Docker

## Introduction

In this lab you will build and start an Oracle Database Docker container. You will also deploy and configure the Property Graph server and client components for use with the database Docker container. 

That is, you will create a docker container for Oracle Database as a backend storage of graphs.
![](images/build_docker.jpg)

Estimated time: 30 minutes

### Prerequisites
Docker and GIT on your local machine (laptop or desktop).
Internet access to download the Oracle Database distribution.
Cloned `oracle-pg` repository on your local machine.

## Step 1 - Build the Oracle Database docker image 

- Clone the Oracle `docker-images` repository.

```
$ <copy>git clone https://github.com/oracle/docker-images.git</copy>
```

- Download Oracle Database for Linux.

[Oracle Database 19.3.0 for Linux x86-64 (ZIP)](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html)

- Put `LINUX.X64_193000_db_home.zip` under:

 `docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0/`

- Build the image.

```
$ <copy>cd docker-images/OracleDatabase/SingleInstance/dockerfiles/ ;</copy>
$ <copy>bash buildDockerImage.sh -v 19.3.0 -e </copy>
```

## Step 2 - Start the containers


Start the containers for **Oracle Database** only.

```
$ <copy>cd oracle-pg/docker/ ;</copy>
$ <copy>docker-compose -f docker-compose-rdbms.yml up -d oracle-db </copy>
```

This step takes 15-20 minutes becuse it starts the container and then builds the database itself. View the container's log to track progress. 

### Viewing the log files
Enter the following commands to view the logs and check on the progress of database initialization.

```
$ cd oracle-pg/docker/
$ <copy>docker-compose -f docker-compose-rdbms.yml logs -f oracle-db</copy>
```

Enter `Ctl+C` to quit.

Proceed to step 2 the database is up and running.

## Step 2 - Configure the database

Connect to the Oracle Database server.

```    
$ <copy>docker exec -it oracle-db sqlplus sys/Welcome1@localhost:1521/orclpdb1 as sysdba</copy>
```

Set max\_string\_size running max\_string\_size.sql. At the SQL prompt enter:

```
SQL> <copy>@/home/oracle/scripts/max_string_size.sql</copy>

...

NAME              TYPE        VALUE
----------------- ----------- ---------
max_string_size   string      EXTENDED
```

### Troubleshooting
You will get this error when you try to connect before the database is created.

```
$ <copy>docker exec -it oracle-db sqlplus sys/Welcome1@localhost:1521/orclpdb1 as sysdba</copy>
...
ORA-12514: TNS:listener does not currently know of service requested in connect
```

### Starting, stopping, restarting, or removing the conatiners once built.

Start, stop, or restart the containers.

```
$ cd oracle-pg/docker/
$ docker-compose -f docker-compose-rdbms.yml start|stop|restart
```

Stop the containers and remove them.

```
$ cd oracle-pg/docker/
$ <copy>docker-compose -f docker-compose-rdbms.yml down</copy>
```


## Acknowledgements ##

- **Author** - Jayant Sharma - Product Manager 
- **Contributors** - Ryota Yamanaka.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.



