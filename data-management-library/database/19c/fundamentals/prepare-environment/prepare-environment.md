# Prepare Your Environment

## Introduction
Use Resource Manager in Oracle Cloud Infrastructure (OCI) to quickly deploy the following two compute instances for this workshop. Both compute instances have an easy-to-use noVNC desktop, which you can access via a browser.
- `workshop-staged` - You use this compute instance only during the lab called **Install Oracle Database 19c with Automatic Root Script Execution**. If you are not going to do this lab, you can skip Task 2.
- `workshop-installed` - You use this compute instance for all of the other labs.

To create each compute instance, you create and apply a stack in Resource Manager. A stack is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. A Terraform configuration is a set of one or more TF files written in HashiCorp Configuration Language (HCL) that specify the Oracle Cloud Infrastructure resources to create. Oracle highly recommends that you let Resource Manager create a new VCN for you when creating the stack to ensure that you have all of the proper connectivity required to access your compute instance and run the applications. If you accept, you can skip Task 1. If you choose to use one of your own existing VCNs, be sure that your VCN has a public subnet and a routing table configured with an Internet Gateway. Your VCN also requires several ingress security rules, which are covered in Task 1.


Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

- Add security rules to your existing VCN
- Create a `workshop-staged` compute instance
- Create a `workshop-installed` compute instance


### Prerequisites

This lab assumes you have:

- Obtained an Oracle Cloud account
- Signed in to Oracle Cloud Infrastructure

## Task 1: Add security rules to your existing VCN

Configure ingress rules in your VCN's default security list to allow traffic on port 22 for SSH connections, traffic on ports 1521 to 1524 for the database listeners, and traffic on port 6080 for HTTP connections to the noVNC browser interface.

> **Note**: If you plan to let Resource Manager create a new VCN for you (recommended), you can skip this task and proceed to Task 2.

1. From the navigation menu in Oracle Cloud Infrastructure, select **Networking**, and then **Virtual Cloud Networks**.

2. Select your VCN.

3. Under **Resources**, select **Security Lists**.

4. Click the default security list.

5. For each port number/port number range (22, 1521-1524, 6080), click **Add Ingress Rule**. For **Source CIDR**, enter **0.0.0.0/0**. For **Destination port range**, enter the port number. Click **Add Ingress Rule**.

## Task 2: Create a `workshop-staged` compute instance

1. Download [db19cnf-workshop-staged.zip](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/8ymA1czX8XRytfobEBedr8guxJfPwZ9gRUH2PZjbk2AeQBnFHMM06si6NSitFeqY/n/frmwj0cqbupb/b/19cNewFeatures/o/19cnf-workshop-staged.zip) to a directory on your local computer.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**. The **Create Stack** page is displayed.

    ![Create a stack tile on the home page](images/create-a-stack.png "Create a stack tile on the home page")

    The **Create Stack - Stack Information** page is displayed.

3. Select **My Configuration**.

4. In the **Stack Configuration** section, select **.Zip file**, click **Browse**, select the ZIP file that you just downloaded, and then click **Open**.

    ![Stack Configuration for workshop-staged](images/stack-configuration-workshop-staged.png "Stack Configuration for workshop-staged")

5. In the **Stack Information** section, leave **Name** and **Description** for the stack as is, and select your compartment.

    This compartment is used to store the stack, the VCN (if you choose to create a new one), and the `workshop-staged` compute instance. If you plan to use your own VCN, make sure that it resides in this compartment too.

    ![Stack Information for workshop-staged](images/stack-information-workshop-staged.png "Stack Information for workshop-staged")

6. Click **Next**. The **Configure Variables** page is displayed.

7. In the **Main Configuration** section, leave **1** selected for the instance count, and select one of your availability domains.

    ![Main Configuration](images/main-configuration.png "Main Configuration section")


8. In the **Options** section, configure the following:

    - Leave **Use Flexible Instance Shape with Adjustable OCPU Count** selected. For **Instance Shape**, leave **VM.Standard.E4.Flex** selected. Depending on the quota that you have in your tenancy, you can choose a different instance shape, if needed.
    - Leave **1** set as the number of OCPUs per instance. With the VM.Standard.E4.Flex shape, one OCPU provides 16 GB of RAM, which is sufficient for the "Install Oracle Database 19c with Automatic Root Script Execution" lab. If you increase the number of OCPUs, be sure that you have the capacity available.
    - Leave the **Use Existing VCN** check box deselected if you want Resource Manager to create a VCN for you (recommended). If you choose to use your own VCN, select **Use Existing VCN**, and then select your VCN and public subnet. Your VCN needs to have a public subnet and a routing table configured with an Internet Gateway. It also requires several ingress security rules, which are specified in Task 1 above. Your VCN also needs to reside in the compartment that you selected in the **Stack Information** section.

    ![Options Section for workshop-staged](images/options-workshop-staged.png "Options Section for workshop-staged")

9. Click **Next**.

    The **Review** page is displayed.

10. Verify that the information is correct.

    ![Review page for workshop-staged](images/review-workshop-staged.png "Review page for workshop-staged")

