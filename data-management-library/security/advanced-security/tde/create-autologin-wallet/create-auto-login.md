![](../../../../images/banner_ASO.PNG)

## Create Autologin Wallet

---

This step is recommended so the DBAs do not have to manually open the wallet each time the database is restarted. This is very helpful in RAC, Data Guard, or Golden Gate environments.


Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Autologin_Wallet</copy>
````
	
Then run the script to view the wallet on the operating system.<br>

Notice there is no `cwallet.sso`, there will be when we create the auto login wallet.

````        
<copy>./01_view_wallet_on_os.sh</copy>
````
    
   ![](../images/TDE_010.PNG)

You can view what the wallet looks like in the database

````
<copy>./02_view_wallet_in_db.sh</copy>
````    
    
   ![](../images/TDE_011.PNG)

Now, create the autologin wallet

````
<copy>./03_create_autologin_wallet.sh</copy>
````

    ![](../images/TDE_012.PNG)

Run the same queries... You should now see the `cwallet.sso` file:

````
<copy>./04_view_wallet_on_os.sh</copy>
````    
 
   ![](../images/TDE_013.PNG)


**Note:** Now you should see the *.sso file

And no changes to the wallet in the database

````
<copy>./05_view_wallet_in_db.sh</copy>
````

   ![](../images/TDE_014.PNG)

Now your Autologin is created!
