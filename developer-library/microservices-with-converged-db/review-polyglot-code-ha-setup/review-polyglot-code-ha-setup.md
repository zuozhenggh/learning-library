# Polyglot Microservices
## Introduction

This lab will show you how to switch the Inventory microservice to a Python, Node.js or Java Helidon SE implementation while retaining the same application functionality.

![](images/architecture.png " ")

### Objectives
-   Undeploy the existing Java Helidon MP Inventory microservice
-   Deploy an alternate implementation of the Inventory mmicroservice and test the application functionality

### What Do You Need?

This lab assumes you have already completed Lab 1 to 4.

## **STEP 1**: Undeploy the Java Helidon MP Inventory Microservice

1. To undeploy the Inventory Helidon service, open the Cloud Shell and go to the
    inventory-helidon folder, using the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon ; ./undeploy.sh</copy>
    ```

   ![](images/undeploy-inventory-helidon-mp.png " ")

## **STEP 2**: Deploy an alternate implementation of the Inventory Microservice

In this step you can choose between three different implementations of the Inventory Microservice - 1. Java Helidon SE, 2. Python, or 3. Node.js

1. Java Helidon SE: To deploy the service.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon-se; ./deploy.sh</copy>
    ```

2. Python: To deploy the service.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-python; ./deploy.sh</copy>
    ```

3. Node.js: To deploy the service.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-nodejs; ./deploy.sh</copy>
    ```

## **STEP 3**: Verify Application Functionality

1. Repeat Lab 4 Step 2 to verify the order and inventory functionality of the GrubDash store.

## Acknowledgements
* **Authors** - Richard Exley, Maximum Avaiability Architecture; Curtis Dinkel, Maximum Avaiability Architecture; Rena Granat, Maximum Avaiability Architecture;
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
