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
1. Now with access to your remote desktop session, proceed as indicated below to Start your environment before you start executing the subsequent labs. Validate the following Processes should be up and running:
    
    - Database Listeners
    - Database Server Instances

2. On the *terminal* window on the right preloaded with *oracle* user, Execute the below command to start the Environment for the subsequent labs.


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

3. The above command will start the database, listener, oracle rest data service and our eshop application. This script could take 2-5 minutes to run. Check for the "Finished starting servers" status before proceeding next.

    If successful, the page above is displayed and as a result your environment is now ready.

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements
* **Authors** - Balasubramanian Ramamoorthy, Amith Ghosh
* **Contributors** - Laxmi Amarappanavar, Ashish Kumar, Priya Dhuriya, Maniselvan K, Pragati Mourya.
* **Last Updated By/Date** - Ashish Kumar, LiveLabs Platform, NA Technology, April 2021
