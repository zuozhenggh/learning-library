# Lab 4 - Create and populate database tables

## Overview
In this lab you will create and populate database tables containing customer, account, purchase, and relationship data. You will then run some graph algorithms and queries and visualize the results in subsequent labs.

Estimated time: 2-3 minutes

## Step 1 - Load the data

Connect to the database as "sys" user, and create a user, "customer_360".

```
$ <copy> docker exec -it oracle-db sqlplus sys/Welcome1@localhost:1521/orclpdb1 as sysdba</copy>
```

At the SQL prompt enter:
```
<copy>
@/graphs/customer_360/create_user.sql
EXIT
</copy>
```

Connect to the database as the "customer_360" user, and create tables.

```
$ <copy>docker exec -it oracle-db sqlplus customer_360/Welcome1@localhost:1521/orclpdb1</copy>
```

At the SQL prompt enter:
```
<copy>
@/graphs/customer_360/create_tables.sql
EXIT
</copy>
```

Proceed to the next lab and create the graph. 

## Acknowledgements ##

- **Author** -  Jayant Sharma - Product Manager.
- **Contributors** - Ryota Yamanaka.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

