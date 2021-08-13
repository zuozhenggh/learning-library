# Obtain a Compute Image with Staged Oracle Database 19c Installer Files

## Introduction
Use Resource Manager in Oracle Cloud Infrastructure (OCI) to quickly deploy a compute instance with the private `workshop-staged` image from Oracle Cloud Marketplace. The image has the Oracle Database 19c installer files staged on it and has a noVNC desktop, which provides an easy-to-use browser user interface.

Begin by creating and applying a stack in Resource Manager. A stack is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. A Terraform configuration is a set of one or more TF files written in HashiCorp Configuration Language (HCL) that specify the Oracle Cloud Infrastructure resources to create. The Terraform configuration that you use here loads a custom image stored in Oracle Cloud Marketplace and creates a virtual cloud network (VCN). After your compute instance is created, you can log into it via a browser.

Oracle highly recommends that you let Resource Manager create a new VCN for you when creating the stack to ensure that you have all of the proper connectivity required to access your compute instance and run the applications. If you accept, you can skip Task 1. If you choose to use one of your own existing VCNs, be sure that your VCN has a public subnet and a routing table configured with an Internet Gateway. Your VCN also requires several ingress security rules, which are covered in Task 1.

> **Note**: If you are working in the LiveLabs environment, you can skip Task 1 and Task 2 because they are already done for you.

Estimated Lab Time: 30 minutes

### Objectives

Learn how to do the following:

- Add security rules to your existing VCN
- Create and apply a stack in Resource Manager
- Connect to your compute instance from a browser and set up your desktop


### Prerequisites

Before you start, be sure that you have done the following:

- Obtained an Oracle Cloud account
- Signed in to Oracle Cloud Infrastructure
- Created SSH keys in Cloud Shell

## Task 1: Add security rules to your existing VCN

Configure ingress rules in your VCN's default security list to allow traffic on port 22 for SSH connections, traffic on ports 1521 to 1524 for the database listeners, and traffic on port 6080 for HTTP connections to the noVNC browser interface.

> **Note**: If you plan to let Resource Manager create a new VCN for you (recommended), you can skip this task and proceed to Task 2. If you are working in the LiveLabs environment, you can skip this task and Task 2 and proceed to Task 3.

1. From the navigation menu in Oracle Cloud Infrastructure, select **Networking**, and then **Virtual Cloud Networks**.

2. Select your VCN.

3. Under **Resources**, select **Security Lists**.

4. Click the default security list.

5. For each port number/port number range (22, 1521-1524, 6080), click **Add Ingress Rule**. For **Source CIDR**, enter **0.0.0.0/0**. For **Destination port range**, enter the port number. Click **Add Ingress Rule**.

## Task 2: Create and apply a stack in Resource Manager

> **Note**: If you are working in the LiveLabs environment, the `workshop-staged` compute instance is already created for you; therefore, you can skip this task and proceed to Task 3.

1. Download [db19cnf-workshop-staged.zip](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/8ymA1czX8XRytfobEBedr8guxJfPwZ9gRUH2PZjbk2AeQBnFHMM06si6NSitFeqY/n/frmwj0cqbupb/b/19cNewFeatures/o/19cnf-workshop-staged.zip) to a directory on your local computer. This ZIP file contains the terraform script that you use with Resource Manager.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**. The **Create Stack** page is displayed.

  ![Create a stack tile on the home page](images/create-a-stack.png)

    The **Create Stack - Stack Information** page is displayed.

3. Select **My Configuration**.

4. In the **Stack Configuration** area, select **.Zip file**, click **Browse**, select the ZIP file that you just downloaded, and then click **Open**.

  ![Stack Information Page](images/stack-information-page-workshop-installed-needs-updating.png "Stack Information page")

5. For **Name**, leave the default stack name as is.

6. For **Description**, leave the default description for the stack as is.

7. Select your compartment. This compartment is used to store the stack, the VCN (if you choose to create a new one), and the `workshop-staged` compute instance. If you plan to use your own VCN, make sure that it resides in the compartment that you select here.

8. Click **Next**. The **Configure Variables** page is displayed.

9. In the **Main Configuration** section, leave **1** selected for the instance count.

10. Select an availability domain.

11. Paste the contents of your public key into the **SSH Public Key** box. Be sure that there are no carriage returns.

  ![Main Configuration Section](images/main-configuration-section.png "Main Configuration Section")

12. In the **Options** section, configure the following:

    - Leave **Use Flexible Instance Shape with Adjustable OCPU Count** selected. For **Instance Shape**, select **VM.Standard.E4.Flex**. Depending on the quota that you have in your tenancy, you can choose a different instance shape, if needed.
    - Leave **2** set as the number of OCPUs per instance. With the VM.Standard.E4.Flex shape, two OCPUs provides 32 GB of RAM, which is sufficient for this workshop. If you increase the number of OCPUs, be sure that you have the capacity available.
    - Leave the **Use Existing VCN** check box deselected (recommended) if you want Resource Manager to create a VCN for you. If you choose to use your own VCN, select **Use Existing VCN**, and then select your VCN and public subnet. Your VCN needs to have a public subnet and a routing table configured with an Internet Gateway. It also requires several ingress security rules, which are specified in Task 1 above. Your VCN also needs to reside in the compartment that you selected on the **Stack Information** page.

    ![Options Section](images/options-section.png "Options Section")

13. Click **Next**.

15. On the **Review** page, verify that the information is correct.

  ![Review page](images/review-page-needs-updating.png "Review page")

16. In the **Run Apply on the created stack** section, select **Run Apply** to immediately provision the resources.

    ![Run Apply section](images/run-apply-section.png "Run Apply Section")

17. Click **Create**.

    Resource Manager starts provisioning your compute instance and the **Job Details** page is displayed. You can monitor the progress of the job by viewing the details in the log. The job is finished when the state reads **Succeeded**.

  ![Job Details page](images/job-details-page-needs-updating.png "Job Details page")


18. Scroll down to the end of your log. Locate the `remote-desktop` URL and copy it to the clipboard. Don't include the double-quotation marks.

    ![Image URL](images/image-url-needs-updating.png "Image URL")



## Task 3: Connect to your compute instance via a browser and set up your desktop

> **Note**: If you are working in the LiveLabs tenancy, you are provided the URL to your `workshop-staged` compute instance.

1. In a browser, enter the URL to your `workshop-staged` compute instance.

   You are automatically logged in to your compute instance and presented with a user-friendly desktop.

    ![noVNC Desktop](images/noVNC-desktop-needs-updating.png "noVNC Desktop")

2. To enable full screen display: Click the small gray tab on the middle-left side of your screen to open the control bar. Next, click the **Fullscreen** icon (6th button down).

    ![Small Grey Tab](images/small-grey-tab.png "Small Grey Tab")

    ![Full Screen](images/full-screen.png "Full Screen")

3. If the workshop guide is not open on the desktop, double-click the **Get Started with Your Workshop** icon on the desktop.



## Learn More

- [Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/landing.htm#ResourceManager)
- [Video about Resource Manager](https://youtu.be/udJdVCz5HYs)
- [Oracle Cloud Marketplace](https://cloudmarketplace.oracle.com/marketplace/en_US/homePage.jspx)

## Acknowledgements

- **Author**- Jody Glover, Consulting User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, August 13 2021
