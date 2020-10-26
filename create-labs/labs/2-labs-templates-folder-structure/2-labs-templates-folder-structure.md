# Understand the learning-library Folder Structure

## Introduction
This lab describes the prescribed folder structure that we need follow for developing labs and workshops.
### Objectives
* Understand the learning-library folder structure.
* Get to know the components of the workshop and the lab folders.

## **STEP 1:** Folder Structure of the learning-library Repository

The following image shows a folder structure of the "Getting Started with Oracle Big Data Service" workshop. You can see this structure at the following URL [https://github.com/oracle/learning-library/tree/master/data-management-library/big-data/bds](https://github.com/oracle/learning-library/tree/master/data-management-library/big-data/bds), or in the data-management-library/big-data/bds folder of the clone on your machine.
    ![](./images/temp-folder-structure-example1.png " ")

## **STEP 2:** Understand the Components of the Workshop and Lab Folders
  The following describes the components of the above example:
  * The root folder of this example is the name of the workshop, **bds**.
  * Each lab has a separate folder, for example, `bds-create-cluster.md` and `bds-create-hadoop-user.md`.
  * Each lab folder has an **images** folder that contains the screenshots that are used in the lab.
  * The **bds-quickstart-workshop** is the workshop folder, which contains the `index.html`, `intro.md`, `manifest.json`, and `README.md` file.
  * The `index.html` file is executed when it is accessed by a browser.
  * The `intro.md` file contains the introduction of the workshop.
  * The `manifest.json` file defines the structure of the workshop that the `index.html` file renders.
  * The `README.md` file contains the summary of the entire Workshop. You can view it from your git repository.
    ![](./images/temp-folder-structure-manifest-json.png " ")

**This concludes this lab. Please proceed to the next lab in the Contents menu.**

## Want to Learn More?

* [How to Use the GitHub Template](https://otube.oracle.com/media/Use+GitHub+Template/0_780dlc2i)


## Acknowledgements

* **Author:**
    * Anuradha Chepuri, Principal User Assistance Developer, Oracle GoldenGate
* **Contributors:**
    * Lauran Serhal, Principal User Assistance Developer, Oracle Database and Big Data User Assistance

* **Reviewed by:**  
    * Aslam Khan, Senior User Assistance Manager, ODI, OGG, EDQ
    * Tom McGinn, Database and Database Cloud Service Senior Principal Product Manager, DB Development - Documentation

* **Last Updated By/Date:** Anuradha Chepuri, October 2020

## Need Help?  
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
