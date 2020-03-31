# Oracle’s Cloud Data Platform: Autonomous-Driven & AI-Infused

## Introduction

*Complete AI Portfolio:*
Oracle offers a complete portfolio of products, services, and differentiated capabilities to power your enterprise with artificial intelligence. For business users, Oracle offers ready-to-go AI-powered cloud applications with intelligent features that drive better business outcomes. With Oracle’s ready-to-build AI platform, data scientists and application developers have a full suite of cloud services to build, deploy, and manage AI-powered solutions. With Oracle’s ready-to-work Autonomous Database, machine learning is working behind the scenes to automate security patching, backups, and optimize database query performance, which helps to eliminate human error and repetitive manual tasks so organizations can focus on higher-value activities.

This is the first of several labs that are part of the **Oracle’s Cloud Data Platform
Autonomous-Driven & AI-Infused** workshop. This workshop will walk you through the process of using the Autonomous Data Warehouse for storing analytical datasets and applying Machine Learning models in order to learn the correlation between different attributes and predict the future demand while leveraging Application Express to create a simple application as well as link to a 3rd party web app. These features will also be integrated through the bonus use of a chatbot that you can interact with using natural language.

You will take on 2 Personas during the workshop. The **Data Scientist Persona** will prepare the data for training and validating the machine learning models and apply those models in order to predict the future demand. The **Business Analyst Persona** will also build and apply Machine Learning models using Oracle Analytics Cloud service without writing a single line of code. During the workshop, you will get exposure to Oracle Autonomous Data Warehouse (ADW), Oracle Machine Learning tool (OML), Oracle Analytics Cloud Service (OAC), Oracle Application Express (APEX), Oracle Rest Data Service (ORDS), and the Oracle Digital Assistant (ODA) chatbot.

Here is an example of that Cloud Data Platform Architecture which can be extended with further Oracle services such as federation through Identity Cloud Service (IDCS) and Oracle Integration Cloud (OIC):

![](./LabOverview/images/cloud-data-construction-arch.jpg " ")

**Note**: This lab is intended to be a comprehensive full cloud showcase. As such, it is assumed a user going through this workshop will be provisioning resources and creating users from scratch. If you decide to use existing infrastructure or resources, be aware and keep note of your namings so resources don't overlap and conflict. 

**Note**: Additionally, as much as possible, do not stray away from the naming conventions used for resources in this worshop. You may run into errors if you do.


**_To log issues_**, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

### Objectives
- Provision an Autonomous Data Warehouse (ADW) Instance
- Build an Oracle Application Express (APEX) App
- Create Machine Learning Models within the Autonomous Data Warehouse (ADW) Instance by using the Oracle Machine Learning Tool (OML)
- Visualize Data and Prediction Models in Oracle Analytics Cloud (OAC)
- Bonus: Integrate a 3rd Party Web App and Oracle Digital Assistant (ODA) Chatbot


### Required Artifacts
- The following lab requires an Oracle Public Cloud account that will either be supplied by your instructor, or can be obtained through the following steps.
- A cloud tenancy where you have the resources available to provision an ADW instance with 2 OCPUs, an OAC instance with 2 OCPUs, and an ODA instance.
- Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.


## Get an Oracle Cloud Trial Account for Free!
If you don't have an Oracle Cloud account then you can quickly and easily sign up for a free trial account that provides:
- $300 of free credits good for up to 3500 hours of Oracle Cloud usage
- Credits can be used on all eligible Cloud Platform and Infrastructure services for the next 30 days
- Your credit card will only be used for verification purposes and will not be charged unless you 'Upgrade to Paid' in My Services

Click here to request your trial account: [https://www.oracle.com/cloud/free](https://www.oracle.com/cloud/free)
