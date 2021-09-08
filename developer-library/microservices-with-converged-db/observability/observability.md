# Observability (Metrics, Tracing, and Logs)

## Introduction

This lab will show you can trace microservice activity using Jaeger.

Estimated lab Time - 25 minutes

  -   Install and configure Grafana, Prometheus, Loki, Promtail, and Jaeger
  -   Understand single-pane-of glass unified observability using Grafana to analyze metrics, logs, and tracing of the microservices architecture across the applicaiotn and Oracle database tier.

## Task 1: Install and configure observability software as well as metrics and log exporters

1. Run the install script to install Jaeger, Prometheus, Loki, Promtail, Grafana and an SSL secured LoadBalancer for Grafana
   
    ```
    <copy>cd $GRABDISH_HOME/observability;./install.sh</copy>
    ```

2. Run the `/applyMonitorsAndExporter.sh` script. This will do the following...
   - Create Prometheus ServiceMonitors to scrape the Frontend, Order, and Inventory microservices.
   - Create Prometheus ServiceMonitors to scrape the Order PDB, and Inventory PDB metric exporter services.
   - Create configmpas, deployments, and services for PDB metrics exporters.
   - Create configmaps, deployments, and services for PDB log exporters.
   
    ```
    <copy>cd $GRABDISH_HOME/observability;./applyMonitorsAndExporter.sh</copy>
    ```

## Task 2: Configure Grafana

1. Identify the IP address of the Grafana LoadBalancer by executing the following command:
   
       ```
       <copy>services</copy>
       ```
   
     ![](images/grafana-loadbalancer-externalip.png " ")
     
     Note that it will generally take a few minutes for the LoadBalancer to provision during which time it will be in a `pending state`

2. Open a new browser tab and enter the external IP URL :
   
     `https://<EXTERNAL-IP>`
   
      Note that for convenience a self-signed certificate is used to secure this https address and so it is likely you will be prompted by the browser to allow access.

3. Login using the default username `admin` and password `admin` 

      ![](images/grafana_login_screen.png " ")
    
4. Add and configure Prometheus data source...
    
    Select the `Configuration` gear icon on the left-hand side and select `Data Sources`.

      ![](images/configurationdatasourcesidemenu.png " ")
      
    Click `Add data source`.
    
      ![](images/adddatasourcebutton.png " ")
      
    Click `select` button of Prometheus option.
      
      ![](images/selectprometheusdatasource.png " ")
      
    Enter `asdf` in the URL for Prometheus 
     
      ![](images/configureprometheus.png " ")
    
    Click `Save & Test` button and verify success.
    
      ![](images/saveandtestdatasourceisworking.png " ")
    
5. Select the `Data sources` tab and select `Jaeger` 
    
    Select the `Configuration` gear icon on the left-hand side and select `Data Sources`.
    
      ![](images/configurationdatasourcesidemenu.png " ")
      
    Click `Add data source`.
    
      ![](images/adddatasourcebutton.png " ")
      
    Click `select` button of Loki option.
      
      ![](images/selectprometheusdatasource.png " ")
    
    Enter `http://jaeger-query.msdataworkshop:80` in the URL field and select `Loki` in the `Data source` drop down under the `Trace to logs` section.
        
    Click the `Save and test` button and verify successful connection message.
        
    Click the `Back` button.
    
6. Add and configure Loki data source...
    
    Click `Add data source`.
    
      ![](images/adddatasourcebutton.png " ")
      
    Click `select` button of Loki option.
      
      ![](images/lokidatasource.png " ")
    
    Enter `http://loki-stack.loki-stack:3100` in the URL field 
      ![](images/lokidatasourceurl.png " ")
       
    Create the two Derived Fields shown in the picture below.
    The values are as follows: 
    
        Name: traceIDFromSpanReported
        Regex: Span reported: (\w+)
        Query: ${__value.raw}
        Internal link enabled and `Jaeger` selected from the drop-down list.
    
        Name: traceIDFromECID
        Regex: ECID=(\w+)
        Query: ${__value.raw}
        Internal link enabled and `Jaeger` selected from the drop-down list

    Click the `Save and test` button and verify successful connection message.
        
    Click the `Back` button.
    
7. Install the GrabDish Dashboard

    Select the `+` icon on the left-hand side and select `Import`
      
      ![](images/importsidemenu.png " ")
    
    Copy the contents of the GrabDish Dashboard JSON found here: https://raw.githubusercontent.com/oracle/microservices-datadriven/main/grabdish/observability/dashboards/grabdish-dashboard.json
    
    Paste the contents in the `Import via panel json` text field and click the `Load` button
    
    Confirm successful import.
    

## Task 3: Use Grafana to Analyze metrics, tracing, and logs and the integration to correlate between them


1. Select the four squares icon on the left-hand side and select 'Dashboards'

2. In the `Dashboards` panel select `GrabDish Dashboard`

3. Notice the collapsible panels for each microservices and their content which includes
    - Metrics about the kubernetes microservice runtime (CPU load, etc.)
    - Metrics about the kubernetes microservice specific to that microservice (`PlaceOrder Count`, etc.)
    - Metrics about the PDB used by the microservice (open sessions, etc.)
    - Metrics about the PDB specific to that microservice (inventory count)
 
4. 

## Task 4: Understand App and Oracle DB tier metrics (Study)

1. Additional modifications can be made to the following files
   
       db-metrics-orderpdb-exporter-metrics.toml
       db-metrics-inventorypdb-exporter-metrics.toml
    and `./createMonitorsAndDBExporters.sh` can be run  to apply them
    
## Task 5: Troubleshooting

1. Metrics not showing in Grafana. Check Prometheus. Under status click Targets: http://129.213.72.157:9090/targets  and Service Discovery http://129.213.72.157:9090/service-discovery 

2. “Facetting failed for" error attempting to view logs. Change log range to a larger value.

    
## Task 6: Understand App and Oracle DB tier logging (Study)

1. Notice @Traced annotations on `placeOrder` method of `$GRABDISH_HOME/frontend-helidon/src/main/java/io/helidon/data/examples/FrontEndResource.java` and `placeOrder` method of `$GRABDISH_HOME/order-helidon/src/main/java/io/helidon/data/examples/OrderResource.java`
   Also notice the additional calls to set tags, baggage, etc. in this `OrderResource.placeOrder` method.

   ![](images/ordertracingsrc.png " ")


## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, August 2021