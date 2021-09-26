# Load Data

![Banner](images/banner.png)

## Introduction
In this lab you will load the Twitter data into the Autonomous Data Warehouse. After this lab we will be ready to start analyzing the data.

Estimated Lab Time: 5 minutes

### Objectives
- Learn how to load data into the data warehouse, so you can analyze it later.

### Prerequisites
To complete this lab, you need to have the following:
- A provisioned Autonomous Data Warehouse
- You're logged into your Oracle Cloud Account

## **STEP 1**: Upload Red Bull Twitter data to Autonomous Data Warehouse

1. **Download** the three files that contain the data that we'll use in our analysis:

   <a href="
https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/N2qV6WmjOVm9OMa3R7eohbCEKnO0rc-ok1dxFTD9CKz2-RCvWoOO2gRdd29rtoVz/n/odca/b/workshops-livelabs-do-not-delete/o/redbull_twitter_data.csv" target="\_blank">Red Bull Twitter data</a>

   Save the file on your local machine. Make sure that the files are saved with extension `.csv`.

2. Next, come back to your `redbull` ADW console, go to **Tools** tab and click **Open Database Actions**.

   > You should still have a browser tab open with the main page of the Autonomous Data Warehouse service. If not, navigate to this page first. Then, open Database Actions.

   ![Open Database Actions](images/open-database-actions.png)

   Log in with
   - Username: ADMIN
   - Password: Oracle_12345

3. Click to the **Data Load** option, under the **Data Tools** section.

   ![Open Data Load](images/open-data-load.png)

4. Choose **Load Data** to answer the first question and **Local Files** to answer the second one. Click **Next**.

    ![Start Data Load](images/start-data-load.png)

5. Select the file that you downloaded earlier.

    ![Select Files](images/select-files.png)

6. Click the **Play** button to start the process and click **Run** on the **Run Data Load Job** verification window.

    ![Start Load Process](images/load-data.png)

7. This process takes a few seconds. You will see a green tick when done.

    ![Load Completed](images/load-completed.png)

Congratulations! You've successfully loaded the data into Autonomous Data Warehouse.

You can now proceed to the next lab.

## **Acknowledgements**

- **Author** - Jeroen Kloosterman, Technology Product Strategy Director
