# Migrate to ATP

## Introduction

Final lab of this workshop will guide you how to setup simple migration to ATP using Goldengate Microservices. By using Oracle GoldenGate Microservices on Oracle Cloud Marketplace, replication from on-premises to cloud and cloud-to-cloud platforms can easily be established and managed. With Oracle GoldenGate Microservices on Marketplace, you can deploy Oracle GoldenGate in an off-box architecture, which means you can run and manage your Oracle GoldenGate deployment from a single location.

*Estimated lab time*: 30 minutes

### Objectives

In this final step of workshop, we will configure replication process in Microservices and apply captured changes from source database to our target Autonomous database. This is final lab.

### Prerequisites

* This lab assumes that you completed all preceding labs, and ready to migrate to ATP.

## **Step 1**:	Access to Goldengate Microservices instance

1. After successful creating extract processes, now it is time to explore your GG Microservices server. Let's make console connection to microservice, copy ip address of `OGG_Microservices_Public_ip` from your note and connect using:

	**`ssh opc@your_microservice_ip_address -i ~/.ssh/oci`**

## **Step 2**: Retrieve Goldengate Microservices’ admin password

1. Once you are in issue following **`cat ogg-credentials.json`**, and copy credential value from output

	![](/images/oggadmin.png)

2. Good practice is to keep it in your notepad. 

## **Step 3**: Login to Microservices web console

1. Open your web browser and point to `https://your_microservices_ip_address`. Provide oggadmin in username and password which you copied, then log in.

	![](/images/gg_oggadmin.png)

## **Step 4**: Open Target Receiver server

1. Then click on Target Receiver server's port **9023**, it will redirect you to new tab, provide your credentials again for username **oggadmin**.

	![](/images/gg_oggadmin_0.png)

2. You should be seeing something like this, what it means that your extdmp is pumping some trail files to your Microservices.

	![](/images/gg_oggadmin_1.png)

This is something you'd need if you'd want continuous replication and migration. 

## **Step 5**: Open Target Administration server

1. In this lab scope, we will only migrate to ATP with help of initload. Click on Target Receiver server port **9021**, it will redirect you to new tab, provide your credentials again for username **oggadmin**.

	![](/images/micro_oggadmin_0.png)

## **Step 6**: Modify Goldengate credentials

1. You should be seeing empty Extracts and Replicats dashboard. Let's add some Autonomous Database credentials at first. Open hamburger menu on left top corner, choose **Configuration**

	![](/images/micro_ggadmin_0.png)

2. It will open OGGADMIN Security and you will see we already have a connection to **HOL Target ATP** database. However, you still need to add password here. Click on a pencil icon to **alter credentials**.

	![](/images/micro_ggadmin_1.png)

## **Step 7**: Update password and test connection

1. Provide the password `GG##lab12345` and verify it. This is your ggadmin password, which we provided in lab 3.

	![](/images/micro_ggadmin_2.png)

2. After that click on **Log in** database icon.

	![](/images/micro_ggadmin_3.png)

## **Step 8**: Add checkpoint table

3. Scroll to **Checkpoint** part and click on **+** icon, then provide `ggadmin.chkpt` and **SUBMIT**. 

	![](/images/micro_ggadmin_4.png)

	Checkpoint table contains the data necessary for tracking the progress of the Replicat as it applies transactions to the target system. Regardless of the Replicat that is being used, it is a best practice to enable the checkpoint table for the target system.

4. Now let's go back to **Overview** page from here.

## **Step 9**: Add replication process

1. The apply process for replication, also known as Replicat, is very easy and simple to configure. There are five types of Replicats supported by the Oracle GoldenGate Microservices. In overview page, go to Replicat part and click on **+** to create our replicat process.

	![](/images/micro_initload_0.png)

2. We will choose **Nonintegrated Replicat** for initial load, click **Next**. In non-integrated mode, the Replicat process uses standard SQL to apply data directly to the target tables. In our case, number of records in source database is small and we don't need to run in parallel apply, therefore it will suffice.

	![](/images/micro_initload_1.png)

## **Step 10**: Modify replication parameters

1. Provide your name for replicat process, for example **initload**, process name has to be unique and 8 characters long. It is better if you give some meaningful names to identify them later on. Let's name it as **initload**, because this is currently our initial load process.

	![](/images/micro_initload_2_1.png)

2. Then click on **Credentials Domain** drop-down list. There is only one credential at the moment, choose the available option for you. In the **Credential Alias**, choose **hol_tp** from drop down, which is our pre-created connection group to target ATP. 

	![](/images/micro_initload_2_2.png)

3. After that go below to find Trail Name, add **il** as trail name, because we defined this in our extract parameter, so it cannot be just a random name.

	![](/images/micro_initload_2_3.png)

4. Also provide **/u02/trails** in "Trail Subdirectory" and choose a **Checkpoint Table** from drop-down list. It is **GGADMIN.CHKPT** in our case.

5. Review everything then click **Next**

## **Step 11**: Edit parameter file

1. Microservices has created some draft parameter file for your convenience, let's edit to our need.

	![](/images/micro_initload_3_1.png)

2. Erase existing and paste below configuration 

	```
	<copy>
	replicat initload
	useridalias hol_tp domain OracleGoldenGate
	MAP public."Countries", TARGET admin.Countries;
	MAP public."Cities", TARGET admin.Cities;
	MAP public."Parkings", TARGET admin.Parkings;
	MAP public."ParkingData", TARGET admin.ParkingData;
	MAP public."PaymentData", TARGET admin.PaymentData;
	</copy>
	```

	![](/images/micro_initload_3_2.png)

3. Make sure everything is correct until this stage. Click **Create and Run** to start our replicat.

	![](/images/micro_initload_4.png)


## **Step 12**: Check INITLOAD status

1. In overview dashboard, now you should be seeing successful running INITLOAD replication. Click on **Action** button choose **Details**.

	![](/images/micro_initload.png)
	
2. You can see details of running replicat process. In statistics tab, you'd see some changes right away. Because this is Initial load you will not see any update there, but in continuous replication case we see totally different numbers.

	![](/images/micro_initload_5.png)

Congratulations! You have completed this workshop! 

You successfully migrated Postgresql database to Autonomous Database in Oracle Cloud Infrastructure.

## Summary

Here is summary of resources which was created by Terraform script and used in our workshop.

1. [Virtual Cloud Network](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingVCNs.htm)
- Public Subnet, Internet Gateway
- Private Subnet, NAT Gateway, Service gateway

2. [Compute Virtual Machines and Shapes, OS Images](https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm)
- Source PostgreSQL database instance, 
- Goldengate PostgreSQL instance
- Goldengate Microservices instance

3. [Autonomous Database offerings](https://docs.oracle.com/en-us/iaas/Content/Database/Concepts/adboverview.htm)
- Target ATP

4. [Oracle Cloud Marketplace](https://docs.oracle.com/en-us/iaas/Content/Marketplace/Concepts/marketoverview.htm)
- Goldengate non-oracle deployment 
- Goldengate Microservices deployment

## **Rate this Workshop**

Don't forget to rate this workshop!  We rely on this feedback to help us improve and refine our LiveLabs catalog.  Follow the steps to submit your rating.

1.  Go back to your **workshop homepage** in LiveLabs by going back to your workshop and clicking the Launch button.
2.  Click on the **Brown Button** to re-access the workshop  

    ![](/images/workshop-homepage-2.png " ")

3.  Click **Rate this workshop**

    ![](/images/rate-this-workshop.png " ")

## Acknowledgements

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - Bilegt Bat-Ochir 3/22/2021