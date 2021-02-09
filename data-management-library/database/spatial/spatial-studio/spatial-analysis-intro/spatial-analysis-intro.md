# Perform Spatial Analyses

## Introduction

Spatial Studio provides access to the spatial analysis features of Oracle Database without the need to write code. Simple user interfaces are provided for spatial analyses and all of the underlying database syntax is handled automatically behind the scenes. Spatial analysis operations in Spatial Studio are organized into categories:

**Filter**  -  i.e., "Identify which items in a dataset are inside of a region?"

**Combine** - i.e., "Join 2 datasets based on a spatial relationship" 

**Transform** - i.e., "Generate a dataset of points in the middle of each region"

**Measure** - i.e., "What is the area of each region in my dataset?"

**Analytics** - i.e., "How many items are inside of each region?" 

In this lab you will explore several of these spatial analyses.

Estimated Lab Time: xx minutes


### Objectives

* Understand the categories of spatial analyses in Spatial Studio
* Learn how to perform spatial analyses and visualize results

### Prerequisites

* Successfully complete Labs 1-3

<!-- *This is the "fold" - below items are collapsed by default*  -->


## **STEP 1**: Identify by Proximity

In this step you identify accidents within a specified distance of a selected police station.

1. Begin by clicking on a police station. In the image below, I have clicked on the police station in the red box. This selects the police station to use for the proximity analysis. If there is any issue with making the selection, confirm that **Allow selection** is turned on for the POLICE\_POINTS layer as described in Lab 3 Step 6.

 ![Image alt text](images/spatial-analysis-1.png "Image title")  
   
2. Click the hamburger menu for the ACCIDENTS layer and select **Spatial Analysis**

   ![Image alt text](images/spatial-analysis-2.png "Image title")  

3. Click on the **Filter** tab select **Return shapes within a specific distance of another**

   ![Image alt text](images/spatial-analysis-3.png "Image title")  

4. In the analysis dialog, you may enter a name for the result or leave the default. We are filtering ACCIDENTS based on distance from a selected item in POLICE_POINTS. In the example show below, I have used a distance of 150 kilometers. 
   
   **Note:** The analysis includes switches to **Include only items that have been selected** for the layers involved. We are only interested in including the 1 selected police station for proximity analysis in this example. Therefore **Include only items that have been selected** should be **On** for POLICE_POINTS. 

   Once selections are made, click **Run**.

   ![Image alt text](images/spatial-analysis-4.png "Image title")  

5. The analysis result is listed under Analyses in the Data Elements panel. Drag and drop the analysis result onto the map. This creates a new map layer displaying only the accidents within the specified distance of the selected police station.

   ![Image alt text](images/spatial-analysis-5.png "Image title") 

   **Note:** Analysis results are just another type of Dataset in Spatial Studio. As you'll see in a later Lab, analysis results may be added to other maps/tables, used in other projects, accessed programmatically via REST or SQL, or exported as a file. 

6. You no longer need this analysis result in the map. So to avoid clutter, you next remove it from the map. Right click on the analysis result in the Layers List and select **Remove**
   
   ![Image alt text](images/spatial-analysis-6.png "Image title")  

   **Note:** A Layer is just a Dataset rendered in a map. After removing a Layer (our analysis result in this case), the Dataset is still listed in the Data Elements panel and could be re-added to the map. To remove a Dataset from a Project you would right click on the Dataset in the Data Elements panel and select **Remove from project**.

## **STEP 2**: Identify by Containment

In this step you identify accidents inside a selected police region.

1. Begin by clicking in a region in the POLICE\_BOUNDS layer. The selected region will be used as to filter accidents. In the image below, the region in the red box was selected.

   ![Image alt text](images/spatial-analysis-7.png "Image title")  
   
2. As you did for the previous analysis in Step 1, right click on the ACCIDENTS layer and select Spatial Analysis. This time we are filtering by containment. So select the tile **Return shapes that are inside another**  

   ![Image alt text](images/spatial-analysis-8.png "Image title")  

3. You may enter a name for the results or leave the default. The layer to be filtered is ACCIDENTS and the layer used as the filter is POLICE\_BOUNDS. The option to **Include only items that have been selected** should be selected for POLICE\_BOUNDS since we are only filtering for accidents contained in the 1 selected police region.

   ![Image alt text](images/spatial-analysis-9.png "Image title")  
   
4. Drag and drop the analysis result into the map. Observe the new layer containing the accidents inside the selected police region.

   ![Image alt text](images/spatial-analysis-10.png "Image title")  
   
   You can use your mouse wheel to zoom into the area of results. In the image below the ACCIDENTS layer is turned off to focus on the analysis result.

   ![Image alt text](images/spatial-analysis-11.png "Image title")  

## **STEP 3**: Join by Containment


## **STEP 4**: Summarize Items by Region


## **STEP 5**: Identify Nearest Items

You may now [proceed to the next lab](#next).


## Acknowledgements
* **Author** - David Lapp, Database Product Management
* **Last Updated By/Date** - David Lapp, Database Product Management, February 2021


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
