# Create a Pipeline and publish tasks

## Introduction

This lab will walk you through the steps to create an application, publish tasks and pipeline.

Estimated Lab Time: 30 minutes

## Objectives
In this lab, you will:
* Create an Application
* Publish the Integration task and Data Loader task into the Application
* Creating Pipelines and calling the published Tasks
* Creating a Pipeline Task
* Publish the Pipeline Task

## Prerequisites
* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported
* You completed Lab 0, Lab 1, Lab 2, Lab 3 of this LiveLabs Workshop

## **STEP 1:** Create an Application

In OCI Data Integration, an Application is a container for published tasks, data flows, and their dependencies. You can run published tasks in an Application for testing, or roll them out into production.
1. In the Oracle Cloud Infrastructure Console navigation menu, navigate to **Analytics & AI**. Under Big Data, click **Data Integration**.
![](./images/menu_di.png " ")

2. From the Workspaces page, make sure that you are in the compartment you created for data integration (DI-compartment). Click on your **Workspace** (DI-workspace).
![](./images/workspaces-click.png " ")

3. On the workspace Home page, in the Quick Actions tile, click Create Application.
![](./images/create-app-tile.png " ")

4. On the Applications page, enter "Workshop Application" for Name. You can optionally give a short description for your application, then click Create.
create-app

5. The Application Details page for "Workshop Application" opens in a new tab.
my-app

## **STEP 2:** Publish the Integration task and Data Loader task into the Application

Step 1 opening paragraph.

1. From the Application Details you are currently in, click on Open tab (plus icon) in the tab bar and select Projects.
tab-projects

2. Select your DI_Workshop project from the projects list.
di-workshop

3. In the Tasks list, from the Actions icon (three dots) for Load Customers Lab, select Publish to Application.
In the Publish to Application dialog, select Lab Application.
Click Publish.
You can modify the task or edit its data flow without impacting the published task. This enables you to test a version of your data flow, while working on some new changes.

You can now go to Lab Application to run your published task.

## **STEP 3:** Create a Pipeline
A pipeline is a design-time resource in Data Integration for connecting a set of tasks and activities in a sequence from start to finish.

1. On the workspace home page, from the Quick Actions tile, select Create Pipeline.
Alternatively, you can navigate to a project or folder and then click Create Pipeline from the Pipelines section of the project or folder details page.

2. Under the Details tab of the Properties panel for the pipeline, enter a Name and Description (optional).

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

*At the conclusion of the lab add this statement:*
You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.
