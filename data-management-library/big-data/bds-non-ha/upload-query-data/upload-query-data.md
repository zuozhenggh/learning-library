# Upload Data to Hadoop Distributed File System (HDFS) and Object Store

## Introduction

In this lab, you run two sets of scripts. First, you will run the HDFS scripts to download data from Amazon S3 to a new local directory on your master node in your Hadoop cluster. Next, you will manipulate some of the downloaded data files, and then upload them to new HDFS directories. The HDFS scripts also create Hive databases and tables which you will query using Hue. Second, you will run the object store scripts to download data from Amazon S3 to your local directory using OCI Cloud Shell. Next, you will upload the data to new objects in a new bucket.

### Objectives

* Download and run scripts that are required to set up your environment and to download the dataset from Amazon's S3 to the **`training`** Administrator user's local working directory.
* Manipulate and upload the downloaded data from the local working directory to HDFS and Object Store.
* Create Hive databases and tables that represents the data that you uploaded to HDFS, and then query the Hive tables using Hue.


### What Do You Need?
+ This lab assumes that you have successfully completed all the labs in the **Contents** menu.
+ Download some stations and bike trips data files from [Citibikes](https://www.citibikenyc.com/system-data) and some random weather data from GitHub.

## **STEP 1:** Gather Information About the Compartment and the Master Node Reserved Public IP Address

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator, if you are not already logged in. On the **Sign In** page, select your `tenancy`, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

2. In the **Oracle Cloud Console** navigation menu, navigate to **Governance and Administration > Identity > Compartments > training-compartment**. In the row for the compartment, in the **OCID** column, hover over the OCID link and then click **Copy**. Next, paste that OCID to an editor or a file, so that you can retrieve it later in this lab.

  ![](./images/compartment-ocid.png " ")

3. In the **Oracle Cloud Console** navigation menu, navigate to **Core Infrastructure > Networking > Virtual Cloud Networks > IP Management**. The **Reserved Public IP Addresses** page is displayed. In the **List Scope** on the left pane, make sure that your **training-compartment** is selected.

4. In row for the `traininmn0-public-ip` reserved IP address, copy the reserved public IP address associated with the master node in the **Reserved Public IP** column. Next, paste that IP address to an editor or a file, so that you can retrieve it later in this lab. You might need this IP address to ssh to the master node, if you didn't save your ssh connection in Lab 6.

  ![](./images/traininmn0-ip-address.png " ")


## **STEP 2:** Connect to the Cluster's First Master Node Using Secure Shell (SSH)

In this step, you will connect to the first (only one master node in a non-HA cluster) master node in your cluster using SSH as the **`training`** Hadoop Administrator user that you created in **Lab 6**.

**Note:** In this lab, we will connect to our cluster using Windows **PuTTY** and provide the SSH private key named `mykey.ppk` which is associated with our `mykey.pub` public key. Refer to **Lab 6: Create a Hadoop Administrator User**, if needed, to review the steps on how to connect to first master node in your cluster. If you created or used an OpenSSH key pair (using your Linux system or Windows PowerShell), you will need to use your Linux system or Windows PowerShell as shown in **Lab 6**.

1. Start **PuTTY**. The **PuTTY Configuration** window is displayed. In **Saved Sessions** section, click the `ssh to traininmn0 on BDS cluster` saved session that you created in **Lab 6**, and then click **Load**.

   ![](./images/connect-to-traininmn0.png " ")

2. Click **Open**. You are connected to the **`traininmn0`** master node.

   ![](./images/connected.png " ")


3.  Log in as the **`training`** Hadoop Administrator user that you created in **Lab 6**.

    ```
    $ <copy>sudo -su training</copy>
    ```

4. Use the `id` command to confirm that you are connected as the **`training`** Hadoop Administrator user.

    ```
    $ <copy>id</copy>
    ```

    ![](./images/connect-as-training.png " ")

4. Use the `cd` command to change the working directory to that of the **`training`** user. Use the `ls -l` command to confirm that you are in the `training` working directory:

    ![](./images/change-directory.png " ")


## **STEP 3:** Download and Run the Scripts to Set Up the HDFS Data

In this step, you download two scripts that you will use to set up your environment and to download the HDFS dataset from Amazon's S3 (Simple Storage Service). The dataset represents the Citi Bikes trip data and stations information from the [Citibike System Data](https://www.citibikenyc.com/system-data) page, and some random weather data that is hosted on GitHub _(for now Marty until I get the Object Store resources from the LiveLabs team)_.

The Citi Bikes trip data zipped files are first downloaded to a local folder. Next, the files are unzipped, and the header row is removed from each file. Finally, the updated files are then uploaded to a new **`/data/biketrips`** HDFS directory. Next, a new **`bikes`** Hive database is created with two Hive tables: **`bikes.trips_ext`** and **`bikes.trips`**. The tables are populated with data from the `.csv` files in the **`/data/biketrips`** directory.

The stations data file is downloaded (and then manipulated) from the [station information](https://gbfs.citibikenyc.com/gbfs/es/station_information.json) page. The updated file is then uploaded to a new **`/data/stations`** HDFS directory.

The weather data is downloaded from the [GitHub repository](https://raw.githubusercontent.com/martygubar/bds-getting-started/master/lab-bikes-setup/weather-newark-airport.csv). Next, the header row in the file is removed. The updated file is then uploaded to a new **`/data/weather`** HDFS directory. Next, a new **`weather`** Hive database and **`weather.weather_ext`** table are created and populated with from the `weather-newark-airport.csv` file in the **`/data/weather`** directory.

**Note:**    
Developers, engineers, statisticians and academics can find and download data on Citi Bike membership, ridership and trip histories from [Citi Bikes NYC](https://www.citibikenyc.com/system-data). See the [Data License Agreement](https://www.citibikenyc.com/data-sharing-policy) for information about the data license agreement. To view the complete data files that are available, navigate to [Citibike System Data](https://www.citibikenyc.com/system-data) page. In the **Citi Bike Trip Histories** section, click [downloadable files of Citi Bike trip data](https://s3.amazonaws.com/tripdata/index.html). The [Index of bucket "tripdata"](https://s3.amazonaws.com/tripdata/index.html) page displays the available data files. In this lab, you will be using only some of the data files on that page.  

1. Run the following command to download the **`env.sh`** script to the **`training`** working directory. You will use this script to set up your environment.

    ```
    $ <copy>wget https://raw.githubusercontent.com/martygubar/bds-getting-started/master/lab-bikes-setup/env.sh</copy>
    ```

    ![](./images/run-env-script.png " ")


2. Run the following command to download the **`download-all-hdfs-data.sh`** script to the **`training`** working directory. You will run this script to download the dataset to your local working directory. You will then upload this data to HDFS.

    ```
    $ <copy>wget https://raw.githubusercontent.com/martygubar/bds-getting-started/master/lab-bikes-setup/download-all-hdfs-data.sh</copy>
    ```

    ![](./images/run-download-hdfs-data.png " ")

3. Add the **execute** privilege to the two downloaded `.sh` files as follows:

    ```
    $ <copy>chmod +x *.sh</copy>
    ```

    ![](./images/execute-privilege.png " ")

4. Display the content of the **`env.sh`** file using the **cat** command. This file sets the target local and HDFS directories.

    ```
    $ <copy>cat env.sh</copy>
    ```

  ![](./images/env-script.png " ")


  **Note:** You will download the data from Amazon S3 to the new **`Downloads`** local target directory as specified in the **`env.sh`** file. You will upload the data from the local **`Downloads`** directory to the following new HDFS directories under the new **`/data`** HDFS directory as specified **`env.sh`** file: **`biketrips`**, **`stations`**, and **`weather`**.

5. Use the **`cat`** command to display the content of the **`download-all-hdfs-data.sh`** script. This script downloads the **`download-citibikes-hdfs.sh`** and **`download-weather-hdfs.sh`** scripts to the local **`training`** working directory, adds execute privilege on both of those scripts, and then runs the two scripts.

    ```
    $ <copy>cat download-all-hdfs-data.sh</copy>
    ```

    ![](./images/cat-download-hdfs-script.png " ")

  The **`download-citibikes-hdfs.sh`** script does the following:

      + Runs the **`env.sh`** script.
      + Downloads the stations information from the Citi Bike Web site to the local **`Downloads`** target directory.
      + Creates a new **`stations`** HDFS directory under the **`data`** HDFS directory, and then copies the `stations.json` file to the **`stations`** HDFS directory.
      + Downloads the bike rental data files (the zipped `.csv` files) from the NYC Bike Share, LLC and Jersey City Bike Share data sharing service to the local **`Downloads`** target directory.
      _Question for Marty: Is Citibikes site different than the NYC Bike Share service?_
      + Unzips the bike rental files, and removes the header row from each file.
      + Creates a new `biketrips` HDFS directory under the **`data`** HDFS directory, and then uploads the updated `csv` files to the `biketrips` HDFS directory. Next, it changes the file permissions to read, write, and execute.
      + Creates the `bikes` Hive database and the `bikes.trips_ext` and `bikes.trips` Hive tables in that database. It then populates the tables with the bike trips data from the **`/data/biketrips`** HDFS directory.

  The **`download-weather-hdfs.sh`** script provides a random weather data set for Newark Liberty Airport in New Jersey. It does the following:

      + Runs the `env.sh` script._why do we need to run this again?_
      + Downloads the `weather-newark-airport.csv` file to the **`Downloads`** stations information from the Citi Bike Web site to the local **`Downloads`** target directory.
      + Removes the header row from the file.
      + Creates a new **`weather`** HDFS directory under the **`data`** HDFS directory, and uploads the `weather-newark-airport.csv` file to that directory.
      + Creates the `weather` Hive database and the `weather.weather_ext` Hive table. It then populates the table with the weather data from the `weather-newark-airport.csv` file in the local **`Downloads`** directory.

6. Run the **`download-all-hdfs-data.sh`** script as follows:

    ```
    $ <copy>./download-all-hdfs-data.sh</copy>
    ```
    ![](./images/run-hdfs-script.png " ")


7. Text messages will scroll on the screen. After a minute or so, the **Weather data loaded** and **Done** messages are displayed on the screen.

    ![](./images/script-completed.png " ")

8. Navigate to the local **`Downloads`** directory to display the downloaded trip data, stations, and weather data files.

    ![](./images/data-downloaded.png " ")

9. Use the **`head`** command to display the first two records of the downloaded **`stations.json`** file.

    ```
    $ <copy>head -2 stations.json </copy>
    ```

    ![](./images/view-stations.png " ")

10. Use the **`head`** command to display the content of the downloaded **`weather-newark-airport.csv`** file.

    ```
    $ <copy>head weather-newark-airport.csv </copy>
    ```

    ![](./images/view-weather.png " ")

11. Use the following commands to display the HDFS directories that were created, and list their contents.

    ```
    $ <copy>hadoop fs -ls /data</copy>
    $ <copy>hadoop fs -ls /data/biketrips</copy>
    $ <copy>hadoop fs -ls /data/stations</copy>
    $ <copy>hadoop fs -ls /data/weather</copy>
    ```

    ![](./images/hdfs-directories.png " ")

12. Use the following command to display the first 5 rows from the uploaded **`JC-201901-citibike-tripdata.csv`** file in the **`/data/biketrip`** HDFS folder. Remember, the header row for this uploaded `.csv` file was removed when you ran the **`download-citibikes-hdfs.sh`** script.

    ```
    $ <copy>hadoop fs -cat /data/biketrips/JC-201902-citibike-tripdata.csv | head -5</copy>
    ```

    ![](./images/view-tripdata.png " ")


## **STEP 4:** Query the Uploaded HDFS Data Using Hue

In this step, you log into Hue as the **`training`** administrator user and query the Hive tables that were created by the scripts that you ran in the previous step. Remember, in a non-HA BDS cluster, Hue runs on the first utility node. You will use the reserved public IP address that is associated with **`traininun0`** that you created in **Lab 5, Access a BDS Node Using a Public IP Address**.

1. Open a Web browser window.

2. Enter the following URL:

    ```
    https://<ip-address>:8888
    ```
  **Note:**    
  In the preceding command, substitute **_``ip-address``_** with your own **_``ip-address``_** that is associated with the **first utility node** in your cluster, **`traininun0`**.

  In our example, we used the reserved public IP address that is associated with our first utility node as follows:

    ```
    https://193.122.194.103:8888
    ```

3. If this is the first time you are accessing Hue, the Hue Login screen is displayed. Enter your **`username`** (**`admin`** by default) and the **`password`** that you specified when you created the cluster such as **`Training123`**.

  ![](./images/hue-login-page.png " ")

  The **Hue Editor** page is displayed. Note the **`bikes`** and **`weather`** Hive databases that were created when you ran the scripts in the previous step in this lab.

  ![](./images/hue-home-page.png " ")

4. Copy the following query that ranks the top 10 most popular start stations, and then paste it in the Query section in Hue.

    ```
    <copy>select start_station_name, value,
       rank() over (order by value desc) as ranking
    from (
    select start_station_name, count(*) as value
    from trips
    group by start_station_name
  ) as t
limit 10;</copy>
    ```

    The following is the query result.

    ![](./images/query-result.png " ")

    **Note:** For documentation on using Hue, see [Introduction to Hue](https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/hue.html). You can also select **Help** from the **User** drop-down menu for general help topics.

  ![](./images/hue-doc.png " ")


## **STEP 5:** Download and Run the Scripts to Set Up the Object Store Data

In this step, you will download two scripts that will set up your environment and download the Object Store dataset from Amazon's S3. The dataset represents the Citi Bikes trip data and stations information from the [Citibike System Data](https://www.citibikenyc.com/system-data) page, and some random weather data that is hosted on GitHub.

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator that you used to create the resources in **Lab 1**, if you are not already logged in. On the **Sign In** page, select your `tenancy` if needed, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

2. On the **Oracle Cloud Console** banner at the top of the page, click **Cloud Shell**
![](./images/cloud-shell-icon.png). It may take a few moments to connect and authenticate you.

    ![](./images/cloud-shell-started.png " ")

3. Click **Copy** to copy the following command. Right-click your mouse, select **Paste**, and then paste it on the command line.  You will use this script to set up your environment for the Object Store data. Press the **[Enter]** key to run the command.

    ```
    <b>$</b> <copy>wget https://raw.githubusercontent.com/martygubar/bds-getting-started/master/lab-bikes-setup/env.sh
    </copy>
    ```

    ![](./images/env-script-object-store.png " ")

4. Edit the downloaded **`env.sh`** file using the **vi** Editor (or an editor of your choice) as follows:

    ```
    $ <copy>vi env.sh</copy>
    ```

    ![](./images/view-os-env-script.png " ")

5. To input and edit text, press the **[i]** key on your keyboard (insert mode) at the current cursor position. The **INSERT** keyword is displayed at the bottom of the file to indicate that you can now make your edits to this file. Scroll-down to the line that you want to edit. Copy your **training-compartment** **OCID** value that you identified in **STEP 1**, and then paste it between the **`" "`** in the **`export COMPARTMENT_OCID=""`** command.

    ![](./images/vi-env-script-os.png " ")


    **Note:** You will upload the Object Store data to the **`training`** bucket as specified in the `env.sh` file.

6. Press the **[Esc]** key on your keyboard, enter **`:wq`**, and then press the **[Enter]** key on your keyboard to save your changes and quit **vi**.    

    ![](./images/saving-os.png " ")

7. At the **$** command line prompt, enter the following command, or click **Copy** to copy the command, and then paste it on the command line. You will run this script to download the dataset to your local working directory. You will then upload this data to Object Store. Press the **`[Enter]`** key to run the command.

    ```
    <b>$</b> <copy>wget https://raw.githubusercontent.com/martygubar/bds-getting-started/master/lab-bikes-setup/download-all-objstore.sh
    </copy>
    ```
    ![](./images/download-os-script.png " ")


8. Add the **execute** privilege to the two downloaded `.sh` files as follows:

    ```
    $ <copy>chmod +x *.sh</copy>
    ```

    ![](./images/chmod-scripts.png " ")

9. Use the **`cat`** command to display the content of this script. This script runs the `env.sh` script, downloads the **`download-citibikes-objstore.sh`** and **`download-weather-objstore.sh`** scripts, adds execute privilege to both of those scripts, and then runs the two scripts.

    ```
    $ <copy>cat download-all-objstore.sh</copy>
    ```

    ![](./images/cat-os-script.png " ")

  You can use the **`cat`** command to display the content of this script. The **`download-all-objstore.sh`** script runs the **`env.sh`** script which sets the environment. The script writes some of the data from Amazon S3 to the local **`Downloads`** local directory and to a new bucket named **`training`**, as specified in the **`env.sh`** script. The **`training`** bucket will contain the following new objects:

    + The **`weather`** object which stores the weather data.
    + The **`stations`** object which stores the stations data.
    + The **`biketrips`** object which stores the bike trips data.

10. Run the **`download-all-objstore.sh`** script as follows:

    ```
    $ <copy>./download-all-objstore.sh</copy>
    ```

11. Text messages will scroll on the screen. After a minute or so, the **Done** message along with the location of the data (both compartment and bucket) are displayed on the screen.

    ![](./images/objstore-done.png " ")

12. Navigate to the local **`Downloads`** directory to display the downloaded data files.

    ![](./images/data-downloaded-objstore.png " ")

13. In the **Oracle Cloud Console** navigation menu, navigate to **Object Storage > Object Storage**. The **Buckets** page is displayed. In the **List Scope** on the left pane, make sure that your **training-compartment** is selected. In the list of available buckets, the newly created **training** bucket is displayed in the **Name** column. Click the **training** link.

    ![](./images/buckets-page.png " ")

14. The **Buckets Details** page for the **training** bucket is displayed. Scroll-down to the **Objects** section to display the newly created **biketrips**, **stations**, and **weather** objects.

    ![](./images/bucket-details.png " ")

15. To display the data files in an object such as the **biketrip** object, click **Expand** ![](./images/expand-icon.png) next to the object's name. The files contained in that object are displayed. To collapse the list of files, click **collapse** ![](./images/collapse-icon.png) next to the object's name.

    ![](./images/files-in-object.png " ")

16. To display the first 1KB of the file's content (in read-only mode), click the **Actions** button on the row for the file, and then select **View Object Details** from the context menu.

    ![](./images/view-object-details.png " ")

    **Note:** To view all the data in a file, select **Download** from the context menu, and then double-click the downloaded file to open it using its native application, MS-Excel (.csv) in this example.  

**This concludes this lab and the workshop.**

## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Using Hue](https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/hue_using.html)

## Acknowledgements

* **Author:**
    * Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
* **Contributors:**
    * Martin Gubar, Director, Oracle Big Data Product Management
* **Last Updated By/Date:** Lauran Serhal, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
