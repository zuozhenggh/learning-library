# Connnect to the Database

## Introduction

*This lab walks you through the steps required to connect to the database. 

Estimated Time: 20 minutes

### About <Product/Technology> (Optional)


### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Connect to the database

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

* To connect to the database, you'll need the public or private IP address of the DB system.
    - Use the private IP address to connect to the system from your on-premises network, or from within the virtual cloud network (VCN). This includes connecting from a host located on-premises connecting through a VPN or FastConnect to your VCN, or from another host in the same VCN. Use the Exadata system's public IP address to connect to the system from outside the cloud (with no VPN). You can find the IP addresses in the Oracle Cloud Infrastructure Console as follows:
        -  Cloud VM clusters (new resource model): On the Exadata VM Cluster Details page, click Virtual Machines in the Resources list.
        - DB systems: On the DB System Details page, click Nodes in the Resources list.
    - The values are displayed in the Public IP Address and Private IP Address & DNS Name columns of the table displaying the Virtual Machines or Nodes of the Exadata Cloud Service instance.
* For Secure Shell (SSH) access to the DB system, you'll need the full path to the file that contains the private key associated with the public key used when the DB system was launched.


*Below, is the "fold"--where items are collapsed by default.*

## Task 1: Connecting from within the VCN

For security reasons, Oracle recommends that you connect to your database services from within the VCN. You can use this method whether you are connecting to an administration service or to an application service.

1. To connect using SQL*Plus, you run the following command using the applicable connection string:
    sqlplus system/<password>@<connection_string>



## Task 2: Connecting from the internet

Although Oracle does not recommend connecting to your database from the Internet, you can connect to a database service by using a public IP address if port 1521 is open to the public for ingress.

To use this method, you run the following command using the public IP address instead of the hostname or SCAN in the connection string:

1. sqlplus system/<password>@<public_IP>:1521/<service_name>.<DB_domain>

Consider the following:
 - SCANs and hostnames are not resolvable on the Internet, therefore load balancing and failover for multi-node DB systems, which rely on these names, cannot work.
 - For multi-node DB systems, which normally use SCANs, you must specify the IP address of one of the RAC hosts to access the database.

** Do not use this method to connect to the database from within the VCN. Doing so negatively impacts performance because traffic to the database is routed out of the VCN and back in through the public IP address.





## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
