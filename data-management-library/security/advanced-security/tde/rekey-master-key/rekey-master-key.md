## TDE - Rekey the Master Key

## Introduction

You must create a master key for the container database before continuing. Each pluggable database must have their own master key as well (except for PDB$SEED). In this lab you will perform a rekey operation for the CDB and pluggable database, `PDB`.

Estimated Lab Time: 10 minutes

### Objectives
-  Generate a new master key to protect the encrypted data within the database

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account (Always Free is not supported)
- SSH Keys
- Have successfully connected to the workshop machine

## Steps to complete this lab

1. Start this lab here:

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Rekey_Master_Key</copy>
````

2. To_rekey the container database TDE master key, run the following command:

````
<copy>./01_rekey_cdb_mkey.sh</copy>
````

3. To rekey a master key for the pluggable database, PDB1, run the following command:

````
<copy>./02_rekey_pdb_mkey.sh pdb1</copy>
```` 

4. If you want, you can do the same for PDB2.  This is not a requirement though. It might be helpful to show some databases with TDE and some without.

````
<copy>./02_rekey_pdb_mkey.sh pdb2</copy>
````
    
  Now that you have a master key, you can begin encrypting tablespaces or column. 

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
