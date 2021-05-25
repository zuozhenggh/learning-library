# Skillset Tracking Application                                   

The goal of this workshop is to build a customizable application starting from a ***simple JSON file***, using an ***Oracle Autonomous JSON Database*** to store the data in ***SODA Document Collections***. The application is using ***NodeJS*** and ***SODA*** on the server-side, and ***OracleJET*** for the interface. There is also an integration with ***Oracle Digital Assistant (ODA)***.

## Code customization

The application presented in the workshop is based on a sample JSON file with data regarding a group of employees and details about them and their skills on certain categories of skills and areas of development. The JSON can be easily updated in order to fit any other business need.

## Dependencies
* OCI tenancy
* see **Lab 3: Install and prepare prerequisites** for more dependencies

## Lab Breakdown
| Lab | Description |
| ----       |    ----  |
| **Lab 1:** Generate SSH Key | Learn how to generate SSH keys. These are going to be used later in the other labs for connecting to the OCI instances |
| **Lab 2:** Login to OCI | Create an Oracle account |
| **Lab 3:** Install and prepare prerequisites | Download and install the needed packages and software |
| **Lab 4:** Autonomous JSON Database & SODA Collections | Learn how to create an Autonomous JSON Database, an Object Storage Standard Bucket, upload an object (a JSON file) into the bucket, then use the DBMS_CLOUD package to create a document collection in the database with the data from the Object Storage |
| **Lab 5:** Build an OracleJET Web Application | Go through a series of steps to build and run a simple OracleJET application with a treemap based on a static JSON file |
| **Lab 6:** Build NodeJS APIs | Learn how to use SODA for NodeJS to build and test APIs for manipulating data in a document collection from an Autonomous JSON Database  |
| **Lab 7:** Integration with Oracle Digital Assistant and Slack | Learn how to provision an Oracle Digital Assistance Instance, download, import and test a Skill, create a Slack Channel and Workspace and integrate your Bot with Slack channel.  |
| **Lab 8:** Deployment on OKE | Create a Docker file and deploy the NodeJS APIs code in Container Engine for Kubernetes (OKE) |
| **Lab 9:** Set up the Development Environment | Put it all together in one single application that uses an Autonomous JSON Database for storing the data, APIs built using SODA for NodeJS to manipulate the data, OracleJET for the user interface, an integration with Oracle Digital Assistant and an integration with OKE |
