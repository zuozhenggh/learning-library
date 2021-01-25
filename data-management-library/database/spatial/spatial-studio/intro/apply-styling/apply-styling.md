# Load Data


## Introduction

This lab walks you through configuring styling point layers in Spatial Studio.

descr ...


Estimated Lab Time: xx minutes


### About ...


### Objectives

In this lab, you will:
* ...
* ...

### Prerequisites

As described in the workshop introduction, ......


## **STEP 1:** Navigate to styling

We begin by ....

1. From the left-panel menu, navigate to the Projects page. Click on hamburger icon for Livelabs Spatial Intro and select Open. 
![Image alt text](images/apply-styling-1.png)

2. You can collapse the Data Elements panel to have more screen space for our map. Hover over the right edge of the Data Elements panel and click the grey left arrow.
 ![Image alt text](images/apply-styling-2.png)
  This collapses the Data Elements panel. The panel can be re-expanded by clicking on the grey right arrow. 
 ![Image alt text](images/apply-styling-3.png)

3. To focus on the ACCIDENTS layer, turn off the 2 police layers in the map by clicking on the visibility controls (i.e., blue eyeball icons.) 
  ![Image alt text](images/apply-styling-4.png)

4. As you did in the previous lab, click the hamburger icon for ACCIDENTS and select Settings.  

## **STEP 2:** Apply cluster style  
   
5. Point layers, such as ACCIDENTS, can be rendered using various render styles. Each render style has its own settings.  Change the render style from Circle (the default) to Cluster.
  ![Image alt text](images/apply-styling-5.png)

5. The map now displays ACCIDENTS using circles to represent numerous points clustered in areas. The cluster circle size is based on the number of points clustered in each area. You can experiment with the color and the style of the text labels representing the number of points in each cluster.
  ![Image alt text](images/apply-styling-6.png)
   Observe that as you zoom in (rotate mouse wheel) the clusters explode into smaller clusters, and vice verse as you zoom out.
  ![Image alt text](images/apply-styling-7.png)

## **STEP 3:** Apply heatmap style 

6. Change the Render Style from Cluster to Heat Map. The map now renders ACCIDENTS with continuous colors based on the concentration of points. Hot colors represent  concentration of points, and cool colors represent sparcity of points. A key parameter of the Heatmap style is Radius, which controls the distance around each point for defining a concentration. The default Radius is so large that the initial heatmap just shows point contrations along the roads, which is not very helpful.
  ![Image alt text](images/apply-styling-8.png)
  To focus our Heatmap on more localized contrations, reduce the Radius from the default to 10 and observe a more localized view of point concenrtations.
  ![Image alt text](images/apply-styling-9.png)

## **STEP 4:** Apply data-driven circle style 

7. Change the Render Style from Heat Map to Circle. When using the Circle render style, both the radius and color can be controlled by data values. Pull down the Color menu and select "Based on data".
  ![Image alt text](images/apply-styling-10.png)

 8. You now select the column to use for controlling styling. Select the coloumn NR_VEHICLES (i.e., number of vehicles involved in the accident) and observe the ACCIDENTS become color-coded. You can accept the other default values and then click the Back link at the top of the Style details panel.
  ![Image alt text](images/apply-styling-11.png)

 9. Now that we have assigned colors based on data values, finalize the style by setting the radius to 3 and opacity to 90%. Also, update the stroke (i.e., outline) width to 0.5, color to grey, and opacity to 90%. You can of course pick your own values for these if you prefer. Then click the Back link to return to the Layers List.
  ![Image alt text](images/apply-styling-12.png)

## **STEP 5:** Apply symbol style 

10. You will next use the remaining point style option, Symbol, for the POLICE\_POINTS layer. Turn on the POLICE\_POINTS layer and turn off the other 2 layers in the map by clicking on the visibility controls (i.e., blue eyeball icons.)  Then click the hamburger icon for POLICE\_POINTS and select Settings. 

    Change Render Style to Symbol and then click inside the Image text box to open the Symbol selection dialog. Select "marker-11" and update the opacity to 90% and Size factor to 0.6. You can of course pick your own values for these if you prefer.  Then click the Back link to return to the Layers List.
 ![Image alt text](images/apply-styling-13.png)

## **STEP 6:** Save changes

11. Click the back link and turn on all 3 layers, and then click the Save button to save our project with the style changes.
 ![Image alt text](images/apply-styling-14.png)

12. Return to the Project page and observe the thumbnail is updated with changes.
 ![Image alt text](images/apply-styling-15.png)

Please proceed to the next Lab.



## Learn More
* [Spatial Studio product portal] (https://oracle.com/goto/spatialstudio)
* 


## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date** 

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-spatial). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
