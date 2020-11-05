# Load ADB Database

## Introduction
In this lab you will run a script to import data from Object Store into your Autonomous JSON Database (AJD) using Oracle Data Pump.  

*Estimated time:* 40 Minutes

### Objectives
- Connect to compute instance
  

### Prerequisites
- Lab: Generate SSH Keys
- Lab: Setup Compute and ADB

## **STEP 1:**  Load AJD Instance
1. mkdir wallet
2. cd wallet
3. unzip ../converged-wallet.zip .
4. vi sqlnet.ora  -> Replace sqlnet.ora with /home/<<<<>>>>/wallet
5. export TNS_ADMIN=/home/<<<<>>>>/wallet
6. sqlplus /nolog
7. conn admin/<<<<<admin pwd>>>>>@cvgadb02_high
8. If it connects then run the import script
9. Ignore the errors related to GRANT DBA, the DBA role is not available
10. grant dwrole to all users


## **STEP 2:**:  Connect Docker Instance to AJD


1.  Run the script env\_setup\_script.sh, this will start the database, listener, oracle rest data service and our eshop application. This script could take 2-5 minutes to run.

      ````
      <copy>cd /u01/script
      ./env_setup_script.sh</copy>
      ````
   ![](./images/setup-script.png " ")

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Kay Malcolm, Ashish Kumar
* **Contributors** - Ashish Kumar, Yaisah Granillo
* **Last Updated By/Date** - Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