11. In the **Run Apply on the created stack** section, select **Run Apply** to immediately provision the resources.

    ![Run Apply section](images/run-apply-section.png "Run Apply section")

12. Click **Create**.

    Resource Manager starts provisioning your compute instance and the **Job Details** page is displayed. You can monitor the progress of the job by viewing the details in the log. The job is finished when the state reads **Succeeded**. Please allow 5 minutes for the job to complete.

13. Scroll down to the end of your log. Locate the `remote-desktop` URL and copy it to the clipboard. Don't include the double-quotation marks. The URL syntax is `http://[your instance public-ip address]:6080/vnc.html?password=LiveLabs.Rocks_99&resize=scale&quality=9&autoconnect=true`.

    ![Image URL for workshop-staged](images/image-url-workshop-staged.png "Image URL for workshop-staged")

14. In a browser, paste the URL to your `workshop-staged` compute instance.

   You are automatically logged in to your compute instance and presented with a user-friendly desktop.



## Task 3: Create a `workshop-installed` compute instance

1. Download [db19cnf-workshop-installed.zip](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/8ymA1czX8XRytfobEBedr8guxJfPwZ9gRUH2PZjbk2AeQBnFHMM06si6NSitFeqY/n/frmwj0cqbupb/b/19cNewFeatures/o/19cnf-workshop-staged.zip) to a directory on your local computer.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**. The **Create Stack** page is displayed.

    ![Create a stack tile on the home page](images/create-a-stack.png "Create a stack tile on the home page")

    The **Create Stack - Stack Information** page is displayed.

3. Select **My Configuration**.

4. In the **Stack Configuration** section, select **.Zip file**, click **Browse**, select the ZIP file that you just downloaded, and then click **Open**.

    ![Stack Configuration for workshop-installed](images/stack-configuration-workshop-installed.png "Stack Configuration for workshop-installed")

5. In the **Stack Information** section, leave **Name** and **Description** for the stack as is, and select your compartment.

    This compartment is used to store the stack, the VCN (if you choose to create a new one), and the `workshop-staged` compute instance. If you plan to use your own VCN, make sure that it resides in this compartment too.

    ![Stack Information for workshop-installed](images/stack-information-workshop-installed.png "Stack Information for workshop-installed")

6. Click **Next**. The **Configure Variables** page is displayed.

7. In the **Main Configuration** section, leave **1** selected for the instance count, and select one of your availability domains.

    ![Main Configuration section](images/main-configuration.png "Main Configuration section")


8. In the **Options** section, configure the following:

    - Leave **Use Flexible Instance Shape with Adjustable OCPU Count** selected. For **Instance Shape**, leave **VM.Standard.E4.Flex** selected. Depending on the quota that you have in your tenancy, you can choose a different instance shape, if needed.
    - Leave **2** set as the number of OCPUs per instance. With the VM.Standard.E4.Flex shape, two OCPUs provides 32 GB of RAM, which is sufficient for labs. If you increase the number of OCPUs, be sure that you have the capacity available.
    - Leave the **Use Existing VCN** check box deselected if you want Resource Manager to create a VCN for you (recommended). If you choose to use your own VCN, select **Use Existing VCN**, and then select your VCN and public subnet. Your VCN needs to have a public subnet and a routing table configured with an Internet Gateway. It also requires several ingress security rules, which are specified in Task 1 above. Your VCN also needs to reside in the compartment that you selected in the **Stack Information** section.

    ![Options Section for workshop-installed](images/options-workshop-installed.png "Options Section for workshop-installed")

9. Click **Next**.

    The **Review** page is displayed.

10. Verify that the information is correct.

    ![Review page for workshop-installed](images/review-workshop-installed.png "Review page for workshop-installed")

11. In the **Run Apply on the created stack** section, select **Run Apply** to immediately provision the resources.

    ![Run Apply section](images/run-apply-section.png "Run Apply section")

12. Click **Create**.

    Resource Manager starts provisioning your compute instance and the **Job Details** page is displayed. You can monitor the progress of the job by viewing the details in the log. The job is finished when the state reads **Succeeded**. Please allow 5 minutes for the job to complete.

13. Scroll down to the end of your log. Locate the `remote-desktop` URL and copy it to the clipboard. Don't include the double-quotation marks. The URL syntax is `http://[your instance public-ip address]:6080/vnc.html?password=LiveLabs.Rocks_99&resize=scale&quality=9&autoconnect=true`.

    ![Image URL for workshop-installed](images/image-url-workshop-installed.png "Image URL for workshop-staged")

14. In a browser, paste the URL to your `workshop-installed` compute instance.

    You are automatically logged in to your compute instance and presented with a user-friendly desktop.



## Learn More

- [Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/landing.htm#ResourceManager)
- [Video about Resource Manager](https://youtu.be/udJdVCz5HYs)
- [Oracle Cloud Marketplace](https://cloudmarketplace.oracle.com/marketplace/en_US/homePage.jspx)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, August 19 2021
