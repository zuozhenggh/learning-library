# Load Data


## Introduction

In Spatial Studio, a Project is where you visualize and analyze your data. Projects may be saved so that you can resume work, and they can be published so that you can share your results with others.  In this lab you create and save your first Project. 

Estimated Lab Time: xx minutes

### Objectives

* Learn how to create and save a Project
* Learn how to add Datasets to a Project
* Learn how to create a style a map

### Prerequisites

...


## **STEP 1:** Create Project

We begin by creating a new empty Project and ...

1. From the left-panel menu, navigate to the Projects page and click Create Project.
![Image alt text](images/create-proj-1.png)

2. Click the "+" icon to Add a Dataset.
![Image alt text](images/create-proj-2.png)

3. Select Accidents and click OK.
![Image alt text](images/create-proj-3.png)

4. Drag and drop the ACCIDENTS Dataset onto the map. This creates a map Layer.
![Image alt text](images/create-proj-4.png)

5. Observe the map pan and zoom to the area of the data. In the Layers List panel, click the hamburger icon for Accidents and select Settings.
![Image alt text](images/create-proj-5.png)

6. From here we control the layer display and interactivity settings. We will experiment with these cpabilities in a later section. For the moment, just update the layer's Radius (size), Color, and Opacity and then click the Back link.
 ![Image alt text](images/create-proj-6.png)

## **STEP 2:** Add Datasets

1. Next we add our 2 police Datasets to the Project.  Click the + icon at the top of the Data Elements panel, select Add Dataset, and use shift-enter to select both police Datasets and click OK.
 ![Image alt text](images/create-proj-7.png)

2. As you did previously with ACCIDENTS, drag and drop the POLICE\_POINTS Dataset from the Data Elements panel onto the, click the POLICE\_POINT layer's hamburger menu and select Settings. Update Radius, Color, Opacity. Then click the Back button at the top of the Layers panel.
 ![Image alt text](images/create-proj-8.png)

3. As Layers are added to the map, they are rendered on top of the existing Layers. Therefore POLICE\_POINTS are currently on top of ACCIDENTS. To reorder  the layers such that POLICE\_POINTS are underneath ACCIDENTS, move the mouse over POLICE\_POINTS in the Layer's list, click and hold (you'll see the cursor change to cross-hair), and drag under ACCIDENTS. 
 ![Image alt text](images/create-proj-9.png)
 
4. Drag and drop the POLICE\_BOUNDS Dataset onto the map. As you did with POLICE\_POINTS, re-order the layers so that POLICE\_BOUNDS are at the bottom (i.e., rendered beneath the other layers). We now have our 3 datasets added as map layers in our project.

  Note: Individual layers may be turned off/on by clicking the blue eyeball icon next to the layer name.
  
 ![Image alt text](images/create-proj-10.png)  

5. Click the POLICE\_BOUNDS layer's hamburger menu and select Settings. Update Color and Opacity for the Fill and Outline. Observe that using a white outline reduces the cluttered effect of a darker outline.
 ![Image alt text](images/create-proj-11.png)   

## **STEP 3:** Save Project 
    
1. Click the Save button at the top right to save the Project and supply a name, for example "LiveLabs Spatial Intro".
 ![Image alt text](images/create-proj-12.png)

2. Navigate to the projects page from the left navigation bar and observe our Project now listed.
 ![Image alt text](images/create-proj-13.png)

You may now [proceed to the next lab](#next).

## Learn More
* [Spatial Studio product portal] (https://oracle.com/goto/spatialstudio)

## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date**  - David Lapp, Database Product Management, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-spatial). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
