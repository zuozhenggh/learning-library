# Initialize Environment

## Introduction

In this lab we will review and startup all components required to successfully run this workshop.

*Estimated Lab Time:* 10 Minutes.

### Objectives
- Initialize the workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## **STEP 1:** Validate That Required Processes are Up and Running.
1. Now with access to your remote desktop session, proceed as indicated below to validate your environment before you start executing the subsequent labs. The following Processes should be up and running:

    - Database Listener
    - Database Server
    - Enterprise Manager - Management server (OMS)
    - Enterprise Manager - Management Agent (emagent)

2. On the *Firefox* window on the right preloaded with *Enterprise Manager*, click on the *Username* field and select the saved credentials to login. These credentials have been saved within *Firefox* and are provided below for reference

    ```
    Username: <copy>sysman</copy>
    ```

    ```
    Password: <copy>welcome1</copy>
    ```

    ![](images/em-login.png " ")

3. Confirm successful login. Please note that it takes about 5 minutes after instance provisioning for all processes to fully start.

    ![](images/em-landing.png " ")

    If successful, the page above is displayed and as a result your environment is now ready.  

    You may now [proceed to the next lab](#next).

4. If you are still unable to login or the login page is not functioning after reloading from the *Workshop Links* bookmark folder, open a terminal session and proceed as indicated below to validate the services.

    - Database services (All databases and Standard Listener)
        ```
        <copy>
        systemctl status oracle-database
        </copy>
        ```

        ![](images/db-service-status.png " ")
        ![](images/db-service-status2.png " ")

    - Listener Service (Non-Standard)
        ```
        <copy>
        systemctl status oracle-db-listener
        </copy>
        ```
        ![](images/listener-service-status.png " ")

    - Enterprise Manager Services (OMS and emagent)
        ```
        <copy>
        systemctl status oracle-emcc
        </copy>
        ```

        ![](images/em-service-status.png " ")

5. If you see questionable output(s), failure or down component(s), restart the corresponding service(s) accordingly

    - Database and Listener
        ```
        <copy>
        systemctl restart oracle-database
        systemctl restart oracle-db-listener
        </copy>
        ```

    - Enterprise Manager Services (OMS and emagent)
  
        ```
        <copy>
        systemctl restart oracle-emcc
        </copy>
        ```

You may now [proceed to the next lab](#next).

## Appendix 1: Managing Startup Services

1. Database Service

    ```
    Start: <copy>systemctl start oracle-database</copy>
    ```
    ```
    Stop: <copy>systemctl stop oracle-database</copy>
    ```
    ```
    Status: <copy>systemctl status oracle-database</copy>
    ```
    ```
    Restart: <copy>systemctl restart oracle-database</copy>
    ```
2. Listener Service

    ```
    Start: <copy>systemctl start oracle-db-listener</copy>
    ```
    ```
    Stop: <copy>systemctl stop oracle-db-listener</copy>
    ```
    ```
    Status: <copy>systemctl status oracle-db-listener</copy>
    ```
    ```
    Restart: <copy>systemctl restart oracle-db-listener</copy>
    ```
3. Enterprise Manager Service

    ```
    Start: <copy>systemctl start oracle-emcc</copy>
    ```
    ```
    Stop: <copy>systemctl stop oracle-emcc</copy>
    ```
    ```
    Status: <copy>systemctl status oracle-emcc</copy>
    ```
    ```
    Restart: <copy>systemctl restart oracle-emcc</copy>
    ```

## Acknowledgements
- **Author** - Rene Fontcha, Master Principal Solutions Architect, NA Technology
- **Contributors** - Dave Le Roy, Pankaj Chandiramani, Shefali Bhargava - Enterprise Manager Product Management
- **Last Updated By/Date** - Ashish Kumar - LiveLabs, July 2021
