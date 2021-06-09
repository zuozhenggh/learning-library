# Transactional Tests: Compare MongoDB, Postgres, and Kafka to Oracle DB with TEQ/AQ

## Introduction

This lab will show you how to test different failure scenarios and compare/contrast the behavior when using different resources.

Estimated Lab Time - 10 minutes

### Objectives

-   Test the three failure scenarios shown in the following table...


   ![](images/mongopostgreskafka_vs_OracleAQ.png " ")


### Prerequisites

* Completion of Lab 1 Setup and Lab 2 Microservices Walk-through

## **STEP 1**: Install MongoDB, Postgres, and Kafka, and deploy Order and Inventory services that use them.

1.  Install MongoDB, Postgres, and Kafka:

    ```
    <copy>cd $GRABDISH_HOME/mongodb-kafka-postgres;./install-all.sh</copy>
    ```


2.  Undeploy any existing Order, Inventory, and Supplier Services and deploy the MongoDB, Postgres, and Kafka backed Order and Inventory implementations.
    
    ```
    <copy>
    for i in order-helidon inventory-helidon inventory-helidon-se inventory-python inventory-nodejs inventory-dotnet inventory-go supplier-helidon-se; do cd $GRABDISH_HOME/$i; ./undeploy.sh; done
    cd $GRABDISH_HOME/order-mongodb-kafka ; ./deploy.sh
    cd $GRABDISH_HOME/inventory-postgres-kafka ; ./deploy.sh
    cd $GRABDISH_HOME
    </copy>
    ```

3. Check that all pods and services are running by running the `msdataworkshop` command.

    ```
    <copy>msdataworkshop</copy>
    ```


## **STEP 2**: Run tests against MongoDB, Postgres, Kafka implementations


1.  Click the `Crash order service after Order is inserted` button
2.  Go through the same process as in the Lab 2 Microservices Walk-through and click the `Place Order` button
3.  Notice hang and then the fact that order is pending.

  Crash order service after Order is inserted (before Order message is sent to Inventory service)
  Crash Inventory service after Order message is received (before inventory for order is checked)
  Crash Inventory service after inventory for order is checked (before Inventory status message is sent)
  
   ![](images/getinventory10.png " ")
   
   ![](images/crashorder.png " ")
   
   ![](images/placeorder66.png " ")
   
   ![](images/connectionrefused.png " ")
   
   ![](images/order66pending.png " ")
   
   ![](images/getinventory10.png " ")
   
   ![](images/crashinventorybefore.png " ")
   
   ![](images/crashinventorybeforeset.png " ")
   
   ![](images/placeorder67.png " ")
   
   ![](images/order67pending.png " ")
   
   ![](images/showorder67.png " ")
   
   ![](images/order67success.png " ")
   
   ![](images/getinventory9.png " ")
   
   ![](images/crashinventoryafter.png " ")
   
   ![](images/crashinventoryafterset.png " ")
   
   ![](images/placeorder68.png " ")
   
   ![](images/order68pending.png " ")
   
   ![](images/showorder68.png " ")
   
   ![](images/order68success.png " ")
   
   ![](images/getinventory7.png " ")
  
## **STEP 3**: Deploy Order and Inventory services that use Oracle and AQ/TEQ.

1.  Undeploy any existing Order, Inventory, and Supplier Services and deploy the MongoDB, Postgres, and Kafka backed Order and Inventory implementations.
    
    ```
    <copy>
    for i in order-mongodb-kafka inventory-postgres-kafka; do cd $GRABDISH_HOME/$i; ./undeploy.sh; done
    cd $GRABDISH_HOME/order-helidon ; ./deploy.sh
    cd $GRABDISH_HOME/inventory-helidon ; ./deploy.sh
    cd $GRABDISH_HOME/supplier-helidon-se ; ./deploy.sh
    cd $GRABDISH_HOME
    </copy>
    ```

3. Check that all pods and services are running by running the `msdataworkshop` command.

    ```
    <copy>msdataworkshop</copy>
    ```
   
## **STEP 5**: Run tests against Oracle DB + AQ implementations

1.  Click the `Crash order service after Order is inserted` button
2.  Go through the same process as in the Lab 2 Microservices Walk-through and click the `Place Order` button
3.  Notice hang and then the fact that order is pending.

  Crash order service after Order is inserted (before Order message is sent to Inventory service)
  Crash Inventory service after Order message is received (before inventory for order is checked)
  Crash Inventory service after inventory for order is checked (before Inventory status message is sent)
  
   ![](images/getinventory10.png " ")
   
   ![](images/crashorder.png " ")
   
   ![](images/placeorder66.png " ")
   
   ![](images/connectionrefused.png " ")
   
   ![](images/showordernull.png " ")
   
   ![](images/getinventory10.png " ")
   
   ![](images/crashinventorybefore.png " ")
   
   ![](images/crashinventorybeforeset.png " ")
   
   ![](images/placeorder67.png " ")
   
   ![](images/order67pending.png " ")
   
   ![](images/showorder67.png " ")
   
   ![](images/order67success.png " ")
   
   ![](images/getinventory9.png " ")
   
   ![](images/crashinventoryafter.png " ")
   
   ![](images/crashinventoryafterset.png " ")
   
   ![](images/placeorder68.png " ")
   
   ![](images/order68pending.png " ")
   
   ![](images/showorder68.png " ")
   
   ![](images/order68success.png " ")
   
   ![](images/getinventory7.png " ")
   
   
## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Richard Exley, April 2021
