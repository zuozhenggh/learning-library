# Create a private subnet for Load Balancer services

## Introduction

In preparation for creating Kubernetes Load Balancer services, you will need a private subnet set up in the VCN. You can create a new subnet or use an existing private subnet. This tutorial describes how you can create a new subnet in the same VCN where the Kubernetes cluster is running.


Estimated time: 5 minutes


## Task 1:  Create a private subnet

1. 1.	From the Oracle Cloud navigation menu, select **Developer Services** > **Kubernetes Clusters (OKE)**.

   ![Oracle Cloud console, Navigation Menu](images/1-1-menu.png " ")

2. Locate the compartment you created the Kubernetes cluster when you performed the prerequisite **[Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850)** workshop. Then click the name of the VCN.

   ![Oracle Cloud console, Compartment](images/1-2-compartment.png " ")

3.	In the Virtual Cloud Network Details page, click **Create Subnet**.

   ![Oracle Cloud console, Cluster](images/1-3-cluster.png " ")

4. Enter the values to the fields and select options as in below:
     *	Name: **oke-wls-lb-private-subnet**
     *	Create In Compartment:  leave as default
     *	Subnet Type: **Regional**
     *	CIDR Block: **10.0.11.0/24**
     *	Route Table: select **oke-private-routable-&lt;cluster_name&gt:**
     *	Subnet Access: select **Private Subnet**
     *	DHCP options: select **Default DHCP Options for the VCN**
     *	Leave the Security List blank

   Click **Create Subnet**.

      ![Oracle Cloud console, Cluster](images/1-4-subnet.png " ")

      ![Oracle Cloud console, Cluster](images/1-5-subnet.png " ")

5.	In the **Virtual Cloud Network Details** page, **Subnet** section, verify that a new subnet is created. Click the link to the subnet just created.

      ![Oracle Cloud console, Cluster](images/1-6-subnet.png " ")

6.	In the Subnet Details page, click **Copy** next to the OCID. Save the value to a text file. You will need this value in the next Tutorial, when create Load Balancer services.

      ![Oracle Cloud console, Cluster](images/1-7-subnet.png " ")



You may now [proceed to the next tutorial](#next).

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** -
Renjit Clement, Principal Member Technical Staff,<br>
Rupesh Kumar, Consulting Member of Technical Staff,<br>
Ravi Mohan, Senior Software Development Manager,<br>
Steven Lemme, Senior Principal Product Manager,<br>
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, March 2022
