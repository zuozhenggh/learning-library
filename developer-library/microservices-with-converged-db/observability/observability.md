# Observability (Metrics, Tracing, and Logs)

## Introduction

This lab will show you can trace microservice activity using Jaeger.

Estimated lab Time - 20 minutes

  -   Install and configure Grafana, Prometheus, Loki, Promtail, and Jaeger
  -   Understand single-pane-of glass unified observability using Grafana to analyze metrics, logs, and tracing of the microservices architecture across the applicaiotn and Oracle database tier.

## Task 1: Install software

1. Run the install script to install Prometheus, Loki, Promtail, Jaeger, and Grafana
   
    ```
    <copy>cd $GRABDISH_HOME/observability;./install.sh</copy>
    ```

2. Run the `/applyMonitorsAndExporter.sh` script. This will do the following
   - Create Prometheus ServiceMonitors to scrape the Frontend, Order, and Inventory microservices
   - Create Prometheus ServiceMonitors to scrape the Order PDB, and Inventory PDB metric exporter services.
   - Create deployments and services for PDB metrics exporters
   - Create deployments and services for PDB log exporters
   
    ```
    <copy>cd $GRABDISH_HOME/observability;./applyMonitorsAndExporter.sh</copy>
    ```

3. Open Grafana. 

`kubectl get service stable-grafana -n msdataworkshop`
 login: admin/prom-operator
This is stored in `stable-grafana` secret.

Select `Configuration` gear and `DataSources` and datasources and URLs

    http://loki-stack.loki-stack:3100
    http://jaeger-query-nodeport.msdataworkshop:80
    http://stable-kube-prometheus-sta-prometheus:9090/
    
#
Derived Fields

Name: traceIDFromSpanReported
Regex: Span reported: (\w+)
Query: ${__value.raw}
Internal link: Jaeger

#
Install Dashboard
Different dashboards for different uses... diagnostics, performance, lower or upper level arch focus, etc.

#
Conduct Queries and Drill-downs


#sample queries
https://grafana.com/docs/loki/latest/logql/

#grafana alerts
https://grafana.com/docs/grafana/latest/alerting/

* it may be possible to provide grafana.ini if we want to remove manual steps
https://grafana.com/docs/grafana/latest/administration/provisioning/#datasources




From https://docs.oracle.com/cd/E18283_01/server.112/e17120/monitoring001.htm#insertedID1 ...
https://docs.oracle.com/en/cloud/paas/database-dbaas-cloud/csdbi/view-alert-logs-and-check-errors-using-dbaas-monitor.html

The alert log is a chronological log of messages and errors, and includes the following items:

All internal errors (ORA-00600), block corruption errors (ORA-01578), and deadlock errors (ORA-00060) that occur

Administrative operations, such as CREATE, ALTER, and DROP statements and STARTUP, SHUTDOWN, and ARCHIVELOG statements

Messages and errors relating to the functions of shared server and dispatcher processes

Errors occurring during the automatic refresh of a materialized view

The values of all i




## Task 7: Understand Oracle DB Metrics Exporter (Study)

1. Additional modifications can be made to the following files
   
       db-metrics-orderpdb-exporter-metrics.toml
       db-metrics-inventorypdb-exporter-metrics.toml
    and `./createMonitorsAndDBExporters.sh` can be run  to apply them
    
## Task 8: Understand tracing (Study)

1. Notice @Traced annotations on `placeOrder` method of `$GRABDISH_HOME/frontend-helidon/src/main/java/io/helidon/data/examples/FrontEndResource.java` and `placeOrder` method of `$GRABDISH_HOME/order-helidon/src/main/java/io/helidon/data/examples/OrderResource.java`
   Also notice the additional calls to set tags, baggage, etc. in this `OrderResource.placeOrder` method.

   ![](images/ordertracingsrc.png " ")

2. Place an order if one was not already created successfully in Lab 2 Step 3.

3. Identify the external IP address of the Jaeger Load Balancer by executing the following command:

    ```
    <copy>services</copy>
    ```

    ![](images/jaegerservice.png " ")

4. Open a new browser tab and enter the external IP URL:

  `https://<EXTERNAL-IP>`

   Note that for convenience a self-signed certificate is used to secure this https address and so it is likely you will be prompted by the browser to allow access.

5. Select `frontend.msdataworkshop` from the `Service` dropdown menu and click **Find Traces**.

    ![](images/jaegertrace.png " ")

   Select a trace with a large number of spans and drill down on the various spans of the trace and associated information. In this case we see placeOrder order, saga, etc. information in logs, tags, and baggage.

   *If it has been more than an hour since the trace you are looking for, select a an appropriate value for Lookback and click Find Traces.*

    ![](images/jaegertracedetail.png " ")

## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
               Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Richard Exley, April 2021