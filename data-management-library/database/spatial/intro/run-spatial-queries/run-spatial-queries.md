# Spatial Queries

## Introduction

This lab walks you through basic spatial queries in Oracle Database.  

Estimated Lab Time: n minutes

### About Product/Technology
Enter background information here..

### Objectives

In this lab, you will:
* 

### Prerequisites


* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

<!--  *This is the "fold" - below items are collapsed by default*  -->


## Spatial Queries 

explanation...

**Identify 5 closest branches to the the Dallas Warehouse:**
```
<copy> 
select branch_name, branch_type
from branches b, warehouses w
where w.warehouse_name = 'Dallas Warehouse'
and sdo_nn(b.geometry, w.geometry, 'sdo_num_res=5') = 'TRUE';
</copy>
```

Notes:
    
* The ```SDO_NN``` operator returns the 'n nearest' branches to the Dallas Warehouse, where 'n' is the value specificed for ```SDO_NUM_RES```. The first argument to ```SDO_NN``` (b.geometry in the example above) is the column to search. The second argument (w.geometry in the example above) is the location you want to find the neighbors nearest to. No assumptions should be made about the order of the returned results. For example, the first row returned is not guaranteed to be the closest. If two or more branches are an equal distance from the warehouse, then either may be returned on subsequent calls to ```SDO_NN```.
* When using the ```SDO_NUM_RES``` parameter, no other criteria are used in the WHERE clause. ```SDO_NUM_RES``` takes only proximity into account. For example, if you added a criterion to the WHERE clause because you wanted the five closest branches having a specific zipcode, and four of the five closest branches have a different zipcode, the query above would return one row. This behavior is specific to the ```SDO_NUM_RES``` parameter. In example 3 below you will use an alternative parameter for the scenario of additional query criteria. 


**Identify 5 closest branches to the the Dallas Warehouse with distance:**
```
<copy>
select branch_name, branch_type, round(sdo_nn_distance(1),2) distance_km
from branches b, warehouses w
where w.warehouse_name = 'Dallas Warehouse'
and sdo_nn(b.geometry, w.geometry, 'sdo_num_res=5 unit=km', 1) = 'TRUE'
order by distance_km;
</copy>
```

Notes:

* The ```SDO_NN_DISTANCE``` operator is an ancillary operator to the ```SDO_NN``` operator; it can only be used within the ```SDO_NN``` operator. The argument for this operator is a number that matches the number specified as the last argument of SDO_NN; in this example it is 1. There is no hidden meaning to this argument, it is simply a tag. If ```SDO_NN_DISTANCE()``` is specified, you can order the results by distance and guarantee that the first row returned is the closest. If the data you are querying is stored as longitude and latitude, the default unit for ```SDO_NN_DISTANCE``` is meters.
* The ```SDO_NN``` operator also has a UNIT parameter that determines the unit of measure returned by ```SDO_NN_DISTANCE```.
* The ORDER BY DISTANCE clause ensures that the distances are returned in order, with the shortest distance first.


**Identify 5 closest wholesale branches to the the Dallas Warehouse with distance:**
```
<copy>
select branch_name, branch_type, round(sdo_nn_distance(1),2) distance_km
from branches b, warehouses w
where w.warehouse_name = 'Dallas Warehouse'
and b.branch_type='WHOLESALE'
and sdo_nn(b.geometry, w.geometry, 'sdo_batch_size=5 unit=km', 1) = 'TRUE'
and rownum <= 5
order by distance_km;
</copy>
```

Notes:
* ```SDO_BATCH_SIZE``` is a tunable parameter that may affect your query's performance. ```SDO_NN``` internally calculates that number of distances at a time. The initial batch of rows returned may not satisfy the constraints in the WHERE clause, so the number of rows specified by ```SDO_BATCH_SIZE``` is continuously returned until all the constraints in the WHERE clause are satisfied. You should choose a ```SDO_BATCH_SIZE``` that initially returns the number of rows likely to satisfy the constraints in your WHERE clause.
* The UNIT parameter used within the ```SDO_NN``` operator specifies the unit of measure of the ```SDO_NN_DISTANCE``` parameter. The default unit is the unit of measure associated with the data. For longitude and latitude data, the default is meters.
* b.branch_type = 'WHOLESALE' and rownum <= 5 are the additional constraints in the WHERE clause. The rownum  clause is necessary to limit the number of results returned to 5.
* The ```order by distance_km``` clause ensures that the distances are returned in order, with the shortest distance first and the distances measured in miles.

