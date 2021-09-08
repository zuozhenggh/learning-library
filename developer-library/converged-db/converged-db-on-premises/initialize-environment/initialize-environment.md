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

## Task 1: Start And Validate The Required Processes are Up and Running.
1. Now with access to your remote desktop session, proceed as indicated below to Start your environment using Environment script before you start executing the subsequent labs and validate the following Processes should be up and running:
    
    - Database Listeners
    - Database Server Instances
    - Nodejs eShop Application on docker container
    - Oracle Rest Data Service 
        ![](./images/convg-novnc-guide.png " ")

2. Open the *Workshop Guides* folder from the *Firefox* toolbar area above and select the correct guide for your workshop.
    - On the *SQL-Developer* window on the right preloaded with saved credential
    ![](./images/convg-novnc-landing.png " ")

3. Click on *Terminal* icon on the desktop to start a terminal and execute the below command.
    
    - Go to folder /u01/script

        ```
        <copy>
        cd /u01/script
        </copy>
        ```
    - Run the script file to start the components.

        ```
        <copy>
        ./env_setup_db-workshop.sh
        </copy>
        ```
        ![](./images/convg-terminal.png " ")
        ![](./images/convg-application.png " ")
4. The above command will start the database, listener, oracle rest data service and our eshop application. This script could take 2-5 minutes to run. Check for the "Finished starting servers" status before proceeding next.
    
    ![](./images/convg-final.png " ")
    If successful, the page above is displayed and as a result your environment is now ready.  

You may now [proceed to the next lab](#next).

## Appendix 1: External Terminal Access (using SSH Key Based Authentication)

While you will only need the browser to perform all tasks included in this workshop, you can optionally use your preferred SSH client to connect to the instance should you prefer to run SSH Terminal tasks from a local client (e.g. Putty, MobaXterm, MacOS Terminal, etc.) or need to perform any troubleshooting task such as restarting processes, rebooting the instance, or just look around.

1. Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):

    - From the web session where you completed your provisioning request, do:
        - For **Reserve Workshop on LiveLabs** - Navigate to "*My Reservations* >> *Launch Workshop* >> *Workshop Instructions* >> *Lab: Environment Setup*"
        - For **Launch Free Trial Workshop** and **Run on Your Tenancy** - Click on the corresponding provisioning option and open *Lab: Environment Setup*
    - Authentication OS User - “*opc*”
    - Authentication method - *SSH RSA Key*
    - OS User – “*oracle*”.

2. First login as “*opc*” using your SSH Private Key

3. Then sudo to “*oracle*”. E.g.

    ```
    <copy>sudo su - oracle</copy>
    ```

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala, Rene Fontcha
- **Last Updated By/Date** - Ashish Kumar, LiveLabs Platform , NA Technology, July 2021
