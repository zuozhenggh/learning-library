# Introduction

## About this workshop

This workshop is an extension of a previous workshop. It showcases the use of enabling an OCI service, DataSafe, to extend your EBS environment.

Data Safe is a cloud-based monitoring tool that allows users to assess, monitor, audit, and mask data and activity from on-premises or cloud-native databases. Database Administrators, or others whose concern includes database security, can use Data Safe to monitor and manage sensitive data on multiple environments and keeps tabs on the accessibility and activities of the database. 

This workshop walks you through the setup of Data Safe on a private database provisioned by the EBS Cloud Manager. You will be configuring network settings and creating a user on the database with the appropriate permissions to setup a connection to Data Safe. Then the workshop provides a short walkthrough of the features of Data Safe. 

This workshop assumes you have completed the **Lift and Shift On-Premises EBS to OCI Workshop** found [here](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=672&clear=180&session=5980193088668). It also assumes you have created an EBS environment through advanced provisioning with a Virtual Machine Database System. 

In order to complete this lab you will need the resources created in the [Lift and Shift On-Premises EBS to OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=672&clear=180&session=5980193088668)

Estimated Workshop Time: 1 hour

### **Background**

This lab will leverage the EBS Cloud Manager and affiliated EBS Instances created in the main section of the EBS Lift and Shift Lab. We will now work to incorporate further use of OCI services to enhance our environment

Notes:

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.

### Workshop Overview

* Using the pre-existing EBS environment we will first enable OCI Datasafe and configure the private endpoint for connection to our databases. 

* Next, we will configure a database user as the Data Safe Admin.

* Lastly, we will add the database as a target on the Data Safe console and begin using Data Safe.

This workshop uses the following components: 

* Data Safe Service from OCI

* Virtual Cloud Network and related resources.
    - User-generated using Resource Manager and provided Terraform script.

* Oracle E-Business Suite Cloud Manager and created EBS instances

### Workshop Architecture

* We will build on top of the architecture created in the EBS Lift and Shift On-Premises EBS to OCI as seen in Figure W-1 below

![](./images/architecture.png " ")

### **Prerequisites**

* Complete Workshop: [Lift and Shift On-Premises EBS to OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=672&clear=180&session=5980193088668)
* DataSafe requires Advanced Provisioned EBS instance with a Private VM Database

**From the previous labs:**

* The IP addresses and SSH path of the instances in your environment

## Acknowledgements

* **Author:** Quintin Hill, William Masdon, Cloud Engineering
* **Contributors:** Santiago Bastidas, Product Management Director
* **Last Updated By/Date:** William Masdon, Cloud Engineering, Mar 2021

### Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/ebs-on-oci-automation). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 
