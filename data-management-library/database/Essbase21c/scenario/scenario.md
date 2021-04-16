# Scenario Management

## Introduction

Using scenario management, scenario participants can perform what-if analysis to model data in their own private work areas. These scenarios can optionally be subject to an approval workflow, which includes a scenario owner and one or more approvers. In the workflow, scenario owners merge scenario data with the final cube data only after it is approved.

Estimated Lab Time: *30 minutes*.

### Objectives

To understand the following:

*	Scenario Management Overview
*	Creating a cube with Sandboxes
*	Creating a Scenario
*	Lightweight Sandboxes		
*	Changing Sandbox Data
*	Scenario Workflow

### Prerequisites

* Essbase 21 instance with Service administrator role.
* Windows Operating System for Essbase add-ins (Smart View and Cube Designer).
* Smart View plugin enabled for Excel.

## Overview – Understand Scenario

The exercises contained within this lesson will allow the user to get acquainted with different aspects of Scenario Management.  The different aspects include the lightweight nature of sandboxes on the cube; the process involved with initiating Scenario Management and adding sandboxes; as well as, the workflow supported by Scenario Management.  

*	Scenarios are private work areas in which users can model different assumptions within the data and see the effect on aggregated results, without affecting the existing data.

*	Each scenario is a virtual slice of a cube in which one or more users can model data and then commit or discard the changes.

*	The sandbox dimension is flat, with one member called Base and up to 1000 other members, commonly referred to as sandbox members. Sandbox members are named sb0, sb1, and so on.

*	Each sandbox is a separate work area, whereas the Base holds the data currently contained in the cube. A specific scenario is associated with exactly one sandbox member.

*	When first created, sandbox member intersections are all virtual and have no physical storage.

## **Step 1:**	Create a Scenario-Enabled Sample Cube

You can create a scenario-enabled cube by importing the scenario-enabled sample application workbook.

1. Download the worksheet SandboxApp.xlsx [here](./files/SandboxApp.xlsx).

   Open the SandboxApp.xlsx file.

2. Change the Application name (sheet Essbase.Cube) to Sample_Scenario.

3.	Navigate to the Cube.Settings sheet and check the properties section and the Scenario Sandboxes properties.

    ![](./images/imageSM_01.png "")

4. Save your file as SandboxApp.xlsx and create a new cube with the help of **Lab6->Step1**. Make sure to check that Load Data option is selected under Advanced Option.

    ![](./images/imageSM_02.png "")

## **Step 2:** Lightweight Sandboxes

**Show that Sandboxes are lightweight**  

This Step shows that creating sandboxes has little impact on resource usage such as disk space.

1. Download SmartView.xlsx file [here](./files/SmartView.xlsx).
   
   Open SmartView.xlsx  and go to sheet1 tab.
   ![](./images/imageSM_03.png "")

2. Go to the smartview, Create a private connection to Essbase: http://IP:9000/essbase/smartview.

   Login and Select the “Sample_Scenario” Application and “Sandbx” Cube.
   
   In order to query the selected Cube, choose the option -> “Set Active Connection for this Worksheet”.

3. Refresh the data.
   ![](./images/imageSM_04.png "")

   **Note:**

   By default, all Sandboxes you create have the same values as the data loaded into the base. The data in the sandbox is dynamically queried and will not use any extra storage disk space. Only values that are modified as part of a scenario will be stored. This makes creating and using most scenarios a very light weight operation.  

## **Step 3:** Scenario Management
This Step is geared towards developing an understanding of security for Essbase and also the workflow aspects of Scenario Management.  In addition, you will create a couple of calculation scripts and leverage run-time substitution variables from within Smart View.

1. Add Users:   
   Go to security tab to add Users
   
   a) Under Users tab, click on Add user
   ![](./images/imageSM_05.png "")
   
   b) Provide the details for adding user: "Frank"
     * Id: Frank
     * Role: user
     * Password: password
    ![](./images/imageSM_06.png "")

   c) Repeat above steps for adding George, William and Susan.
    ![](./images/imageSM_07.png "")

2.	Defining Security:  

    We will define security roles for several people to be used throughout the next several exercises. Once the security is defined validate the privileges by logging in as each user and pay attention to the differences from user to user.
    
   a) On the home page, navigate to the “Sample_Scenario” Application. Launch the application inspector by clicking the button under Actions and selecting Inspect.
   ![](./images/imageSM_08.png "")

   b) On the application inspector, click the Permissions tab. Click the + icon on this page to add users to this application.
   ![](./images/imageSM_09.png "")

   c) Search for Frank, Susan, George & William and click the + icon next to their ids to add the to the application.

   d) by default all users have the Database Access Roles.

   e) Assign the following roles to the new ids added and Click Close:
      * Frank -> Database Manager
      * George -> Database Update
      * William -> Database Update
      * Susan -> Database Update

    f) Go to Smartview and disconnect from the current connection.

    g) Open the Smart View.xlsx file and go to the Sheet3 tab.

    h) Connect as Frank, William and Susan drilling down and up on the Sandbox dimension for each user. 

       **Note: To easily switch between users – select Disconnect All from the SmartView Panel and then re-log in**


