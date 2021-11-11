# Set Up a Fleet

## Introduction

This lab walks you through the steps to set up a new fleet in Java Management Service (JMS). 

Estimated Time: 5 minutes

### Objectives
In this lab, you will:

* Set up a Java Management Service Fleet 

### Prerequisites:
* You have signed up for an account with Oracle Cloud Infrastructure and have received your sign-in credentials.
* You are using a Linux/Windows Operating system or virtual machine for this workshop.
* Access to the cloud environment and resources configured in Lab 2 

## Task 1: Set Up Java Management Service Fleet

1. In the Oracle Cloud Console, open the navigation menu, click **Observability & Management**, and then click **Java Management**.

  ![image of console navigation to java management service](/../images/console-navigation-jms.png)

2. Select the compartment created for JMS resources in Lab 1 and **Create Fleet**. 

  ![image of create fleet](/../images/create-fleet-create-new.png)

3. In the Create Fleet dialog box, enter a name for the Fleet Name (for example, `fleet_1`), and a description. 
    
4. Select **Create New Management Agent Configuration**.
    
5. Click **Show Advanced Options**
  
  ![image of create fleet options page](/../images/create-fleet.png)
    
6. Under **Advanced Options** 
  
  ![image of fleet advanced options](/../images/create-fleet-advanced-configuration.png)
  
  If you would like to keep the default name of the Install key, no changes are needed, or else deselect **Use Fleet Name** for Install Key Name and enter an alternative name for the management agent install key, for this example, enter "management-agent-install-key-fleet-1". 
  
  In the **Maximum Installations** field, specify a number that indicates the maximum number of installations that can be associated with the key. The default value is 1000, for this example enter **10**.
    
  In the **Valid For** field, specify a number that indicates the period for which the key is valid. The default value is 1 Year. 
     
7. Click **Next**.You are prompted to review the fleet information and management agent configuration. If you wish to modify your choices, click **Previous**.
  
8. Click **Create**. This creates a new fleet and a new management agent install key using the information you provided. 
     
  ![image of create fleet confirm creation](/../images/create-fleet-create.png) 

9. There are **2 files** to be downloaded. Click **Download Install Key** to download the install key (response file) and click the link to **Download the management agent software**.
     
  ![image of page to download management agent software](/../images/download-management-agent-software-new.png)
 
  Select the appropriate software for the compute instance operating system then click **Close**

  ![image of download management agent software](/../images/download-management-agent-software-os.png)

  Click **Done** once both files have been downloaded.

You may now **proceed to the next lab.**

## Want to Learn More?

You may proceed to the next lab for installing management agent on your host and JMS Agent Plugin.

Refer to the [Fleet Management](https://docs.oracle.com/en-us/iaas/jms/doc/fleet-management.html) section of the JMS documentation for more details.

Use the [Troubleshooting](https://docs.oracle.com/en-us/iaas/jms/doc/troubleshooting.html#GUID-2D613C72-10F3-4905-A306-4F2673FB1CD3) chapter for explanations on how to diagnose and resolve common problems encountered when installing or using Java Management Service. 

If the problem still persists or if the problem you are facing is not listed, please refer to the [Getting Help and Contacting Support](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/contactingsupport.htm) section or you may open a a support service request using the **Help** menu in the OCI console.

## Acknowledgements
* **Author** - Esther Neoh, Java Management Service
* **Last Updated By** - Esther Neoh, November 2021
