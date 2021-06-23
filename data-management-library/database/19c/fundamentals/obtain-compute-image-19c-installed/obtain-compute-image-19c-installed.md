# Obtain a Compute Image with Oracle Database 19c Installed

## Introduction

Use Resource Manager in Oracle Cloud Infrastructure (OCI) to quickly deploy a compute image that has Oracle Database 19c installed on it.

Begin by creating a stack in Resource Manager. A stack is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. A Terraform configuration is a set of one or more TF files written in HashiCorp Configuration Language (HCL) that specify the Oracle Cloud Infrastructure resources to create. The Terraform configuration that you use here loads a custom image stored in Oracle Cloud Marketplace and creates a virtual cloud network (VCN). After you create the stack, you apply it to start a provisioning job. When the job is completed, you verify that you can connect to your compute instance via Cloud Shell and a browser, and download the necessary lab files for the workshop.

Oracle highly recommends that you create a new VCN when configuring the stack, which is the default, to ensure you have all of the proper connectivity required to access your compute instance and run the applications. If you choose to use one of your own existing VCNs when you configure the stack, be sure that your VCN has a public subnet and a routing table configured with an Internet Gateway. Your VCN also requires several ingress security rules. STEP 1 covers how to configure the security rules. If you accept the default to create a new VCN when configuring the stack, then you can skip STEP 1.

> **Note**: If you are working in the LiveLabs environment, you can skip STEP 1 and STEP 2 because they have already been done for you.

Estimated Lab Time: 15 minutes

### Objectives

Learn how to do the following:

- Add security rules to your existing VCN
- Create and apply a stack in Resource Manager
- Obtain the public IP address of your compute instance
- Connect to your compute instance via Cloud Shell and initialize your environment
- Connect to your compute instance via a browser
- Download the labs files for this workshop

### Prerequisites

Be sure that the following tasks are completed before you start:

- Obtain an Oracle Cloud account.
- Create SSH keys.
- Sign in to Oracle Cloud Infrastructure.

## **STEP 1**: Add security rules to your existing VCN

Configure ingress rules in your VCN's default security list to allow traffic on port 22 for SSH connections and traffic on ports 1521, 1523, and 1524 for the DB Listener.

> **Note**: You can skip this step if you plan to create a new VCN when configuring the stack (recommended).

1. From the navigation menu in Oracle Cloud Infrastructure, select **Networking**, and then **Virtual Cloud Networks**.

2. Select your VCN.

3. Under **Resources**, select **Security Lists**.

4. Click the default security list.

5. For each port number (22, 1521, 1523, 1524, 6080), do the following:

    1. Click **Add Ingress Rule**.

    2. For **Source CIDR**, enter **0.0.0.0/0**.

    3. For **Destination port range**, enter the port number.

    4. Click **Add Ingress Rule**.

## **STEP 2**: Create and apply a stack in Resource Manager

> **Note**: If you are working in the LiveLabs environment, you can skip this step and proceed to STEP 2.

1. Download [db-multitenant-mkplc-freetier.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/G7LZB2PC1IU-WlBfrsDzKTgqKL9vbyhE5mWrF01MAyD3Gi589C6detaJdbTESF3F/n/natdsecurity/b/stack/o/db-multitenant-mkplc-freetier.zip) to a directory on your local computer. This ZIP file contains the necessary terraform scripts to create your compute instance and database.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**.

  ![Create a stack tile on the home page](images/create-a-stack.png "Create a stack tile on the home page")

    The **Create Stack** page is displayed.

3. For **Stack Information**, do the following:

    1. Select **My Configuration**.

    2. In the **Stack Configuration** section, select **.ZIP file**, click **Browse**, select the ZIP file that you just downloaded, and then click **Open**.

    3. Leave the default values for **Name** and **Description** as is.

    4. Select your compartment.

  ![Stack Information page top half](images/stack-information-page-top-half.png "Stack Information page top half")

  ![Stack Information page bottom half](images/stack-information-page-bottom-half.png "Stack Information page bottom half")

4. Click **Next**.

    The **Configure Variables** page is displayed.

5. In the **Main Configuration** section, do the following:

    1. Leave **Instance Count** set to **1**.

    2. Select an **availability domain**.

    3. Paste your **SSH Public Key** into the box.

  ![Main Configuration section](images/main-configuration-section.png "Main Configuration section")

