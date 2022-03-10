# Set up EM Agent

## Introduction

In this tutorial, you will create a compute instance using the public subnet created in the previous tutorial, configure firewall settings, and install EM agent to the compute from the EMCC console.


Estimated time: 15 minutes

* Completion of the **[Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=567)** workshop, labs 1, 2, 3 and 4.
* Completion of the preceding tutorials in this workshop

## Task 1: Create a compute instance

1. From the Oracle Cloud Shell navigation menu, select **Compute** > **Instances**.

   ![Oracle Cloud console, Navigation Menu](images/1-1-menu.png " ")

2. In the **Instances** page, Click **Create Instance**.

   ![Oracle Cloud console, Instances](images/1-2-instances.png " ")

3.  In the **Create Compute Instance** window, enter the following information to create a compute instance.

     * Name: **EMAgent**
     * Compartment: Select the same compartment where you have the cluster
     * Availability domain: Select a default AD

   ![Oracle Cloud console, Create Instance](images/1-3-instances.png " ")


     * Image: Accept the default Linux image
     * Shape: Select a shape. VM.Standard 2.1 is selected in the example

   ![Oracle Cloud console, Create Instance](images/1-4-instances.png " ")


     * Primary network: Select the option, **Select existing virtual cloud network**. Then select a VCN, which is used by the OKE cluster
     * Subnet: Select the option, **Select existing subnet**. Then select the subnet created in the previous tutorial
     * Public IP address: Select the option, **Select Assign a public IPv4 address**

   ![Oracle Cloud console, Create Instance](images/1-5-instances.png " ")


     * Add SSH keys: Select any option to add SSH keys. Upload public key file was selected in the example
     * Boot volume size: **200 (GB)**

    Click **Create** button.

   ![Oracle Cloud console, Create Instance](images/1-6-instances.png " ")

4. Wait for few minutes for the provisioning to complete.

   ![Oracle Cloud console, Instances](images/1-7-instances.png " ")


5.  Ensure the Instance is in the RUNNING state. Click **Copy** next to the **Public IP address**, then save the value to a text file on your computer. Also click **Copy** next to the **Internal FQDN** and save the value to the text file.

   ![Oracle Cloud console, Instances](images/1-8-instances.png " ")

## Task 2: Preparing for the agent installation

1. Open a terminal window (or a Putty connection) on your computer, type the following command to open an SSH connection to the Agent host. Replace the **Agent-Instance-Public-IP** with the value copied in the previous step (Tutorial 5, Task 1, Step 5).

    ``` bash
    <copy>
    ssh opc@<Agent-Instance-Public-IP> -i "<path-to-the-private-key>/id_rsa"
    </copy>
    ```

    E.g., $ ssh opc@123.456.12.26 -i "/Users/labuser/rsa/id_rsa"

2.  Open the ***hosts*** file with the following command.

    ``` bash
    <copy>
    sudo vi /etc/hosts
    </copy>
    ```

3. Add the following entries to the ***hosts*** file.

    a)  Kubernetes load balancer IPs and the matching WebLogic Server names saved in the Tutorial 3, Task 3, Step 3.

        E.g.,)
        10.0.x.248 sample-domain1-admin-server
        10.0.x.252 sample-domain1-managed-server1
        10.0.x.156 sample-domain1-managed-server2


    b)  **Public IP** and the **hostname (FQDN)** of the EM server (OMS) computer instance, in the below format.

        <Public IP address of the OMS host> <FQDN of the OMS host>

    > **NOTE:** Ask your EMCC Administrator if you do not know the IP address and the FQDN of the OMS host/compute instance.

   ![Terminal](images/2-1-terminal.png " ")


   Save the file with ***esc + :wg***.

4.  While still in the EM Agent host, enter the following commands in the terminal to configure firewall settings to allow traffic on the agent port 3872 and http communication with the OMS.

    ``` bash
    <copy>
    sudo firewall-cmd --zone=public --permanent --add-port=3872/tcp
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --reload
    </copy>
    ```

