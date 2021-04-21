# Deploy a Compute Image with Staged Oracle Database 19c Installer Files

## Introduction
In this lab, you use Resource Manager in Oracle Cloud Infrastructure (OCI) to quickly create a compute instance that has the Oracle Database 19c installer files staged on it. This lab creates the environment that you will use in the [Install ORacle Database 19c using Automatic Root Script Execution](?lab="install-db19c-auto-config-script-execution.md") lab

In Resource Manager, you begin by creating a stack, which is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. A Terraform configuration is a set of one or more TF files written in HashiCorp Configuration Language (HCL) that specify the Oracle Cloud Infrastructure resources to create. The Terraform configuration that you use in this lab is provided by LiveLabs and loads a custom image stored in Oracle Cloud Marketplace. Guacomole is installed on the image to provide a friendly user interface. You can also access a terminal window on the image. After you create the stack, you apply it to start the provisioning job in OCI. When the job is completed, you log in to your compute instance through a browser.


### Objectives

In this lab, you learn how to do the following:

- Create and apply a stack in Resource Manager
- Obtain the public IP address of your compute instance
- Connect to your compute instance from a browser
- Connect to your compute instance from Cloud Shell

### Prerequisites

- You have an Oracle account. You can obtain a free account by using Oracle Free Tier or you can use a paid account provided to you by your own organization.
- You have created SSH keys.

### Assumptions

- You are signed in to Oracle Cloud Infrastructure.

## **STEP 1**: Create and apply a stack in Resource Manager

1. Download [livelabs-db19staged-0421.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/R_vJuMUIrsFofKYcTuJOsDiXl2xdSjHNQU7yjQPtnh4/n/c4u03/b/labfiles/o/livelabs-db19ccompute-0812.zip) to a directory on your local computer. This ZIP file contains the terraform script.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**. The **Create Stack** page is displayed. The **Create Stack** page is displayed.

  ![Create a stack tile on the home page](images/create-a-stack.png)

3. For **Stack Information**, do the following:

  a) Select **My Configuration**.

  b) In the **Stack Configuration** area, select **.ZIP file**, click **Browse**, select the ZIP file that you just downloaded, and then click **Open**.

  c) Scroll down, and in the **NAME** box, enter a name for the stack, for example, **livelabs19cstaged**.

  ![Stack Information](images/stack-information-page.png)

  d) Click **Next**.

4. For **Configure Variables**, do the following:

  a) Leave **Region** as is.

  b) Select the compartment in which you want to create the compute instance.

  c) Select an availability domain.

  d) Select **Paste SSH Key**, and paste the contents of your public key into the box.

  e) Leave **VMStandard.E2.4** selected as the instance shape. This shape meets the memory requirements for installing Oracle Database 19c.

  f) Leave the network settings as is.

  ![Configure Variables](images/configure-variables-page.png)

  g) Click **Next**.

5. On the **Review** page, verify that the information is correct.

  ![Review page](images/review-page.png)

6. Click **Create**. Your stack is created and the **Stack Details** page is displayed.

  ![Stack Details page](images/stack-details-page.png)

6. From the **Terraform Actions** drop-down, select **Apply**. The **Apply** window is displayed.

7. In the **Apply** window, leave the name as is and the **APPLY JOB PLAN RESOLUTION** set to **Automatically approve**, and click **Apply**. Resource Manager starts a job to deploy your resources.

  ![Apply window](images/apply-window.png)

8. When the job is finished, inspect the log. The last line should read `Apply complete!`.


## **STEP 2**: Obtain the public IP address of your compute instance

1. From the navigation menu in the Oracle Cloud Infrastructure Console, select **Compute**, and then **Instances**.

2. Select your compartment.

3. Verify that you have a compute instance named **workshop-staged**.

4. Click the **workshop-staged** compute instance to view its details.

5. On the **Instance Details** page, find the public IP address for your compute instance and jot it down. You need this IP address to connect to your compute instance.

## **STEP 3**: Connect to your compute instance from a browser


1. On the details page for your compute instance, find the public IP address.

2. Open a browser and enter the following url, replacing the <public-ip-address> with the public IP address of your compute instance.

    ```nohighlighting
    <copy>http://public-ip-address:8080/guacamole</copy>
    ```
3. Enter `oracle` as the user, enter `Guac.LiveLabs_` as the password (don't forget the underscore at the end), and then click `Login`.

  You are now connected to your compute instance.

4. On the desktop, notice that you have a shortcut to Firefox and a terminal window.


## **STEP 4**: Connect to your compute instance from Cloud Shell

1. From the navigation menu, select **Compute**, and then **Instances**.

2. Find the compute instance that you created (called **Workshop-Staged**) and make note of its public IP address.

3. Open Cloud Shell if it not already opened.

4. Enter the following `ssh` command to connect to your compute instance. Replace `private-key-file` with the name of your private key file. In this example, we use `cloudshellkey`. Replace `public-ip-address` with the public IP address of your compute instance.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/cloudshellkey opc@public-ip-address</copy>
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

5. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@compute-instance-name ~]$` (for example, `opc@workshop`), where `compute-instance-name` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.


You may now [proceed to the next lab](#next).

## Learn More

- [Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/landing.htm#ResourceManager)
- [Video about Resource Manager](https://youtu.be/udJdVCz5HYs)
- [Oracle Cloud Marketplace](https://cloudmarketplace.oracle.com/marketplace/en_US/homePage.jspx)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, April 21 2021
