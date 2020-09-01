# TDE - Restore Before TDE

## Introduction

Only if you have followed the steps in [Allow_DB_Restore](../Allow_DB_Restore/README.md) you can run the following steps to restore this DB to it's state before implementing TDE.

Estimated Lab Time: 10 minutes

### Objectives
Optional
- Restore the database to it's pre-TDE state in order to repeat the labs 

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account (Always Free is not supported)
- SSH Keys
- Have successfully connected to the workshop machine

## Steps to complete this lab

1. Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

2. Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Restore_Before_TDE</copy>
````

3. First, execute this script to restore the pfile

````
<copy>./01_restore_init_parameters.sh</copy>
````

4. Second, restore the database (this may take some time)

````
<copy>./02_restore_db.sh</copy>
````

5. Third, delete the associated wallet files

````
<copy>./03_delete_wallet_files.sh</copy>
````

6. Finally, start the container and pluggable databases

````
<copy>./04_start_db.sh</copy>
````

  This should have restored your database to it's pre-TDE state

7. Verify the initialization parameters don't say anything about TDE

````
<copy>./05_check_init_params.sh</copy>
````

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
