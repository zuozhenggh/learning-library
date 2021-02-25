# Extend EBS with OCI Services (DataSafe Logging Analytics)

## About this workshop

This 2-part workshop is an extension of previous workshop. It showcases the use of enabling OCI services: DataSafe and Logging Analytics to extend your EBS environment

Estimated Workshop Time: 1.5 hours

### **Access this workshop**:
[**Extend EBS with OCI Services**]()

Estimated Workshop Time: 1.5 hours
    Note: This does not include downtime for creating the backup, which lasts about 2.5 hours. 

### **Background**

This lab will leverage the EBS Cloud Manager and affiliated EBS Instances created in the main section of the EBS Lift and Shift Lab. We will now work to incorporate further use of OCI services to enhance our environment

Notes:

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.

### Workshop Overview

* Using the pre-existing EBS environment we will first connect OCI Datasafe for audit and mask sensitive datapoints

* Next we will enable Logging Analytics to monitor and manage our technological footprint

This workshop uses the following components:

* Trial accounts (one per attendee).

* Logging Analytics Service from OCI

* DataSafe Service from OCI

* Virtual Cloud Network and related resources.
    - User-generated using Resource Manager and provided Terraform script.

* Oracle E-Business Suite Cloud Manager and created EBS instances

### The following figure (W-1) describes the architecture you will create in this workshop.
Figure W-1: 

![](./images/w-1.png " ")

### Objectives

In this lab, you will:
* Enable DataSafe
* Enable Logging Analytics

### **Prerequisites**

* DataSafe requires advanced Provisioned EBS instance

**From the previous labs:**

* The IP addresses and SSH path of the instances in your environment

### Acknowledgements

* **Author:** Quintin Hill, William Masdon, Cloud Engineering
* **Contributors:** Santiago Bastidas, Product Management Director
* **Last Updated By/Date:** Quintin Hill, Cloud Engineering, Feb 2021

### Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/ebs-on-oci-automation). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 