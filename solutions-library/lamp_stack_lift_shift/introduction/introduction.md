# LAMP Stack Lift & Shift Workshop

## Introductions
This workshop series is a part of *Oracle Cloud Infrastructure's Third Party Move & Improve* workshop. This series will walk you through the process of migrating an existing LAMP Stack application from an on-prem environment to being natively deployed within the cloud. It will walk you through how to migrate data from on-prem MySQL to MySQL on OCI (MDS). Later, the workshop focuses on how to configure a Compute Instance and migrate the PHP LAMP Stack Application to OCI and how to connect the PHP Application with MySQL (MDS). The workshop also focuses on how to dockerize the application and deploy the LAMP Stack application on OKE Cluster.
This workshop will also help you to understand how to configure Network, Security Lists. The LAMP stack stands for Linux, Apache, MySQL, PHP and SSH.

Estimated Workshop Time:  xx minutes

### About Oracle Cloud Platform
Oracle offers a complete portfolio of products, services, and differentiated capabilities to power your enterprise. For business users, Oracle offers ready-to-go networking options, server shapes, and enterprise-grade infrastructure that drives better business outcomes. With Oracle's Autonomous Database and Analytics tools, data scientists and application developers have a full suite of cloud services to build, deploy, and manage any type of solution. Machine learning is working behind the scenes in these products to automate security patching, backups, and optimize database query performance, which helps to eliminate human error and repetitive manual tasks so organizations can focus on higher-value activities.

### Objectives
* Provision MySQL Database (MDS) on OCI
* Migrate data from on-prem MySQL to MySQL on OCI (MDS)
* Provision underlying infrastructure such as networking, security lists etc
* Configure VM for PHP LAMP Stack Application
* Connect PHP Application with MySQL
* Dockerize PHP Application and deploy on OKE Cluster

### Prerequisites
* An Oracle Paid or LiveLabs Cloud account.
* A cloud tenancy where you have the resources available workshop to provision an MySQL instance with 1 OCPUs, an OCI Compute instance with 1 OCPUs, OKE Cluster
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

## Appendix:  Workshop Assumptions
*Note:* This workshop is intended to be a comprehensive full cloud showcase. As such, it is assumed a user going through this workshop will be provisioning resources and creating users from scratch. If you decide to use existing infrastructure or resources, be aware and keep note of your naming's so resources don't overlap and conflict.

*Note:* Additionally, as much as possible, do not stray away from the naming conventions used for resources in this workshop. You may run into errors if you do.

## Acknowledgements
* **Author** - Rajsagar Rawool
* **Adapted for Cloud by** -  Rajsagar Rawool
* **Last Updated By/Date** - Rajsagar Rawool, November 2020
