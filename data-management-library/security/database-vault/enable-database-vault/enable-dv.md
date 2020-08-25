
# Enabling DB Vault

Enable Database Vault in the container and `PDB1` pluggable database.

Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd $DBSEC_HOME/workshops/Database_Security_Labs/Database_Vault/Enable_Database_Vault</copy>
````

Start by enabling Database Vault in the container database.

````
<copy>./01_config_enable_dv_on_cdb.sh</copy>
````

   ![](../images/DV_001.PNG)

---
**Note**: To enable DB Vault, database will be rebooted!
---
    
Next, enable it on the pluggable database. For now, just enable it on pdb1.

````
<copy>./02_config_enable_dv_on_pdb.sh pdb1</copy>
````

Now you will see a status like this:

   ![](../images/DV_002.PNG)
    
Now, Database Vault is enabled in the container database as well as `PDB1`!<br>
<br>&nbsp;
