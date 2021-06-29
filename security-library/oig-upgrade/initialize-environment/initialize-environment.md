# Initialize the workshop environment

## Introduction

In this lab we will review and startup all components required to successfully run this workshop.

*Estimated Lab Time*: 20 minutes

### About Product/Technology
Oracle Identity Governance(OIG) is a powerful and flexible enterprise identity management system that automatically manages user's access privileges within enterprise IT resources.

### Objectives

In this lab, you will:
* Start the database
* Start and Verify 11g Domain available for upgrade
* Start and Verify 12c Domain

### Prerequisites

* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported
* SSH Private Key to access the host via SSH

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***

## **STEP 1:** Login to the instance

1. Launch your browser to the following URL to access the instance

    ```
    http://[your instance public-ip address]:6080/index.html?password=LiveLabs.Rocks_99&resize=remote&autoconnect=true
    ```

## **STEP 2:** Verify that the Database is up and running

1. Verify that the Database has started

    ```
    <copy>systemctl status oracle-database.service</copy>
    ```

    ![](images/1-database.png)

## **STEP 3:** Start and Verify the 11g Domain

1. Launch a terminal instance and Run the *startDomain11g.sh* script. The Admin server will take about 3-4 mins to start. It may take about 10mins for the SOA and OIM servers to start.

    ```
    <copy>cd /u01/scripts</copy>
    ```
    ```
    <copy>./startDomain11g.sh</copy>
    ```

2. Open a browser window to access the Weblogic console. Click on the bookmark *Workshop Links* and click on *WLS11g* from the dropdown "OR" paste the following URL in the browser:

    ```
    <copy>http://onehopiam:7001/console</copy>
    ```

    Verify the version as 11g and login to the instance.

    ```
    Username: <copy>weblogic</copy>
    ```

    ```
    Password: <copy>Welcom@123</copy>
    ```

    ![](images/2-weblogic-console.png)

3. On the Weblogic console, Click on *Servers* under *Environment* and verify that all servers(OIM,SOA) are in the ‘RUNNING’ state.

    ![](images/3-weblogic-servers.png)

    ![](images/4-weblogic-servers.png)


4. Access the Identity Self Service console. Click on the bookmark *Workshop Links* and click on *OIG11g* "OR" paste the following URL in the browser:

    ```
    <copy>http://onehopiam:14000/identity</copy>
    ```
    ```
    Username: <copy>xelsysadm</copy>
    ```
    ```
    Password: <copy>Welcom@123</copy>
    ```

    ![](images/5-identity-console.png)

5. Click on *xelsysadm* on the top right corner and Click on *About* from the dropdown. Verify that the OIM version is 11g

    ![](images/6-identity-console.png)

6. Click on *Manage* on the top right corner. Then, click on *Users* and notice that 3 test users have been created (*TUSER1, TUSER2, TUSER3*)

    ![](images/7-users.png)

    ![](images/8-users.png)

## **STEP 4:** Start and Verify the 12c Domain

1. Run the *startDomain12c.sh* script. The Admin server will take about 3-4 mins to start. It may take about 10mins for the SOA and OIM servers to start.

    ```
    <copy>./startDomain12c.sh</copy>
    ```

2. Open a browser window to access the Weblogic console. Click on the bookmark *Workshop Links* and click on *WLS12c* "OR" paste the following URL in the browser:

    ```
    <copy>http://onehopiam:7005/console</copy>
    ```

    Verify the version as 12c and login to the instance.

    ```
    Username: <copy>weblogic</copy>
    ```
    ```
    Password: <copy>Welcom@123</copy>
    ```

    ![](images/9-weblogic12c.png)

3. On the Weblogic console, Click on *Servers* under *Environment* and verify that all servers(OIM,SOA) are in the ‘RUNNING’ state.

    ![](images/10-weblogic12c.png)

4. Access the Identity Self Service console. Click on the bookmark *Workshop Links* and click on *OIG12c* "OR" paste the following URL in the browser:

    ```
    <copy>http://onehopiam:14005/identity</copy>
    ```

    ```
    Username: <copy>xelsysadm</copy>
    ```

    ```
    Password: <copy>Welcom@123</copy>
    ```

    ![](images/11-oim12c.png)

5. Click on *xelsysadm* on the top right corner and Click on *About* from the dropdown. Verify that the OIM version is 12c

    ![](images/12-oim12c.png)

6. Click on *Manage* on the top right corner. Then, click on *Users* and notice that there are no new users created.

    ![](images/13-oim12c.png)

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Keerti R, Brijith TG, Anuj Tripathi, NATD Solution Engineering
* **Contributors** -  Keerti R, Brijith TG, Anuj Tripathi
* **Last Updated By/Date** - Keerti R, NATD Solution Engineering, June 2021
