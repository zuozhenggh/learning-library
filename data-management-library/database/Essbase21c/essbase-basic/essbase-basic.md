# Essbase Features: Basic

## Introduction

This lab walks you through the major features of Essbase 21c and their functionalities across the platform along with Overview of the Essbase 21c Web interface.

Estimated Lab Time: 20 minutes.

### Objectives

 * Understand the Essbase 21c add-ins (Smart View and Cube designer)
 * Understand the Essbase 21c Web-interface overview.

### Prerequisites

This lab requires:

* Essbase 21c instance
* Service administrator role
* Windows Operating System for Essbase add-ins (Smart View and Cube Designer)


## **Step 1:** Creating a Sample Application in Essbase21c

1.	Login to the Essbase 21c web interface  using the Essbase URL. i.e. https://ip:9000/essbase/jet

2.	On the Applications tab click on “Import” option from the Essbase web interface as shown below.

    ![](./images/image14_1.png "")

3.	 From the Import dialog box, click Catalog.

    ![](./images/image14_2.png "")

4.	Select “Sample_Basic.xlsx” file  from:   
    All Files -> Gallery -> Applications ->Demo Samples-> Block Storage.

    ![](./images/image14_3.png "")

5.	Name the application “DynamicCorp,” and name the cube “Sales” and click OK.

    ![](./images/image14_4.png "")

6.	Once the application is deployed, it will be visible under the "Applications" tab.

    ![](./images/image14_5.png "")

This concludes the creation of sample application from the “Catalog” in the Essabase 21c Web Interface.

## **Step 2:** Analyzing Essbase data using Smart View Add-ins

In this section, The following topics will be covered:  

* Connect to Data Sources
* Explore the Smart View interface
* Create ad hoc grids
* Use Audit Trail

After installing Oracle Smart View for Office, you can create connections to Essbase. 

*TSteps o create a private connection to Essbase:*

1. In Excel, select the Smart View ribbon, and then click Panel.

2. On the Smart View Panel, select the Private Connections from the list.

    ![](./images/image14_6.png "")

3. Enter the URL for the data source to create a connection. The URL syntax: `http://ip:9000/essbase/smartview`

4. Click Go.

5. On the login window, enter your login credentials.

    ![](./images/image14_7.png "")

6. After successful login, you can now begin working with data in Essbase. Expand ‘EssbaseCluster,’ navigate to the ‘DynamicCorp’ application. click on ‘Sales’ and 'connect' and then click on 'Ad hoc analysis'.
   
   

   ![](./images/image14_8.png "")

 

## **Step 3:** Create Ad Hoc Grids

  ![](./images/smartview.png "")

**Smart View Ribbon**

The Smart View ribbon option enables you to set Smart View options and perform commands that are common for all data source providers.

**Essbase Ribbon**

The Essbase ribbon contains commands that enable you to view, navigate, and analyze Essbase data.

**POV Toolbar**

Dimensions that are not displayed in columns or rows of a data grid are displayed on POV toolbar, which identifies a slice of the database for a grid. For default ad hoc grids, all database dimensions are displayed on the POV toolbar at the dimension level.

**Smart View Panel**

You use Smart View panel to connect to your smart view data sources and manage connections.

1. Open a new Excel. Click Smart View – Panel – Private Connections. Enter the Smart View URL and the credentials.

2. In the Connection Manager panel to your right, click ‘DynamicCorp’ – ‘Sales’. Click Connect and then Ad hoc analysis.

    ![](./images/image14_11.png "")

3. After connecting to an Essbase server and opening the worksheet, you can initiate ad hoc reports against databases on the connected server. The Adhoc report on a blank worksheet returns data from the top levels of each database dimension.

    ![](./images/image14_12.png "")

4. Double click or zoom in to Year. You will now see the Quarter level data.

    ![](./images/image14_13.png "")

    ![](./images/image14_14.png "")

5. Go to Year. Click on Keep only. Using this option, only the Year Dimension will be displayed and all the Quarters are removed.

    a. Select the member and then, on the Essbase ribbon, click Zoom In.
    b. Double-click the member.

    ![](./images/image14_15.png "")

    ![](./images/image14_16.png "")


6. Go to Year. Click on Zoom in-All levels.You will now see the numbers drill down to leaf level(Months).

    ![](./images/image14_17.png "")

7. In the Smart View ribbon click 'Undo'. Undo reverses the last change you made to the data.

    ![](./images/image14_18.png "")

8. In the Smart View ribbon click ‘Redo’. It will take you back to the sheet prior to the ‘Undo’.

9.  Pivot to POV:

    a. Click on ‘POV’ in ‘Essbase’ ribbon.

    ![](./images/image14_19.png "")

    b. Click the down arrow next to Market. Select New York.

    ![](./images/image14_20.png "")

    ![](./images/image14_21.png "")

    c. Select New York in the POV toolbar, and click Refresh to see the figures refreshed in the sheet for New York.

    ![](./images/image14_22.png "")

