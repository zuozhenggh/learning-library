# View and Analyse Geolocation Enriched data in Map Visualization


## Introduction
You will learn how to use the Map Visualization capability to view log records grouped by the location from where the logs are collected.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:
* Explore Geolocation Visualization
* Geolocation Analytics

### Prerequisites
* An Oracle Cloud Environment
* Working knowledge of OCI Logging Analytics and OCI in general.
* Logs ingested in Logging Analytics using Geolocation enabled Source eg. Source used in Lab 1 or Lab 2.</br>
Note: To understand more about how log ingestion works see the Logging Analytics [documentation](https://docs.oracle.com/en-us/iaas/logging-analytics/doc/ingest-logs.html).

## **Task 1:**  Open Map Visualization
1. From the upper left of the OCI Console select the navigation icon (looks like 3 bars), drop down the menu and navigate to **Logging Analytics** and then the **Log Explorer**.</br>

2. First you will set the log search range. From the upper right of the Log Explorer page (to the left of Actions), drop down the menu to Quick Select the last 60 minutes and click the **Apply** button.
![](./images/search-visual-time-filter.jpg " ")

3. On the Log Explorer page, from the upper left and under the **Visualizations** column, select **Map** from the drop-down menu. You will now see a visual **Map**.
![](./images/search-visual-geo.jpg " ")

4. Drill down further using various Geolocation fields
![](./images/search-visual-geo-filter.jpg " ")


There are many reasons businesses choose to collect log data, such as for IT Ops, security, and compliance purposes. Geographic data enrichment to log data adds additional contextual information to better ascertain where something is occurring or where the impact has occurred. And you have now experienced how geolocation mapping of public and private IP addresses in logs provides geo-coordinates & location metadata to provide you a geographical view of logging data to visualize and plan by geographic location.


## Acknowledgements
* **Author** - Sachin Mirajkar, Logging Analytics Development Team
* **Contributors** -  Kumar Varun, Logging Analytics Product Management, Jolly Kundu - Logging Analytics Development Team
* **Last Updated By/Date** - Jan 12 2022
