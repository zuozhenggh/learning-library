# Review Polyglot Code
## Introduction

This lab will show you how to switch the Inventory microservice to a Python, Node.js or Java Helidon SE implementation while retaining the same application functionality.

![](images/veggie-dash-app-arch.png " ")

### Objectives
-   Undeploy the existing Java Helidon MP Inventory microservice
-   Deploy an alternate implementation of the Inventory mmicroservice and test the application functionality

### What Do You Need?

This lab assumes you have already completed the following labs:
- Sign Up for a Free Tier
- Setup OCI, OKE, ATP and Cloud shell
- Build the GitHub code and deploy the microservices
- Setup Service broker and Messaging

## **STEP 1**: Undeploy the Java Helidon MP Inventory Microservice

1. To undeploy the Inventory Helidon service, open the Cloud Shell and go to the
    inventory-helidon folder, using the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon ; ./undeploy.sh</copy>
    ```

## **STEP 2**: Deploy and alternate implementation of the Inventory Microservice

In this step you can choose between three different implementations of the Inventory Microservice - 1. Java Helidon MP, 2. Python, or 3. Node.js

1. To build and deploy the Java Helidon SE implementation of the Inventory Microservice, open the Cloud Shell and execute the following command the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon-se ; ./build.sh ; ./deploy.sh</copy>
    ```

TODO

   Once the image has been deployed in a pod, you should see the following message.

TODO

2. To build and deploy the Python implementation of the Inventory Microservice, open the Cloud Shell and execute the following command the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-python ; ./build.sh ; ./deploy.sh</copy>
    ```

TODO

   Once the image has been deployed in a pod, you should see the following message.

TODO

3. To build and deploy the Node.js implementation of the Inventory Microservice, open the Cloud Shell and execute the following command the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-nodejs ; ./build.sh ; ./deploy.sh</copy>
    ```

TODO

   Once the image has been deployed in a pod, you should see the following message.

TODO

## **STEP 3**: Verify Application Functionality

1. Check the inventory of a given item such as cucumbers, by typing `cucumbers`
    in the veggie field and clicking **getInventory**. You should see the inventory
    count result 0.

   ![](images/ea46ee63349f987bd43f772ed6562a87.png " ")

2. (Optional) If for any reason you see a different count, click **removeInventory** to bring back the count to 0.

3. Let’s try to place an order for cucumbers by clicking **place order**.

   ![](images/3ed8a96fec2a7ed044dda26b67865df2.png " ")

4. To check the status of the order, click **showorder**. You should see a failed
    order status.

   ![](images/657d263f888691e7f1070d92201757b7.png " ")

   This is expected, because the inventory count for cucumbers was 0.

5. Click **addInventory** to add the cucumbers in the inventory. You
    should see the outcome being an incremental increase by 1.

   ![](images/2acf1d8f9634c598b44b5dd0f3815457.png " ")

6. Go ahead and place another order by clicking **place order**, and then click
    **showorder** to check the order status.

   ![](images/173839f1dd7c467a9706e551433af67b.png " ")

   ![](images/4916798cb22e9cd8a7dfa4d8dc01c5b9.png " ")

   The order should have been successfully placed, which is demonstrated with the order status showing success.


## Conclusion


## Acknowledgements
* **Authors** - Richard Exley, Consulting Member of Technical Staff; Curtis Dinkel, Principal Member of Technical Staff; Rena Granat, Consulting Member of Technical Staff
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
