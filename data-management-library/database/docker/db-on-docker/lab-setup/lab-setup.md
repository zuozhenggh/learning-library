# Lab Setup
## Before You Begin

This lab walks you through the steps to install Docker engine and start working on it.

### Background



### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys
* YUM

## **STEP 1**: Login to the SSH Terminal

1.  Open a terminal window and connect using the public IP address

    ````
    ssh -i optionskey opc@<your ip address>
    ````

## **STEP 2**: Shut Down Listener

OPTIONAL: If you are running this on a compute instance that has Oracle already installed, you may need to check the status and shut down the listener as oracle user. If you do not have a listener running, proceed to the step 3.

1.  Switch to oracle user:

    ````
    <copy>sudo su - oracle</copy>
    ````

2.  Now let's check the listener status. If the listener is not running proceed to step 3.
   
    ````
    <copy>ps -ef | grep tns</copy>
    ````

    ````
    <copy>lsnrctl status LISTENER</copy>
    ````

3.  If the listener is running, stop the listener and exit.
   
    ````
    <copy>lsnrctl stop LISTENER</copy> 
    ````

    ````
    <copy>ps -ef | grep tns</copy> 
    ````

    ````
    <copy>exit</copy> 
    ````

## **STEP 3**: Install Docker Engine

You will use yum (a package management tool for Linux) to install the Docker engine, grant docker privledges to the opc user and enable it to start on re-boot. When prompted, press *Y* to download. All of these steps will be performed as the root user.

1.  Switch to root user:

    ````
    <copy>sudo -s</copy> 
    ````

2.  Install docker using yum: 
   
    ````
    <copy>yum install docker-engine</copy> 
    ````

    Docker is now installed!

## **STEP 4**: Grant Privileges and Start Docker

1.  Grant docker privilege to the opc user:
   
    ````
    <copy>usermod -aG docker opc</copy> 
    ````

2.  Enable the docker service:
   
    ````
    <copy>systemctl enable docker</copy> 
    ````

    ![](images/python1.png) 

    ![](images/python2.png)

3.  Start the docker on re-boot:

    ````
    <copy>systemctl start docker</copy> 
    ````

## **STEP 5**: Install GIT on Docker

Now, we are going to install git using yum as the root user.

1.  Verify you are root user: 

    ````
    <copy>whoami</copy>
    ````

    ![](images/installgit.png) 

2.  Install git using yum.

    ````
    <copy>yum install git</copy>
    ````

    Git is now installed!

## **STEP 6**: Verify Docker and GIT Version

Verify the version of docker and git by switching to the opc user.

1.  Switch to opc user:

    ````
    <copy>su - opc</copy>
    ````

2.  Check docker version:

    ````
    <copy>docker version</copy>
    ````

3.  Check docker image:

    ````
    <copy>docker images</copy>
    ````

4.  Check git version:
   
    ````
    <copy>git --version</copy> 
    ````

    ![](images/gitversion.png) 

## **STEP 7**: Update the Server Mode

1.  Exit from opc user:

    ````
    <copy>exit</copy> 
    ````

2.  Place your server in permissive mode.
   
    ````
    <copy>setenforce 0</copy> 
    ````

3.  Check Status:
   
    ````
    <copy>sestatus</copy> 
    ````

    ![](images/setenforce.png) 

4.  Switch back to the opc user:

    ````
    <copy>su - opc</copy> 
    ````

5.  Verify you are the `opc` user
   
    ````
    <copy>whoami</copy> 
    ````

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Adapted for Cloud by** -  
* **Last Updated By/Date** - Anoosha, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
