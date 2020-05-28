
# Oracle Graph 

<br>

**Property Graph Prerequisites**

The requirements for using the property graph features are the following.

•	The Oracle Graph Server and Graph Client must be installed.

•	max string size must be enabled.

•	AL16UTF16 (instead of UTF8) must be specified as the NLS NCHAR CHARACTERSET.

•	AL32UTF8 (UTF8) should be the default character set,  but  AL16UTF16 must be the NLS NCHAR CHARACTERSET.


**Oracle Graph Server and Client**

It is a software package for use with the Property Graph feature of Oracle Database. Oracle Graph Server and Client includes the high speed in-memory analytics server (PGX) and client libraries required for graph applications.

Oracle Graph Client: A zip file containing Oracle Graph Client.

Oracle Graph Server: An rpm file containing an easy to deploy Oracle Graph Server.

**Note:** Graph client and Sever installation is completed and the setup is ready for use.

**Interactive Graph Shell**

Both the Oracle Graph server and client packages contain an interactive command-line application for interacting with all the Java APIs of the product, locally or on remote computers.

This interactive graph shell dynamically interprets command-line inputs from the user, executes them by invoking the underlying functionality, and can print results or process them further.

This graph shell is implemented on top of the Java Shell tool (JShell).

The graph shell automatically connects to a PGX instance (either remote or embedded depending on the --base_url command-line option) and creates a PGX session.

**Connect to Graph Server**

For connecting to graph server, ssh to the instance and perform below steps as <graphuser>

**Steps:**

Step1
````
<copy>
cd /opt/oracle/graph/pgx/bin 
</copy>
````

Step2
````
<copy>
./start-server
</copy>
````

![](./images/g1.png) 

![](./images/g2.png) 

The PGX server is now ready to accept requests.
Now that the server is started, will keep this window open and will proceed to start the client now.



**Connect to Graph Client**

For connecting to graph client, ssh to the instance and perform below steps as <graphuser> . The Graph Shell uses JShell, which means the shell needs to run on Java 11 or later. In our case the installation is completed, the shell executables can be found in /opt/oracle/graph/bin after server installation or <INSTALL_DIR>/bin after client installation.


**Steps:**

Step1
````
<copy>
export JAVA_HOME=/u01/jdk-11.0.5/
</copy>
````
Step2
````
<copy>
echo $JAVA_HOME
</copy>
````
Step3
````
<copy>
cd /u01/graphclient/oracle-graph-client-20.1.0/bin
</copy>
````

The graph shell automatically connects to a PGX instance (either remote or embedded depending on the --base_url command-line option) and creates a PGX session.

To launch the shell in remote mode, specify the base URL of the server with the --base_url option. For example:


Step4
````
<copy>
./opg-rdbms-jshell --base_url https://myserver.com:7007
</copy>
````

Below screenshot is an example how Connection to a PGX server using Jshell looks like-


![](./images/IMGG4.PNG) 
