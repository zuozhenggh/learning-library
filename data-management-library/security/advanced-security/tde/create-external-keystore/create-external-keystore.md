# TDE - Create Software Keystore

## Introduction

The first thing you must do for Transparent Data Encryption is to create a software keystore. We often refer to this as an Oracle Wallet. This lab will walk you through the process of creating a software keystore.

Estimated Lab Time: 10 minutes

## Steps to complete this lab

1. Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

2. Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Software_Keystore</copy>
````

3. Run this script to create the directory on the operating system:

````
<copy>./01_create_os_directory.sh</copy>
````

   ![](./images/tde-002.png)

4. Use the database parameters to manage TDE. This will require a database restart for one of the parameters to take effect.

  The script will perform the reboot for you. 

````
<copy>./02_set_tde_parameters.sh</copy>
````

   ![](./images/tde-003.png)

5. Create the software keystore (Oracle Wallet) for the container database.

  You will see the status result goes from `NOT_AVAILABLE` to `OPEN_NO_MASTER_KEY`. 

````
<copy>./03_create_wallet.sh</copy>
````

   [](./images/tde-004.png)
    
  Now, your wallet has been created

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
