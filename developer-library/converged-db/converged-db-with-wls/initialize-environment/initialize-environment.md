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

## **STEP 1:** Start And Validate The Required Processes are Up and Running.
1. Now with access to your remote desktop session, proceed as indicated below to Start your environment using Environment script before you start executing the subsequent labs and validate the following Processes should be up and running:
    
    - Database Listeners
    - Database Server Instances
    - eShop Application (Java Application)

2. To launch *Firefox* browser or a *Terminal* client, click on respective icon on the remote desktop

    ![](./images/guacamole-landing.png " ")

## **STEP 1**: Starting Database and eShop Application
1. From any of the terminal session started above, proceed as shown below as “*oracle*” user

2. Go to folder /u01/script

    ```
    <copy>
    cd /u01/script
    </copy>
    ```
3. Run the script file to start the components.

    ```
    <copy>
    ./env_setup_db-workshop.sh
    </copy>
    ```

This will start the database, listener, oracle rest data service and our eShop application. This script could take 2-5 minutes to run

4. Review the output validate the URLs provided at the bottom

## **STEP 2**: Start the WebLogic service

1.	As an oracle user run the setWLS14Profile.sh script. This will setup the environment variables needed to start the WebLogic 14c Services.

    ````
    <copy>
    cd /u01/middleware_demo/scripts/
    . ./setWLS14Profile.sh
    cd $DOMAIN_HOME/bin
    </copy>
    ````

2.	As an oracle user run startWebLogic.sh script. This will start the WebLogic services.

    ````
    <copy>
    nohup ./startWebLogic.sh &
    </copy>
    ````

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala, Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020
