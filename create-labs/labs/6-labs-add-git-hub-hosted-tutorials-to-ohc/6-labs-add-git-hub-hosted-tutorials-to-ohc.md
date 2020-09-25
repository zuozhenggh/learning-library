# Add GitHub Hosted Labs and Workshops to OHC

## Introduction
You need to add a link from your Oracle Help Center (OHC) page to a lab hosted on an Oracle GitHub repository. This lab details how to use Oracle Learning Library (OLL) administration tools to manage links and how to add a link to an OHC page.

### Objectives
* Create an OLL content entry for your lab.
* Create the Target URL for a Lab.
* Add the content entry link to OHC.

### What Do You Need?
* Required OLL privileges
* Required privileges to add your entry to OHC

This lab assumes that you have successfully completed the following labs in the **Contents** menu on the right:
+ **Lab 1: Get Started with Git and Install GitHub Environment**
+ **Lab 2: Understand the Templates Folder Structure**
+ **Lab 3: Use Atom Editor to Develop Content**
+ **Lab 4: Merge, Commit, Create Pull Request**

## **Step 1:** Create an Oracle Learning Library Content Entry for the Lab
Every GitHub-hosted lab that will be accessed from the Oracle Help Center must be registered as a content entry in the Oracle Learning Library (OLL).
You must have OLL administrator privileges to view and edit content entries in OLL.
1. Log in to the [OLL Home page] (https://apexapps.oracle.com/pls/apex/f?p=44785:1) using your Oracle SSO credentials.
2. From your *User ID* drop-down, click **Administration**.
3. Under **Maintenance**, click **Content**.
4. Click **Content Entries**.
5. Click **Create**.
6. Enter the **Content Entry Details**. A few entries are highlighted here:
  * Link: Enter the complete URL for the lab on GitHub, for example, https://oracle.github.io/learning-library/workshops/adwc4dev/?version=Self-Guided&page=L100.md.

  ![](./images/content-entry-link.png " ")
  * Type: Select **OBE**. (Older labs were called Oracle By Example or tutorials.)

## **Step 2:** Create the Target URL for a Lab

1. Log in to the [OLL Home page] (https://apexapps.oracle.com/pls/apex/f?p=44785:1) using your Oracle SSO credentials.
2. From your *User ID* drop-down, click **Administration**.
3. Under **Maintenance**, click **Content**.
4. Click **Content Entries**.
5. To find your the content entry for the lab, click on a header label in the table, click in the **Filter** field, begin typing what you're looking for, and then select the appropriate item.
6. Hover your mouse over the **Preview** icon.

  ![](./images/content-entry-preview.png " ")

  Look at the URL listed in the status bar at the bottom of the browser. Make a note of the CONTENT_ID, which is the 5-digit number before the final comma in the URL. For example, 28287. The content ID URL will be:
https://apexapps.oracle.com/pls/apex/f?p=44785:112:0::::P112_CONTENT_ID:28287

7. Save the URL, which you will use to create a link from an OHC page.


## **Step 3:** Add a Link to the Lab from Oracle Help Center
You need to work with your manager or Lead to get this link added to OHC.

**This concludes this lab. Please proceed to the next lab in the Contents menu on the right.**

## Want to Learn More?
* [Add GitHub Hosted Tutorials to OHC](https://confluence.oraclecorp.com/confluence/display/DBIDDP/Add+GitHub-Hosted+Tutorials+to+the+Oracle+Help+Center)

## Acknowledgements

* **Author:**
    +
*
* **Last Updated By/Date:** Anuradha Chepuri, September 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
