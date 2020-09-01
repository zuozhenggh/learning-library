# TDE - View Software Keystore

## Introduction

To view the software keystore you first need to have a keystore.

Estimated Lab Time: 10 minutes

## Steps to complete this lab

1. Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

2. Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/View_Software_Keystore</copy>
````

3. Once you have a keystore, you can run either of these scripts.

  You will notice there are multiple copies of the `ewallet.p12` file.

  Every time you make a change, including create or rekey, the `ewallet.p12` file is backed up.

  You will also see the contents of the wallet file by using `orapki`

4. View the OS files related to the keystore

````
<copy>./01_view_wallet_on_os.sh</copy>
````            

   ![](./images/tde-008.png)

5. View the keystore data in the database

````
<copy>./02_view_wallet_in_db.sh</copy>
````

   ![](./images/tde-009.png)

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.