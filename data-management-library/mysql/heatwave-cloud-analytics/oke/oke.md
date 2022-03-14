# Create Oracle Kubernetes Engine

## Introduction

**Oracle Container Engine for Kubernetes (OKE)** is an Oracle-managed container orchestration service that can reduce the time and cost to build modern cloud native applications. Unlike most other vendors, Oracle Cloud Infrastructure provides Container Engine for Kubernetes as a free service that runs on higher-performance, lower-cost compute shapes. 

Before you start to provision any OCI resources, it is a good practice to create a **compartment** as an isolated environment for your work. 
In this lab, we will create a compartment for all the OCI resources required to host the various open-source tools as well as MySQL HeatWave cluster

Estimated Time: 2 minutes

## Task 1: Create Compartment

1. Log in to **OCI** and click on the <a href="#menu">&#9776; hamburger menu</a> at the top left corner of the OCI console, and type **compartment** in the search box. Click on the **Compartments** in the search result

![compartment](images/compartment.png)

2. Specify the name of the compartment such as **PHP-Compartment** with a description, click on **Create Compartment**

![create compartment](images/create-compartment.png)

You may now **proceed to the next lab.**

## Acknowledgements
* **Author** 
			 - Ivan Ma, MySQL Engineer, MySQL JAPAC, Ryan Kuan, Cloud Engineer, MySQL APAC
* **Contributors** 
* **Last Updated By/Date** - Ryan Kuan, March 2021