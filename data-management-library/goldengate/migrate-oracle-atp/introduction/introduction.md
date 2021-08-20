# Migrate HR database application to OCI

## Introduction

In this workshop, we will migrate the sample HR database application to an Autonomous Database in Oracle Cloud Infrastructure using new cloud native GoldenGate service. Purpose of this workshop is to show simple and yet efficient way to migrate a database to Oracle Cloud. We will use GoldenGate service for the database migration to designated resources in Oracle Cloud Infrastructure and in the final **Bonus** lab we will create HR application in APEX. This workshop consists of 4 labs. 

*Estimated total Workshop Time*: 1.5 hours

### About HR database

### About GoldenGate Service

### About Terraform 

Terraform is an open-source tool that allows you to manage programmatically, version, and persist infrastructure through the "infrastructure-as-code" model.
The Oracle Cloud Infrastructure (OCI) Terraform provider is a component that connects Terraform to the OCI services that you want to manage. We will use it as our infrastructure orchestration to deploy all necessary resources.

### Objectives

In this workshop you will :
* Explore Cloud-Shell, web-based terminal
* Benefit from OCI terraform provider
* Explore OCI compute service
* Understand the migration flow of GoldenGate
* Explore Autonomous Database and its capabilities
* Dive into APEX low-code application development

**Architecture Overview**

- Virtual Cloud Network: we will create a VCN with a public sub-network and internet access to avoid complexity.
- Source Oracle database: we will create a source database in a Virtual Machine with sample schema, which acts as our source on-premise database. Multiple preparation yet mandatory steps are automated by Terraform and bash script, such as creating GGADMIN schema, granting accesses, enabling supplemental logs etc.
- Target Autonomous database: we will provision Oracle Autonomous Database to act as our target database.
- Goldengate database registration: while our databases are being provisioned and configured, we will register them. Database registration is the vital and important part of GoldenGate deployment. There is no way to connect databases from Goldengate deployment without active registered databases.
- Goldengate deployment: we will create a Microservices environment for an Autonomous Database that applies trails from source to target autonomous database.

	![](/images/architecture.png)

All of the above resources are going to be deployed in Oracle Cloud Infrastructure using Terraform. It is not necessary to have prior knowledge of Terraform scripting. All you need to do is follow every step exactly as described.

### Prerequisites

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the available quotas to provision what mentioned in Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***

**This concludes the introduction. You may now [proceed to next step](#next).**

## Learn More

* [Terraform OCI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraform.htm)
* [Oracle Goldengate](https://docs.oracle.com/en/middleware/goldengate/core/19.1/oggmp/using-oracle-goldengate-microservices-oracle-cloud-marketplace.html)
* [Oracle Autonomous Database](https://docs.oracle.com/solutions/?q=autonomous&cType=reference-architectures&sort=date-desc&lang=en)

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - Vahidin Qerimi - Principal Solution Engineer
* **Last Updated By/Date** - Bilegt Bat-Ochir 9/1/2021