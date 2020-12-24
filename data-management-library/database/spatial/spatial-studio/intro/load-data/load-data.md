# Load Data


## Introduction

This lab walks you through the steps to load and prepare data in Spatial Studio. 

descr existing data, excel, shapefile, geojson...

descr prepare...


Estimated Lab Time: xx minutes


### About ...


### Objectives

In this lab, you will:
* Load ..., ..., ... data from common formats
* Prepare data for mapping and spatial analysis

### Prerequisites

As described in the workshop introduction, ......


## **STEP 1:** Load Accidents data

We begin by loading a set of traffic accident data from a GeoJSON file. The data are  are ficticous and were generated for random locations along roadways in South Africa.. 

1. Download GeoJSON file to a convenient location: <a href="files/accidents.geojson" download>  accidents.geojson  </a>

2. In Spatial Studio, from the left panel menu navigate to the Datasets page, click Create Dataset, and drag-and-drop accidents.geojson. You can also click on the upload region and navigate to select the file.
![Image alt text](images/load-data-1.png)

3. A preview of the GeoJSON data will be displayed. Select the destination Connection for this upload. In this workshop we are using the SPATIAL_STUDIO connection (the Spatial Studio metadata repository), but in a production scenario you would have other connection(s) for such business data, separate from the metadata repository. Click Submit to initiate the upload.
![Image alt text](images/load-data-2.png)

4. The uploaded ACCIDENTS Dataset will be listed with a small warning icon to indicate that a preparation step is needed. In this case we need to add a Dataset key. Although this is not needed for basic mapping, we will add the key now since we'll need it for analyses in later workshop sections. Click on the warning icon and then click the link to  Go to Dataset Columns
![Image alt text](images/load-data-3.png)

5. If our ACCIDENTS data had a unique identifier column we could assign it as a key. But this ficticious data does not have such a column, so we will have Spatial Studio create one. Click Create Key Column, set the name as ACCIDENT_ID, and click Apply.
![Image alt text](images/load-data-4.png)
Observe the ACCIDENTS dataset now listed with no warnings, meaning that is prepared for mapping and spatial analyses.
![Image alt text](images/load-data-5.png)


## **STEP 2:** Load Police Station data
Next we load South African Police Servce (SAPS) Stations and Station Boundaries from Shapefiles stored in a single zip file. 

1. Download zip file containing Shapefiles to a convenient location: <a href="https://objectstorage.us-ashburn-1.oraclecloud.com/p/UqtQ-IJyh-S6VT8KLBGUttO2Y4Np1dky9cQ60U41d7-aQNCtyBdYO31aad_kZmOQ/n/oradbclouducm/b/spatial-livelabs/o/SAPS_police.zip" download>SAPS_police.zip</a>  

2. Navigate to the Datasets page, click Create Dataset, and drag-and-drop SAPS_police.zip  Spatial Studio will extract the Shapefiles from the zip file and process them individually. 
![Image alt text](images/load-data-6.png)

3. The first Shapefile extracted will be Police Station Boundaries, i.e., the geographical area patrolled by stations. Select the destination Connection, and set the table and Dataset names to POLICE_BOUNDS.
![Image alt text](images/load-data-7.png)

4. The second Shapefile extracted will be Police Stations. Select the destination Connection, and set the table and Dataset names to POLICE_POINTS.
![Image alt text](images/load-data-8.png)

5. The POLICE\_BOUNDS and POLICE\_POINTS Datasets are now listed with warnings since keys needs to be defined. Click on the warning icon for POLICE\_BOUNDS and follow the link Go to Dataset Columns.
![Image alt text](images/load-data-9.png) 
   
6. In the case we have an existing unique column to use as the key. Select Use as Key for column COMPNT\_NAME, then click Validate key, and the Apply. 
![Image alt text](images/load-data-10.png)

   Repeat steps 5 and 6 to set the key for Dataset POLICE_POINTS.

7. All Datasets are now ready for mapping and spatial analysis 
![Image alt text](images/load-data-11.png)


## Learn More
* [Spatial Studio product portal] (https://oracle.com/goto/spatialstudio)
* 


## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date** 

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-spatial). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
