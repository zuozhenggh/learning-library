# Oracle Spatial  

 

## Steps ##

**Load Data And Metadata:**


1. Login to the PDB:
   
   ````
    <copy>
    ps -ef|grep|pmon
    . oraenv
    sqlplus ' / as sysdba'
    alter session set container=SPAGRAPDB;
    </copy>
    ````

   
2. Create a  user **app_test**

    ````
    <copy>
    create user app_test identified by app container=current;
    </copy>
    ````
    
3. Grant dba privilage to **app_test** user.

    ````
    <copy>
    grant dba to app_test;
    </copy>
    ````
   
4. Connect Container **SPAGRAPDB** as user **app_test**

    ````
    <copy>
    sqlplus app_test/app@SPAGRAPDB
    </copy>
    ````
   
5. Create  table **CUSTOMERS**  and **WAREHOUSES** 

    ````
    <copy>
    CREATE TABLE CUSTOMERS
    ( 
    CUSTOMER_ID NUMBER(6, 0),
    CUST_FIRST_NAME VARCHAR2(20 CHAR),
    CUST_LAST_NAME VARCHAR2(20 CHAR), 
    GENDER VARCHAR2(1 CHAR), 
    CUST_GEO_LOCATION SDO_GEOMETRY,
    ACCOUNT_MGR_ID NUMBER(6, 0)
    );
    
    CREATE TABLE WAREHOUSES
    (
    WAREHOUSE_ID    NUMBER(3,0), 
    WAREHOUSE_NAME        VARCHAR2(35 CHAR), 
    LOCATION_ID   NUMBER(4,0), 
    WH_GEO_LOCATION       SDO_GEOMETRY
    );
    </copy>
    ````
    
6. Create  table **CUSTOMERS**  and **WAREHOUSES** 

    ````
    <copy>
    CREATE TABLE CUSTOMERS
    ( 
    CUSTOMER_ID NUMBER(6, 0),
    CUST_FIRST_NAME VARCHAR2(20 CHAR),
    CUST_LAST_NAME VARCHAR2(20 CHAR), 
    GENDER VARCHAR2(1 CHAR), 
    CUST_GEO_LOCATION SDO_GEOMETRY,
    ACCOUNT_MGR_ID NUMBER(6, 0)
    );
  
    CREATE TABLE WAREHOUSES
    (
    WAREHOUSE_ID    NUMBER(3,0), 
    WAREHOUSE_NAME        VARCHAR2(35 CHAR), 
    LOCATION_ID   NUMBER(4,0), 
    WH_GEO_LOCATION       SDO_GEOMETRY
    );
      </copy>

    ````

     
**Here is a description of the items that were entered:**

     -	TABLE-NAME: Name of the table which contains the spatial data.
     -	COLUMN-NAME: Name of the SDO-GEOMETRY column which stores the spatial data.
     -	 MDSYS.SDO-DIM-ARRAY: Constructor which holds the MDSYS.SDO-DIM-ELEMENT object,which in turn stores the extents of the spatial data  in each dimension (-180.0, 180.0), and a tolerance value (0.05). The tolerance is a round-off error value used by Oracle Spatial, and is in meters for longitude and latitude data. In this example, the tolerance is 5 mm.
     -	4326: Spatial reference system id (SRID): a foreign key to an Oracle dictionary table  (MDSYS.CS-SRS) tha  contains all the     supported coordinate systems. It is important to associate your customer's location to a coordinate system. In this example, 4326    corresponds to "Longitude / Latitude (WGS 84).".
 
 

**Load data**

First we load CUSTOMERS by copying from the table oeuser.CUSTOMERS

   **Note that we are using two spatial functions in this -**
   -  we use sdo_cs.transform() to convert to our desired coordinate system SRID of 4326.
   -  we use sdo-geom.validate-geometry() to insert only valid geometries. 
    



7. Insert Data into **CUSTOMERS** Table

    ````
    <copy>
    INSERT INTO CUSTOMERS
    SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME , sdo_cs.transform(CUST_GEO_LOCATION,4326), ACCOUNT_MGR_ID
    FROM oeuser.customers WHERE sdo_geom.validate_geometry(CUST_GEO_LOCATION,0.05)='TRUE';
    
    commit;
    </copy>
    ````
    

8. Manually load **warehouses** using the **SDO-GEOMETRY** constructor.

    ````
    <copy>
    INSERT INTO WAREHOUSES values (1,'Southlake, TX',1400,SDO_GEOMETRY(2001, 4326, MDSYS.SDO_POINT_TYPE(-103.00195, 36.500374, NULL), NULL, NULL));

    INSERT INTO WAREHOUSES values (2,'San Francisco, CA',1500,SDO_GEOMETRY(2001, 4326, MDSYS.SDO_POINT_TYPE(-124.21014, 41.998016, NULL), NULL, NULL));

    INSERT INTO WAREHOUSES values (3,'Sussex, NJ',1600,SDO_GEOMETRY(2001, 4326, MDSYS.SDO_POINT_TYPE(-74.695305, 41.35733, NULL), NULL, NULL));

    INSERT INTO WAREHOUSES values (4,'Seattle, WA',1700, SDO_GEOMETRY(2001, 4326, MDSYS.SDO_POINT_TYPE(-123.61526, 46.257458, NULL), NULL, NULL));

    COMMIT;
    </copy>
    ````
   


**The elements of the constructor are:**

   -	2001: SDO-GTYPE attribute and it is set to 2001 when storing a two-dimensional single point such as a customer's location.
   -	4326: This is the spatial reference system ID (SRID): a foreign key to an Oracle dictionary table  (MDSYS.CS-SRS) that contains all the supported coordinate systems. It is important to associate your customer's location to a coordinate system. In this example, 4326 corresponds to "Longitude / Latitude (WGS 84)."
   -	MDSYS.SDO-POINT-TYPE: This is where you store your longitude and latitude values within the SDO_GEOMETRY constructor. 
     Note that you can store a third value also, but for these tutorials, all the customer data is two-dimensional.
   -	NULL, NULL: The last two null values are for storing linestrings, polygons, and geometry collections. 
     For more information on all the fields of the SDO_GEOMETRY object, please refer to the Oracle Spatial Developer's Guide. For this tutorial with point data,  these last two fields should be set to NULL.
