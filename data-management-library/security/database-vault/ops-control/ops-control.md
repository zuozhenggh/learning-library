![](../../../images/banner_DV.PNG)

## Operations Control

Oracle Database Vault Operations Control was first released with Oracle Database Vault 19c. In a multitenant database, Ops Control prevents common users (container DBAs, for example) from accessing local data that resides on a PDB.<br>
It enables you to store sensitive data for your business applications and allow operations to manage the database infrastructure without having to access sensitive customer data.

In this lab, SAL is a container admin, DBA_DEBRA is a Pluggable Database admin, and they will have different privileges after we enable Operations Control.

Open a SSH session on your DBSec-Lab VM as Oracle User

````
<copy>sudo su - oracle</copy>
````

Go to the scripts directory

````
<copy>cd $DBSEC_HOME/workshops/Database_Security_Labs/Database_Vault/Ops_Control</copy>
````

Check the status of Database Vault and Operations Control.<br>
Note that it is not yet configured. 

````
<copy>./01_query_dv_status.sh</copy>
````

   ![](../images/DV_013.PNG)

Next, we will run the same queries as both container admin, SAL as well as DBA_DEBRA. Note that the query results are the same. The common user SAL has access to data in the PDB, just as the pdb admin has.

````
<copy>./02_query_w_pdb_debra.sh</copy>
````

   ![](../images/DV_014.PNG)

````
<copy>./03_query_with_sal.sh</copy>
````

   ![](../images/DV_015.PNG)

Enable Database Vault 19c Operations Control and run the queries again.<br>

Notice who can and who cannot query the `EMPLOYEESEARCH_PROD` schema data now.<br>
SAL should no longer be able to access data.

````
<copy>./04_enable_ops_control.sh</copy>
````

   ![](../images/DV_009.PNG)

````
<copy>./05_query_dv_status.sh</copy>
````
    
   ![](../images/DV_016.PNG)

````
<copy>./06_query_w_pdb_debra.sh</copy>
````

   ![](../images/DV_017.PNG)

````
<copy>./07_query_with_sal.sh</copy>
````

   ![](../images/DV_018.PNG)

When you are have completed this lab, disable Ops Control

````
<copy>./08_disable_ops_control.sh</copy>
````
        
   ![](../images/DV_009.PNG)

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
