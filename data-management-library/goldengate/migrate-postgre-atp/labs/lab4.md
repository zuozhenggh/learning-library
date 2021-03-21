# LAB 4

## Introduction

Final lab of this workshop will guide you how to setup simple migration to ATP using Goldengate Microservices. By using Oracle GoldenGate Microservices on Oracle Cloud Marketplace, replication from on-premises to cloud and cloud-to-cloud platforms can easily be established and managed. With Oracle GoldenGate Microservices on Marketplace, you can deploy Oracle GoldenGate in an off-box architecture, which means you can run and manage your Oracle GoldenGate deployment from a single location.

## Objectives

In this final step of workshop, we will configure replication process in Microservices and apply captured changes from source database to our target Autonomous database. This is final lab.

## **Step 1**:	Access to Goldengate Microservices instance

After successful creating extract processes, now it is time to explore your GG Microservices server. Let's make console connection to microservice, copy ip address of OGG_Microservices_Public_ip and connect using:

**`ssh opc@your_microservice_ip_address -i ~/.ssh/oci`**

## **Step 2**: Retrieve Goldengate Microservices’ admin password

Once you are in issue following **`cat ogg-credentials.json`**, and copy credential value from output

![](/files/oggadmin.png)

Good practice is to keep it in your notepad. 

## **Step 3**: Login to Microservices web console

Now, open your web browser and point to https://your_microservices_ip_address. Provide oggadmin in username and credentials, then log in

![](/files/gg_oggadmin.png)

## **Step 4**: Open Target Receiver server

Then click on Target Receiver server's port **9023**, it will redirect you to new tab, provide your credentials again for username **oggadmin**.

![](/files/gg_oggadmin_0.png)

You should be seeing something like this, what it means that your extdmp is pumping some trail files to your Microservices.

![](/files/gg_oggadmin_1.png)

This is something you'd need if you'd want continuous replication and migration. 

## **Step 5**: Open Target Administration server

In this lab scope, we will only migrate to ATP with help of initload. Click on Target Receiver server port **9021**, it will redirect you to new tab, provide your credentials again for username **oggadmin**.

![](/files/micro_oggadmin_0.png)

## **Step 6**: Modify Goldengate credentials

You should be seeing empty Extracts and Replicats dashboard. Let's add some Autonomous Database credentials at first. Open hamburger menu on left top corner, choose **Configuration**

![](/files/micro_ggadmin_0.png)

It will open OGGADMIN Security and you will see we already have a connection to **HOL Target ATP** database. However, you still need to add password here. Click on a pencil icon to alter credentials.

![](/files/micro_ggadmin_1.png)

## **Step 7**: Update password and test connection

Provide password ` GG##lab12345 ` and verify it. This is your ggadmin password, which we provided in lab 3. 
**NOTE: if you specified different password, please use that password**

![](/files/micro_ggadmin_2.png)

After that click on **Log in** database icon.

![](/files/micro_ggadmin_3.png)

## **Step 8**: Add checkpoint table

Scroll to **Checkpoint** part and click on **+** icon, then provide `ggadmin.chkpt` and **SUBMIT**. 

![](/files/micro_ggadmin_4.png)

Checkpoint table contains the data necessary for tracking the progress of the Replicat as it applies transactions to the target system. Regardless of the Replicat that is being used, it is a best practice to enable the checkpoint table for the target system.

Now let's go back to **Overview** page from here.

## **Step 9**: Add replication process

The apply process for replication, also known as Replicat, is very easy and simple to configure. There are five types of Replicats supported by the Oracle GoldenGate Microservices. In overview page, go to Replicat part and click on **+** to create our replicat process.

![](/files/micro_initload_0.png)

We will choose **Nonintegrated Replicat** for initial load, click **Next**. In non-integrated mode, the Replicat process uses standard SQL to apply data directly to the target tables. In our case, number of records in source database is small and we don't need to run in parallel apply, therefore it will suffice.

![](/files/micro_initload_1.png)

## **Step 10**: Modify replication parameters

Provide your name for replicat process, for example **initload**, process name has to be unique and 8 characters long. It is better if you give some meaningful names to identify them later on. 
I choose to name it as **initload**, because this is currently our initial load process.

![](/files/micro_initload_2_1.png)

Then click on **Credentials Domain** drop-down list. There is only one credential at the moment, choose the available option for you.  
In the **Credential Alias**, choose **hol_tp** from drop down, which is our pre-created connection group to target ATP. 

![](/files/micro_initload_2_2.png)

After that go below to find Trail Name and edit to **il**. We defined this in our extract parameter, so it cannot be just a random name.

![](/files/micro_initload_2_3.png)

Also provide **/u02/trails** in "Trail Subdirectory" and choose a **Checkpoint Table** from drop-down list. It is **GGADMIN.CHKPT** in our case.


Review everything then click **Next**


## **Step 11**: Edit parameter file

Microservices has created some draft parameter file for your convenience, let's edit to our need.

![](/files/micro_initload_3_1.png)

Erase existing and paste below configuration 

```
replicat initload
useridalias hol_tp domain OracleGoldenGate
MAP public."Countries", TARGET admin.Countries;
MAP public."Cities", TARGET admin.Cities;
MAP public."Parkings", TARGET admin.Parkings;
MAP public."ParkingData", TARGET admin.ParkingData;
MAP public."PaymentData", TARGET admin.PaymentData;
```

![](/files/micro_initload_3_2.png)


I hope everything is correct until this stage. Click **Create and Run** to start our replicat.


![](/files/micro_initload_4.png)


## **Step 12**: Check INITLOAD status

In overview dashboard, now you should be seeing successful running INITLOAD replication. Click on **Action** button choose **Details**.


![](/files/micro_initload.png)


You can see details of running replicat process. In statistics tab, you'd see some changes right away. Because this is Initial load you will not see any update there, but in continuous replication case we see totally different numbers.

![](/files/micro_initload_5.png)

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

3. [Autonomous Database offerings ](https://docs.oracle.com/en-us/iaas/Content/Database/Concepts/adboverview.htm)
- Target ATP

4. [Oracle Cloud Marketplace](https://docs.oracle.com/en-us/iaas/Content/Marketplace/Concepts/marketoverview.htm)
- Goldengate non-oracle deployment 
- Goldengate Microservices deployment


## Acknowledgements

* **Author** - Bilegt Bat-Ochir, Solution Engineer
* **Contributors** - John Craig, Patrick Agreiter
* **Last Updated By/Date** -