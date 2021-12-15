# Diagnosability and Debugging Use Case

## Introduction

This lab will show you how...

Estimated lab Time - 5 minutes

  -   ...
  
## Task 1: Notice perf metrics and create Alert for response time threshold

1. Create Alert in Grafana with Slack alert channel set up in earlier lab.

    ```
    <copy>cd $GRABDISH_HOME/observability;./install.sh</copy>
    ```


## Task 2: Run stress test

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 


## Task 3: Notice metrics and Slack message from alert

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 

## Task 4: Scale pods and/or database

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 


## Task 5: Notice metrics and Slack message from alert that response time is acceptable again

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 

## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, August 2021
