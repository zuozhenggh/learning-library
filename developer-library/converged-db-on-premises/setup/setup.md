# Environment Setup 

## Introduction

This lab will show you that how to start database instance and listener from putty window,also this covers how to setup vncserver and sqldeveloper etc. 

Estimated time: 1 hour

### Objectives
- Start the Oracle Database and Listener

### Lab Prerequisites

- Lab 1: Login to Oracle Cloud
- Lab 2: Generate SSH Key
- Lab 3: Create Compute Instance


## Step 1: Start the Database

1. Click the Hamburger Menu in the top left corner. Then hover over Compute > Instances. Find the instance you created in the previous lab. 

   ![](./images/nav_compute_instance.png " ")

2. Click on your instance and copy your Public IP address to a notepad. 

   ![](./images/public_ip.png " ")


3. In Oracle CloudShell (*recommended*) or the terminal of your choice, login via ssh as the **opc** user.  
 
      ````
      ssh -i <<sshkeylocation>> opc@<<your address>>
      ````

      - sshkeylocation - Full path of your SSH key
      - your address - Your Public IP Address
  
4. Switch to the oracle user
      ````
      <copy>
      sudo su - oracle
      </copy>
      ````

   ![](./images/putty_snap4.png " ")

5.  Check for the oratab file and get the SID  and the oracle home details for the DB to start.

      ````
      <copy>
      cat /etc/oratab 
      </copy>
      ````

   ![](./images/putty_snap5.png " ")


7. Start the database by first sourcing the environment.
 
       ````
      <copy>
      . oraenv
      ConvergedCDB
      </copy>
      ````

8. Use sqlplus to startup the database
 
      ````
      <copy>
      sqlplus / as sysdba
      startup 
      </copy>
      ````

      ![](./images/putty_snap6.png " ")

9. Start up all the pluggable databases (pdbs) and open them up for access
  
      ````
      <copy>
      show pdbs
      alter pluggable database all open;
      show pdbs 
      </copy>
      ````

      ![](./images/putty_snap7.png " ")

9.	Exit out of sqlplus
 
      ````
      <copy>
      exit
      </copy>
      ````

## Step 2: Start the Listener

1. Get the complete hostname of the server.

      ````
      <copy>
      cat /etc/hosts
      </copy>
      ````
      ![](./images/putty_snap8.png " ")

  **Note:**In above screenshot red highlighted one is the full qualified hostname. Gather similar details from your respective instance.

2.	Open tnsnames.ora in nano and replace the LISTENER_CONVERGEDCDB lab with the old hostname with the new hostname from Step 1.

      ````
      <copy>
      cd $ORACLE_HOME/network/admin
      nano tnsnames.ora
      </copy>
      ````

3. Replace the existing hostname with **your fully qualified hostname**

4.  Save the file using the command **^O** and **^X** to exit

5.	Repeat the same steps for listener.ora using nano

      ````
      <copy>
      nano listener.ora
      </copy>
      ````

1. Replace the fully qualified hostname and save the file

7.	Check for the listener name. 
      ````
      <copy>
      cat listener.ora
      </copy>
      ````

      ![](./images/putty_snap9.png " ")

8.	Start the listener
      ````
      <copy>
      lsnrctl start LISTENER_CONVERGEDDB
      </copy>
      ````
      ![](./images/putty_snap10.png " ")

15.	Check the listener status
      ````
      <copy>
      lsnrctl status LISTENER_CONVERGEDDB
      </copy>
      ````
      ![](./images/putty_snap11.png " ")

16.	Register the service into database. Login via sqlplus as sysdba. 
      ````
      <copy>
      sqlplus  / as sysdba
      </copy>
      ````

1.  Set the local listener by replacing the **hostname** with the hostname you identified in earlier.
      ````
      alter system set local_listener='(ADDRESS = (PROTOCOL=TCP)(HOST=hostname)(PORT=1521))';
      ````

2.   Register the listener and exit sqlplus.

      ````
      <copy>
      alter system register;
      exit
      </copy>
      ````
      ![](./images/putty_snap12.png " ")

17.	Check the listener status.
      ````
      <copy>
      lsnrctl status LISTENER_CONVERGEDDB
      </copy>
      ````
      ![](./images/putty_snap13.png " ")

18.	Ensure the database, **ConvergedCDB**, and the listener, **LISTENER_CONVERGEDDB** is up and running
      ````
      <copy>
      ps -ef|grep pmon
      ps -ef|grep tns

      </copy>
      ````
      ![](./images/putty_snap14.png " ")

## Step 3: Start VNC  

1. Run the below command and start vncserver as **oracle** user. 

````
    <copy>
   vncserver
   </copy>
   ````
![](./images/vnc1.png " ")

2. Check if the  vncserver process is running.
  ````
    <copy>
   ps -ef|grep vnc
   </copy>
   ````
![](./images/vnc2.png " ")

3. Lets do the tunnelling  for the  port mentioned in the vnc process

Go to putty settings -> SSH -> Tunnels and provide the source port and destination details.

![](./images/vnc3.png " ")

4.	Then click on Add, Once we click on add we can see an entry in the forwarded ports, then click on Apply.

![](./images/vnc4.png " ")

5.	Start the VNC viewer.Provide the VNC server details, click on connect and provide the password as “vncserver”.
![](./images/vnc5.png " ")

6.	Open a terminal in vnc and follow below steps to start the sqldeveloper.
````
    <copy>
   cd /u01/graph/jdk-11.0.5/
   export JAVA_HOME=/u01/graph/jdk-11.0.5/
   echo $JAVA_HOME
   sqldeveloper
   </copy>
   ````

You may proceed to the next lab.

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K., Robbie Ruppel
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
  


















