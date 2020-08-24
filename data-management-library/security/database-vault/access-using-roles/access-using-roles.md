## Trusted Application Path

A method to allow the application to connect, using the application credentials, but prevent misuse or abuse of those application credentials by everything else.

The first step is to [Enable_Database_Vault](../enable-database-vault/enable-dv.md). If you have not done so please do it before continuing. 

You will use the Glassfish application to view the `EMPLOYEESEARCH_PROD` data. Open a web browser and navigate to `http://PUBLIC_IP:8080/hr_prod_pdb1`.

Login as **hradmin** / **Oracle123** and search the employee data.

Next, run this query to view the session information associated with the Glassfish application.

````
<copy>./01_query_employeesearch_usage.sh</copy>
````

Now, query the `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES` table as `SYS` to demonstrate it is accessible. 

````
<copy>./02_query_employeesearch.sh</copy>
````

Begin protecting the application credentials by creating a Database Vault Rule

````
<copy>./03_create_rule.sh</copy>
````

We use the Database Vault Rule by adding it to a DV Rule Set. You can have one or more rules in the rule set. If you have more than one, you can choose between the rule set evaluating all rules must be true or *any* rule must be true.  Think of it like the difference between `IN` and `EXISTS` - `IN` includes all while `EXISTS` stops once it identifies one result matches. 

````
<copy>./04_create_rule_set.sh</copy>
````

Create a Command Rule on Connect to protect the `EMPLOYEESEARCH_PROD` user. You can only `CONNECT` AS `EMPLOYEESEARCH_PROD` if you match the Rule Set we created.

````
<copy>./05_create_command_rule.sh</copy>
````

Re-run our query of the application usage to verify that it still works. You might have to refresh the browser a few times and run some queries. 

````
<copy>./06_query_employeesearch_usage.sh</copy>
````
    
Now try to query the `DEMO_HR_EMPLOYEES` table as `SYS`. You should be blocked.

````
<copy>./07_query_employeesearch.sh</copy>
````      
    
Once you have successfully completed the lab, you can delete the Command Rule, Rule Set, and Rule from Database Vault. 

````
<copy>./08_delete_trusted_path.sh</copy>
````

You have completed the Database Vault lab on Trusted Application Path. 
