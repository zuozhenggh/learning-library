# Visualize the Data in OAC

## Introduction

This lab walks you through the steps to visualize and analyze the extracted data of the reviews using Oracle Analytics Cloud.

Estimated Lab Time: 90 minutes

### Objectives

In this lab, you will:
* Create a Connection to Autonomous Data warehouse
* Create a new Dataset
* Create a Workbook/Project

### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


## Task 1: Create a Connection to Autonomous Data warehouse


1.	Sign into Oracle Analytics Cloud.
2.	Click the Create Dataset icon. (Or you can navigate to Data > Create > Connection)
3.	Select Create Connection, and select Oracle Autonomous Data Warehouse
4.	Enter the credentials to the data warehouse (target database) you created in Section 8. If you need a reminder on how to get the wallet, see Download a Wallet.

![](./images/introduction.png " ")


## Task 2: Create a new Dataset

1.	Navigate to Data> Create > Create a New Dataset
2.	Select the data warehouse you just created.
3.	Drag the 3 tables from the USER1 data base that you just populated into the canvas:
REVIEWS, SENTIMENT and ENTITIES
4.	Drag them on top of each other. This will automatically create some JOINS.
5.	Modify the JOINS so that they join on RECORD_ID.
You may get a warning that doing so will treat record-id as an attribute (instead of a numeric value) – that’s ok. That’s what we want.

![](./images/introduction.png " ")

6.	Save your dataset.



## Task 3: Create a Workbook/Project

In this task we'll create and configure your target Autonomous Data Warehouse database to add a schema and a table.

1.	1.	Click Create > Workbook . This will take you to a wizard that will ask you to select a dataset.
2.	Add the dataset you just created. Click Add to Workbook.
3.	Navigate to visualizations tab, and drag  a stacked bar visualization into the canvas.
4.	Navigate to the data tab.
5.	Open the contextual menu (Right click) on the My calculations table and select Add Calculation…
a.	For Name select COUNT OF SENTIMENT
b.	For the function enter COUNT(SENTIMENT)
6.	Drag COUNT OF SENTIMENT int the Value (Y-Axis) of the visualization.
7.	For the Category (X-Axis), select REVIEWS>REVIEW_DATE>Quarter
Right click on the REVIEW_DATE field in Category (X-Axis) and select Show by… Quarter.
8.	For the Color, select Sentiment.
9.	Right Click on the bars show, and click Color > Manage Assignments
10.	Set Negative to Red, and Positive to Green.

![](./images/introduction.png " ")

11.	Follow the same pattern and customize your canvas to meet your needs. You can try different visualizations. For our example below, we used a word cloud to visualize the top aspects being mentioned, and a table to visualize the reviews that mentioned the aspect of interest.

![](./images/introduction.png " ")


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