10. Member Selection:

    a. Drag Scenario from POV tool bar to the sheet.

    ![](./images/image14_23.png "")

    b. Click on Scenario

    c. Click on Member Selection in the Essbase ribbon. Select Actual and Refresh.

    ![](./images/image14_25.png "")

    ![](./images/image14_24.png "")

    

11. Free Form processing:

    a. You can enter a member combination on a sheet. Click Refresh. The sheet will be updated to show the results of the query in your free form sheet.

    b. Start by creating smart view analysis report.

    c. Create below report by zooming into the Year & Measures dimension.

    ![](./images/image14_26.png "")

12. You can directly enter Sales account member in place of Profit to visualize sales data across year without needing to perform member selection.

13. Click on the Profit cell, replace with Sales, hit and select refresh.

    ![](./images/image14_27.png "")


## **Step 4:** Install the Smart View Cube Designer Extension

1. On the ‘Smart View’ ribbon, select ‘Options’, and then ‘Extensions’.

    ![](./images/image14_38.png "")

2. Click the ‘Check for updates’ link. Smart View checks for all extensions that your administrator has made available to you.

    ![](./images/image14_39.png "")

3. Locate the extension named Oracle ‘Cube Designer’ and click ‘Install’ to start the installer.

4. Follow the prompts to install the extension.

5. Now, in the Essbase 21c web interface , click ‘Console’.

6. On the ‘Desktop Tools’ tab, to the right of Cube Designer Extension, click ‘Download’.

    ![](./images/image14_40.png "")

7. In the ‘CubeDesignerInstaller.svext’ dialog box, select ‘Save File’ and click ‘OK’. Save the file to a local directory.

    ![](./images/image14_41.png "")

8. Close all Microsoft Office applications and make sure Microsoft Office applications are not running in the background.

9. Double click the ‘CubeDesignerInstaller.svext’ file we downloaded to local directory.

10. Restart Microsoft Office applications.


## **Step 5:** Creating a Cube from Tabular Data in Cube Designer

