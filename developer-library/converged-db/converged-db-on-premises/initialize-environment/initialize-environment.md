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
    - Nodejs eShop Application on docker container
    - Oracle Rest Data Service 
    ![](./images/convg-landing.png " ")
    
2. On the *terminal* window on the right preloaded with *oracle* user, Execute the below script to start to  database, listener, oracle rest data service and eShop application.

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

You may now [proceed to the next lab](#next).


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala, Rene Fontcha
- **Last Updated By/Date** - Ashish Kumar, LiveLabs Platform , NA Technology, July 2021
