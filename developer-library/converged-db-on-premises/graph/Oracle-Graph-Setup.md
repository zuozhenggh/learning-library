
# Oracle Graph 

## Introduction

This lab walks you through the steps of setting up the environment for property graph. Below are the prerequisites:

-	The Oracle Graph Server and Graph Client must be installed.
-	max\_string\_size must be enabled.
-	AL16UTF16 (instead of UTF8) must be specified as the NLS\_NCHAR\_CHARACTERSET.
-	AL32UTF8 (UTF8) should be the default character set,  but  AL16UTF16 must be the NLS\_NCHAR\_CHARACTERSET.


**Oracle Graph Server and Client**

It is a software package for use with the Property Graph feature of Oracle Database. Oracle Graph Server and Client includes the high speed in-memory analytics server (PGX) and client libraries required for graph applications.

Oracle Graph Client: A zip file containing Oracle Graph Client.

Oracle Graph Server: An rpm file containing an easy to deploy Oracle Graph Server.

**For installing the Graph server, the prerequisites are:**
-	Oracle Linux 6 or 7 x64 or a similar Linux distribution such as RedHat
-	Oracle JDK 8
  
**For installing the Graph client, the prerequisites are:**
-	A Unix-based operation system (such as Linux) or macOS or Microsoft Windows
-	Oracle JDK 11


**Note:** Graph client and Sever installation is completed and the setup is ready for use.

**Interactive Graph Shell**

Both the Oracle Graph server and client packages contain an interactive command-line application for interacting with all the Java APIs of the product, locally or on remote computers.

This interactive graph shell dynamically interprets command-line inputs from the user, executes them by invoking the underlying functionality, and can print results or process them further.

This graph shell is implemented on top of the Java Shell tool (JShell).

The graph shell automatically connects to a PGX instance (either remote or embedded depending on the --base_url command-line option) and creates a PGX session.

## Before You Begin

**What Do You Need?**

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup

## Step 1:Connect to Graph Server 

For connecting to graph server, open a terminal in VNC and execute below steps as oracle user.

 ````
<copy>
   cd /opt/oracle/graph/pgx/bin 
</copy>
````

## Step 2: Start Graph server
````
<copy>
./start-server
</copy>
````
![](./images/g1.png) 

![](./images/g2.png) 

The PGX server is now ready to accept requests.
Now that the server is started, will keep this window open and will proceed to start the client now.

## Step 3:Connect to Graph Client

The Graph Shell uses JShell, which means the shell needs to run on Java 11 or later. In our case the installation is completed, the shell executables can be found in /u01/graph/oracle-graph-client-20.1.0/bin after server installation or <\INSTALL\_DIR>/bin after client installation.

For connecting to graph client, open a putty session and execute below commands as oracle user.

````
<copy>
export JAVA_HOME=/u01/graph/jdk-11.0.5/
cd /u01/graph/oracle-graph-client-20.1.0/bin
</copy>
````

The graph shell automatically connects to a PGX instance (either remote or embedded depending on the --base_url command-line option) and creates a PGX session.

To launch the shell in remote mode, specify the base URL of the server with the --base_url option. For example:

````
<copy>
[oracle@bigdata bin]$ ./opg-rdbms-jshell --base_url http://machine-IP-address:7007
</copy>
````
Below screenshot is an example how Connection to a PGX server using Jshell looks like

![](./images/IMGG4.PNG) 


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
  