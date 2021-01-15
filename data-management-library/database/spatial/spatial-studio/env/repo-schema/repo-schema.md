# Provision Spatial Studio using Cloud Marketplace

## Introduction

This lab walks though ....


Estimated Lab Time: n minutes

### About Product/Technology
Enter background information here..

### Objectives

In this lab, you will:
* .......

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default*

## **STEP 1**: Select Spatial Studio from Marketplace

Step 1 opening paragraph.

1. Create Spatial Studio repository schema. The schema can have any name, but for consistency with other labs we use the name **studio_repo**.
    ```
   <copy>CREATE USER studio_repo
   IDENTIFIED BY <password goes here>;</copy>
    ```

2. Assign default tablespace to Spatial Studio repository schema. If using Autonomous Database you can use tablespace name **data**. 
   
    ```
   <copy>ALTER USER studio_repo
   DEFAULT TABLESPACE <tablespace name here>;</copy>
    ```


    ![Image alt text](images/env-marketplace-1.png "Image title")




 





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

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
