# Setup Environment

## Introduction
In this lab, you will run the scripts to setup the environment for the Oracle Database 21c workshop. 

Estimated Lab Time: 15 minutes

### About Product/Technology
Enter background information here..

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

*Use this section to describe any prerequisites, including Oracle Cloud accounts, set up requirements, etc.*

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default*

## **STEP 1**: title

1. Verify that your Oracle Database 21c `CDB21` and `PDB21` are created, that alias entries are either automatically or manually created in `/u01/app/oracle/homes/OraDB21Home1/network/admin/tnsnames.ora`
2. The sub-directory `OraDB21Home1` is the sub-directory mentioned in the file `/u01/app/oraInventory/ContentsXML/oraInventory`.
      ````
      <HOME_LIST>
      <HOME NAME="OraGrid210" LOC="/u01/app/21.0.0.0/grid" TYPE="O" IDX="1" CRS="true">
      <HOME NAME="<B>OraDB21000_home1</B>" LOC="/u01/app/oracle/product/21.0.0.0/dbhome_1" TYPE="O" IDX="2">
      </HOME_LIST>
      ````
3. Create an alias entry by copying the CDB alias entry, replace the CDB alias name with your PDB name, and the CDB service name with your PDB service name.
      ````
      cat /u01/app/oracle/homes/OraDB21Home1/network/admin/tnsnames.ora
      ````
4. Create an alias entry by copying the CDB alias entry, replace the CDB alias name with your PDB name, and the CDB service name with your PDB service name.



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