3. Creating Scenarios:
   
   In this exercise you log in as Susan creating a new scenario defining William as a participant.  Validate the impact of the security changes for each user Frank, Susan, William and George.  Without logging out from Smart View, make George a Scenario Approver, then refresh the data in Smart View validate the change to his security.
    
   a) Go to the Web UI, logging in as Susan.

   b) Navigate to Scenarios tab. Click Create Scenario button.

   c) Give the scenario a name:**What-If** and a due date. Add William as a Participant by selecting the Users tab and click the + icon. By default a user is added as a Participant. 
      
      Click Save.

   d) Identify which sandbox member your scenario is using by clicking on the name of the scenario once it is created.

   e) Go back to Smart View.

   f) Go to Excel and on the Sheet3 tab connect as Frank, William, and Susan drilling down and up on the Sandbox dimension for each user.

   g) Go to the Web UI, logging in as Susan and assign George the approver role to the sandbox.

   h) Go to Smart View and connect as George drilling down on the Sandbox dimension.


4. Changing Sandbox Data:
   As William, you will change some data for the scenario that was just created and, using the Essbase Web UI shows the differences between Base and the scenario.

   a) Go to Excel and in the Smart View.xlsx 

   b) Go to the DataSheet tab and connect to the database as William, ensure the the POV has the correct sandbox member identified in the previous exercise

   c) Go to the cell C12 enter a number then click submit (the intersection updates should be  XXU->FYQ4-FY2015->Automotive->ORCL USA).

   d) Go to Essbase Web UI, navigate to the Scenarios tab and filter for “Sandbx” database under WkrShpL<Student ID> application. Select the scenario What-if01 and click the Actions icon.

   e) Click on the icon in the Show Changes column, to show the changes in the UI.

5. Calculations in a Sandbox: 
Create a calculation script that will create data for ORCL USA->XXU->Automotive in 2016 by increasing 2014 data by 15%.

   a) Login to Essbase Web UI as Frank.

   b) Navigate to the database inspector for the “Sandbx” database under the “WrkShpL<Student ID>” application.

   c) Click on the Scripts tab on the database inspector and select Calculation Scripts from the left navigation menu.

   d) Click the + icon on the right to create a calculation script. Name the script as Feed16, type the below content in the scripts section (code can also be found in the Seed_16.csc file):


    ```
    <copy>        
    set updatecalc off;
    SET CREATENONMISSINGBLK ON;
    Fix("XXU","Automotive","[USA].[ORCL US].[ORCL USA]", @Children(FY2016), "sb1")
    "CD" (@Prior(Base, 8, @LevMbrs(Time,0)) * 1.15;)
    "USD" (@Prior(Base, 8, @LevMbrs(Time,0)) * 1.15;)
    EndFix

	</copy>
    ````

   e) Validate the script.
 
   f) Save and Close the script.

   g) To execute the script, navigate to the Jobs tab and create a new job by clicking New Job -> Run Calculation.

   h) Select the Application and database and the calc script that was just created. For Variables select the “sb1” as Value for the sandbox variable.

   i) Click OK.

   f) Click refresh icon, to see the job status.

   g) Go to Smart View and retrieve data into the DataSheet tab. Also review the comparison tab.

   i) Go to Essbase Web UI as William, Navigate to the Scenarios tab. Filter for WrkShpL<Student ID>.Sandbx database. Click on the icon under Actions and select Show Changes, to show the changes in the UI

1. Scenario Workflow:
   
   At this point two things happened with our Sandbox. William entered some data using Smart View and Frank run a calc script that created some data for 2016. Now we will use the Scenario workflow to submit and ultimately merge the scenario data with the base. The flow that we will simulate is:

   * Susan is submitting the data for approval
   * William can review the data and decides to approve
   * Once Susan sees that william approve, she can apply the data to the Base


   Since you are doing it by yourself, you will need to play both Susan and George. If you have two different browsers (e.g. Firefox and Chrome) you can log in as each participant in a different browser and jump between the two personas. The instructions will assume that you are using the same browser for both (and therefore logout and login will be needed).

   Let’s start:

   a) Login to Essbase Web UI as Susan. Navigate to the Scenarios tab and filter for Database as “Sandbx” and application as “WrkShpL<Student ID>” and select Scenario What-if01.

   b) Under Actions, click the “->” icon to Submit, enter a comment if needed. The status should now be submitted.

   c) Go to Smart View and retrieve data into the Comparison tab.

   d) Go to the Web UI logging in as William. Navigate to the Scenarios tab and filter for Database as “Sandbx” and application as “WrkShpL<Student ID>” and select Scenario What-if01.

   e) Under Actions, click the   icon to Approve, enter a comment if needed.

   f) Go to Smart View and retrieve data into the Comparison tab.

   g) Login to Essbase Web UI as Susan. Navigate to the Scenarios tab and filter for Database as “Sandbx” and application as “WrkShpL<Student ID>” and select Scenario What-if01.

   h) Under Actions, click the   icon to Apply sandbox “sb1” to the Base, enter a comment if needed.

   i) Go to Smart View and retrieve data into the Comparison tab



## Acknowledgements
* **Authors** -Sudip Bandyopadhyay, Manager, Analytics Platform Specialist Team, NA Technology
* **Contributors** - Eshna Sachar, Jyotsana Rawat, Kowshik Nittala, Venkata Anumayam
* **Last Updated By/Date** - Jyotsana Rawat, Solution Engineer, Analytics, NA Technology, March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-analytics-cloud). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
