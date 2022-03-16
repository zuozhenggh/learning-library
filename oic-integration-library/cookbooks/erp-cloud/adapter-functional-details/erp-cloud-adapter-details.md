# Functional Details of ERP Cloud Adapter

## Introduction

In this section we will see various Out of the Box Adapter capabilities w.r.t design patterns described earlier. You will be executing an hands on lab exercise after understanding the functional usage of the adapter capabilities.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

* Understand Functional Usage of the ERP Cloud adapter

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed.

##	Task	1: ERP Cloud Adapter usage roles

Adapters Identify and Select pattern of Integration upfront. The adapter wizard provides an intuitive way to select task of choice by listing out relevant integration artifacts which provides an abstract view to the Integration Developer

### When used as a trigger role

Adapter Configuration wizard supports ability to process events, expose an object interface, subscription to completed FBDI jobs

![ERP Cloud Adapter Trigger Role](images/erp-adapter-trigger-role.png)

### *Configure Business Events*

Business Event is received as a request that starts the integration. Only events that can be subscribed to are displayed in the Adapter Wizard.

![ERP Cloud Adapter Business Events](images/trigger-business-events.png)

ERP Cloud Adapter Supports Events from various modules such as

- Financials
- Inventory Management
- Maintenance
- Manufacturing
- Order Management
- Product Lifecycle Management
- Procurement
- Supply Chain Collaboration and Visibility
- Project Portfolio Management

### *Configure Business Objects*

Gives functional view of the ERP Cloud objects to expose a comprehensive interface

![ERP Cloud Adapter Business Objects](images/trigger-business-objects.png)


### When used as a invoke role
Adapter Configuration wizard supports ability to invoke SOAP/REST services, simplify invocation of FBDI jobs, send FBDI files to ERP Cloud

![ERP Cloud Adapter Webservices](images/invoke-business-services.png)

##	Task	2: (Exercise) Explore ERP Cloud connection with trigger/invoke roles


You may now **proceed to the next lab**.

## Learn More

* [Getting Started with Oracle Integration](https://docs.oracle.com/en/cloud/paas/integration-cloud)
* [Using the Oracle ERP Cloud Adapter with Oracle Integration](https://docs.oracle.com/en/cloud/paas/integration-cloud/erp-adapter)

## Acknowledgements

* **Author** - Kishore Katta, Product Management, Oracle Integration
* **Contributors** - Subhani Italapuram, Product Management, Oracle Integration
* **Last Updated By/Date** -