6. In the **Options** section, do the following:

    1. Leave **Use Flexible Instance Shape with Adjustable OCPU Count** selected.

    2. For **Instance Shape**, leave **VM.Standard.E4.Flex** selected.

    3. For **Select OCPUs Count per Instance**, leave 2 selected.

    4. (Optional) If you want to use one of your existing VCNs, select **Use Existing VCN**, and then select a VCN that has a regional public subnet and the required security rules. Also select your public subnet.

  ![Options section](images/options-section.png "Options section")

7. Click **Next**.

8. On the **Review** page, review your configuration variables and make sure they are correct. Only the variables that you edited are displayed.

  ![Review page](images/review-page.png)

9. In the **Run Apply on the created stack** section, select **RUN APPLY**.

  ![Run Apply option](images/run-apply-option.png "Run Apply option")

10. Click **Create** to begin the provisioning job.

    The **Job Details** page is displayed showing the job in progress.

11. Wait for the job to be completed. The job is successful when it reads "SUCCEEDED" and the last line of the log file reads `Apply complete!`.

  ![Job Details page with the job marked as succeeded](images/job-details-page-succeeded.png "Job Details page with the job marked as succeeded")



## **STEP 3**: Obtain the public IP address of your compute instance

1. From the navigation menu in the Oracle Cloud Infrastructure Console, select **Compute**, and then **Instances**.

2. Select your compartment.

3. Find the public IP address of the compute instance that starts with **db19-hol-s01-...** in the table and jot it down.



## **STEP 4**: Connect to your compute instance via Cloud Shell and initialize your environment

1. On the toolbar in Oracle Cloud Infrastructure, click the Cloud Shell icon to launch Cloud Shell.

  ![Cloud Shell icon](images/cloud-shell-icon.png "Cloud Shell icon")

  A terminal window is displayed at the bottom of the page.

2. Enter the following `ssh` command to connect to your compute instance. Replace `public-ip-address` with the public IP address of your compute instance. Replace `cloudshellkey` with the name of your private key file if it has a different name.

    ```
    $ ssh -i ~/.ssh/cloudshellkey opc@public-ip-address
    ```

    A message states that the authenticity of your compute instance can't be established. Do you want to continue connecting?

3. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  You are now connected to your new compute instance via Cloud Shell.

4. Preserve user configured hostname across instance reboots

    ```
    sudo sed -i -r 's/^PRESERVE_HOSTINFO.*$/PRESERVE_HOSTINFO=2/g' /etc/oci-hostname.conf
    ```
5. Preserve hostname info and set it for current boot

    ```
    sudo hostnamectl set-hostname workshop-installed.subnet1.labvcn.oraclevcn.com
    ```


## **STEP 5**: Connect to your compute instance via a browser

1. Open a browser on your personal computer and enter the following url. Replace public-ip-address with your compute instance's public IP address.

    ```
    http://public-ip-address:6080/index.html?resize=remote
    ```
2. Click **Connect**.

3. Enter the password **LiveLabs.Rocks_99**, and click **Send Password**.

    The noVNC desktop is displayed.


## **STEP 6**: Download the lab files for this workshop

1. On the noVNC desktop, open a terminal window.

2. Create a `/home/oracle/labs/19cnf` directory and switch to it.

    ```
    $ mkdir ~/labs/19cnf
    $ cd ~/labs/19cnf
    ```

3. Download the lab files into the `19cnf` directory.

    ```
    wget https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/7dgNGKXZqAlG_W04kW_i6VV4yDZWLNY5Mkw8Z-Bfd1AJhnQCH6TlJmAdmYDuCYKr/n/frmwj0cqbupb/b/19cNewFeatures/o/19c-new-features-lab-files.zip
    ```

4. Extract the ZIP file in the `19cnf` directory.

    ```
    $ unzip -q 19c-new-features-lab-files.zip
    ```

5. Verify that you have 27 files.

    ```
    ls
    ```

6. Grant permissions to execute on files in the `19cnf` directory.

    ```
    chmod -R +x ~/labs/19cnf
    ```




## Learn More

- [Resource Manager Video](https://youtu.be/udJdVCz5HYs)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, June 23 2021
