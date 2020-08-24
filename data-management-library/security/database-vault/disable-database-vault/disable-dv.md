![](../../../images/banner_DV.PNG)

## Disabling DB Vault

Disable Database Vault in the container and pdb1 pluggable database.

Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd $DBSEC_HOME/workshops/Database_Security_Labs/Database_Vault/Disable_Database_Vault</copy>
````

Disable the pluggable database pdb1

````
<copy>./01_config_disable_dv_on_pdb.sh pdb1</copy>
````
    
You should see a status like this:

  ![](../images/DV_027.PNG)

- Now, Disable Database Vault in the container database

````
<copy></copy>
````
        ./02_config_disable_dv_on_cdb.sh

   ![](../images/DV_028.PNG)

---
**Note**: To disable DB Vault, database will be rebooted!
---
    
Now, Database Vault is disabled in the container database as well as `PDB1`!
<br>&nbsp;
