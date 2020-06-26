# Access a BDS Node Using a Public IP

## Introduction *** Work in Progress, Don't Review ***

Big Data Service nodes are by default assigned private IP addresses, which aren't accessible from the public internet. One way to make a node accessible from the internet is to map a node's private IP address to a public IP address.

In this lab, you will use the Oracle Cloud Infrastructure Cloud Shell, which is a web browser-based terminal accessible from the Oracle Cloud Console. You'll gather some information about your network and your cluster nodes, and then you'll pass that information to commands in the shell. To perform this task, you must have a cluster running in a VCN in your tenancy, and that cluster must have a regional, public subnet.

### Objectives

* Learn how to gather information about the cluster.
* Learn how to map private IP Address of a node to a public IP address

### What Do You Need?

This lab assumes that you have successfully completed the following labs in the **Contents** menu on the right:
+ **Lab 1: Setup the BDS Environment**
+ **Lab 2: Create a BDS Hadoop Cluster**
+ **Lab 3: Add Oracle Cloud SQL to the Cluster**

## STEP 1: Gather Information About the Cluster

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator, if you are not already logged in. On the **Sign In** page, select your `tenancy`, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

2. Click the **Navigation** menu in the upper left-hand corner of the **Oracle Cloud Console** Home page. Under **Data & AI**, select **Big Data**.

3. On the **Clusters** page, click the **`training-cluster`** link in the **Name** column to display the **Cluster Details** page.

4. In the **Cluster Information** tab, under **Network Information**, click the **Copy** link next to **Subnet OCID**. Next, paste that OCID to an editor or a file, so you can retrieve it later in this process.

5. On the same page, under **List of Cluster Nodes**, in the **IP Address** column, find the private IP address for the first utility node, **`traininun0`**. Save the IP address so that you can retrieve it later.

## STEP 2: Map the Private IP Address to a Public IP Address

In this step, you will set three variables using the **`export`** command. The variables will be used in the **oci network** command that you will use to map the private IP address of the first utility node to a public IP address.

1. In the Cloud Console, click the Cloud Shell Cloud Shell icon at the top of the page. It may take a few moments to connect and authenticate you.

2. At the command line prompt, enter the following command, or use the **Copy** button to the command, and then  paste it in the command line. The **_`<display-name>`_** is optional. It is a "friendly name" that will be attached to the reserved public IP address. This name is not pre-existing. It's created when you run this command.

    For convenience, you might want to use the name of the node whose private IP address you're mapping such as `traininun0`.

      ```
    <copy>export DISPLAY_NAME=&lt;<i>display-name</i>&gt;</copy>
      ```
3. At the command line prompt, enter the following command, or use the **Copy** button to the command, and then paste it in the command line. Replace the **_``<subnet-ocid>``_** with your own **subnet-ocid** that you identified in **STEP 1** in this lab. This is the OCID of the customer public subnet used by the cluster.  

      ```
    <copy>export SUBNET_OCID=&lt;<i>subnet-ocid</i>&gt;</copy>
      ```
4. At the command line prompt, enter the following command, or use the **Copy** button to the command, and then paste it in the command line. The <ip-address> is the private IP address assigned to the node that you want to map.

      ```
    <copy>export PRIVATE_IP=&lt;<i>ip-address</i>&gt;</copy>
      ```
5.  At the command line prompt, enter the following command exactly as it's shown below without any breaks, or use the **Copy** button to the command, and then paste it in the command line.

      ```
    <copy>oci network public-ip create --display-name $DISPLAY_NAME --compartment-id `oci network private-ip list --subnet-id $SUBNET_OCID --ip-address $PRIVATE_IP | jq -r '.data[] | ."compartment-id"'` --lifetime "RESERVED" --private-ip-id `oci network private-ip list --subnet-id $SUBNET_OCID --ip-address $PRIVATE_IP | jq -r '.data[] | ."id"'`</copy>
      ```
6.  In the output returned, find the value for **ip-address**. In our example, it's 203.0.113.1. This is the new reserved public IP address that is mapped to the private IP address for the node.

7.  To see the reserved public IP address in the console, click the Navigation menu and navigate to  **Core Infrastructure > Networking > Virtual Cloud Networks**. In the navigation list on the left, under **Networking**, click **Public IPs**. The new reserved public IP address appears in the **Reserved Public IPs** list. If you did specify a display name in the **oci network** command that you ran above, that name will appear in the **Name** column; Otherwise, a name such as  **publicipnnnnnnnnn** is generated.

**This concludes this lab. Please proceed to the next lab in the Contents menu on the right.**

## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)

## Acknowledgements

* **Authors:**
    + Martin Gubar, Director, Oracle Big Data Product Management
    + Lauran Serhal, Principal Developer, Oracle Database and Big Data User Assistance
* **Last Updated By/Date:** Lauran Serhal, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
