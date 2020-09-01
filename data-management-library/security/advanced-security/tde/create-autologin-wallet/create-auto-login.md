# Introduction

We will now create an auto-login wallet. This step is recommended so the DBAs do not have to manually open the wallet each time the database is restarted. This is very helpful in RAC, Data Guard, or Golden Gate environments.

Estimated Lab Time: 10 minutes

## TDE - Create Autologin Wallet

Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Autologin_Wallet</copy>
````
	
Then run the script to view the wallet on the operating system.

Notice there is no `cwallet.sso`, there will be when we create the auto login wallet.

````        
<copy>./01_view_wallet_on_os.sh</copy>
````
    
   ![](./images/tde-010.png)

You can view what the wallet looks like in the database

````
<copy>./02_view_wallet_in_db.sh</copy>
````    
    
   ![](./images/tde-011.png)

Now, create the autologin wallet

````
<copy>./03_create_autologin_wallet.sh</copy>
````

    ![](./images/tde-012.png)

Run the same queries... You should now see the `cwallet.sso` file:

````
<copy>./04_view_wallet_on_os.sh</copy>
````    
 
   ![](./images/tde-013.png)


**Note:** Now you should see the *.sso file

And no changes to the wallet in the database

````
<copy>./05_view_wallet_in_db.sh</copy>
````

   ![](./images/tde-014.png)

Now your Autologin is created!

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
