# Introduction

Welcome to migrate to autonomous database lab.

In this lab we will migrate a postgresql database to an Autonomous database in Oracle Cloud Infrastructure. We will use Oracle Goldengate for migration steps, and all of our services will be hosted in OCI for this lab purpose. This lab has 4 steps. 

*Estimated Lab Time*: 1.5 hours

## About GoldenGate for PostgreSQL

## About GoldenGate Microservices

## About Terraform 


**Architecture Overview**

- Virtual Cloud Network: we will create a VCN with public sub network and internet access to avoid complexity.
- Source Postgreqsql database: we will create a Postgresql database server in a Virtual Machine, acts as our source on-premise databas.
- Goldengate for non-Oracle deployment: we will create a Goldengate classic for Postgresql which will extract data from source and ships trails to cloud.
- Goldengate Microservices deployment: we will create a Microservices environment for Autonomous database which applies trails from source to target autonomous database.
- Target Autonomous database: we will provision Oracle Autonomous database acts as our target database.

![](/files/architecture.png)

### Objectives

In this workshop you will :
* Explore Cloud-Shell, web based terminal
* Benefit from OCI terraform provider
* Explore OCI compute service
* Migrate PostgreSQL database to Autonomous Transaction Processing database

**This concludes this lab. You may now [proceed to prerequisites step](#next).**



## Learn More

* 

## Acknowledgements

* **Author** - Bilegt Bat-Ochir, Solution Engineer
* **Contributors** - John Craig, Patrick Agreiter
* **Last Updated By/Date** -


