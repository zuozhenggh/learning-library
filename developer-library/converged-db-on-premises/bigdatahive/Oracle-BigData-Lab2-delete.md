
# Oracle BigData-HIVE


**Customers windows shopping  history ( through Online)**

## Steps


1. Connect to **Database**
    ````
    <copy>
    .oraenv
    </copy>
    ````
    ````
    <copy>
    sqlplus apphdfs/apphdfs@orclpdb
    </copy>
    ````
2. List customers with **window shopping** history
    ````
    <copy>
    select * from orders_ext_hive o INNER JOIN customer_hive_ext c on o.customer_id=c.customer_id inner join stores_ext_hive s on s.store_id=o.store_id;
    </copy>
    ````
    ![](./images/IMG5.PNG)

 



