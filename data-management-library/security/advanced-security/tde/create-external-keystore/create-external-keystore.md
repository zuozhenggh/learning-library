   ![](../../images/banner_ASO.PNG)

## TDE - Create Software Keystore

The first thing you must do for Transparent Data Encryption is to create a software keystore.<br>
We often refer to this as an Oracle Wallet.

---

Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Software_Keystore</copy>
````

Run this script to create the directory on the operating system:

````
<copy>./01_create_os_directory.sh</copy>
````

   ![](../images/TDE_002.PNG)

Use the database parameters to manage TDE. This will require a database restart for one of the parameters to take effect.<br>

The script will perform the reboot for you. 

````
<copy>./02_set_tde_parameters.sh</copy>
````

   ![](../images/TDE_003.PNG)

Create the software keystore (Oracle Wallet) for the container database.<br>

You will see the status result goes from `NOT_AVAILABLE` to `OPEN_NO_MASTER_KEY`. 

````
<copy>./03_create_wallet.sh</copy>
````

   [](../images/TDE_004.PNG)
    
Now, your wallet has been created
