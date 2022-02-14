# Design Data Flows in OCI Data Integration

## Introduction

This lab walks you through the steps to create the components necessary to create a data flow like the one shown in the graph below. In order to create source and target components, first we need to create a set of “data assets”. The data assets represent each of the elements in the diagram. We’ll start by creating the data asset for the source, and then the target.

Estimated Lab Time: 90 minutes

### Objectives

In this lab, you will:
* Create a data asset for your source and staging data
* Create a data asset for your target
* Create the Data flow.
* Run the Data flow

![](./images/introduction.png " ")

### Prerequisites

This lab assumes you have:
* All previous labs successfully completed
* You have the rights to use OCI Data Integration. Below are steps to check your access:
    - Work with you administrator to create the policies that will allow you to use the data integration service and grant your DI workspace the ability to read data from storage buckets. Follow the setup steps that are described at [Connect to Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/tutorial/tutorials/01-connecting-to-dis.htm#getting-workspace-ocid)
		- Wait until your DI workspace is created. The process will take about 10 minutes.
		- Keep the “Enable private network” selected.
		- Make sure that the subnet you select is indeed your private subnet.
		- From the Console, click **Analytics & AI** > **Data Integration**.
		- Identify the workspace you created and ensure it is already in the **Active** state.



## Task 1: Create a data asset for your source and staging data

1.	From the Console, click **Analytics & AI** > **Data Integration**, and navigate to the workspace you just created.

2.	On your workspace Home page, click **Create Data Asset** from the Quick Actions tile.

3.	On the **Create Data Asset** page, complete the General Information fields:
				-   For **Name**, enter reviews-data-source without any spaces. You can use alphanumeric characters, hyphens, periods, and underscores only.
				-   For **Description**, enter a description about your data asset.
				-   From the **Type** dropdown, select **Oracle Object Storage**.
				-   For **Tenant OCID**, enter the tenancy OCID. If needed, you can navigate to your tenancy information from the Profile icon on the top right corner of your cloud console.
				-   For **OCI region**, you can copy the code that is shown in the url for instance “us-phoenix-1”

4.	Test the connection and **Create** the data asset.

Repeat the same steps for your “staging” bucket location (if it is different). Currently the name of the data asset for the staging location needs to be capitalized.


## Task 2: Create a data asset for your target

In Data Integration, we need to create a data asset for the data warehouse we just created. Once we transform, enrich and analyze your data, we will save the structured data to a set of tables in the autonomous data warehouse.

1.	In the Oracle Cloud Infrastructure Console navigation menu, go to **Analytics & AI**, then select **Data Integration**.

2.	Navigate to the compartment where you created the workspace and select your workspace.

3.	On your workspace **Home** page, click **Create Data Asset** from the **Quick Actions** tile.
You can also click **Open** tab (plus icon) in the tab bar and select **Data Assets**, then click **Create Data Asset**.

4.	On the **Create Data Asset** page, for **General Information**, set the following:
- **Name**: Data_Warehouse (You can use alphanumeric characters, hyphens, periods, and underscores only).
- **Identifier**: Auto-generated based on the value you enter for Name. You can change the auto-generated value, but after you save the data asset, you cannot update the identifier again.
- **Description**: Optional
- **Type**: Oracle Autonomous Data Warehouse
- **Wallet File**: Drag and drop or browse to select the wallet file. See [Download a Wallet](https://docs.oracle.com/en-us/iaas/Content/Database/Tasks/adbconnecting.htm#access)
- **Service Name**: Service level to connect to your Autonomous Data Warehouse database

5.	In the **Connection** section, enter the following:
		- **Name**: Default connection (Optionally, you can rename the connection)
		- **Description**:  Optional (For example, Connect with BETA user)
		- **User Name**: USER1
		- **Password**: The password you created for USER1
6.	Click **Test Connection** to verify that you can connect to the data warehouse using the credentials you just provided.
7.	Assuming your test was successful, click **Create**.

## Task 3: Create the Data flow

To create a data flow, first you need to create a project in Data Integration. To create a project and a data flow:

1.	On your workspace Home page, click Projects. You can also click Open tab (plus icon) in the tab bar and select Projects.
2.	On the Projects page, click Create Project.
3.	On the Create Project page, enter “language-lab” for Name, and then click Create.

Now we will create a data flow to ingest data the hotels review file we just ingested.
4.	On the language-lab project details page, click Data Flows in the submenu on the left.
5.	Click Create Data Flow. The data flow designer opens in a new tab.
6.	In the Properties panel, for Name, enter lab-data-flow, and click Create.
The designer remains open for you to continue editing.
Add a data source:
7.	Add a Source by dragging the “Source” icon into the data flow workspace area. Select the source you just added and navigate to the Details tab in the Properties pane.

8.	Fill the properties as follows:
Enter HOTEL_REVIEWS_CSV as the identifier. Enter the following fields:
In Details, select the source asset your created (data-lake)
Connection: Keep “Default connection”
In Schema, select the bucket with the hotel reviews file.
In Data Entity select the hotels review data file and enter CSV as the File Type.

9.	You can confirm that you loaded the data correctly by going to the Data section. It takes a minute or two for the data to appear there.

![](./images/introduction.png " ")


10.	First, we will add an expression to change the format of our review_id field.
Right click on the 3 vertical dots next to the <data source name>.review_id field  and select Change Data Type. Call it REVIEW_ID.  Select Integer as the Data Type and click Apply.
This will create a new expression step in your dataflow.

11.	Now we will perform a second transformation.  We will make sure that the date is treated as a Date. Start by navigating to the Data tab in the Properties pane while selecting the Expression.

12.	Right click on the 3 vertical dots next to the <data source name>.review_date field and select Change Data Type. Select Data Type Date and the Date Format that matches the CSV format (in this case yyyy-MM-dd). Set the Name to REVIEW_DATE.

13.	Clicking on the Data tab of the expression will allow you to see the newly created fields.

![](./images/introduction.png " ")


Now we will connect the function you created in section 5 to extract the aspect level sentiment from the review text.
14.	From the operators toolbar, drag the Function (fn) operator into the canvas, and connect the output of your expression as the input into the function.

![](./images/introduction.png " ")

15.	Select the function you just added, in the Properties pane, navigate to the Details Pane.
change the identifier to: SENTIMENT_FUNCTION

16.	Click the Select button to select the OCI Function. Select the application you created earlier in section 5 and pick the “sentiment” OCI Function.
Click OK to confirm your changes.

17.	Now you will need to add or edit the properties below. Except for the BATCH_SIZE property (which you can edit), you can do this by clicking the Add Property button for each field.

| Name | Type | Data Type | LENGTH | Value |
| --- | --- | --- |
| 1 | Some text or a link | More text  |
| 2 |Some text or a link | More text |
| 3 | Some text or a link | More text |

![](./images/introduction.png " ")

18.	Once you are done, navigate to the Map tab, and map the review field from the source attributes into the info field Function Input. You do this by “dragging” review in the left table into the info field.

![](./images/introduction.png " ")

Now we will map the output of the sentiment analysis to the Data Warehouse Table we created for this purpose:
19.	From the operator’s toolbar, drag the Target operator into the canvas, and connect the output of your sentiment function as the input into the target operator.

20.	In the details properties tab for the target, set the following fields:
Identifier: TARGET_SENTIMENT
Integration Strategy: Insert
Data Asset: Select the data warehouse asset you created in Section 8.
Connection: Default connection
Schema: USER1
Data Entity: SENTIMENT

For staging Location you just need to provide an object storage location where intermediate files can be created during the data flow:
Data Asset: DATA_STAGING
Connection: Default connection
In Schema, select the object storage location that you want to use for staging purposes.

21.	Now we need to do a mapping exercise again, mapping the output of the function to the right fields in the target database table.

Make sure the fields are mapped as follows:

![](./images/introduction.png " ")



22.	Homework for you: Using the principles you just learned, follow a similar set of steps for the entities function, and route the output to the ENTITIES table you created. Once you have completed your data flow, make sure to save it.

When you are done with your data flow it will look something like this:

![](./images/introduction.png " ")

## Task 3: Run the Data Flow

Now we need to execute the data flow. The process is as follows.

1.	Navigate back to your workspace and click Create Integration Task in the Quick Actions menu.
As part of the process of creation you need to select the project and the data flow you just created in Step 8.

2.	Go to your data integration workspace and select the Applications link. Then click Create an Application. Give it a name and click Create.

3.	Navigate back to the data integration workspace. Click on the Projects link in the workspace and selecting the project you created in Step 8.

4.	Click on the Tasks link in the Details menu, select the contextual menu for the task you just created, and click “Publish to Application”. Select the application you just created.

 ![](./images/introduction.png " ")

5.	Navigate back to the application you just created, select your integration task, and select Run on the contextual menu as shown below.

![](./images/introduction.png " ")


You will navigate to the Runs page where you will be able to monitor the execution of your integration task run. If there are any errors, make sure to check the logs to understand the cause of the run error.

![](./images/introduction.png " ")


6.	Assuming everything ran successfully, we can now navigate to our database and see if our tables got populated with the insights extracted from the reviews.

![](./images/introduction.png " ")


1. Sub step 1 - tables sample

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
