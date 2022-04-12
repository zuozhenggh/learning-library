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
## Task 2: Add Oracle GoldenGate Users and Database Credentials

You need to establish a database connection through the Administration Client in preparation to issue other Oracle GoldenGate commands that affect the database. Therefore, the Oracle GoldenGate user must have the appropriate database privileges to be able to execute the commands in the Administration Client.

To add Oracle GoldenGate Users and Database Credentials in the Administration Client:

1. Run the following command to add a user:

    ```
    <copy>
    ALTER CREDENTIALSTORE ADD USER c##ggadmin@phoenix98251.dev3sub1phx.databasede3phx.oraclevcn.com:1521/orcl.dev3sub1phx.databasede3phx.oraclevcn.com ALIAS cggnorth  DOMAIN OracleGoldenGate Password Welcome1
    <copy>

    ```
2.  To establish a database connection through Administration Client, run the following command:

    ```
    <copy>
    DBLOGIN USERIDALIAS ggeast
    <copy>

    ```

## Learn More
* [Using the Admin Client](https://docs.oracle.com/en/middleware/goldengate/core/21.1/admin/getting-started-oracle-goldengate-process-interfaces.html#GUID-84B33389-0594-4449-BF1A-A496FB1EDB29)
* [Command Line Interface Reference for Oracle GoldenGate](https://docs.oracle.com/en/middleware/goldengate/core/21.3/gclir/command-line-interfaces.html#GUID-C0F6B123-14C0-466F-AE43-CAFB99B08C3D)
* [ALTER CREDENTIALSTORE](https://docs.oracle.com/en/middleware/goldengate/core/21.3/gclir/alter-credentialstore.html#GUID-50893039-3C29-4C66-87E4-F63EAB05C811)
* [DBLOGIN USERIDALIAS](https://docs.oracle.com/en/middleware/goldengate/core/21.3/gclir/dblogin-useridalias.html#GUID-897F212D-7F83-4610-BCE8-E1D61744D9AA)

## Acknowledgements
* **Author**
* **Contributors**
* **Last Updated By/Date**
