# Add Oracle GoldenGate Users and Database Credentials

## Introduction
This lab describes how to add the database credentials to connect to the source and target databases using the Administration Service.

The Administration Service is one of the components of Oracle GoldenGate Microservices Architecture. This service supervises, administers, manages, and monitors processes (such as Extract and Replicat) within an Oracle GoldenGate Deployment. The Administration Service is the central control entity for managing the replication components in an Oracle GoldenGate deployment. In this service, you can manage your local Extract and Replicat processes without having to access the server where Oracle GoldenGate is installed.

The Admin Client is a command line utility (similar to the classic GGSCI utility).You can use it to issue the complete range of commands that configure, control, and monitor Oracle GoldenGate.

This lab walks you through the steps to connect the Administration Service with the Administration Client, and then create Oracle GoldenGate Users and database credentials.

*Estimated Lab Time*: 30 minutes

### Objectives
In this lab, you will:
* Connect to the Administration Server from the Administration Client.
* Add Oracle GoldenGate Users.
* Create Database credentials.

## Task 1: Connect to the Administration Server from the Administration Client

1. Open the Administration Client.

2. Execute the following command to connect to the Administration Service:

    ```
    <copy>
    CONNECT http://phoenix98251.dev3sub1phx.databasede3phx.oraclevcn.com:9012 deployment ggdepdev as oggadmin password oggadmin
    <copy>

    ```


## Learn More
* [Using the Admin Client](https://docs.oracle.com/en/middleware/goldengate/core/21.1/admin/getting-started-oracle-goldengate-process-interfaces.html#GUID-84B33389-0594-4449-BF1A-A496FB1EDB29)

## Acknowledgements
* **Author**
* **Contributors**
* **Last Updated By/Date**
