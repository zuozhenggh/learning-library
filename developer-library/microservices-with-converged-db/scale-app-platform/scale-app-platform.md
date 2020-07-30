# Scaling Application Platform
## Introduction

This lab will show how the application can be scaled at the microservice and database level to maintain optimal performance.

![](images/veggie-dash-app-arch.png " ")

### Objectives
-   Install the k6 load testing tool
-   Start the external load balancer for the order-helidon microservice
-   Test the performance of the existing deployment and identify the point at which performance begins to degrade
-   Scale the microservice tier to improve performance and identify the point at which further application tier scaling does not help
-   Scale the database tier and demonstrate how performance is improved

### What Do You Need?

This lab assuemes that you have already completed labs 1 through 4.

## **STEP 1**: Setup: Install the k6 load testing tool and start and external load balancer for the Order service

1. To install the k6 tool.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; wget https://github.com/loadimpact/k6/releases/download/v0.27.0/k6-v0.27.0-linux64.tar.gz; tar -xzf k6-v0.27.0-linux64.tar.gz; ln k6-v0.27.0-linux64/k6 k6</copy>
    ```

2. Start an external load balancer for the order service.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/order-helidon; kubectl create -f ext_order_service.yaml</copy>
    ```
TODO

    Repeatedly view the service until the external IP address has been allocated.  Make a note of the IP address.

    ```
    <copy>kubectl get services -n msdataworkshop</copy>
    ```

TODO

   Set the LB environment variable.

    ```
    <copy>export LB='<note IP address>'</copy>
    ```

## **STEP 2**: Load Test and Scale the Microservice Tier

1. Execute a 300 Request Per Second test by executing the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh 1 30 5</copy>
    ```

TODO

   Note the median response time for the requests.

TODO

2. Execute a 600 Request Per Second test by executing the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh 2 60 5</copy>
    ```

TODO

   Note the median response time for the requests and note how the response time has degraded.

TODO

3. Scale to 2 Replicas.
    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=2 -n msdataworkshop</copy>
    ```

TODO

   List the running pods.
    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=2 -n msdataworkshop</copy>
    ```

   Note there are now two order-helidon replicas.

TODO

4. Reexecute a 600 Request Per Second test by executing the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh 3 60 5</copy>
    ```

TODO

   Note the median response time for the requests.  Response time has returned to normal.

TODO

5. Execute a 900 Request Per Second test by executing the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh 4 90 5</copy>
    ```

TODO

   Note the median response time for the requests and note how the response time has degraded.

TODO

3. Scale to 3 Replicas.
    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=3 -n msdataworkshop</copy>
    ```

TODO

   List the running pods.
    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=3 -n msdataworkshop</copy>
    ```

   Note there are now three order-helidon replicas.

TODO

4. Reexecute a 900 Request Per Second test by executing the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh 5 90 5</copy>
    ```

TODO

   Note the median response time for the requests.  Response time has not returned to normal.  There must be a bottleneck elsewhere.

TODO

## **STEP 3**: Load Test and Scale the Database Tier

3. Scale the ATP database to 2 OCPUs.

TODO

4. Reexecute a 900 Request Per Second test by executing the following command.
    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh 6 90 5</copy>
    ```

TODO

   Note the median response time for the requests.  Response time has returned to normal.

TODO

## Conclusion

Application and Database tiers can be scaled to maintain application performance during high loads.

## Acknowledgements
* **Authors** - Richard Exley, Consulting Member of Technical Staff; Curtis Dinkel, Principal Member of Technical Staff; Rena Granat, Consulting Member of Technical Staff
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
