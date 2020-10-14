<!-- "filename": "https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/cloud-login-livelabs2.md" -->

# Introduction

## About this Workshop

In this hands-on lab, the users are provided with step-by-step instructions on setting up a user group, creating and adding users to a group, and creating a compartment and respective policies in the **Oracle Cloud Infrastructure (OCI)**. Subsequently, this guide instructs how to **install the Cloud Manager 11 using Marketplace**. The final section provides the steps to **provision a PeopleSoft Environment** followed by some simple hands-on exercises for you to get familiar with the system.

You can download the Word file here : [PSFT-Workshop Doc](https://objectstorage.us-ashburn-1.oraclecloud.com/p/1EIFGD4wIGKmoToeJ241ly9AuzPIA-7oeYauUYv1Qoz-t2dmEP4OjCF5BRcmtC3Q/n/orasenatdpltoci03/b/TestDrive/o/PSFT-HOL-Workshop.docx)     

You can download the PPT file here : [PSFT-Workshop PPT](https://objectstorage.us-ashburn-1.oraclecloud.com/p/0QHo_3IYUvoU7mdHlc2CgyF9hySoay4jhb5BWNM-7ve_nQEJB4IwlK594fRVbie4/n/orasenatdpltoci03/b/TestDrive/o/PSFT-CM-LabOverview.pptx)    

You can download PDF file here: [PSFT-Workshop PDF](https://objectstorage.us-ashburn-1.oraclecloud.com/p/n7Khl1L7M_HC--UqWmwoiSv2vANQbCOFiqwFIF5xRQrZMLhzKrGviCzywpaBG67p/n/orasenatdpltoci03/b/TestDrive/o/PSFT-HOL-Workshop.pdf)  

Estimated Lab Time: 5 hours, including provisioning time. A complete time breakdown is as follows:

Lab 1 - 10 mins   
Lab 2 - 20 mins   
Lab 3 - 30 mins configuration + 1 hour waiting   
Lab 4 - 10 mins   
Lab 5 - 5 mins configuration + maximum 3 hours waiting   
Lab 6 - 5 mins   
Lab 7 - 10 mins   
Lab 8 - 15 mins configuration + 1.5 hours waiting 

**Note**:

- The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.   
- IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.

### Overview Architecture  (About Product/Technology)

![](./images/arch.png " ")
<!-- Enter background information here....

*You may add an option video, using this format: [](youtube:YouTube video id)*

  [](youtube:zNKxJjkq0Pw) -->

### Objectives

<!-- *List objectives for the lab - if this is the intro lab, list objectives for the workshop, for example:* -->

In this lab, you will:
* Set up Oracle Cloud Infrastructure Account (Provision
* Create Identity and Access Management (IAM) Resources (Setup
* Provision the Peoplesoft Cloud Manager using Marketplace (Data Load
* Configure Cloud Manager Settings (Query
* Review and Update a Topology (Analyze
* Create a New Environment Template (Visualize
* Create Environment in PeopleSoft



### Prerequisites
1. User already has a tenancy with Administrator user access. 

2. My Oracle Support credentials. Please make sure that you can successfully login to [Oracle Support](https://support.oracle.com). Note down this login credential in a notepad. You will use it later to configure Cloud Manager.

3. User should have their own workstation/laptop to access the OCI console, PSFT Cloud Manager, and provisioned instances. 

4. User has access to a workstation/laptop with the following installed:

    a. If you have a windows machine, please download Git Bash for Windows from here: https://git-scm.com/download/win  

    b. User must have admin privileges on their laptop to update the **etc/hosts** file to add URL/IP address for PSFT Cloud Manager. Please let the team know if you can't get this access.

    **NOTE: If you don't have admin privileges in your local machine, please make sure to follow the "Windows VM Compute" Lab. You can use the windows compute to follow this Workshop. Please also make sure to install Git Bash in Windows Compute.** You will also need to install **Remote Desktop Connection** in your local machine from this [link](https://www.microsoft.com/en-us/p/microsoft-remote-desktop/9wzdncrfj3ps).

    c. A web browser to connect to OCI web console and Cloud Manager PIA – Firefox or Chrome recommended.
<!-- *Use this section to describe any prerequisites, including Oracle Cloud accounts, set up requirements, etc.*

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default* -->

## **STEP 1**: title

Step 1 opening paragraph.

1. Sub step 1

  To create a link to local file you want the reader to download, use this format:

  Download the [starter file](files/starter-file.sql) SQL code.

  *Note: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)*

2. Sub step 2 with image and link to the text description below. The `sample1.txt` file must be added to the `files` folder.

    ![Image alt text](images/sample1.png "Image title")

3. Ordered list item 3 with the same image but no link to the text description below.

    ![Image alt text](images/sample1.png)

4. Example with inline navigation icon ![Image alt text](images/sample2.png) click **Navigation**.

5. One example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

## **STEP 2:** title

1. Sub step 1

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy&gt;</copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

*At the conclusion of the lab add this statement:*
You may proceed to the next lab.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Appendix

*Terminology*

The following terms are commonly employed in Peoplesoft cloud operations and used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – Allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes) that can be accessed only by certain groups..

**Peoplesoft Cloud Manager (PSFT)** - Oracle Peoplesoft Cloud Manager is a Peoplesoft lifecycle management application used for creating, managing, and configuring Peoplesoft environments on Oracle Cloud Infrastructure.

**PSFT Cloud Manager infrastructure** – Virtual network resources, compute resources, and policies required to run PSFT Cloud Manager on Oracle Cloud Infrastructure.

**Virtual Cloud Network (VCN)** – Networking and compute resources required to run PSFT on Oracle Cloud Infrastructure. The PSFT VCN includes the recommended networking resources (VCN, subnets routing tables, internet gateway, security lists, and security rules) to run Oracle Peoplesoft on OCI.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure are hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used, since using nearby resources is faster than using distant resources.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.

## Acknowledgements

**Created By/Date**   
- Rich Konopka, Peoplesoft Specialist, October 2020  
- Megha Gajbhiye, Cloud Solutions Engineer, October 2020  

**Last Updated By/Date**    
- Sara Lipowsky, Cloud Solutions Engineer, October 2020  

<!-- ## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store. -->

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
