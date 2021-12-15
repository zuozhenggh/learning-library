# Better Understand and Modify Metrics, Logging, and Tracing

## Introduction

This lab will take a deeper dive into expliaining Metrics, Logging, and Tracing and will show you how extend the observability framework for your own needs and use cases.

You can extend the observability functionality provided here in a number of ways by modifying the metrics and log exporter config, tracing in your microservices, dashboards, etc.

## Task 1: Modify Metrics Exporter config

   Modify and save  `$GRABDISH_HOME/observability/db-metrics-exporter/db-metrics-inventorypdb-exporter-metrics.toml`
   and/or `$GRABDISH_HOME/observability/db-metrics-exporter/db-metrics-inventorypdb-exporter-metrics.toml and run the following command.`
    
    ```
    <copy>cd $GRABDISH_HOME/observability;./updatedbteqexporters.sh</copy>
    ```
   You will notice the related configmap is updated and the deployment is reapplied such that they can be observed in the dashboard.

## Task 2: Modify Application Tracing

Study the tracing behavior in $GRABDISH_HOME/order-helidon/src/main/java/io/helidon/data/examples/OrderResource.java 

For example, the `@Traced` annotation, `tracer.buildSpan` logic, etc.

Modify and save the source. Then rebuild, and redeploy by deleting the previous pod version (deployments are configured with image-pull=always) using the following command.

    ```
    <copy>cd $GRABDISH_HOME/order-helidon;./build.sh;deletepod order-helidon</copy>
    ```
     
You will notice the related tracing changes in the dashboard

The observability-exporter image correpsonding to the repos at https://github.com/oracle/oracle-db-appdev-monitoring  will soon be available as will more advanced customization of the DB log exporter, etc.

Proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, August 2021
