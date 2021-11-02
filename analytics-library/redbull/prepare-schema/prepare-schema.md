# Load Data into Autonomous Data Warehouse

<!--![Banner](images/banner.png)-->

## Introduction
In this lab you will load the Grand Prix data into the Autonomous Data Warehouse. After this lab we will be ready to start analyzing the data.

We will:
1. Login in the Database Actions section as the ADMIN user. We will run a script here that a) creates the F1 user and b) creates a set of **empty** tables in the F1 schema.
2. Log out and then login again in the Database Actions, now as the new F1 user.
3. Load the data into the tables as the F1 user.

Estimated Lab Time: 10 minutes

### Objectives
- Learn how to load data into the data warehouse, so you can analyze it later.

### Prerequisites
To complete this lab, you need to have the following:
- A provisioned Autonomous Data Warehouse
- You're logged into your Oracle Cloud Account

## **Task 1**: Create a New Database User/Schema in Autonomous Data Warehouse

This new user/schema will hold the Grand Prix data.

1. Go to **Menu** > **Oracle Database** > **Autonomous Data Warehouse**.

   ![ADW Menu](images/adw-menu.png)

2. Click on the **REDBULL** database that you created earlier.

   ![ADW Menu](images/open-redbull2.png)

3. Go to **Tools** tab and click **Open Database Actions**.

   ![ADW Menu](images/open-database-actions.png)

   Login with user **ADMIN**, password **Oracle_12345** (you specified this upon creation of the Autonomous Data Warehouse earlier).

4. Click the **SQL** tile under **Development** section.

    ![ADW Menu](images/open-sql.png)

5. **Download** <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/bUMuZhglMweYaXxscbcgvjzVEt02nvvIgIG5gWWZ3lzbk8g4mzN8luJgB87ZINeJ/n/odca/b/workshops-livelabs-do-not-delete/o/create_user.sql" target="\_blank">`create_user.sql`</a>. Save the file on your local machine. Make sure that the file is saved with extension `.sql`.

6. Open the `create_user.sql` file with a text editor and copy-and-paste all of its contents into the database actions worksheet area. This file will create a new user "F1" for us.

    ![ADW Menu](images/copy-paste.png)

7. Click the run-script button (**not** the Run button). Then verify the output in the **Script Output** tab. The last lines in the output should indicate that the script has run successfully.

    ![ADW Menu](images/run-script.png)

8. Log out from the Data Actions as the ADMIN user.

   ![ADW Menu](images/signoutadmin.png)

## **Task 2**: Upload the Grand Prix data to Autonomous Data Warehouse

1. **Download** the 6 files that contain the data that we'll use in our analysis:

   <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/SACcTyC3Ggal6GNffGp6oRhJABi7Wm94MPXww-c2sA3JFyJZbH9GF5kYw0ivqSei/n/odca/b/workshops-livelabs-do-not-delete/o/RACES.csv" target="\_blank">Races data</a>

   <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/wQuDVV-FDxGaYhwHyG3YVzGL9OF1uLDr2QjU9ojLiVOVyfjoZi9DFJTUFcYQfUb0/n/odca/b/workshops-livelabs-do-not-delete/o/LAP_TIMES.csv" target="\_blank">Lap Times data</a>

   <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/3h5etgru8Q4o6YiQ2nEJUKLuKQ5df03nOoE22FDe_YQgJkNd7UBFQ8sYpU4gA54l/n/odca/b/workshops-livelabs-do-not-delete/o/SAFETY_CAR.csv" target="\_blank">Safety Car data</a>

   <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/pPpBJUxWOsUO71yPXsOz8nINXd3RPl2R5qAduASCUwAUKjolY-8OvO0-CST-aJk8/n/odca/b/workshops-livelabs-do-not-delete/o/PIT_STOPS.csv" target="\_blank">Pit Stop data</a>

   <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/vyScD5nC1MKyRjw2DJe0sVNjJWxXhiOEYJTVztdWOyEtsSim6dFEWUbjYfL2qYS_/n/odca/b/workshops-livelabs-do-not-delete/o/RESULTS.csv" target="\_blank">Race Results data</a>

   <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/K1ct-GD7lhs8sofFf53hz1supOKuytLnqHnGOWYVXJrCQ24NaaEMdQdRK-2HffI8/n/odca/b/workshops-livelabs-do-not-delete/o/DRIVER_STANDINGS.csv" target="\_blank">Driver Ranking data</a>

   Save the files on your local machine. **Make sure that the files are saved with extension `.csv`**

2. Next, come back to your `REDBULL` ADW console, go to **Tools** tab and click **Open Database Actions**.

   ![Open Database Actions](images/open-database-actions.png)

   It's **important** that you **use the F1 user** (_not_ the ADMIN user) to log in. Note that you created this "F1" user earlier (when you ran the create_user.sql script).

   - Username: F1
   - Password: Oracle_12345

3. Click to the **Data Load** option, under the **Data Tools** section.

   ![Open Data Load](images/open-data-load.png)

4. Choose **Load Data** to answer the first question and **Local Files** to answer the second one. Click **Next**.

    ![Start Data Load](images/start-data-load.png)

5. Select the files that you downloaded earlier.

    ![Select Files](images/select-files.png)

6. Edit the configuration of each of the data sets by changing the load option into "Insert into table". We are doing this because we already created the empty tables earlier, and we want to add the data into those existing tables.

  We are showing the instructions for SAFETY_CAR. **Please make sure that you do this for all data sets.**

   ![Select Files](images/edit-safety-car.png)

   ![Select Files](images/change-option1.png)

7. After you have changed the load option of **all** files, click the **Play** button to start the process and click **Run** on the **Run Data Load Job** verification window.

    ![Start Load Process](images/load-data.png)

8. This process takes a few seconds. You should see  green ticks next to all data load jobs.

    ![Load Completed](images/load-completed.png)

Congratulations! You've successfully loaded the data into Autonomous Data Warehouse.

You can now proceed to the next lab.

## **Acknowledgements**

- **Author** - Jeroen Kloosterman, Technology Product Strategy Director
