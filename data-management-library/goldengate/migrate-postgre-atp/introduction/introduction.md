# Migrate PostgreSQL to Oracle Autonomous database workshop

## Introduction

Welcome to migrate to autonomous database workshop.

In this workshop we will migrate a postgresql database to an Autonomous database in Oracle Cloud Infrastructure. We will use Oracle Goldengate for migration steps, and all of our services will be hosted in OCI for this workshop purpose. This workshop has 4 steps. 

*Estimated total Workshop Time*: 1.5 hours

### About GoldenGate for PostgreSQL

Oracle GoldenGate on Marketplace contains pre-configured Oracle GoldenGate for Non-Oracle for PostgreSQL. We will use it for our extract data processes from source PostgreSQL.

### About GoldenGate Microservices

Oracle GoldenGate Microservices Architecture allows this premier replication tool to scale out to the cloud and provide a secure, flexible and scalable replication platform. It has very clear and easy to manage both extract and replicate processes from on-premises to cloud, and cloud to cloud. We will use it to replicate our extracted data in target Autonomous Database.

### About Terraform 

Terraform is an open source tool that allows you to programmatically manage, version, and persist infrastructure through the "infrastructure-as-code" model.
The Oracle Cloud Infrastructure (OCI) Terraform provider is a component that connects Terraform to the OCI services that you want to manage. We will use it as our infrastructure orchestration to deploy all necessary resources.

### Objectives

In this workshop you will :
* Explore Cloud-Shell, web based terminal
* Benefit from OCI terraform provider
* Explore OCI compute service
* Migrate PostgreSQL database to Autonomous Transaction Processing database
* Explore Autonomous Database and its capabilities

**Architecture Overview**

- Virtual Cloud Network: we will create a VCN with public sub network and internet access to avoid complexity.
- Source Postgreqsql database: we will create a Postgresql database server in a Virtual Machine, acts as our source on-premise database.
- Goldengate for non-Oracle deployment: we will create a Goldengate classic for Postgresql which will extract data from source and ships trails to cloud.
- Goldengate Microservices deployment: we will create a Microservices environment for Autonomous database which applies trails from source to target autonomous database.
- Target Autonomous database: we will provision Oracle Autonomous database acts as our target database.

	![](/images/architecture.png)

All of these mentioned resources are going to to be deployed in Oracle Cloud infrastructure using Terraform. It is not necessary to have prior knowledge of Terraform scripting, all you need to do is follow every steps exactly as it described.

### Prerequisites

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor, or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the resources available to provision what mentioned in Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

**This concludes introduction. You may now [proceed to next step](#next).**

## Learn More

* [Terraform OCI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraform.htm)
* [Oracle Goldengate](https://docs.oracle.com/en/middleware/goldengate/core/19.1/oggmp/using-oracle-goldengate-microservices-oracle-cloud-marketplace.html)
* [Oracle Autonomous Database](https://docs.oracle.com/solutions/?q=autonomous&cType=reference-architectures&sort=date-desc&lang=en)

## Acknowledgements

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - Bilegt Bat-Ochir 3/22/2021