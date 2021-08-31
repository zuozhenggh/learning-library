# Observability (Metrics, Tracing, and Logs)

## Introduction

This lab will show you can trace microservice activity using Jaeger.

Estimated lab Time - 25 minutes

  -   Install and configure Grafana, Prometheus, Loki, Promtail, and Jaeger
  -   Understand single-pane-of glass unified observability using Grafana to analyze metrics, logs, and tracing of the microservices architecture across the applicaiotn and Oracle database tier.

## Task 1: Install and configure observability software as well as metrics and log exporters

1. Run the install script to install Prometheus, Loki, Promtail, Jaeger, and Grafana
   
    ```
    <copy>cd $GRABDISH_HOME/observability;./install.sh</copy>
    ```

2. Run the `/applyMonitorsAndExporter.sh` script. This will do the following...
   - Create Prometheus ServiceMonitors to scrape the Frontend, Order, and Inventory microservices.
   - Create Prometheus ServiceMonitors to scrape the Order PDB, and Inventory PDB metric exporter services.
   - Create deployments and services for PDB metrics exporters.
   - Create deployments and services for PDB log exporters.
   
    ```
    <copy>cd $GRABDISH_HOME/observability;./applyMonitorsAndExporter.sh</copy>
    ```

## Task 2: Configure Grafana

1. Identify the IP address of Ingress Controller Service by executing the following command:
   
       ```
       <copy>services</copy>
       ```
   
       ![](images/ingress-nginx-loadbalancer-externalip.png " ")

2. Open a new browser tab and enter the external IP URL followed by "grafana":
   
     `https://<EXTERNAL-IP>/grafana`
   
      Note that for convenience a self-signed certificate is used to secure this https address and so it is likely you will be prompted by the browser to allow access.

3.  Login using the default username `admin` and password `prom-operator` 
    (This value is stored in the `stable-grafana` secret and can be modified there is necessary).
    
4. Select the `Configuration` gear icon on the left-hand side and select `Plugins`.

    In the search field type `Jaeger` and when `Jaeger` is shown click it to install.
    
    Repeat the process for `Loki`.
    
5. Select the `Data sources` tab and select `Loki` 
    
    Enter `http://loki-stack.loki-stack:3100` in the URL field and create the two Derived Fields shown in the picture below.
    The values are as follows:
    
        - Name: `traceIDFromSpanReported`
        - Regex: `Span reported: (\w+)`
        - Query: `${__value.raw}`
        - Internal link enabled and `Jaeger` selected from the drop-down list.
        
        - Name: `traceIDFromECID`
        - Regex: `ecid=(\w+)`
        - Query: `${__value.raw}`
        - Internal link enabled and `Jaeger` selected from the drop-down list
        
    Click the `Save and test` button and verify successful connection message.
        
    Click the `Back` button.
    
6. Select the `Data sources` tab and select `Jaeger` 
    
    Enter `http://jaeger-query.msdataworkshop:80` in the URL field and select `Loki` in the `Data source` drop down under the `Trace to logs` section.
        
    Click the `Save and test` button and verify successful connection message.
        
    Click the `Back` button.
    
7. Install the GrabDish Dashboard

    Select the `+` icon on the left-hand side and select `Import`
    
    Copy the contents of the GrabDish Dashboard JSON found here: https://raw.githubusercontent.com/oracle/microservices-datadriven/main/grabdish/observability/dashboards/grabdish-dashboard.json
    
    Paste the contents in the `Import via panel json` text field and click the `Load` button
    
    Confirm successful import.
    

## Task 3: Use Grafana to Analyze metrics, tracing, and logs and correlate between them


1. Select the four squares icon on the left-hand side and select 'Dashboards'

2. In the `Dashboards` panel select `GrabDish Dashboard`

3. Notice the collapsible panels for each microservices and their content which includes
    - Metrics about the kubernetes microservice runtime (CPU load, etc.)
    - Metrics about the kubernetes microservice specific to that microservice (`PlaceOrder Count`, etc.)
    - Metrics about the PDB used by the microservice (open sessions, etc.)
    - Metrics about the PDB specific to that microservice (inventory count)
 
4. 

## Task 4: Understand Oracle DB Metrics Exporter (Study)

1. Additional modifications can be made to the following files
   
       db-metrics-orderpdb-exporter-metrics.toml
       db-metrics-inventorypdb-exporter-metrics.toml
    and `./createMonitorsAndDBExporters.sh` can be run  to apply them
    
## Task 5: Understand tracing (Study)

1. Notice @Traced annotations on `placeOrder` method of `$GRABDISH_HOME/frontend-helidon/src/main/java/io/helidon/data/examples/FrontEndResource.java` and `placeOrder` method of `$GRABDISH_HOME/order-helidon/src/main/java/io/helidon/data/examples/OrderResource.java`
   Also notice the additional calls to set tags, baggage, etc. in this `OrderResource.placeOrder` method.

   ![](images/ordertracingsrc.png " ")


    
## Task 6: Understand logging (Study)

1. Notice @Traced annotations on `placeOrder` method of `$GRABDISH_HOME/frontend-helidon/src/main/java/io/helidon/data/examples/FrontEndResource.java` and `placeOrder` method of `$GRABDISH_HOME/order-helidon/src/main/java/io/helidon/data/examples/OrderResource.java`
   Also notice the additional calls to set tags, baggage, etc. in this `OrderResource.placeOrder` method.

   ![](images/ordertracingsrc.png " ")


## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
               Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Richard Exley, April 2021