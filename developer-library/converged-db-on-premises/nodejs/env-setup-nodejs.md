
# Oracle Node.js 



## Steps:#


 **Node-js Application Environment setup**

 **Before You Begin**

This lab walks you through the steps to build an application Node-js with Docker image on an Oracle Cloud Compute instance.

**Background**

A Docker image contains all of the necessary code to execute an application for a host kernel. In this lab, you will pull the Docker image from OCI registry for Application.

**What Do You Need?**

-	An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click here.
-	SSH keys
-	OCI image and Docker will be the pre-installed with image.


1. Start Docker by using below command 
   
    ````
    <copy>
    systemctl start docker
    systemctl status docker

    </copy>
    ````
    
2. Run Script to start the Node-js Application
    
         
    ````
    <copy>
    Check the directory Name Docker script 

	cd /docker

	Check the script is available and run the script by using below command.

	./ApplicationScript.sh

             </copy>
    ````
   
3. Verify Application on browser 
   
   
    ````
    <copy>
   Application URL: - http://<Public-IP>:3000/
   Application API URL: - http://<Public-IP>:3001/products
   </copy>
    ````
 
  
    ![](./images/env_setup_nodejs.PNG " ") 


See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).