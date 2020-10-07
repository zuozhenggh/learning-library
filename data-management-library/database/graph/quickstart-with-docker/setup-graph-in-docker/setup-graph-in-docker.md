# Lab 1 - Setup a Graph analysis environment in Docker

## Introduction

In this lab you will build and start Oracle Linux Docker containers. You will deploy and configure the Property Graph server and clients component in these  containers. 

Estimated time: 10 minutes

### Prerequisites
Docker and GIT on your local machine (laptop or desktop).
Internet access to download the Graph Server and Client kit.

## **Step 1:** Get required components

### Clone this Repository
Clone the git repository which has the required Docker Compose files and other configuration files and scripts to your machine.

$ <copy>git clone https://github.com/jayant62/oracle-pg.git</copy>

Note the directory where you have cloned it. We will refer to it as `$REPO_HOME` here and in other labs in this workshop.

### Download and Extract the Graph and other Packages
Go to the following sites and download the packages.

- [Oracle Graph Server and Client 20.1](https://www.oracle.com/database/technologies/spatialandgraph/property-graph-features/graph-server-and-client/graph-server-and-client-downloads.html) Note: This version of the lab only works with the **20.1** Graph Server & Client kit. **It will not work later versions**.
- [Apache Groovy 2.4.18](https://dl.bintray.com/groovy/maven/apache-groovy-binary-2.4.18.zip)  
  The Graph Server and client kit requires Groovy.

Once you have downloaded the above do the following.
Put the following files into `$REPO_HOME/oracle-pg/docker/tmp/`

- oracle-graph-20.1.0.x86_64.rpm
- oracle-graph-zeppelin-interpreter-20.1.0.zip
- apache-groovy-binary-2.4.18.zip

Change directory to `$REPO_HOME` and run the following script to extract the packages:

```
$ <copy>cd oracle-pg/docker/tmp/</copy>
$ <copy>sh extract.sh</copy>
```

### Modify the PGX interpreter settings for Zeppelin

The extract script above copies the necessary jar files and a json configuration file into the `oracle-pg/docker/zeppelin/interpreter/pgx` directory. Open the file `interpreter-settings.json` in a text editor and change the default `PGX_BASE_URL` property in it. i.e. change the line (line 15)
` "defaultValue":"https://localhost:7007" `
to 
```
<copy>"defaultValue":"http://graph-server:7007"</copy>
```
## **Step 2:** Create and start the Containers
Build and pull images, create containers, and start them.

```
$ <copy>cd oracle-pg/docker/</copy>
$ <copy>docker-compose up -d</copy>
```

This takes some time. The next section shows some docker commands for viewing the log files to check the progress or state of the initialization.

### Viewing the log files

View the containers' log files to check the progress of creating and starting them.

```
$ <copy>cd oracle-pg/docker/ </copy>
$ <copy>docker-compose logs -f</copy>
```

`Ctl+C` to quit.

### Starting, stopping, restarting or removing containers once they're built.

o start, stop, or restart the containers.

```
$ <copy>cd oracle-pg/docker/ </copy>
$ <copy>docker-compose start|stop|restart</copy>
```

To remove the docker containers.

```
$ <copy>cd oracle-pg/docker/ </copy>
$ <copy>docker-compose down</copy>
```

You may now proceed to the next lab.

## Acknowledgements ##

- **Author** - Jayant Sharma - Product Manager.
- **Contributors** - Ryota Yamanaka.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
