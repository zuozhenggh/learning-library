# Oracle Spatial  



## Steps ##

**Create tables and spatial metadata:**
 
 
1. **Create Indexes**
   
  ````
    <copy>
   CREATE INDEX customers_sidx ON customers(CUST_GEO_LOCATION) 
   indextype is mdsys.spatial_index; 

   CREATE INDEX warehouses_sidx ON warehouses(WH_GEO_LOCATION)
    indextype is mdsys.spatial_index;  
   
  </copy>
  ````
