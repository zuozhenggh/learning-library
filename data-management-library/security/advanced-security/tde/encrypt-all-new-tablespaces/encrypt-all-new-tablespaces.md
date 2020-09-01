## TDE - Encrypt All New Tablespaces

## Introduction

In this lab we will ensure that any new tablespaces that you create in the container or pluggable will be encrypted by default.

Estimated Lab Time: 10 minutes

## Steps to complete this lab

1. Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

2. Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Encrypt_All_New_Tablespaces</copy>
````

3. First, check the existing initialization parameters

````
<copy>./01_Check_Init_Params.sh</copy>
````
        
   ![](./images/tde-018.png)

4. Next, change the init parameter `encrypt_new_tablespaces` to be `ALWAYS` so all new tablespaces are encrypted.

````
<copy>./02_Encrypt_All_New_Tablespaces.sh</copy>
````

   ![](./images/tde-019.png)

5. Finally, create a tablespace to test it.

  The tablespace `TEST` will be created without specifying the encryption parameters (the default encryption is AES128) and will be dropped after

````
<copy>./03_Create_New_Tablespace.sh</copy>
````

   ![](./images/tde-020.png)

Now, your new Tablespaces will be encrypted by default!

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
