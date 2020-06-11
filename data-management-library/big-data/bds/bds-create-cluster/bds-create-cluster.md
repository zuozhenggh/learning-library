# Create a BDS Hadoop Cluster

## Introduction

In this lab, you will learn how to plan and create a simple Cloudera Distribution Including Apache Hadoop (CDH) highly-available (HA) cluster using the Oracle Cloud Infrastructure Console (OCI) and Big Data Service (BDS). This will be a small development cluster that is not intended to process huge amounts of data. It will be based on small Virtual Machine (VM) shapes that are perfect for developing applications and testing functionality at a minimal cost.


### Objectives

* Learn how to create an HA Hadoop cluster using BDS and OCI.
* Learn how to monitor the cluster creation.
* Learn how to review your cluster.

### What Do You Need?

This lab assumes you have successfully completed **Lab 1: Setup the BDS Environment** seen in the menu on the right.

### Video Preview

Watch a video demonstration of creating a simple non-HA Hadoop cluster:

[](youtube:zpASc1xvKOY)


## STEP 1: Login to the Oracle Cloud Console

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

   ![](./images/oracle-cloud-console-home.png " ")    


## STEP 2: Create a Cluster
There are many options when creating a cluster. You will need to understand the sizing requirements based on your use case and performance needs. In this lab, you will create a small development cluster that is not intended to process huge amounts of data. It will be based on small Virtual Machine (VM) shapes that are perfect for developing applications and testing functionality at a minimal cost.

Your simple HA cluster will have the following profile:

* **Nodes:** **2** Master nodes, **2** Utility nodes, and **3** Worker nodes.  
* **Shape:** **VM.Standard2.4** shape for all nodes in the cluster. This shape provides **4 CPUs** and **60 GB** of memory.
* **Storage Size:** **250 GB** block storage for the Master and Utility nodes and **750 GB** block storage for the Worker nodes.


**Note:**
For better performance and scalability, change the above specs appropriately. Consider **DensIO** shapes (with direct attached storage) and **Bare Metal** shapes.

When you create the cluster, the **Create Cluster** wizard will prompt you to provide information about your network and to make choices based on your network. To prepare for those questions, see [Create a Network](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-network.html#GUID-36C46027-65AB-4C9B-ACD7-2956B2F1B3D4).

Create the cluster as follows:

1. Click the **Navigation** menu in the upper left-hand corner of the **Oracle Cloud Console** Home page.

2. Under **Data & AI**, select **Big Data**.

   ![](./images/big-data.png " ")

3. On the **Clusters** page, click **Create Cluster**.

  ![](./images/clusters-page.png " ")


  At the top of the **Create Cluster** panel, provide the cluster details as follows:
    * **CLUSTER NAME:** **`training-cluster`**.
    * **CLUSTER ADMIN PASSWORD:** Enter a `cluster admin password` of your choice such as **`Training123`**. You'll need this password to sign into Cloudera Manager and to perform certain actions on the cluster through the Cloud Console.
    * **CONFIRM CLUSTER ADMIN PASSWORD:** Confirm your password.
    * **SECURE & HIGHLY AVAILABLE(HA):** Check this box to make the cluster secure and highly available. A secure cluster has the full Hadoop security stack, including HDFS Transparent Encryption, Kerberos, and Apache Sentry. This setting can't be changed for the life of the cluster.
    * **CLUSTER VERSION:** This read-only field displays the latest version of Cloudera 6 that is available to Oracle which is deployed by BDS.

    ![](./images/create-cluster-1.png " ")

  In the **Hadoop Nodes > Master/Utility Nodes** section, provide the following details:

    * **CHOOSE INSTANCE TYPE:** **`Virtual Machine`**.
    * **CHOOSE MASTER/UTILITY NODE SHAPE:** **`VM.Standard2.4`**.
    * **BLOCK STORAGE SIZE PER MASTER/UTILITY NODE (IN GB):** **`250 GB`**.
    * **NUMBER OF MASTER & UTILITY NODES** _READ-ONLY_ **:** Since you are creating an HA cluster, this field shows **4** nodes: **2** Master nodes and **2** Utility nodes. For a non-HA cluster, this field would show only **2** nodes: **1** Master node and  **1** Utility node.

    ![](./images/create-cluster-2.png " ")

  In the **Hadoop Nodes > Worker Nodes** section, provide the following details:

    * **CHOOSE INSTANCE TYPE:** **`Virtual Machine`**.
    * **CHOOSE MASTER/UTILITY NODE SHAPE:** **`VM.Standard2.4`**.
    * **BLOCK STORAGE SIZE PER MASTER/UTILITY NODE (IN GB):** **`750 GB`**.
    * **NUMBER OF WORKER NODE:** **`3`**. This is the minimum allowed for a cluster.

    ![](./images/create-cluster-3.png " ")

   In the **Network Setting > Cluster Private Network** section, provide the following details:

     * **CIDR BLOCK:** **`10.1.0.0/16`**. This CIDR block assigns the range of contiguous IP addresses available for the cluster's private network that BDS creates for the cluster. This private network is created in the Oracle tenancy and not in your customer tenancy. It is used exclusively for private communication among the nodes of the cluster. No other traffic travels over this network, it isn't accessible by outside hosts, and you can't modify it once it's created. All ports are open on this private network.

     **Note:** Use CIDR block **`10.1.0.0/16`** to avoid overlaping with the **`10.0.0.0/16`** CIDR block range that you used for the **`training-vcn`** VCN that you created in **Lab 1**.

    In the **Network Setting > Customer Network** section, provide the following details:

      * **CHOOSE VCN IN `training-compartment`:** **`training-vcn`**. The VCN must contain a regional subnet.   **Note:** Make sure that **`training-compartment`** is selected; if it's not, click the _CHANGE COMPARTMENT_ link, and then search for and select your **`training-compartment`**.
      * **CHOOSE REGIONAL SUBNET IN `training-compartment`:** **`Public Subnet-training-vcn`**. This is the public subnet that was created for you when you created your **`training-vcn`** VCN in **Lab 1**.
      * **Networking Options:** **`DEPLOY ORACLE-MANAGED SERVICE GATEWAY AND NAT GATEWAY (QUICK START)`**. This simplifies your network configuration by allowing Oracle to provide and manage these communication gateways for private use by the cluster. These gateways are created in the Oracle tenancy and can't be modified after the cluster is created.

      ![](./images/create-cluster-4.png " ")

   In the **Additional Options > SSH PUBLIC KEY** section, associate an SSH key with the cluster. Enter an SSH public key in any of the following ways:
     * Select **CHOOSE SSH KEY FILE**, and then either Drag and drop a public SSH key file into the box,
      or click **Select one...** and navigate to and choose a public SSH key file from your local file system.
     * Select **PASTE SSH PUBLIC KEY**, and then paste the contents from a public SSH key file into the box.

      **Note:** For information on how to create an SSH key pair, see the [Creating a Key Pair](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm?Highlight=ssh%20key#CreatingaKeyPair) topic in the OCI documentation.

     ![](./images/create-cluster-5.png " ")


4.  Click **Create Cluster**. The **Clusters** page is re-displayed. The status of the new cluster      
    is initially **Creating**.



## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)

## Acknowledgements
* **Authors:**
    * Martin Gubar, Director, Oracle Big Data Product Management
    * Lauran Serhal, Principal Developer, Oracle Database and Big Data User Assistance
* **Last Updated By/Date:** Lauran Serhal, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
