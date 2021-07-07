# Obtain a Compute Image with Staged Oracle Database 19c Installer Files

## Introduction
Use Resource Manager in Oracle Cloud Infrastructure (OCI) to quickly create a compute instance that has the Oracle Database 19c installer files staged on it. noVNC is installed on the compute instance to provide an easy-to-use browser user interface. You can also access a terminal window on the compute instance.

Begin by creating a stack in Resource Manager. A stack is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. A Terraform configuration is a set of one or more TF files written in HashiCorp Configuration Language (HCL) that specify the Oracle Cloud Infrastructure resources to create. The Terraform configuration that you use here loads a custom image stored in Oracle Cloud Marketplace and creates a virtual cloud network (VCN). After your compute instance is created, you can log into it via a browser.

Oracle highly recommends that you create a new VCN when configuring the stack, which is the default, to ensure you have all of the proper connectivity required to access your compute instance and run the applications. If you choose to use one of your own existing VCNs when you configure the stack, be sure that your VCN has a public subnet and a routing table configured with an Internet Gateway. Your VCN also requires an ingress security rule to allow traffic on port 6080 so that you can access your compute instance via a browser. STEP 5 covers how to configure the security rule.

> **Note**: If you are working in the LiveLabs environment, you can skip STEP 1 because it is already done for you.

Estimated Lab Time: 30 minutes

### Objectives

Learn how to do the following:

- Create and apply a stack in Resource Manager
- Obtain the public IP address of your compute instance
- Connect to your compute instance from a browser and set up your desktop
- Configure a security rule in your VCN

### Prerequisites

Before you start, be sure that you have done the following:

- Obtained an Oracle Cloud account
- Signed in to Oracle Cloud Infrastructure
- Created SSH keys in Cloud Shell.



## **STEP 1**: Create and apply a stack in Resource Manager

> **Note**: If you are working in the LiveLabs environment, you can skip this step and proceed to STEP 2.

1. Download [workshop-staged.zip](need url) to a directory on your local computer. This ZIP file contains the terraform script that you use with Resource Manager.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**. The **Create Stack** page is displayed.

  ![Create a stack tile on the home page](images/create-a-stack.png)

    The **Create Stack - Stack Information** page is displayed.

3. Select **My Configuration**.

4. In the **Stack Configuration** area, select **.ZIP file**, click **Browse**, select the ZIP file that you just downloaded, and then click **Open**.

  ![Stack Information](images/stack-information-page.png "Stack Information page")

5. For **Name**, leave the default stack name as is.

6. For **Description**, leave the default description as is.

7. Select your compartment.

8. Click **Next**. The **Configure Variables** page is displayed.

9. In the **Instance** section, make sure the appropriate region is selected.

10. Select your compartment.

11. Select an availability domain.

12. Select **Paste SSH Key**, and then paste the contents of your public key into the box. Be sure that there are no carriage returns. The key should be all on one line.

13. Select **VM.Standard.E3.Flex** as the instance shape.

   *update this graphic*

  ![Instance Configuration](images/instance-configuration.png "Instance Configuration")

14. Choose one of the following options to configure the network:

    - Option 1 (Recommended): Leave the default settings as is to generate a new VCN.

    - Option 2: Select **Use existing VCN** to select one of your own existing VCNs. If you select this option, your VCN needs to have a public subnet and a routing table configured with an Internet Gateway. Your VCN also requires an ingress security rule to allow traffic on port 6080 so that you can access your compute instance via a browser. See STEP 5 for information on how to configure the security rule.

  ![Network Configuration](images/network-configuration.png "Network Configuration")

15. Click **Next**.

16. On the **Review** page, verify that the information is correct.

  ![Review page](images/review-page.png "Review page")

17. In the **Run Apply on the created stack** section, select **RUN APPLY** to immediately provision the resources.

  ![Run Apply section](images/run-apply-section.png "Run Apply Section")

18. Click **Create**.

    Resource Manager starts provisioning your compute instance. The **Job Details** page is displayed. You can monitor the progress of the job by viewing the details in the log. When the job is finished, the state reads **Succeeded**.

  ![Job Details page](images/job-details-page.png "Job Details page")

19. Wait for the log to indicate that the Apply job has completed. The last line in the log should read as follows:

    ```
    Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
    ```



## **STEP 2**: Obtain the public IP address of your compute instance

After the job is completed, you are directed to the **Instance Details** page. Find the public IP address under **Instance Access** and jot it down.

If you navigated away from the **Instance Details** page, you can return to it by following these steps:

1. From the navigation menu in the Oracle Cloud Infrastructure Console, select **Compute**, and then **Instances**.

2. Select your compartment.

3. Find the public IP address of the compute instance called **workshop-staged** in the table and jot it down.

4. (Optional) Click the name of your compute instance to view all of its details.


## **STEP 3**: Connect to your compute instance via a browser and set up your desktop

1. On your local computer, open a browser, and enter the following URL. Replace `compute-public-ip` with the public IP address of your compute instance.

    ```
    http://compute-public-ip:6080/vnc.html?password=LiveLabs.Rocks_99&resize=scale&quality=9&autoconnect=true
    ```

   You are presented with user-friendly desktop for your Unix instance. On the desktop, you can find shortcuts to Firefox and a terminal window. The "Install Oracle Database 19c with Automatic Root Script Execution" lab instructions are displayed in Firefox.

    ![noVNC Desktop](images/noVNC-desktop.png "noVNC Desktop")

2. To enable full screen display: Click the small gray tab on the middle-left side of your screen to open the control bar. Click the **Fullscreen** icon (6th button down).

    ![Enable Full Screen](images/enable-full-screen.png "Enable Full Screen")

3. If the workshop guide is not already open on the desktop: Double-click the Firefox icon on the desktop to open Firefox. On the Firefox toolbar, click **Workshop Guides** and then select **Oracle Database 19c New Features**.


## **STEP 4**: Configure a security rule on your VCN

> **Note**: Complete this step only if you selected to use your own VCN when creating the stack in STEP 1.

1. From the navigation menu, select **Networking**, and then **Virtual Cloud Networks**.

2. Select the compartment in which your VCN resides.

3. Click the name of your VCN.

4. On the left, click **Security Lists**.

5. Click the default security list.

6. Click **Add Ingress Rules**. An Ingress Rule dialog box is displayed.

7. Configure the following rule, and then click **Add Ingress Rules**.

    - source type: CIDR
    - source cidr 0.0.0.0/0
    - destination port: 6080


## Learn More

- [Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/landing.htm#ResourceManager)
- [Video about Resource Manager](https://youtu.be/udJdVCz5HYs)
- [Oracle Cloud Marketplace](https://cloudmarketplace.oracle.com/marketplace/en_US/homePage.jspx)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, June 25 2021
