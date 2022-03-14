# Create Oracle Kubernetes Engine

## Introduction

**Oracle Container Engine for Kubernetes (OKE)** is an Oracle-managed container orchestration service that can reduce the time and cost to build modern cloud native applications. Unlike most other vendors, Oracle Cloud Infrastructure provides Container Engine for Kubernetes as a free service that runs on higher-performance, lower-cost compute shapes. 

In this lab, we will create a compartment for all the OCI resources required to host the various open-source tools, and create an OKE cluster

Estimated Time: 2 minutes

### Objectives

In this lab, you will:
* Create a compartment 
* Create an OKE cluster 

### Prerequisites

This lab assumes you have:
* An Oracle account
* You have enough privileges to use OCI
* All previous labs successfully completed

## Task 1: Create Compartment

1. Log in to **OCI** and click on the <a href="#menu">&#9776; hamburger menu</a> at the top left corner of the OCI console, and type **compartment** in the search box. Click on the **Compartments** in the search result

![compartment](images/compartment.png)

2. Specify the name of the compartment such as **HOL-Compartment** with a description, click on **Create Compartment**

![create compartment](images/create-compartment.png)

## Task 2: Create OKE cluster

1. Log in to **OCI** and click on the <a href="#menu">&#9776; hamburger menu</a> at the top left corner of the OCI console, select **Developer Services**, and **Kubernetes Clusters (OKE)**

![oke](images/oke.png)

2. Select the **HOL-compartment** you created earlier

![compartment](images/oke-compartment.png)

3. Make sure the **HOL-compartment** is selected, and click on **Create Cluster**

![Create OKE Cluster](images/create-oke.png)

4. Select **Quick Create** to create OKE cluster. Please note that the **Quick Create** wizard will create a Virtual Cloud Network and an OKE cluster node pool with 3 compute instances

![Quick Create](images/create-oke-quick-create.png)

5. Specify a name for OKE cluster, for example, **cluster1**. Review the rest of the details, you can leave the defaults

![OKE cluster](images/oke-cluster-name.png)

6. You can review all the details of the OKE cluster

![OKE Configuration](images/oke-review.png)

7. Once you have reviewed all the details, click on **Create** to start creating the OKE cluster

![Create OKE Cluster](images/oke-confirm-create.png)

8. On the next screen, wait for all the tasks completed and click on **Close**

![OKE Cluster complete](images/oke-complete.png)

9. You should be redirected to the OKE page showing the creation prgroess of OKE cluster

![OKE creation in progress](images/oke-progess.png)

10. You can also scroll down to the bottom of the page to check the progress details by selecting the "Work Request"

![OKE work request](images/oke-work-request.png)

11. Select the **Work Request** to monitor the OKE creation progress. Once the cluster creation completes, you will see the completed status

![OKE Creation Completed](images/oke-completed.png)

You may now **proceed to the next lab.**

## Acknowledgements
* **Author** 
			 - Ivan Ma, MySQL Engineer, MySQL JAPAC, Ryan Kuan, Cloud Engineer, MySQL APAC
* **Contributors** 
* **Last Updated By/Date** - Ryan Kuan, March 2021