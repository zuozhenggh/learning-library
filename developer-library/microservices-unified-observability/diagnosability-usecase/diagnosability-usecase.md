# Diagnosability and Debugging Use Case

## Introduction

This lab will show you how setup an alert when an exception/failure occurs in the system and allow you to diagnose and debug the issue.

Estimated lab Time - 5 minutes

  
## Task 1: Notice propagation metrics and create Alert for message propgation failure case

1. Create Alert in Grafana with Slack alert channel set up in earlier lab.

    ```
    <copy>cd $GRABDISH_HOME/observability;./install.sh</copy>
    ```


## Task 2: Use SQLci to disable propagation

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")


## Task 3: Notice 'down' metric and Slack message from alert

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 

## Task 4: Use SQLci to re-enable propagation

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 


## Task 5: Notice metrics and Slack message from alert that messaging/propagation is working again

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, 

## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, August 2021
