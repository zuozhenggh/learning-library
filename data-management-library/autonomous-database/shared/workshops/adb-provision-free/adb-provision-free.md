
<!-- Updated March 24, 2020 -->

# Provisioning Autonomous Database (ADW and ATP)


## Introduction

This lab walks you through the steps to get started using the Oracle Autonomous Database (Autonomous Data Warehouse [ADW] and Autonomous Transaction Processing [ATP]) on Oracle Cloud. You will provision a new ADW instance and connect to the database using Oracle SQL Developer Web.

*Note: While this lab uses ADW, the steps are identical for creating and connecting to an ATP database.*

### Objectives

-   Learn how to provision a new Autonomous Data Warehouse

### Required Artifacts

The following lab requires an Oracle Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, a Free Tier account, or a training account whose details were given to you by an Oracle instructor.

### Lab Prerequisites

This lab assumes you have completed the [Log in to Oracle Cloud] (?lab=lab-1-login-oracle-cloud) lab.

### Video Preview

Watch a video demonstration of provisioning a new autonomous data warehouse:

[](youtube:Q6hxMaAPghI)

## STEP 1: Cloud Login and Services Menu

1. Login to the Oracle Cloud
2. Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

    __Note:__ You can also directly access your Autonomous Data Warehouse or Autonomous Transaction Processing service in the __Quick Actions__ section of the dashboard.

    ![](./images/Picture100-36.png " ")

3. Click **Autonomous Data Warehouse**.

    ![](images/LabGuide1-39fb4a5b.png " ")

4. Make sure your workload type is __Data Warehouse__ or __All__ to see your Autonomous Data Warehouse instances. You can use the __List Scope__ drop-down menu to select a compartment. Select your __root compartment__, or __another compartment of your choice__ where you will create your new ADW instance. If you want to create a new compartment or learn more about them, click <a href="https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm#three" target="_blank">here</a>.

 __Note__ - Avoid the use of the ManagedCompartmentforPaaS compartment as this is an Oracle default used for Oracle Platform Services.

5. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the state of the databases (available, stopped, terminated, and so on). You can also sort by __Workload Type__. Here, the __Data Warehouse__ workload type is selected.

    ![](./images/Compartment.png " ")

7. You can see your current default **region** in the top, right hand corner of the page. Go ahead and select a different available region such as **Phoenix** or **Toronto**.

    ![](./images/Region.png " ")

## STEP 2: Creating the ADB instance

1. Refer to [Create ADB instance Lab](../adb-create-adb-instance/adb-create-adb-instance.md)

Please proceed to the next lab.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Managemnt
- **Last Updated By/Date** - Richard Green, DB Docs Team, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 
