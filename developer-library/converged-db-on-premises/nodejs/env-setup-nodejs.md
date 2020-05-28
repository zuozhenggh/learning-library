# Oracle Node.js 

## Before You Begin

This lab walks you through the steps to connect to an Oracle Database running in a Docker container on an Oracle Cloud Compute instance. You can connect the Oracle Database instance using any client you wish. In this lab, you'll connect using Oracle SQLDeveloper.

### Prerequisites
This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key

## Step 1: Start Docker and Run Node.js application

1. Start Docker by using below command 
   
    ````
    <copy>
    systemctl start docker
    systemctl status docker

    </copy>
    ````
    
2. Run Script to start the Node-js Application.     Check the directory Name Docker script 
        
    ````
    <copy>
	cd /docker
    </copy>
    ````

3. Check the script is available and run the script by using below command.
   
    ````
    <copy>
	./ApplicationScript.sh
    </copy>
    ````

## Step 2:  Verify Application 
1. Verify the Application in your browser.  Open up a web browser on your PC and visit this Application URL. *http://Public-IP:3000/*

2. Verify the Application API in your browser.  Open up a web browser on your PC and visit this Application URL. *http://Public-IP:3001/*

    ![](./images/env_setup_nodejs.PNG " ") 

## Acknowledgements
* **Author** - Gerald Venzl, Master Product Manager, Database Development
* **Adapted for Cloud by** -  Tom McGinn, Learning Architect, Database User Assistance
* **Last Updated By/Date** - Tom McGinn, March 2020

### Issues
See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 