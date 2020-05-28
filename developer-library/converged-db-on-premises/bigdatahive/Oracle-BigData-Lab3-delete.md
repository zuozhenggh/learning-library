
# Oracle BigData-HIVE
<br>

**Customer who ordered some specific products**
##Steps

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

2. List customers who ordered **specific products** 
````
<copy>
select * from orders_ext_hive o INNER JOIN order_items_ext_hive oi on o.order_id=oi.order_id 
INNER JOIN customer_hive_ext c on c.customer_id=o.customer_id inner join 
products_ext_hive p on oi.product_id=p.product_id where p.product_id=19;

</copy>
````

![](./images/IMG6.PNG)