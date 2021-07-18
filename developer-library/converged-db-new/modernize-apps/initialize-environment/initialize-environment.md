# Initialize Environment

## Introduction

In this lab we will review and startup all components required to successfully run this workshop.

*Estimated Lab Time:* 10 Minutes.

### Objectives
- Initialize the workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## **STEP 1:** Start And Validate The Required Processes For The Subsequent Labs.
1. Now with access to your remote desktop session, proceed as indicated below to Start your environment using Environment script before you start executing the subsequent labs and validate the following Processes should be up and running.

    On the *terminal* window on the right preloaded with *oracle* user. Execute the STEP-2 scripts to start to required process for the lab.
    ![](./images/convg-landing.png " ")


## **STEP 2:** Setup and Initialize Environment
1.	From any of the terminal session, proceed as shown below.
2.	Source the setWLS14Profile.sh and setBankAppEnv.sh to set the environment variables required to start the weblogic 14c Admin server and run commands to build Helidon and Bank applications:

  	```
  	<copy>  cd /u01/middleware_demo/scripts/
  	. ./setWLS14Profile.sh
  	. ./setBankAppEnv.sh
    </copy>
  	```

3.	Change the working directory to WebLogic 14c domain bin and start AdminServer in the wl_server domain:

    ```
    <copy>
    cd $DOMAIN_HOME/bin
    nohup sh startWeblogic.sh &
    tail -f nohup.out
    </copy>
  	```

Press `CTRL + C` to end the tail command

4.	The terminal shows stdout logs for starting the AdminServer.
3.	Open the Weblogic Admin Console and login with credentials provided below:

    ![](./images/adminconsole.png " ")  

    ```
    Console URL: <copy>http://<Your instance public IP address>:7101/console</copy>
    ```
    ```
    username: <copy>weblogic</copy>
    ```
    ```
    password: <copy>Oracle123!</copy>
    ```

4.	On the left hand side Menu under “Domain Structure” click on “Deployments”. Observe that the bestbank2020 application has been already deployed and available to access.

	![](./images/deployments.png " ")  

5.	Open a new browser tab or session and access the bank application UI with URL `http://<Your instance public IP address>:7101/bestbank2020`
6.	The existence of base version of the sample bestbank application is confirmed.
7.	Change directory to `/u01/middleware_demo/wls-helidon`

  	```
  	<copy>cd /u01/middleware_demo/wls-helidon/</copy>
  	```

8.	Verify if pom.xml and `src/` folder is available under `/u01/middleware_demo/wls-helidon`

  	```
  	<copy>ls -alrt</copy>
  	```

You may now *proceed to the next lab*.

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020
