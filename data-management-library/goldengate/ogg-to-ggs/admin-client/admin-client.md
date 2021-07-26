# Use the Admin Client to View Extract Statistics and Log messages

## Introduction

This is an optional lab that guides you on how to connect to the on premise or Marketplace Oracle GoldenGate Admin Client and use it to view all running processes, Extract statistics, log messages, and purge unused files.

Estimated lab time: 5 minutes

### About the Admin Client
The Admin Client is a command line utility that uses Microservices REST API to control and configure tasks in an Oracle GoldenGate deployment. You can also use the Admin Client to create, modify, and remove processes.

### Objectives

In this lab, you will:
* Connect to the Admin Client
* Run various commands

### Prerequisites

This lab assumes you successfully completed all preceding labs.

## **STEP 1:** Retrieve the OCI GoldenGate Deployment URL

1.  Log in to Oracle Cloud Infrastructure.

2.  From the navigation menu, under **Oracle Database**, select **GoldenGate**.

3.  From the list of OCI GoldenGate deployments, select the deployment you created for this LiveLab.

4.  In the Deployment Details page, next to **Console URL** click **Copy**.

## **STEP 2:** Connect to the Admin Client

1.  SSH into the Marketplace Oracle GoldenGate instance.

2.  Change directories to **/u01/app/ogg/bin**, and then start the Admin Client:

    ```
    ./adminclient
    ```

3.  Connect to the OCI GoldenGate deployment:

    ```
    connect <OCI-GoldenGate-deployment-url> as <OCI-GoldenGate-user> password <OCI-GoldenGate-password> !
    ```
    NOTE: The exclamation point (!) is very important. Without it, the command fails and returns an error.

4.  After connecting successfully, you can run any of the following commands:

    Display the status of OCI GoldenGate processes:
    ```
    info all
    ```

    View statistics of your Extract:
    ```
    view stats
    ```

    View the content of a ggserror log file:
    ```
    view messages
    ```

    Purge trail files that are no longer used by Extracts:
    ```
    purge exttrail <trail-file-name>
    ```

## Learn More
* [Using the Admin Client](https://docs.oracle.com/en/middleware/goldengate/core/21.1/admin/getting-started-oracle-goldengate-process-interfaces.html#GUID-84B33389-0594-4449-BF1A-A496FB1EDB29)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Julien Testut, Database Product Management
* **Last Updated By/Date** - Jenny Chan, July 2021
