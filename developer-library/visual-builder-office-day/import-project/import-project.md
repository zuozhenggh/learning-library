# Add a Friends or Enemies table

## Introduction

This lab shows how you can add a table inside a Visual Builder Application

Estimated Time:  30 minutes

### Background

In a previous lab, you have created a visual builder installation and imported the base OfficeDay program that you will extend.

## Task 1: Create a business object

In this task, you'll create a business object (table) called Friends (or Enemies if you prefer)

1.  Click the **Business Object** ![Web Applications icon](./images/vbcsmd_webapp_icon.png) tab, click (+) to create a business objects. Enter "Friends" as teh business object name.

    ![](./images/friend-bo-create.png)

2.  In the Table's Properties, click Fields Tab, then (+) New Field. In the name, enter "username". Then Create.

    ![](./images/friend-bo-field-username.png)

3.  Still in the Field tab, click again (+) New Field. In the name, enter "name". Type "Reference". Then refer to the Business Object : "Users". Display Field "Name". Then Create.

    ![](./images/friend-bo-field-name.png)

## Task 2: Create a table

In this task, you will create the user interface

1.  Click Mobile Application. Then choose the page "user-custom"
2.  In the component filter, type "table", and drag and drop the table component in the middle of the page. 

    ![](./images/friend-table-component.png)

3. To add data to the table, click "Quick Start" then "Add Data"

    ![](./images/friend-table.png)

4. In the first page of the Wizard, choose the table Friend that you created

    ![](./images/friend-table-businessobject.png)

5. In the columns, choose "username". Open the tree, "nameobjects", then "items". Choose "image", "name".
   
   Modify the image column to the image type. Then next.

    ![](./images/friend-table-columns.png)

6. In the data, choose "filterCriterion". Add condition. Type it like in the screenshot. 
   
```
If username equals ($eq) $application.variables.username
```
Click Done. Then finish.

    ![](./images/friend-table-filter-criterion.png)

## Task 3: Add a Create Page 

A Create page lets you add new records to the table.

1.  In the same Quick Start menu than above, click **Add Create Page**.
2.  In the Wizard, choose the Friends business obejct.

    ![](./images/friend-create-wizard-bo.png)

2.  In the columns, choose the "name" and "username".

    ![](./images/friend-create-wizard-columns.png)

3.  When the page is created, go in live mode, click on the (+) to add a record. 

    ![](./images/friend-create-navigate.png)

4.  Before to add a real record, we need to set the default value of the username.

    Navigate to the **Variable tab**, then choose the variable "Friends", "username". And set the default value to 

```
[[ $application.variables.userProfile.username ]]
```
    You can simply choose this value in the dropdown menu.

    ![](./images/friend-create-username-default-value.png)

## Task 3: Add a Delete Button for the Department Business Object

Let's test.

1.  Press the preview button

2.  Go to your custom tab.

    Click (+) to add a new friend

    ![](./images/friend-preview-create.png) 

    Choose your friend. Then save. Do it 2 or 3 times.

    ![](./images/friend-preview-done.png)    

## Optional: cleanup

  3. Let's do some cleanup to make it prettier. Back to Visual Builder

    ![](./images/friend-cleanup-refresh.png)  

    First press on the refresh. Choose the table. Data. Remove the username columns.
    Click on the image and change the size to 64 x 64.  

    ![](./images/friend-cleanup-table2.png)    


## Acknowledgements

* **Author** - Marc Gueury
* **Last Updated By** - March 2022
