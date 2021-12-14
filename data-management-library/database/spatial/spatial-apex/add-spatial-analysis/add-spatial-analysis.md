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

5. Enter a Page Name. (With this wizard, the Page Name will also be used as the name of the Map Region created in the page.)  Click the icon to the right of the table input to select the EBA_SAMPLE_AIRPORTS table. For geometry column, select GEOMETRY, and finally select a column to use a tooltip when mousing over an item in the map.
![Image alt text](images/create-map-05.png)

6. Observe your new page is now listed under **Pages**. Click **Create Application**.
![Image alt text](images/create-map-06.png)

7. You are navigated to the page where you manage your new application. Click **Run Application**.
![Image alt text](images/create-map-07.png)

8. Sign in to your application.
![Image alt text](images/create-map-08.png)
 
9. The default layout we selected for our appliciation provides a home page with links to other pages. From the home page, navigate to your map page **My First Map**.
![Image alt text](images/create-map-09.png)

10. Observe the page includes an interactive map showing airport location with tooltips as you configured.
![Image alt text](images/create-map-10.png)

## Task 2: Inspect the map page

First map under the covers...

1. In the Developer Toolbar at the bottom of the page, click on the **Edit Page** button.
![Image alt text](images/create-map-11.png)

2. In the Page tree on the left, under **Body** click **My First Map**. This is the title of the Map Region created by the Create Page wizard and is, by default, the same as the Page title and can be changed as desired. In the Region details panel on the right, observe that this Region has a type of **Map**.  
![Image alt text](images/create-map-12.png)

3. Map Regions include Layers which are the data-driven points, lines, and polygons displayed on top of a background map. When stepping through the Create Page wizard you selected a Map using the table EBA_SAMPLE_MAP_AIRPORTS. So the wizard has created one layer containing those airport locations. By default the Layer has the same name as the Page, i.e. My First Map. This can be changed as desired. 
   
   To inspect this Layer, in the Page tree on the left panel, under Layers click on **My First Map**. Configuration details are displayed in the **Layer** panel on the right. For information about configuration items, click on the **Help** tab in the middle panel. When you then click on configuration items, help info is displayed for that item. For example click in the **Layer Type** menu to see help on its options. 
![Image alt text](images/create-map-13.png)

4. Scroll down in the Layer panel to see the other configuration options, including Column Mapping where the geometry data type is set. Here you are using Oracle's native spatial data type, SDO_GEOMETRY, and the column name is GEOMETRY.  
![Image alt text](images/create-map-14.png)

## Task 3: Create a map from scratch

Create map from scratch in new page

1. Click **App Builder** and then **Create Page**. 
![Image alt text](images/create-map-15.png)

2. Select **Blank Page** and then click **Next**. You could select Map here to have the same wizard you saw in teh Creaet App wizard. But this step is to create a map from scratch., for example if you had an existing page.
![Image alt text](images/create-map-16.png)

3. Select option to create a new navigation menu entry and provide a name. Then click **Next**.
![Image alt text](images/create-map-17.png)

4. Review the summary and click **Finish**.
![Image alt text](images/create-map-18.png)

5. Drag **Map** from the Regions items at the bottom and drop under the Body section of the page layout.
![Image alt text](images/create-map-19.png)

    Observe the Map Region appears in the Page tree under Body with default name New. Click on **New** in the Page tree and observe its properties on the right.  Observe the Region Type is Map.
    ![Image alt text](images/create-map-20.png)

6. In the panel on the right, update the Region Title from New to a name of your choosing, for example **My Map Region**. Observe the title is updated in the page tree on the left.
![Image alt text](images/create-map-21.png)

7. Observe that the Map Region includes a child element called Layers with a default Layer called New. Layers are the data driven content to be rendered on the map. Clicl on the Layer **New** in teh page tree to see it's properties in the right panel.
![Image alt text](images/create-map-22.png)

8. Update the Layer Name to **Airports** and the Type to **Points**. Observe the Layer Name update in the page tree on on the left.
![Image alt text](images/create-map-23.png)

9. Scroll down in the Layer properties panel on the right. Update the **Source** to use the table **EBA\_SAMPLE\_AIRPORTS**. To limit the airports rendered in the layer, add the where clause **LAND_AREA_COVERED > 2500**.
![Image alt text](images/create-map-24.png)


10. Scroll down in the Layer properties panel on the right to the **Column Mapping** section. This is where you configure the spatial column for rendering. Select geometry data type **SDO\_GEOMETRY** and geometry column **GEOMETRY**.
![Image alt text](images/create-map-25.png)

11. Scroll down in the Layer properties panel on the right to the **Info Window** section. This is where you can configure the content of a info window that pops up when clicking on an item in the map. Enable **Advanced Formatting** and paste in the following:
    ```
    <copy>
    <strong>&AIRPORT_NAME.</strong><br>
    &CITY., &STATE_NAME.<br>
    Code: &IATA_CODE.
    </copy>
    ```
    ![Image alt text](images/create-map-25a.png)

12.   Next you will add another Layer to your map. In the Page tree on the left, right-click on **Layers** under your Map Region and select **Create Layer**.  
![Image alt text](images/create-map-26.png)

13.  Click on the newly created Layer in the Page tree under your Map Region. Then in the Layer details panel on the right, update the Name to **States**, Layer type to **Polygons**, and Source to **EBA\_SAMPLE\_SIMPLE\_STATES**.
![Image alt text](images/create-map-27.png)

14.  Layers will be rendered in the order they appear under Layers in the page tree. To have Airports render on top States, drag the **States** layer above the Airports layer under Layers in teh page tree. Scroll down in the Layer details panel on the right to the Coloumn Mapping section section. Select geometry data type **SDO\_GEOMETRY** and geometry column **GEOMETRY**. Under Appearance, enable **Use Color Scheme** which provides data-driven styling. You will style each state based on its **LAND_AREA**. Select a Color Scheme, Scheme Name, Fill Opacity, and Stroke Color (i.e., shape outline) of your choosing. 
![Image alt text](images/create-map-28.png)

15. At the upper right, click **Save** and then green **Run** button.
![Image alt text](images/create-map-29.png)
Observe your map render with States and Airports layers. Click and drag the map to pan, and use the navigation control at the top right to zoom in and out. Click on an Airport to see the Info Window that you configured. Turn layers off and on with the checkboxes under the map.
![Image alt text](images/create-map-30.png)

Congratulations on creating your first maps. There is a lot of capability beyond the basics you have just explored. .....expand....  


You may now [proceed to the next lab](#next).

## Learn More
* 

## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date**  - David Lapp, Database Product Management, xxx 2021

