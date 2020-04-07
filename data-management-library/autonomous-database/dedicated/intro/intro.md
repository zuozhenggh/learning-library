# Workshop Introduction and Overview #

## Introduction to Oracle Autonomous Database Dedicated ##
Oracle Autonomous Database offers two deployment choices - Serverless or  Dedicated.

### ADB Serverless
With Autonomous Database Serverless, Oracle automates all aspect of the infrastructure and database management for customers including provisioning, configuring, monitoring, backing up and tuning.

### ADB Dedicated
Autonomous Database Dedicated allows customers to implement a Private Database Cloud running on dedicated Exadata Infrastructure within the Oracle Public Cloud. Making it an ideal platform to consolidate multiple databases regardless of their workload type or size or to offer database as a service within an enterprise. Dedicated infrastructure provides complete isolation from other tenants and provides an opportunity to customize operational policies, such as software update schedules, availability and density, to match your business requirements.

Watch the video below for an overview of Autonomous Database Dedicated

[](youtube:fOKSNzDz1pk)

## A Private Database Cloud in the Oracle Public Cloud 

With Autonomous Database Dedicated, customers get their own Exadata infrastructure in the Oracle Cloud. The customers administrator simply specifies the size, region and availability domain where they want their dedicated Exadata infrastructure provisioned.  They also get to determine the update or patching schedule if they wish. Oracle automatically manages all patching activity but with Autonomous Database Dedicated service, customers have the option to customize the patching schedule.

## ADB Dedicated Architecture

Autonomous Databases on dedicated Exadata infrastructure have a three-level database architecture model that makes use of Oracle multitenant database architecture.  You must create the dedicated Exadata infrastructure resources in the following order:

1. Autonomous Exadata Infrastructure
2. Autonomous Container Database
3. Autonomous Database

### Autonomous Exadata Infrastructure

This is a hardware rack which includes compute nodes and storage servers, tied together by a high-speed, low-latency InfiniBand network and intelligent Exadata software.

### Autonomous Container Database

This resource provides a container for multiple user databases. This resource is sometimes referred to as a CDB, and is functionally equivalent to the multitenant container databases found in Oracle 12c and higher databases.

### Autonomous Database

You can create multiple Autonomous Databases within the same container database. This level of the database architecture is analogous to the pluggable databases (PDBs) found in non-Autonomous Exadata systems. Your Autonomous Database can be configured for either transaction processing or data warehouse workloads.


Please proceed to the next lab.

## Acknowledgements

- **Authors/Contributors** - Tejus Subramanian, Kris Bhanushali, Yaisah Granillo
- **Last Updated By/Date** - Kay Malcolm, April 2020
- **Workshop Expiration Date** - April 31, 2021

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
