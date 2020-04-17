# Provision Autonomous Data Warehouse (ADW) 

## Introduction

This is the first of several labs that are part of the Predicting Flight Delays with Oracle Machine Learning & Autonomous Data Warehouse Cloud Service workshop. This lab walks you through the steps to get started using the Oracle Autonomous Data Warehouse (ADW) on Oracle Infrastructure Cloud (OCI). You will provision a new ADW instance during this lab. 


## Objectives
-   Learn how to provision a new Autonomous Data Warehouse (ADW) 
-   Learn how to creae Oracle Machine Leaning (OML) Notebook Users

## Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.


## Part 1. Provisioning an ADW Instance

-   Once you are logged in, you are taken to the OCI Console. Click **Create a data warehouse**

![](./images/100/Picture100-25.png) 

-  This will bring up the **Create Autonomous Data Warehouse** screen where you will specify the configurations of the instance. Select the root compartment, or another compartment of your choice.

![](./adw-provision/images/picture100-26.jpg)

-  Specify a memorable display name for the instance. Also specify your database's name (e.g. **ADW_FlightDelay**).

![](./adw-provision/images/picture100-27.jpeg)

-  Next, select the number of CPUs and storage size. Here, we will use **1 CPU** and **1 TB of storage**.

![](./adw-provision/images/picture100-28.jpeg)

-  Then, specify an **ADMIN password** for the instance.

![](./adw-provision/images/picture100-29.jpeg)

-  For this lab, we will select **Subscribe To A New Database License**. If your organization owns Oracle Database licenses already, you may bring those license to your cloud service.

![](./adw-provision/images/picture100-37.JPG)

-  Make sure everything is filled out correctly, then proceed to click on **Create Autonomous Data Warehouse**.

![](./adw-provision/images/picture100-31.jpeg)

-  Your instance will begin provisioning. Once the state goes from Provisioning to Available, click on your display name to see its details.

![](./adw-provision/images/picture100-32.jpeg)

-  You now have created your first Autonomous Data Warehouse instance. Have a look at your instance's details here including its name, database version, CPU count and storage size.

![](./adw-provision/images/picture100-33.jpeg)


## Part 2. Creating OML Users

- Click the **Service Console** button on your Autonomous Data Warehouse details page.

![](./adw-provision/images/picture100-34.jpeg)

- Click the **Administration** tab and click **Manage Oracle ML Users** to go to the OML user management page.

![](./adw-provision/images/picture100-35.jpeg)

This will open OML user Administration page as a new tab within your browser. 

-   Click **Create** button to create a new OML user. Note that this will also create a new database user with the same name. This newly created user will be able to use the OML notebook application. Note that you can also enter an email address to send an email confirmation to your user (*for this lab you can use your own personal email address*) when creating the user.

![](./adw-provision/images/picture700-5.png)

-   Enter the required information for new user (Username:**omluser1** and Password). If you supplied a valid **email address**, a welcome email should arrive within a few minutes to your Inbox. Click the **Create** button, in the top-right corner of the page, to create the user.

![](./adw-provision/images/picture700-7.png)

-   Below is a welcome email. It includes a direct link to the OML application for the user. 

![](./adw-provision/images/picture700-8.png)

-   After you click **Create**, you can find the user on the list of Users. 

![](./adw-provision/images/picture700-9.png)

-   Using the same steps, create another user named **omluser2**.

![](./adw-provision/images/picture700-10.png)

You will use **omluser1** later in this workshop. 

