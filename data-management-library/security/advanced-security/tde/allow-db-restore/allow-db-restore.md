# TDE - Allow DB Restore

## Introduction

This lab will enable you to roll back the TDE configuration should you wish to repeat the workshop without having to re-provision the entire environment. To restore your database to a pre-TDE point in time, this lab will enable archive redo log mode and set a restore point. Since this database is not in Archive Log mode and doesn't have the Flash Recovery Area enabled, a "Cold Backup" of the database will be created.

Hence, this requires stopping the database, creating a tape archive file (tar) and restarting it.

Estimated Lab Time: 5 minutes

## Steps to complete this lab

Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Allow_DB_Restore</copy>
````
    
Run the backup command:

````
<copy>./01_backup_db.sh</copy>
````

   ![](./images/tde-001.png)

Once it has completed, it will automatically restart the container and pluggable databases

---
**Note:** If you have executed this script before and there is an existing backup file, the script will not complete. You must manually manage the existing backup (delete or move) before running this script again.

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
