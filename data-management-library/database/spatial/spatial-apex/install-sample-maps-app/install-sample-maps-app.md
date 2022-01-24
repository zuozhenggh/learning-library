# Install the Sample Maps application


## Introduction

Oracle APEX provides access to a portfolio of sample applications that highlight specific areas of functionality. Among these is the Sample Maps application which showcases the mapping capabilities in Oracle APEX. A wide variety of examples are provided to serve as functional examples and starting points for further custumization. In this lab you will install and configure the Sample Maps appication. 

Estimated Lab Time: xx minutes

### Objectives

* Install the Sample Maps application
* Load supporting data

### Prerequisites

* APEX 21.2+


## Task 1: Install the application

1. Begin by clicking on **App Builder**.
![Image alt text](images/install-sample-maps-00.png)

2. Click **Install a Starter or Sample App**
![Image alt text](images/install-sample-maps-01.png)
Note: If your Workspace has existing application(s) then click **Create** and then **Starter App**.

3. Click **Samples** to open a new browser tab with a listing of available sample apps.
![Image alt text](images/install-sample-maps-02.png)

4. Scroll down to **Sample Maps** and click **Download App**
![Image alt text](images/install-sample-maps-03.png)
You will be prompted to same the application bundle to a local folder. 

5. Return to your App Builder browser tab and click **Import**
![Image alt text](images/install-sample-maps-04.png)

6. Drag and drop or browse to the Sample Maps application zip file that you downloaded previously.  Leave the File Type selection as Database Application, and then click **Next**.
![Image alt text](images/install-sample-maps-05.png)

7. File import is confirmed. Click **Next** again
![Image alt text](images/install-sample-maps-06.png)

8. Leave the default menu selections and click **Install Application**.
![Image alt text](images/install-sample-maps-07.png)
This will take you to the Install Application wizard.

9. Leave the default menu selections and click **Next**. 
![Image alt text](images/install-sample-maps-08.png)

10.  Click **Next** to validate system compatibility. 
![Image alt text](images/install-sample-maps-09.png)

11.  With compatibility confirmed, click **Install** to initiate the installation of supporting database objects and the APEX application. 
![Image alt text](images/install-sample-maps-10.png)

12.  Once installation is complete, click **Run Application**. 
![Image alt text](images/install-sample-maps-11.png)

13.  Sign in to the Sample Maps application using your APEX workspace username and password.
![Image alt text](images/install-sample-maps-12.png)

## Task 2: Load Data

1. You are now in the Sample Maps application which provides numerous examples of maps and spatial operations in APEX. On initial launch a warning message is displayed regarding data loading. Click on the **Data Loading** link within that message. You will navigate to a page where you complete loading of demo data.
![Image alt text](images/install-sample-maps-13.png)

2. The Data Loading page shows the loading status of the States and Airports datasets used by the Sample Maps applocation and the rest of this workshop. Upon installation of the Sample Maps application, these datasets are only partially loaded. To complete the sample data loading, you may either load directly from files stored in github, or you may first download the files and load from your local system. In this case, you will load directly from github. 
   
   Click on the link to load **Directly from GitHub** and then click **Load Dataset** at the top right.
![Image alt text](images/install-sample-maps-14.png)
If you have any issues accessing github, then you may also click the option upload files which provides alternate instructions.

3.  When data loading is complete you will see a notification at the top right, and the warning message is gone. The Sample Maps application is now ready to use.  
![Image alt text](images/install-sample-maps-15.png)


## Task 3: Explore the Sample Maps application

1. Clicking on any of the tiles navigates to the associated page in the application. As an example, click on **Map and Report**.
   ![Image alt text](images/install-sample-maps-16.png)

2. In this page, clicking on an item in the report on the right centers on the item in the map and openns an info window. Clicking on the icon at the top left corner opens a navigation panel to access other pages in the application. 
   ![Image alt text](images/install-sample-maps-17.png)

3. In this page, clicking on an item in the report on the right centers on the item in the map and opens an info window. Clicking on the icon at the top left corner opens a navigation panel. 
   ![Image alt text](images/install-sample-maps-17.png)

4. Click items in the navigation panel to access other pages in the application. 
   ![Image alt text](images/install-sample-maps-18.png)


5. To close the navigation panel click the icon at the top left. You can also navigate to the application home page by clicking on **Sample Maps** on the top left.
   ![Image alt text](images/install-sample-maps-19.png)


## Task 4: Explore the demo data

1. Return to APEX, click **SQL Workshop** and then **Object Browser**.
   ![Image alt text](images/install-sample-maps-20.png)

2. Observe the tables created by the data loading step performed previously. Click on **EBA\_SAMPLE\_MAP\_AIRPORTS**. Observe that the columns includes a column named GEOMETRY that has the type SDO\_GEOMETRY (Oracle's native spatial data type).
   ![Image alt text](images/install-sample-maps-21.png)

3.  Click on the **Data** tab to view the table contents. 
   
       ![Image alt text](images/install-sample-maps-22.png)

       Then scroll to the right to see the geometry column. Since airports are stored as points, APEX displays a string representation of the point geometry value. Points are always based on a single coordinate so it makes seense for APEX to display the value in this way. 
       ![Image alt text](images/install-sample-maps-23.png)

4. Click on **EBA\_SAMPLE\_MAP\_SIMPLE_STATES**. Again, observe that the columns includes a column named GEOMETRY that has the type SDO\_GEOMETRY (Oracle's native spatial data type).
   ![Image alt text](images/install-sample-maps-24.png)

5. Click on the **Data** tab to view the table contents. Since this table stores states, the geometries are polygons. APEX does not display a string representation of these values since they may include be extremely long sets of coordinates.
   ![Image alt text](images/install-sample-maps-25.png)

6. Observe the tables with names like **MDRT_....$**. These are automatically created and managed behind the scnenes by the database to support spatial indexes on other tables. You never manually create, update, or delete these tables. They are soley to support spatial analysis operations and can be ignored.
   ![Image alt text](images/install-sample-maps-26.png)

6. Finally, you can run a basic spatial query with this data.  Click on **SQL Workshop** and then  **SQL Commands**.
  ![Image alt text](images/install-sample-maps-27.png)

7. The following query returns the number of airports with land coverge over 1000 acres that are within 100km of Texas. Notive the use of the native spatial operator **sdo\_within\_distance**.  Copy and paste the query into the SQL Commands window and then click **Run** at the top right.

      ```
      <copy>
      select count(a.id) as number_of_airports
      from EBA_SAMPLE_MAP_AIRPORTS a, 
           EBA_SAMPLE_MAP_SIMPLE_STATES b
      where b.state_code= 'TX'
      and land_area_covered > 1000
      and sdo_within_distance(a.geometry, b.geometry, 'distance=100 unit=KM') = 'TRUE'
      </copy>
      ```

     ![Image alt text](images/install-sample-maps-28.png)

 8. In the sdo\_within\_distance operator, update the distance to 300km and re-run. Observe the result changes based on the larger search area.
     ![Image alt text](images/install-sample-maps-29.png)    

      In a later lab you will configure a map that dislpays the results of this query where the state and distance are controlled by the menus in the page.

      You now have installed and explored the Sample Maps application and data. Next you move on to begin creating your own applcation and maps.


You may now [proceed to the next lab](#next).

## Learn More
* 

## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date**  - David Lapp, Database Product Management, xxx 2022

