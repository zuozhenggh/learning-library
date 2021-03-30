# Initialize Environment

## Introduction

This lab provides detailed instructions for deploying Essbase on OCI Compute. The image comes with Essbase installed and configured with RCU schema configuration using local database. Once the deployment is complete, you should be able to access Essbase on the Web UI on your machine.

*Estimated Lab Time:* 15 Minutes.

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

## **STEP 1**: Login To Oracle Essbase 21c
This lab has been designed to be executed end-to-end with any modern browser on your laptop or workstation. Proceed as detailed below to login.
### UI Access
1. Launch your browser to the following URL to access Oracle Essbase 21c UI
    ```
    <copy>
    http://[Instance-public-ip]:9000/essbase/jet
    </copy>
    ```
    ![](./images/ess-environment1.png " ")
***Note:*** While application processes are automatically started upon instance boot up, it takes approximately 15 minutes for this URL to become active after all processes have fully started. Should this URL remain inactive after 15 minutes, refer to **Step 2** below for manual start.
2. Login with the below credentials
    ```
    Username	: <copy>Weblogic</copy>
    ```

    ```
    Password	: <copy>EssbaseTechBang123</copy>
    ````

## **STEP 2**: Login to Host for manual startup (Optional)
While you will only need the browser to perform all tasks included in this workshop, you can optionally use your preferred SSH client to connect to the instance should you need to perform any troubleshooting task such as restarting processes, rebooting the instance, or just look around.

### Start Script
Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
 - Authentication OS User - “*opc*”
 - Authentication method - *SSH RSA Key*
 - OS User – “*oracle*”.

​Your workshop instance is configured to automatically start all processes needed for the labs. Should you need to start these processes, proceed as shown below as user oracle

1. First login as “*opc*” using your SSH Private Key
​
2. Then login to *oracle*. E.g.
    ```
    <copy>sudo su - oracle</copy>
    ```
3.  Go to this folder /u01/scripts for a manual start
    ```
    <copy>cd /u01/scripts/</copy>
    ```
4.  Start the env_startup_script to start all the services of Database and Essbase.
    ```
    <copy>./env_start_script.sh</copy>
    ```
Your script should be started and wait for the confirmation on start of servers.
You may now *proceed to the next lab*.

## Acknowledgements

- **Authors** - Sudip Bandyopadhyay, Manager, Analytics Platform Specialist Team, NA Technology
- **Contributors** - Eshna Sachar, Jyotsana Rawat, Kowshik Nittala, Venkata Anumayam
- **Last Updated By/Date** - Jyotsana Rawat, Solution Engineer, Analytics, NA Technology, March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