5. Open another terminal window, type the following to open an SSH connection to the EM Server (OMS) host.

    ``` bash
    <copy>
    ssh opc@<OMS-Host-Public-IP> -i "<path-to-the-private-key>/id_rsa"
    </copy>
    ```
6. Open the hosts file with the following command.

    ``` bash
    <copy>
    sudo vi /etc/hosts
    </copy>
    ```
    Add the Public IP and the host name of the EM Agent to the ***hosts*** file, in the below format.

        <Public IP address of the EM Agent host> <FQDN of the EM Agent host>

   ![Terminal](images/2-2-terminal.png " ")

    > **NOTE:** If you do not have permission to access the OMS host, please ask your EM administrator to add the EM Agent information to the hosts file in the OMS host.


7.  Type the following in the terminal window to ensure the OMS Upload port is open in the firewall settings.

    ``` bash
    <copy>
    sudo firewall-cmd --zone=public --permanent --add-port=4903/tcp
    sudo firewall-cmd –reload
    </copy>
    ```

    > **NOTE:** Please also make sure that an ingress rule for the port 4903 is created in the security list in the VCN, which is used by the OMS host. This is required for the EM agent to upload any data to the OMS. To create a security rule, please refer to the Tutorial 4, Task 1.

## Task 3: Install EM agent in the compute instance

1. Launch your Enterprise Manager Cloud Control 13.5 in a browser. Log on with your credentials.

   ![EMCC Console, Login page](images/3-1-emcc.png " ")

  > **NOTE:** Ask your EMCC Administrator if you do not know the login credentials of the Enterprise Manager.

2. From the Enterprise Manager page menu bar, navigate to the **Setup** (a gear icon) **Add Target** > **Add Targets Manually**.

   ![EMCC Console, Setup menu](images/3-2-emcc.png " ")

3. In the  **Add Target Manually** page, click  **Install Agent on Host**.

   ![EMCC Console, Add Targets page](images/3-3-emcc.png " ")

4.  In the **Add Target** page, click **Add**. Enter the FQDN of the EM Agent compute instance, saved in the Tutorial 5, Task 1, Step 5.  Click **Next**.

   ![EMCC Console, Add Target wizard](images/3-4-emcc.png " ")

5.  Enter the directory where the agent files will be installed. **/home/opc/agent** is specified in the image below, as an example. Select **SSH Key based named credentials** that can access the Oracle Cloud compute instance. Leave the other fields with the default values, then click **Next**.

    > **NOTE:** If you have not created a SSH based named credential, go to **Setup** > **Security** > **Named Credentials**. Please refer to the EMCC Security Guide documentation > ***[Configuring and Using Target Credentials](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.5/emsec/security-features.html#GUID-E2792E49-FBF5-4A25-837B-4225CFD16012)*** for how to create SSH key based named credentials.

   ![EMCC Console, Add Target wizard](images/3-5-emcc.png " ")

6.  Review the entries and click **Deploy Agent**. The EM agent installation takes about 10 minutes.

   ![EMCC Console, Add Target wizard](images/3-6-emcc.png " ")

    > **NOTE:** In case the wizard returns warnings for missing packages, update the package in the EM agent host, and try the agent install again. E.g., if the warning is: "Checking for libnsl-2.28-18 Not found", run **sudo yum install libnsl**.

7.  Once the installation is succeeded, you will see a screen similar to the image below. Click **Done** to exit the wizard.

   ![EMCC Console, Add Target wizard](images/3-7-emcc.png " ")

8.  From the menu bar, select **Setup** > **Manage Cloud Control** > **Agents**. Confirm the agent is added, and the status shows green UP arrow icon.

   ![EMCC Console, Manage Cloud Control, Agents page](images/3-8-emcc.png " ")



You may now [proceed to the next tutorial](#next).

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** -
Renjit Clement, Principal Member Technical Staff,  
Rupesh Kumar, Consulting Member of Technical Staff,  
Ravi Mohan, Senior Software Development Manager,  
Steven Lemme, Senior Principal Product Manager,  
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, March 2022
