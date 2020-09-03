# Trusted Application Path

## Introduction
Also called Multi Factor Authorization, in this lab you will create a trusted application path, allowing the application to connect to the database using the application credentials, but preventing misuse or abuse of those application credentials by everything else.

Estimated Lab Time: 20 minutes

### Objectives
-   Protect application/service credentials and prevent them from being used outside of the application tier

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account (Always Free is not supported)
- SSH Keys
- Have successfully connected to the workshop machine
- Have enabled Database Vault
- Have started the Empployeesearch application

## Steps to complete this lab

1. You will use the Glassfish application to view the `EMPLOYEESEARCH_PROD` data. Open a web browser and navigate to `http://PUBLIC_IP:8080/hr_prod_pdb1`.

  Login as **hradmin** / **Oracle123** and search the employee data.

2. Next, run this query to view the session information associated with the Glassfish application.

````
<copy>./01_query_employeesearch_usage.sh</copy>
````

3. Now, query the `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES` table as `SYS` to demonstrate it is accessible. 

````
<copy>./02_query_employeesearch.sh</copy>
````

4. Begin protecting the application credentials by creating a Database Vault Rule

````
<copy>./03_create_rule.sh</copy>
````

5. We use the Database Vault Rule by adding it to a DV Rule Set. You can have one or more rules in the rule set. If you have more than one, you can choose between the rule set evaluating all rules must be true or *any* rule must be true.  Think of it like the difference between `IN` and `EXISTS` - `IN` includes all while `EXISTS` stops once it identifies one result matches. 

````
<copy>./04_create_rule_set.sh</copy>
````

6. Create a Command Rule on Connect to protect the `EMPLOYEESEARCH_PROD` user. You can only `CONNECT` AS `EMPLOYEESEARCH_PROD` if you match the Rule Set we created.

````
<copy>./05_create_command_rule.sh</copy>
````

7. Re-run our query of the application usage to verify that it still works. You might have to refresh the browser a few times and run some queries. 

````
<copy>./06_query_employeesearch_usage.sh</copy>
````
    
8. Now try to query the `DEMO_HR_EMPLOYEES` table as `SYS`. You should be blocked.

````
<copy>./07_query_employeesearch.sh</copy>
````      
    
9. Once you have successfully completed the lab, you can delete the Command Rule, Rule Set, and Rule from Database Vault. 

````
<copy>./08_delete_trusted_path.sh</copy>
````

You have completed the Database Vault lab on Trusted Application Path. 

## Acknowledgements
- **Author** - Gian Sartor, Principal Solution Engineer, Database Security
- **Contributors** - Hakim Loumi, Database Security PM
- **Last Updated By/Date** - Gian Sartor, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
