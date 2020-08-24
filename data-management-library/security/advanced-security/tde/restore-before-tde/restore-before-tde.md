![](../../../../images/banner_ASO.PNG)

## TDE - Restore Before TDE

Only if you have followed the steps in [Allow_DB_Restore](../Allow_DB_Restore/README.md) you can run the following steps to restore this DB to it's state before implementing TDE.


Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Restore_Before_TDE</copy>
````

First, execute this script to restore the pfile

````
<copy>./01_restore_init_parameters.sh</copy>
````

Second, restore the database (this may take some time)

````
<copy>./02_restore_db.sh</copy>
````

Third, delete the associated wallet files

````
<copy>./03_delete_wallet_files.sh</copy>
````

Finally, start the container and pluggable databases

````
<copy>./04_start_db.sh</copy>
````

This should have restored your database to it's pre-TDE state

Verify the initialization parameters don't say anything about TDE

````
<copy>./05_check_init_params.sh</copy>
````
