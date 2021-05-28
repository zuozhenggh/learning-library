# Essbase Drill Through Feature

## Introduction

In this lab, you will use Essbase drill-through functionality to display additional detailed data that is retrieved from the external data sources. When you create an Essbase cube, you do not use all the data from an external data source. You choose and summarize the data in the cube for Essbase users to analyze. The additional detailed data is not available in the Essbase cube.

Estimated Lab Time: *60 minutes*

### Objectives

* Connecting and verifyng data in Oracle Database.
* Create a connection from Essbase 21c to Oracle Database.
* Build dimension using data in database.
* Load data from Database to Essbase cube.
* View / Analyze data from database in Smart View.
* Drill through to data in database from Smart View.

### Prerequisites

* Essbase 21c instance.
* Database Conection details(Refer to Lab5).  
* Smart View plugin for Excel.
* SQL Developer Client(Optional)
* Files: Sample\_Basic\_DT.xlsx


## **Step 1:** Create the cube
We will create a variation of the Sample/Basic cube where Market dim has Region in the leaf level and it has no State. We will then load data from a relational table. The relational table contains Sales data that contains breakdown of Region Sales figures by States. All the Sales numbers for different States in a Region gets added to that Region. The summaries in Essbase enable users to compare Sales figures across Regions. 

1. Log in to Essbase Web User Interface.

2. Download the worksheet Sample\_Basic\_DT.xlsx.  
   
   This file is part of Workshop artifacts. Steps to download the artifacts are mentioned in **lab5 -> step2**.

3. On the Home page, click on Import.

   Click on "File Browser", and browse to select Sample\_Basic\_DT.xlsx excelsheet.
   
   Change application name Sample to SampleDT. 
  ![](./images/imageDT_01.png "")

4. Go to Home. Expand application SampleDT<StudentID>, cube Basic, select Actions and click on Outline. Click on the Market Dimension and check that Regions are at leaf level. 
  ![](./images/imageDT_02.png "")


5.  Close the outline browser tab.

6.	Open the query worksheet QueryDT.Sample within Sample\_Basic\_DT.xlsx.   
   Login to Smart View. Select the application SampleDT and click connect and click "set active connection".

7.  Go to SmartView Ribbon, Click on Options –> Cell Styles –> Essbase –> Data Cells and pick colors for  Drill-through (blue), Read-Only (pink), Writable (green) and Linked Objects (yellow). 
   
   For example, Select "Drill-Thorugh" and double click on it and then double click on "Backgroud" to pick the required  color.

    Click OK.
    
     ![](./images/imageDT_03.png "")

8. Refresh the sheet in Smart View. Notice data cells E2 to E11 representing Sales figures for different Regions are all color coded green.
    ![](./images/imageDT_04.png "")

  
## **Step 2:** Check the data in relational table(Optional)

   **Note**: The data is already loaded in the database.  

1. Open SQL Developer. Create a connection to your Oracle Database. 

   Enter the details: Connection Name, Username, Password, Hostname(IP), Port, Service name.

   ![](./images/imageDT_05.png "")

   Password for Esscs Schema: "Admin123".

2. Query the data in the relational table:
   Right click on Connection name -> Open SQL Worksheet. Type the query and check the result:   
    ```
    <copy>        
          select product, market, statename, scenario, year, sales from SALES_BREAKDOWN_SB order by product, market, scenario, year, sales;
	</copy>
    ````
  ![](./images/imageDT_06.png "")
   
   Notice for example: For the Month April, under the Central Region, there are 6 Sales figures, one each for the 6 States under the Central Region. These 6 Sales numbers will get accumulated into the Sales for Central Region for the month of April. 

3. Check the database table SALES\_BREAKDOWN\_SB. Type the query: 

    ```
    <copy>        
          Select * from SALES_BREAKDOWN_SB
	</copy>
    ````
  ![](./images/imageDT_07.png "")


## **Step 3:** Define a Drill-through Connection
1. In Essbase UI, go to Home. Select the application SampleDT.

2. Launch application inspector, by clicking icon under Actions for the application selected and choose Inspect.
   ![](./images/imageDT_08.png "")

3. Click the Sources tab on the application inspector.

4. Click on Connections and click “Create connection” -> choose Oracle Database.
   ![](./images/imageDT_09.png "")

5. Provide the connection details under Create Connection:   
   Name, Host, User, Password, Port, Service Name. 

   Password for the schema: "Admin123".

6. Click Test to check that the connection to the database is successful. Click Create. 
   ![](./images/imageDT_10.png "")
    
## **Step 4:** Define Drill-through Datasource

1. Click Datasources link on the Sources tab on application inspector. Click on Create Datasource.

2. In the General tab of the Create Datasource wizard, select the connection from the drop down created in the previous step.

  Enter Name: "SalesTable". In the Query field, enter the database query string below and click Next. 

        
        <copy>        
            select product, market, statename, scenario, year, sales from SALES_BREAKDOWN_SB order by product, market, scenario, year, sales
        </copy>
        

   ![](./images/imageDT_11.png "")

3. The next page displays the Columns. Click Next.
   ![](./images/imageDT_12.png "")

4. Next page is Parameters. Click Next. 
   ![](./images/imageDT_13.png "")
   
5. In the next page you can preview the results of the query, which is same as what you saw through SQL Developer in Step2. Click Create.
   ![](./images/imageDT_14.png "")

