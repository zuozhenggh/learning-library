# Create Sample Data

## Introduction

This lab walks you through the steps to create sample spatial data in Oracle Database.  

Estimated Lab Time: n minutes

### About Product/Technology
Oracle Database stores spatial data (points, lines, polygons) in a native data type called  SDO_GEOMETRY.  Oracle Database also provides a native spatial index for high performance spatial operations. This spatial index relies on spatial metadata that is entered for each table and geometry column storing spatial data. Once spatial data is populated and indexed, rubust APIs are available to perform spatual analysis, calulations, and processing.

### Objectives

In this lab, you will:
* Create tables with a geometry column
* Populate geometries
* Create spatial metadata and indexes

### Prerequisites

As described in the workshop introduction, you need access to an Oracle Database and SQL Client. If you do not have these, then go back to the sections on Oracle Cloud Account, Autonomous Database, and SQL Developer Web.



<!--  *This is the "fold" - below items are collapsed by default*  -->

## **STEP 1**: Create tables with coordinates

We begin by creating tables with latitude, longitude coordinates. This is a common starting point for creating spatial data, for example coordinates from GPS, street address geocodes, or IP address geocodes.

The instructions and screen shots refer to SQL Developer Web, however the same steps apply for other SQL clients.

1. Download the SQL script [here](files/create-sample-data.sql).


2. Copy/paste/run the script in SQL Developer Web
![Image alt text](images/run-script-1.png)

3. Refresh listing to see the tables BRANCHES and WAREHOUSES

    ![Image alt text](images/refresh-tables-1.png)


## **STEP 2:** Create geometries from coordinates

Geometries are stored in SDO_GEOMETRY columns which are added to a table just like any other data type. Geometries can then be populated with SQL, in this case by specifying the coordinates of point geometries based on  latitude and longitude columns.

1. Add geometry columns:

    ```
    <copy> 
    ALTER TABLE WAREHOUSES ADD (
     GEOMETRY SDO_GEOMETRY
    );

    ALTER TABLE BRANCHES ADD (
       GEOMETRY SDO_GEOMETRY
    );
    </copy>
    ```

2. Populate geometry columns:

    ```
    <copy> 
   UPDATE WAREHOUSES
   SET
       GEOMETRY = SDO_GEOMETRY(
           2001, 4326, SDO_POINT_TYPE(
               LON, LAT, NULL
           ), NULL, NULL
       );

   UPDATE BRANCHES
   SET
       GEOMETRY = SDO_GEOMETRY(
           2001, 4326, SDO_POINT_TYPE(
               LON, LAT, NULL
           ), NULL, NULL
       );
    </copy>
    ```


## **STEP 3**: Create table with polygon

Lines and polygons can be created in the same way. While a point geometry requires one coordinate, lines and polygons require all of the coordinates that define the geometry. In this case we create a table to store a polygon.

1. Create table and insert row
   
	```
    <copy>
   CREATE TABLE COASTAL_ZONE (
       ZONE_ID   NUMBER,
       GEOMETRY  SDO_GEOMETRY
   );

   INSERT INTO COASTAL_ZONE VALUES (
       1,
       SDO_GEOMETRY(
           2003, 4326, NULL, MDSYS.SDO_ELEM_INFO_ARRAY(
               1, 1003, 1
           ), MDSYS.SDO_ORDINATE_ARRAY(
               -93.719934, 30.210638,
               -95.422592, 29.773714, 
               -95.059698, 29.322204, 
               -96.013892, 28.787021, 
               -96.660964, 28.925638, 
               -97.528688, 28.042050, 
               -97.858501, 27.447461, 
               -97.497364, 25.880056, 
               -96.977826, 25.969716, 
               -97.211445, 27.054605, 
               -96.870226, 27.816077, 
               -93.794290, 29.535729, 
               -93.719934, 30.210638
           )
       )
   );
  
  </copy>
  ```

Refresh the table listing to see the COASTAL_ZONE table.


## **STEP 4**: Add spatial metadata and indexes 
Oracle Database provides a native spatial index for high performance spatial operations. Our sample data is so small that a spatial index is not really needed. However we perform the following steps since they are important for tyical production data volumes. A spatial index requires a row of metadata for the geometry being indexed. We create this metadata and then the spatial indexes.


1. Add spatial metadata:

    ```
    <copy> 
   INSERT INTO USER_SDO_GEOM_METADATA VALUES (
       'WAREHOUSES',
       'GEOMETRY',
       MDSYS.SDO_DIM_ARRAY(
           MDSYS.SDO_DIM_ELEMENT(
               'x', -180, 180, 0.05
           ), MDSYS.SDO_DIM_ELEMENT(
               'y', -90, 90, 0.05
           )
       ),
       4326
   );

   INSERT INTO USER_SDO_GEOM_METADATA VALUES (
       'BRANCHES',
       'GEOMETRY',
       MDSYS.SDO_DIM_ARRAY(
           MDSYS.SDO_DIM_ELEMENT(
               'x', -180, 180, 0.05
           ), MDSYS.SDO_DIM_ELEMENT(
               'y', -90, 90, 0.05
           )
       ),
       4326
   );

   INSERT INTO USER_SDO_GEOM_METADATA VALUES (
       'COASTAL_ZONE',
       'GEOMETRY',
       MDSYS.SDO_DIM_ARRAY(
           MDSYS.SDO_DIM_ELEMENT(
               'x', -180, 180, 0.05
           ), MDSYS.SDO_DIM_ELEMENT(
               'y', -90, 90, 0.05
           )
       ),
       4326
   );
    </copy>
    ```

2. Create spatial indexes:

    ```
    <copy> 
   CREATE INDEX WAREHOUSES_SIDX ON
       WAREHOUSES (
           GEOMETRY
       )
           INDEXTYPE IS MDSYS.SPATIAL_INDEX;

   CREATE INDEX BRANCHES_SIDX ON
       BRANCHES (
           GEOMETRY
       )
           INDEXTYPE IS MDSYS.SPATIAL_INDEX;

   CREATE INDEX COASTAL_ZONE_SIDX ON
       COASTAL_ZONE (
           GEOMETRY
       )
           INDEXTYPE IS MDSYS.SPATIAL_INDEX;
    </copy>
    ```

    Refresh the table listing. You will see 3 tables having names beginning with MDRT_. These are artifacts of the spatial indexes and are managed by Oracle Database automatically. You should never manually manipulate these tables.



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
