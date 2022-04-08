# Walkthrough the Grabdish Functionality Implemented in PL/SQL

## Introduction

This lab will show you how to  walk through the Grabdish application functionality written in PL/SQL and explain how it works.

Estimated Time: 10 minutes

### Objectives

-   Access the microservices
-   Learn how they work

### Prerequisites

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [Sign Up](http://oracle.com/cloud/free).
* The Grabdish application you deployed in Lab 2

## Task 1: Verify the Order and Inventory Functionality of GrabDish Store

1. Click **Transactional** under **Labs**.

   ![Select Transactional Functionality](images/tx-select.png " ")

3. Check the inventory of a given item such as sushi, by typing `sushi`
    in the `food` field and clicking **Get Inventory**. You should see the inventory
    count result 0.

   ![Get Inventory](images/tx-get-inventory.png " ")

4. (Optional) If for any reason you see a different count, click **Remove Inventory** to bring back the count to 0.

5. Let’s try to place an order for sushi by clicking **Place Order**.

   ![Place Order](images/tx-place-order-66.png " ")

6. To check the status of the order, click **Show Order**. You should see a failed
    order status.

   ![Show Order](images/tx-show-order-66.png " ")

   This is expected, because the inventory count for sushi was 0.

7. Click **Add Inventory** to add the sushi in the inventory. You
    should see the outcome being an incremental increase by 1.

   ![Add Inventory](images/tx-add-inventory.png " ")

8. Go ahead and place another order by increasing the order ID by 1 (67) and then clicking **Place Order**. Next click **Show Order** to check the order status.

   ![Place Order](images/tx-place-order-67.png " ")

   ![Show Order](images/tx-show-order-67.png " ")

   The order should have been successfully placed, which is shown by the order status showing success.


Although this might look like a basic transactional mechanic, the difference in the microservices environment is that it’s not using a two-phase XA commit, and therefore not using distributed locks. In a microservices environment with potential latency in the network, service failures during the communication phase or delays in long running activities, an application shouldn’t have locking across the services. Instead, the pattern that is used is called the saga pattern, which instead of defining commits and rollbacks, allows each service to perform its own local transaction and publish an event. The other services listen to that event and perform the next local transaction.

In this architecture, there is a frontend service which mimics some mobile app requests for placing orders. The frontend service is communicating with the order service to place an order. The order service is then inserting the order into the order database, while also sending a message describing that order. This approach is called the event sourcing pattern, which due to its decoupled non-locking nature is prominently used in microservices. The event sourcing pattern entails sending an event message for every work or any data manipulation that was conducted. In this example, while the order was inserted in the order database, an event message was also created in the Advanced Queue of the Oracle database.

Implementing the messaging queue inside the Oracle database provides a unique capability of performing the event sourcing actions (manipulating data and sending an event message) atomically within the same transaction. The benefit of this approach is that it provides a guaranteed once delivery, and it doesn’t require writing additional application logic to handle possible duplicate message deliveries, as it would be the case with solutions using separate datastores and event messaging platforms.

In this example, once the order was inserted into the Oracle database, an event message was also sent to the interested parties, which in this case is the inventory service. The inventory service receives the message and checks the inventory database, modifies the inventory if necessary, and sends back a message if the inventory exists or not. The inventory message is picked up by the order service which based on the outcome message, sends back to the frontend a successful or failed order status.

This approach fits the microservices model, because the inventory service doesn’t have any REST endpoints, and instead it purely uses messaging. The services do not talk directly to each other, as each service is isolated and accesses its datastore, while the only communication path is through the messaging queue.

This architecture is tied with the Command Query Responsibility Segregation (CQRS) pattern, meaning that the command and query operations use different methods. In our example the command was to insert an order into the database, while the query on the order is receiving events from different interested parties and putting them together (from suggestive sales, inventory, etc). Instead of actually going to suggestive sales service or inventory service to get the necessary information, the service is receiving events.

Let’s look at the PL/SQL source code to understand how Advanced Queuing and Oracle database work together.

![Oracle Database Connections](images/getDBConnection.png " ")

What is unique to Oracle and Advanced Queuing is that a JDBC connection can be invoked from an AQ JMS session. Therefore we are using this JMS session to send and receive messages, while the JDBC connection is used to manipulate the datastore. This mechanism allows for both the JMS session and JDBC connection to exist within same atomic local transaction.

## Task 8: Understand Passing Database Credentials to a Microservice (Study)

To connect to an  'Oracle Autonomous Transaction Processing database you need the following four pieces of information:
   - Database user name
   - Database user password
   - Database Wallet
   - Connect alias, string or URL

Let’s analyze the Kubernetes deployment YAML file: `order-helidon-deployment.yaml` to see how this is done.

    ```
    <copy>
    cat $GRABDISH_HOME/order-helidon/order-helidon-deployment.yaml
    </copy>
    ```

1. The **database user name** is passed as an environment variable:

    ```
    - name: oracle.ucp.jdbc.PoolDataSource.orderpdb.user
      value: "ORDERUSER"
    ```

2. The **database user password** is passed as an environment variable with the value coming from a kubernetes secret:

    ```
    - name: dbpassword
      valueFrom:
        secretKeyRef:
          name: dbuser
          key:  dbpassword
    ```

   Note, code has also been implemented to accept the password from a vault, however, this is not implemented in the workshop at this time.

   The secret itself was created during the setup using the password that you entered.  See `utils/main-setup.sh` for more details.

    ```
    <copy>
    kubectl describe secret dbuser -n msdataworkshop
    </copy>
    ```

   ![Oracle Database User Secret](images/db-user-secret.png " ")

3. The **database wallet** is defined as a volume with the contents coming from a Kubernetes secret:

    ```
    volumes:
      - name: creds
        secret:
          secretName: order-db-tns-admin-secret
    ```

   The volume is mounted as a filesystem:

    ```
    volumeMounts:
      - name: creds
        mountPath: /msdataworkshop/creds
    ```

   And finally, when connecting the TNS_ADMIN is pointed to the mounted filesystem:

    ```
    - name: oracle.ucp.jdbc.PoolDataSource.orderpdb.URL
      value: "jdbc:oracle:thin:@%ORDER_PDB_NAME%_tp?TNS_ADMIN=/msdataworkshop/creds"
    ```

   Setup had previously downloaded a regional database wallet and created the order-db-tns-admin-secret secret containing the wallet files.  See `utils/db-setup.sh` for more details.

    ```
    <copy>
    kubectl describe secret order-db-tns-admin-secret -n msdataworkshop
    </copy>
    ```

   ![Oracle Database Wallet](images/db-wallet-secret.png " ")

4. The database connection URL is passed in as an environment variable.  

    ```
    - name: oracle.ucp.jdbc.PoolDataSource.orderpdb.URL
      value: "jdbc:oracle:thin:@%ORDER_PDB_NAME%_tp?TNS_ADMIN=/msdataworkshop/creds"
    ```

   The URL references a TNS alias that is defined in the tnsnames.ora file that is contained within the wallet.

## Task 9: Understand How Database Credentials are Used by a Helidon Microservice (Study)

Let’s analyze the `microprofile-config.properties` file.

    ```
    <copy>
    cat $GRABDISH_HOME/order-helidon/src/main/resources/META-INF/microprofile-config.properties
    </copy>
    ```

This file defines the `microprofile` standard. It also has the definition of the data sources that will be injected. The universal connection pool takes the JDBC URL and DB credentials to connect and inject the datasource. The file has default values which will be overwritten by the environment variables that are passed in.  

The `dbpassword` environment variable is read and set as the password unless and vault OCID is provided.  

Let’s also look at the microservice source file `OrderResource.java`.

    ```
    <copy>
    cat $GRABDISH_HOME/order-helidon/src/main/java/io/helidon/data/examples/OrderResource.java
    </copy>
    ```

Look for the inject portion. The `@Inject` has the data source under `@Named` as “orderpdb” which was mentioned in the `microprofile-config.properties` file.

    ```
    @Inject
    @Named("orderpdb")
    PoolDataSource atpOrderPdb;
    ```

## Task 11: Develop, Build, Deploy in your Own Environment, Outside Cloud Shell  (Study)

The Cloud Shell is extremely convenient for development as it has various software pre-installed as well as software installed by the workshop, however it is certainly possible to do development outside the Cloud Shell.
The following are the major considerations in doing so...

- Building microservices will of course require the software required for a particular service to be installed. For example maven, GraalVM, etc.

- Pushing microservices to the OCI repository will require logging into the repos via docker and for this you will need an authtoken.
You can re-use the auth token created in the workshop or easily create a new one (see setup lab doc).
    Using the auth token you can then login to docker using the following format (replacing values as appropriate)...

    ```
    <copy>
    docker login -u yourtenancyname/oracleidentitycloudservice/youraccountuser@email.com us-ashburn-1.ocir.io
    </copy>
    ```
    You should then set the DOCKER_REGISTRY value in your environment like this...

    ```
    <copy>
    export DOCKER_REGISTRY=us-ashburn-1.ocir.io/yourtenancyname/yourcompartmentname
    </copy>
    ```
- Deploying microservices to your Kubernetes cluster will require you to install the OCI CLI and kubectl, and run the command found in the OCI console to create the kubeconfig file tha will give you access to the cluster.
This can be found under `Developer Services->Kubernetes Clusters` where you will select your cluster and see the following page where you can copy the necessary command...

   ![Oracle Infrastructure Kubernetes Cluster Screen](images/accessclusterscreen.png " ")
   You should then set the ORDER_PDB_NAME and INVENTORY_PDB_NAME values in your environment like this (note the value does not include the suffix of the service type, only the db name)...

   ```
   <copy>export ORDER_PDB_NAME=grabdisho</copy>
   ```

   ```
   <copy>export INVENTORY_PDB_NAME=grabdishi</copy>
   ```

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Contributors** - Paul Parkinson, Architect and Developer Evangelist
* **Last Updated By/Date** - Richard Exley, April 2022