This workflow uses two sample tabular data Excel files to demonstrate the concepts of intrinsic and forced-designation headers. See About [Design and Manage Cubes from Tabular Data](https://docs.oracle.com/en/database/other-databases/essbase/21/ugess/design-and-manage-cubes-tabular-data.html)


1.	In Excel, on the ‘Cube Designer’ ribbon, click ‘Catalog’.

2.	On the Essbase Files dialog box, under Catalog, go to ‘gallery/Technical/Table Format’ as shown below, then select a sample tabular data file: `Unstr_Hints.xlsx`.

 The table format workbook have Intrinsic headers that uses table.column format.
 ![](./images/image14_44.png "")

3.	Double click on the above directed file.  
 The table format workbook have Intrinsic headers that uses table.column format.

4.	On the `Cube Designer` ribbon, select `Transform Data`.

5.	On the `Transform Data` dialog box, enter an application and cube name, if you want to change the default names that are prepopulated.

    ![](./images/image14_45.png "")

6. The application name is based on the source file name without the extension and the cube name is based on the worksheet name.

    `Unstr_Hints.xlsx: Application name is Unstr_Hints and the cube name is SpendHistory`

7.	Click `Preview Data`. The workbook is sent to Essbase 21c for analysis and then you can verify the dimensions and their members. 

8.	When you are ready to create the cube, click `Run`.

9.	Once the job is finished, a pop-up will appear to view the job staus. If you want to see the job status, click `Yes`.

    ![](./images/image14_47.png "")

10.  The newly created application and cube are listed on the Applications home page in the user interface. Now the cube has been created from the tabular data, you can export the cube to an application workbook.

11.	On the `Cube Designer` ribbon, select `Private / Local`, then select `Export Cube to Application Workbook`

    ![](./images/image14_48.png "")

12.	On the `Export Cube to Application Workbook` dialog box, select the application and cube, and then select `Run`

    ![](./images/image14_49.png "")


* In this exercise, you saw how a normal flat file Excel sheet can be converted into an Essbase application and a cube. You can get the application workbook DBX (Design by Example) file in a matter of seconds with the dynamic capabilities of Essbase powered by the Cube Designer add-ins.

## **Step 6:** Overview of the WEB-User Interface

### Applications:
1. Applications tab gives us the information about the Essbase applications and their respective cubes.

    ![](./images/image14_53.png "")

2. By choosing the Inspect option for each application, you can see application specific logs, audit files, configuration files, etc.

    ![](./images/image14_54.png "")
    ![](./images/image14_55.png "")

3. You can access outlines and cube specific options by selecting Inspect for each cube.

    ![](./images/image14_56.png "")
    ![](./images/image14_57.png "")

4. Outline Analysis: The Outline option is equivalent to the EAS console in Essbase on-premises. This is where you can add new dimensions or members under dimensions at any level, as required, and can make changes to existing cubes quickly using the ‘Edit’ option. Select the ‘Outline’ option for the ‘SpendHistory’ cube. [or any cube that is already LIVE on the Essbase 21c web interface ].

    ![](./images/image14_58.png "")
    ![](./images/image14_59.png "")

5. Here, add a new child called ‘TotalA’ under the ‘Measures’ dimension as shown below. Let us now assign an ‘Ignore’ Consolidation operator to the ‘TotalA’ member. The operator defines how a new member rolls up across the hierarchy.

    ![](./images/image14_60.png "")

    ![](./images/image14_61.png "")

6. We now have to add a formula to this new member using the pencil icon under the ‘formula’ tab as shown. We will use **Spend + Invoice**;.
   
    


7. Once added, we need to verify the formula and then select Apply and Close.

    ![](./images/image14_62.png "")

8. You can also specify other options such as Data storage type and ‘Sort/Inspect’ of members in a dimension using the options in the web interface. 

    ![](./images/image14_63.png "")

### Jobs:

1. The Jobs tab displays all the information about the jobs that have been executed in the Essbase web user interface.  

You can create and run new jobs using this tab, as shown below.

    ![](./images/image14_64.png "")

1. Execute a Build Dimension job by selecting the application and cube. The ‘Script’ file is the rule[.rul] file where the dimension build script exists. Select the pre-existing ‘DimBuild.rul’ file and its corresponding ‘DimensionsCSV.txt’ pair as the Data File and execute the job.

    ![](./images/image14_65.png "")

2. You can see the status of the job in Essbase web interface once it is submitted. For more details about the job you can click on "Actions".

    ![](./images/image14_66.png "")

### Files:

1. The Files tab is equivalent to the file directory of Essbase. The "Applications" folder consists of  all the files related to applications and their respective cubes.

    ![](./images/image14_67.png "")

2. In the Files tab, you can upload the artifacts/files related to Essbase, such as script files, rule files, load files etc. from your local system directly into the cube using the ‘Upload Files’ option under the corresponding cube path. [In the image below, the application name is ‘Sample’ and the cube name is ‘Basic’].

    ![](./images/image14_68.png "")

3. The ‘Gallery’ folder on the ‘Files’ tab has industry wide sample templates in dbx format that are ready to use. They help you kickstart the process of building cubes related to that specific industry very quickly.

    ![](./images/image14_69.png "")
    ![](./images/image14_70.png "")

### Scenarios:

1. The ‘Scenarios’ tab is where you create scenario modeling on the applications for ‘What-If’ analysis, which empowers the users to analyze the data and get insights from the data. [More details on this will be covered in an upcoming lab. ]

### Security:

1. The ‘Security’ tab holds the information about the users in Essbase and the roles they’re assigned. You can change the level of access assigned to a particular user.

2. You can add new users/groups by clicking on the ‘Add Role’ option.

    ![](./images/image14_71.png "")

### Sources:

1. Many cube operations require connection information to access remote source data or hosts. You can define ‘Connections’ and ‘Datasources’ once and reuse them in various operations.
   
A connection stores login credentials required to access an external source. A Datasource points to an external source of information.

    ![](./images/image14_72.png "")

### Console:

1. The Console tab is one stop place for Essbase Administrator tools such as:

    *	Export Utility: Command-Line tool for exporting the outline of a cube and other related elements into a application workbook.
    *	LCM: Life-Cycle Management tool is used for backing up and restoring the Essbase artifacts.  
    *	Command-Line Tool: CLI utility for On-Premise Essbase platform.  
    *	Migration Utility: This utility is used for migrating Essbase artifacts  between Essbase instances and environments. This tab also contains the download links for Smart View and Cube Designer add-ins. Extensions and Essbase Client tools such as MaxL, Java API, and others are also available in the Desktop Tools section.

    ![](./images/image14_73.png "")

    * ‘Console’ tab also holds the information regarding session login by users, settings of the Essbase environment, email configuration settings etc.
    * The ‘Global configuration’ file of Essbase is available directly from the Essbase Web-user interface, here we can add new variable property settings with corresponding values using ‘Add’ option.

    ![](./images/image14_74.png "")


### Academy:

1. This tab contains all the information and documentation links related to Essbase 21c.

    ![](./images/image14_75.png "")

You may proceed to the next lab.

## Acknowledgements
* **Authors** -Sudip Bandyopadhyay, Manager, Analytics Platform Specialist Team, NA Technology
* **Contributors** - Eshna Sachar, Jyotsana Rawat, Kowshik Nittala, Venkata Anumayam
* **Last Updated By/Date** - Jyotsana Rawat, Solution Engineer, Analytics, NA Technology, March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-analytics-cloud). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