6. Datasource **SalesTable** and Connection Name **SAMPLEDT.esscs** you created above are listed under Datasources. 
   ![](./images/imageDT_15.png "")

7. Close the application inspector.

## **Step 5:** Define Drill-through Report
1. Navigate to the database inspector for the application SampleDT and database Basic. Click on Scripts.   

2. Select Drill Through Reports on left navigation section. On the Create menu to the right, Select Datasource.
   ![](./images/imageDT_16.png "")

3. Enter Name "SalesBreakdown". 

   a) Click dropdown for Datasource and select the data source "SAMPLEDT.SalesTable".
   
   b) Select the Report Columns check boxes for all the rows.
   
   c) Select the data source column name on the left and provide the generation mapping on the right:

      * PRODUCT – Product -> Model[Generation]  
      * MARKET – Market -> Region[Generation]  
      * SCENARIO – Scenario -> Level0 [Level]   
      * YEAR – Year -> Months[Generation]   

   ![](./images/imageDT_17.png "")

4. Select Drillable Regions on the left navigation bar, click the “+” icon and enter @Children("Market").
   ![](./images/imageDT_18.png "")

5. Click Save and Close. Click Close to close the database inspector.
   


## **Step 6:** Drill-through Color Coding
1. Go back to Smart View and open the query worksheet QueryDT.Sample within Sample\_Basic\_DT.xlsx.
   ![](./images/imageDT_04.png "")

2. We will now check drill-through color coding (blue color) to see if drill-through reports are defined.   

   Click Refresh in Smart View.   

   You will see data cells E2 – E5 and E7 – E10 enabled for drill-through reports.  

   This is the same region where we created the drill-through report through Essbase UI and represent summarized Sales for the different Regions.  
   ![](./images/imageDT_19.png "")

   Next, we will load data and drill through to the detailed breakdown of data in the Oracle Database table.

## **Step 7:** Load Data
1. Create Load Rules:     

   a) Go to Home in Essbase Web User Interface. Select application SampleDT and cube Basic.   
   
   b) Launch the database inspector by clicking the icon under Actions and selecting Inspect.   
   
   c) Click Scripts. On the left navigation bar select -> Rules. Click Create menu to the right.  
   ![](./images/imageDT_20.png "")
   
   d) In the drop down menu, select Data Load.    
     * In the Name field, provide the name of the rules file as SalesDataload.  
     * For Data Dimension, select “Measures” dimension.  
     * Click Proceed.   
    
   
   ![](./images/imageDT_21.png "")

2. Click Create and select “Regular” from the drop down options. Do the same 4 more times to have 5 fields.

3. Map the fields as following:
      *  Field - 1:  Product 
      *  Field - 2:  Market  
      *  Field - 3:  Scenario
      *  Field - 4:  Year
      *  Field - 5:  Sales

   Make Sure to give "Storage Type" for "Sales" field as "Sum".

   
   ![](./images/imageDT_22.png "")

4. Click the Source button at the top. In the General tab, in the Name field, enter the connection string – $OCI$IP:1521/ORCL. 
   ![](./images/imageDT_23.png "")

5. Click the SQL/Datasource Properties tab, enter below SQL statement in the Query field. Click Ok. 

        <copy>        
            select product, market, scenario, year, sales from SALES_BREAKDOWN_SB
        </copy>
        

   ![](./images/imageDT_24.png "")

6.	Click Verify. Click Save and Close. Close the database inspector.

7.	Next, load the data from Jobs:   
    
    a. On the home page select Jobs. Click New Job.

    b. Select Load Data as the job type.  

    c. Select application SampleDT, cube Basic and SQL as the load type.   

    d. For Scripts, select the name of the data load rules file you created, SalesDataload.rul. 

    e. Enter the user name and password of your SQL database schema. Click OK.

    ![](./images/imageDT_25.png "")

8. Click Refresh to update the status. Once the job is completed, click Job details from the right side dropdown to check Job execution status. 
    ![](./images/imageDT_26.png "")


## **Step 8:** Execute Drill-through
1.	Go back to Smart View. Refresh the query sheet. Observe the Sales figure for the Central Region.
   ![](./images/imageDT_27.png "")

2.	The sales for the month of April in the Central Region is 1207. 

    To see the detailed breakdown of Sales by States in Central Region, Double Click on cell E5 1207.   

    Execute the drill-through report defined in cell E5 by clicking Drill-through in the Essbase ribbon.

    A new sheet will be displayed with the results of the drill-through report execution which contains the detailed breakdown. 
    
    Note:  
    1) There are 6 states in Central Region with Sales for April. This matches the Sales query results from the relational table. Check Column C Statename showing the breakdown.  

    2) Enter a formula in cell F8 to sum the Sales numbers for the States: =SUM(F2:F7). The sum is 1207 which is the same value as the summarized Sales for Region Central in the Essbase cube.
      
    3) The column names A1 to F1 for the drill-through table matches the Alias you specified in the drill-through datasource definition.   

    ![](./images/imageDT_28.png "")


You may proceed to the next lab.

## Acknowledgements
* **Authors** -Sudip Bandyopadhyay, Manager, Analytics Platform Specialist Team, NA Technology
* **Contributors** - Eshna Sachar, Jyotsana Rawat, Kowshik Nittala
* **Last Updated By/Date** - Jyotsana Rawat, Solution Engineer, Analytics, NA Technology, March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-analytics-cloud). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
