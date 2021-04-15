# Getting Started

## Python Sample Application
This tutorial introduces you to build a sample python spark application to convert a CSV file into Parquet File locally. Once build, you will learn how to run the application on Oracle Cloud Infrastructure Data Flow, a fully managed service that lets you run any Apache Spark Application  at any scale with no infrastructure to deploy or manage. This tutorial requires basic knowledge of python spark. All the data used in the tutorial have been provided for you.

*Estimated Lab Time*: 40 minutes

### Objectives

In Spark, your first step is usually to clean the data. Data Cleaning means the process of identifying incorrect, incomplete, inaccurate, irrelevant, or missing pieces of data and then modifying, replacing or deleting them as needed. Data Cleansing is considered the basic element of Data Science. Upon cleaning the data, you will convert data from a text format into a Parquet format. Parquet is an optimized binary format supporting efficient reads, making it ideal for reporting and analytics. In this lab, you take source data, convert it into Parquet, and then do a few interesting things with it. Your dataset is the [Nexflix Movies Data dataset](https://www.kaggle.com/shivamb/netflix-shows/downloada), downloaded from the Kaggle website under the terms of the Creative Commons CC0 1.0 Universal (CC0 1.0) "Public Domain Dedication" license.

The data is provided in CSV format and your objective is to convert this data to Parquet and store it in object store for downstream processing.Once the application is done, your next objective is to create a Data Flow Application which runs this Spark app, and execute it with the correct parameters. This lab guides you step by step, and provides the parameters you need.

  ![](../images/ETL.png " ")

### Prerequisites

* Python 3.6 setup locally.

* OCI Python SDK. See [Installing OCI python SDK](https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/en/latest/installation.html#downloading-and-installing-the-sdk)

* A python IDE of your choice. The workshop uses [Visual Studio Code (VSCode)](https://code.visualstudio.com/download)

* Local environment setup with all the dependencies setup as described [Here](https://docs.oracle.com/en-us/iaas/data-flow/data-flow-tutorial/develop-apps-locally/front.htm#develop-locally-concepts)
 
* From the Console, click the hamburger menu to display the list of available services. Select Data Flow and click `Applications`

* Basic understanding of Python and PySpark


## **STEP 1**: Create Sample Python Application

1. Begin by importing the python modules

    ![](../images/import-python-modules.png " ")


2. In the main function we start with the program logic. The main function is a starting point of any python program. When the program is run, the python interpreter runs the code sequentially. As input we pass the the location of the object storage location that has the      netflix csv file.

    ![](../images/main-function.png " ")

3. Next, create a spark session and in the session config, add the OCI configuration. We pass the following configuration

     1. OCID of the user calling the API. To get the value, see [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs).  
   
     2. Fingerprint for the public key that was added to this user. To get the value, see[Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)  
    
     3. Full path and filename of the private key. The key pair must be in the PEM format. For instructions on generating a key pair in PEM forat, see [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)

     4. Passphrase used for the key, if it is encrypted. 

     5. OCID of your tenancy. To get the value, see [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)

     6. An Oracle Cloud Infrastructure region. see [Regions and Availability Domains](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#top) 

    ![](../images/spark-session-config.png " ")

 *Note:  This step requires OCI python library.*

 1. Load the csv file into the input dataframe

    ![](../images/load-csv.png " ")

 2. Next, clean the data. First, count how many null values present in each column.  There are a few columns that contain null values, “director,” “cast,” “country,” “date_added,” “rating.”

    ![](../images/count-missing.png " ")

 3. Next, impute the missing data. Imputation is a treatment method for missing value by filling it in using certain techniques. Can use mean, mode, or use predictive modeling. In this lab, we  use of the `fillna` function from spark dataframe for this imputation. We also Drop rows containing missing values and for that we the `dropna` function. After that we verify if there are any more null values in the dataframe.


     ![](../images/impute-data.png " ")

 4. Finally, we save the output to the parquet file at the same location where the input CSV was stored.
     ![](../images/save-parequet.png " ")

 5. Now, we run the sample python app locally first before running it on the Oracle Cloud Data Flow service. We pass the location of the CSV file as input to the sample app. It prints the count of the missing values in each column as well as prints the missing values after cleanup and finally writes the parquet file to output location.

   ![](../images/sample-app-local.png " ")


## **STEP 2**: Create a PySpark Application in Oracle Cloud Infrastructure Data Flow 


1. Create an Application, and select the Python type. In the `Resource Configuration`. Leave all these values as their defaults.  
   
   ![](../images/Sample-application.png " ")


2. Scroll down to `Application Configuration`. Configure the application as follows:

     1. **File URL** is the location of the Python file in object storage. The location for this application is:

      ```
      <copy>oci://dataflow-code@bigdatadatasciencelarge/data-cleansing/datacleaning.py</copy>
      ```

     2. **Arguments** The Spark app expects one command line parameters,  the input location of the csv file. In the Arguments field, enter

      ```
      <copy>oci://dataflow-sample-data@bigdatadatasciencelarge/Movies/netflix_titles.csv</copy>
      ```
*Note:  For this workshop the datacleaning.py file is already uploaded to the object storage.*

3. Double-check your Application configuration, and confirm it is similar to the following
   
   ![](../images/sample-app-configuration.png " ")

4. When done, click **Create**. When the Application is created, you see it in the Application list.

   ![](../images/sample-app-list.png " ")

## **STEP 3**: Run the Oracle Cloud Infrastructure Data Flow Application

1. Highlight your Application in the list, click the **Actions** icon, and click **Run**

   ![](../images/sampleapp-create.png " ")


2. While the Application is running, you can optionally load the **Spark UI**  to monitor progress. From the **Actions** icon for the run in question, select **Spark UI**

   ![](../images/run-spark-ui.png " ")

 
3. You are automatically redirected to the Apache Spark UI, which is useful for debugging and performance tuning.

   ![](../images/SparkUI..png " ")

4. When the `Run` completes, open it and navigate to the logs

   ![](../images/step1_run_java_app.png " ")     

5. After a minute or so your `Data Flow Run`  should show successful completion with a State of Succeeded:

   ![](../images/run-suceeded.png " ")

6. Drill into the Run to see more details, and scroll to the bottom to see a listing of logs.

   ![](../images/run-complete-log.png " ")

7. When you click the `spark_application_stdout.log.gz`  file, you should see the following log output

   ![](../images/run-stdlog-output.png " ")

8. You can also navigate to your output object storage bucket to confirm that new files have been created.

   ![](../images/run-object-storage-file.png " ")
 

## Acknowledgements

- **Author** - Anand Chandak
- **Adapted by** -  
- **Contributors** -
- **Last Updated By/Date** -

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Data flow). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
