# Create your first map


## Introduction

doc details link...

Estimated Lab Time: 30 minutes

### Objectives

* Understand the basics of Map Regions

### Prerequisites

* ....


## Task 1: Create a new app with a map page using the wizard

Create.... 

1. Navigate to **App Builder** and click **Create**.
![Image alt text](images/create-map-01.png)

2. Select **New Application**.
![Image alt text](images/create-map-02.png)

3. Enter a name for your application and click **Add Page**.
![Image alt text](images/create-map-03.png)

1. Select **Map** as the page type.  **Note this is the same wizard as using  Create Page in an existing application.**
![Image alt text](images/create-map-04.png)

5. Enter the Page Name **Airports Map**. (With this wizard, the Page Name will also be used as the name of the Map Region created in the page.)  Click the icon to the right of the table input to select the EBA_SAMPLE_AIRPORTS table. For geometry column, select GEOMETRY, and finally select a column to use a tooltip when mousing over an item in the map.
![Image alt text](images/create-map-05.png)

6. Observe your new page is now listed under **Pages**. Click **Create Application**.
![Image alt text](images/create-map-06.png)
![Image alt text](images/create-map-06b.png)

7. You are navigated to the page where you manage your new application. Click **Run Application**.
![Image alt text](images/create-map-07.png)

8. Sign in to your application.
![Image alt text](images/create-map-08.png)
 
9. The default layout we selected for our appliciation provides a home page with links to other pages. From the home page, navigate to teh page you just created.
![Image alt text](images/create-map-09.png)

10. Observe the page includes an interactive map showing airport locations with tooltips as you configured.
![Image alt text](images/create-map-10.png)

## Task 2: Inspect the map page

First map under the covers...

1. In the Developer Toolbar at the bottom of the page, click on the **Edit Page** button.
![Image alt text](images/create-map-11.png)

2. In the Page tree on the left, under **Body** click **Airports Map**. This is the title of the Map Region created by the Create Page wizard. It is, by default, the same as the Page title and can be changed as desired. In the Region details panel on the right, observe that this Region has a type of **Map**.  
![Image alt text](images/create-map-12.png)

3. Map Regions include Layers which are the data-driven points, lines, and polygons displayed on top of a background map. When stepping through the Create Page wizard you selected a Map using the table EBA_SAMPLE_MAP_AIRPORTS. So the wizard has created one layer containing those airport locations. By default the Layer has the same name as the Page, i.e. **Airports Map**. This can be changed as desired. 
   
   To inspect this Layer, in the Page tree on the left panel, under Layers click on **Airports Map**. Configuration details are displayed in the **Layer** panel on the right. For information about configuration items, click on the **Help** tab in the middle panel. When you then click on configuration items, help info is displayed for that item. For example click in the **Layer Type** menu to see help on its options. 
![Image alt text](images/create-map-13.png)

4. Scroll down in the Layer panel to see the other configuration options, including Column Mapping where the geometry data type is set. Here you are using Oracle's native spatial data type, SDO_GEOMETRY, and the column name is GEOMETRY.  
![Image alt text](images/create-map-14.png)



Congratulations on creating your first maps. There is a lot of capability beyond the basics you have just explored. .....expand....  


You may now [proceed to the next lab](#next).

## Learn More
* 

## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date**  - David Lapp, Database Product Management, xxx 2021