**Identify branches within 50km of Houston Warehouse:**
```
<copy>
select b.branch_name, b.branch_type
from branches b, warehouses w
where w.warehouse_name = 'Houston Warehouse'
and sdo_within_distance (
  b.geometry,
  w.geometry,
  'distance = 50 unit=km') 
  = 'TRUE';
</copy>
```

Notes:
* The first argument to ```SDO_WITHIN_DISTANCE``` is the column to search. The second argument to ```SDO_WITHIN_DISTANCE (w.wh_geo_location in the example above)``` is the location you want to determine the distances from. No assumptions should be made about the order of the returned results. For example, the first row returned is not guaranteed to be the customer closest to warehouse 3.
* The DISTANCE parameter used within the ```SDO_WITHIN_DISTANCE``` operator specifies the distance value; in this example it is 100.
* The UNIT parameter used within the ```SDO_WITHIN_DISTANCE``` operator specifies the unit of measure of the DISTANCE parameter. The default unit is the unit of measure associated with the data. For longitude and latitude data, the default is meters; in this example, it is miles.


**Identify branches within 50km of Houston Warehouse with distance:**

```
<copy>
select b.branch_name, b.branch_type,
       round(
         sdo_geom.sdo_distance(
           b.geometry,
           w.geometry,
           0.05, 'unit = km'), 2) as distance_km
from branches b, warehouses w
where w.warehouse_name = 'Houston Warehouse'
and sdo_within_distance (
  b.geometry,
  w.geometry,
  'distance = 50 unit=km') 
  = 'TRUE'
order by distance_km;
</copy>
```

Notes:
* The ```SDO_GEOM.SDO_DISTANCE``` function computes the exact distance between the customer's location and warehouse 3. The first argument to ```SDO_GEOM.SDO_DISTANCE (c.cust_geo_location in the example above)``` contains the customer's location whose distance from warehouse 3 is to be computed. The second argument to ```SDO_WITHIN_DISTANCE (w.wh_geo_location in the example above)``` is the location of warehouse 3, whose distance from the customer's location is to be computed.
* The third argument to ```SDO_GEOM.SDO_DISTANCE (0.005)``` is the tolerance value. The tolerance is a round-off error value used by Oracle Spatial. The tolerance is in meters for longitude and latitude data. In this example, the tolerance is 5 mm.
* The UNIT parameter used within the ```SDO_GEOM.SDO_DISTANCE``` parameter specifies the unit of measure of the distance computed by the ```SDO_GEOM```.```SDO_DISTANCE``` function. The default unit is the unit of measure associated with the data. For longitude and latitude data, the default is meters. In this example it is miles.
* The ```ORDER BY DISTANCE_IN_MILES``` clause ensures that the distances are returned in order, with the shortest distance first and the distances measured in miles.


**Identify branches inside coastal zone:**

```
<copy>
select b.branch_name, b.branch_type
from branches b, coastal_zone c
where sdo_inside (
  b.geometry,
  c.geometry) 
  = 'TRUE';
</copy>
```

Notes:


**Identify branches outside but within 10km of coastal zone:**

```
<copy>
select * from 
 ( 
  select b.branch_name, b.branch_type,
        round(
          sdo_geom.sdo_distance(
            b.geometry,
            c.geometry,
            0.05, 'unit = km'), 2) as distance_km
 from branches b, coastal_zone c
 where sdo_within_distance (
   b.geometry,
   c.geometry,
   'distance = 10 unit=km') 
   = 'TRUE'
  order by distance_km
 )
where distance_km>0;
</copy>
```

*At the conclusion of the lab add this statement:*
You may proceed to the next lab.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
