# Title

## Introduction

This lab walks you through the process of optimizing the Oracle Autonomous Database created specifically for PeopleSoft.A Service Request needs to be created on My Oracle Support to have the most optimal application performance. 
 
Estimated Lab Time: 5 minutes


### Objectives


In this lab, you will:
* Create an SR with My Oracle Support for optmal performance of PeopleSoft system on ADB-S


### Prerequisties
* My Oracle Support (MOS) credentials. Please make sure that you can successfully login to [Oracle Support](https://support.oracle.com). 

## Task: Service Request creation for PeopleSoft on ADB-S

- Login to My Oracle Support and click on create technical SR
 
     - PRODUCT: **Autonomous Database on Shared Infrastructure** 
     * ABSTRACT/SUMMARY: **PSFT on ADBS: please set PeopleSoft DB identifier**
        
        * In the SR, please include:
           
           1. Region (Data Center location) 
           2. Tenancy name and OCID 
           3. Autonomous DB name and OCID 
           4. Request to set init.ora parameter: **\_unnest\_subquery=false** 

        
    * Support will then make the change for your environment(s).



You may now **proceed to the next lab.**



## Acknowledgments
* **Authors** - Deepak Kumar M, PeopleSoft Architect
* **Contributors** - Deepak Kumar M, PeopleSoft Architect
* **Last Updated By/Date** - Deepak Kumar M, PeopleSoft Architect, Aug 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.



