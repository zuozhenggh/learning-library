# Lab 2: (Optional) Forecast using Data Science Notebook 

 In this lab, we will learn how to Forecast using Data Science Notebook. We will also learn about data requirements and data formats required by our APIs through some examples. 

*Estimated Time*: 50 minutes

### Objectives:

In this lab, you will:
*	Learn how to generate API key 
*	Learn how to create a project in Data Science service 
*	Learn how to set up a notebook session inside a data science project 
* Understand the data requirements and data formats for training model and forecast 
* Download prepared sample datasets & upload the downloaded dataset into Data Science Notebook Session
* Learn to use forecast API 
* Learn to get forecasts and predictions intervals for the forecast horizon
* Learn how to generate global explanation
* Learn how to generate local explanation for all the time steps in the forecast forizon


### Prerequisites:
*	A free tier or paid tenancy account in OCI
* You have completed all the tasks in Getting Started.  
* Download the sample python [notebook](files/ForecastingAPI_LiveLabs_SampleNotebook.ipynb). We will be using for explaining  how to use Forecasting Service APIs


## Task 1: API key generation  
1.  Log in to your Oracle Cloud account, expand the Profile menu and click on User Settings:
    ![](images/lab1-task1-step1-login.png " ")

2.  Under User Settings click on the API Keys under Resources on the left :
    ![](images/lab1-task1-step2-apikey.png " ")

3. Click on the Add API Key
    ![](images/lab1-task1-step3-addkey.png " ")

4. Download the private key on your system. We will use this later for authorization when using the forecasting APIs. After downloading, click on Add button. By clikcing on Add, this key would get listed under API Keys and become active.  
    ![](images/lab1-task1-step4-savekey.png " ")

5. Save the contents of the configuration file preview in a text file on your system. Details such as user, fingerprint, tenancy, region etc. will be needed when setting up authorization for using the forecasting APIs.
    ![](images/lab1-task1-step5-configurationfile.png " ")



## Task 2: Create a Data Science project


1.  Log in to your OCI account and search for data science in the top search bar. Click on the Data Science under Services:
    ![](images/lab1-task2-step1-login.png " ")

2.  Select the root compartment and press the create project button. 
    ![](images/lab1-task2-step2-createproject.png " ")

3.  Fill the name and description field and press the create button: 
    ![](images/lab1-task2-step3-project-details.png " ")



## Task 3: Create a Notebook session


1.  Log in to your OCI account and search for data science in the top search bar. Click on the Data Science under Services:

    ![](images/lab1-task3-step1-search.png " ")

2.  Select the root compartment and open the project where you want to create a notebook session. 
    
    ![](images/lab1-task3-step2-access.png " ")

3.  On opening a project, you will see the button to create a notebook session. Click the create notebook session: 
    ![](images/lab1-task3-step3-notebooksession.png " ")

4.  Give a name to the notebook session. Select appropriate compute, storage, VCN and subnet. Press the create button
    
    ![](images/lab1-task3-step4-sessiondetails.png " ")

5.  It takes a few minutes (5-10 minutes) for the newly created notebook session to become active. It can be seen under the     project. Once it has become active, open it.

    ![](images/lab1-task3-step5-wait.png " ")

6.  Click on the open button:
    
    ![](images/lab1-task3-step6-open.png " ")

7.  A new notebook can be created by using Python 3 kernel. Also a new folder can be created and given a custom name by using the + button:
    ![](images/lab1-task3-step7-python3.png " ")

8.  Setting up authorization for to use forecasting APIs
Use the tenancy, user and fingerprint from the configuration file as shown in API key generation step. Also upload the private API key that you downloaded in the API key generation step and give its path to private_key_file. Don’t change the pass_phrase. 

    ```Python
    from oci.signer import Signer

    auth = Signer(
        tenancy='ocid1.tenancy.oc1-------------------------------------------',
        user='ocid1.user.oc1..-------------------------------------------,
        fingerprint='00:ff:00:::::::::::::::60',
        private_key_file_location='api_key.pem',
        pass_phrase='test'  # optional
    )

    ```

    ![](images/lab1-task3-step9-authorization.png " ")


## Task 4: Understand Data, Download Samples, Prepare data, Create Project
In this task, we will discuss the data requirements and data formats required by our APIs through some examples. Forecasting service provides an AutoML solution with multiple univariate/multivariate algorithms that can run on single series or multiple series at once. For this, there are some data validations and data format requirements that the input data must satisfy.

**Data Validations**

For a successful forecast, the input data should pass the following data validations:

* Number of rows for a time series >= 5 and <= 5000
* Series length >= 2 X Major Seasonality
* If the series is non-seasonal, at least one non-seasonal method needs to be available for running.
* If ensemble method is selected, at least 2 other methods need to be selected as well
* Number of missing values <= 10% of series length
* If there are missing values for 5 consecutive time steps, throw an error
* All the timestamps in the primary data source should exist in the secondary data source, also the number of rows in the additional data source should be equal to the number of rows in the primary data source + forecast horizon size (adjusted by input and output frequency)
* Check if there are any duplicate dates in timeseries after grouping also (Check for both additional and primary data)

**Data format requirements**

The data should contain one timestamp column and other columns for target variable and series id (if using grouped data)
- timestamp column should contain dates in standard [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format e.g., 2020-07-13T00:00:00Z. Allowed formats: "yyyy-MM-dd","yyyy-MM-dd HH:mm:ss","yyyy-dd-MM HH:mm:ss","MM-dd-yyyy HH:mm:ss" ,"dd-MM-yyyy HH:mm:ss","dd-MM-yyyy","MM-dd-yyyy", "yyyy-dd-MM" 
- If the input date doesn't follow allowed format then it needs to be converted in the required format. Sample Python code for converting different date strings to ISO 8601 format is provided in Step 2 of Task 4 in this lab for  "yyyy-MM-dd HH:mm:ss"
- target_column should contain target values of time series. For example it be sales number of a sales data 
- series_id column should contain identifiers for different series e.g., if the data is having sales for different products, then series id can have product codes. 

**Note**: The column names used in the examples here are just for representation and actual data can have different custom names.  

Currently, our APIs support datasets that can be in one of the following formats:

1.  Single time series without any additional data:**
    Such datasets have only two columns in them. The first column should be a timestamp column and the second column should be the target column.

    **Here is a sample CSV-formatted data:**
    ```csv
    timestamp,target_column
    2020-07-13T00:00:00Z,20
    2020-07-14T00:00:00Z,30
    2020-07-15T00:00:00Z,28
    ...
    ...
    ```
2.  Multiple time series without any additional data:
    The input data can have multiple time series in it(grouped data). For such datasets there must be a column to identify different time-series.

    **Here is a sample CSV-formatted data:**
    ```csv
    timestamp,target_column,series_id
    2020-07-13T00:00:00Z,20,A
    2020-07-14T00:00:00Z,30,A
    2020-07-15T00:00:00Z,28,A
    ....
    ....
    2020-07-13T00:00:00Z,40,B
    2020-07-14T00:00:00Z,50,B
    2020-07-15T00:00:00Z,28,B
    ....
    ....
    2020-07-13T00:00:00Z,10,C
    2020-07-14T00:00:00Z,20,C
    2020-07-15T00:00:00Z,30,C
    ....
    ....
    ``` 
3.  Time series with additional data:
    The input data can have additional influencers that help in forecasting. We call the two datasets as primary and additional. The primary data should have three columns - timestamp, target column and a column for series id. The additional data should have a timestamp column, a series id column and columns for additional influencers.   

    **Here is a sample CSV-formatted data:**

    Primary data 
    ```csv
    timestamp,target_column,series_id
    2020-07-13T00:00:00Z,20,A
    2020-07-14T00:00:00Z,30,A
    2020-07-15T00:00:00Z,28,A
    ....
    ....
    2020-07-13T00:00:00Z,40,B
    2020-07-14T00:00:00Z,50,B
    2020-07-15T00:00:00Z,28,B
    ....
    ....
    2020-07-13T00:00:00Z,10,C
    2020-07-14T00:00:00Z,20,C
    2020-07-15T00:00:00Z,30,C
    ....
    ....
    ```
    Additional data 
    ```csv
    timestamp,feature_1,series_id
    2020-07-13T00:00:00Z,0,A
    2020-07-14T00:00:00Z,1,A
    2020-07-15T00:00:00Z,2,A
    ....
    ....
    2020-07-13T00:00:00Z,0,B
    2020-07-14T00:00:00Z,0,B
    2020-07-15T00:00:00Z,1,B
    ....
    ....
    2020-07-13T00:00:00Z,1,C
    2020-07-14T00:00:00Z,0,C
    2020-07-15T00:00:00Z,0,C
    ....
    ....
    ```
   
    Steps on how to generate inline data from csv files are given in Task 3 below.
    
    **Note:**
    * Missing values are permitted (with empty), and boolean flag values should be converted to numeric (0/1)

## Task 5: Download Sample Data and upload to Data Science Notebook Session

1. Here is a sample dataset to help you to easily understand how the input data looks like, Download the files to your local machine.

* [Primary data](files/favorita_13_beverages_primary_v1.csv)
* [Additional data](files/favorita_13_beverages_add_v1.csv)
  

2.  Next, we need to upload the sample training data into data science notebook, to be used for *inline data* preparation for model training in next steps.

Click on upload and then browse to file which you desire to upload:
![](images/lab1-task3-upload-data.png " ")

## Task 6: Inline Data preparation

1.  Import below necessary python modules for executing the scripts:

    ```Python
    import pandas as pd
    import requests
    import json
    import ast
    import matplotlib.pyplot as plt
    import re
    import os
    import simplejson
    ```

2.  You need to load the data in notebook via below mentioned python commands in a data frame
    Specify the correct path for the csv file that has the time series data.

    ```Python
    df_primary = pd.read_csv('favorita_13_beverages_primary_v1.csv')
    df_add = pd.read_csv('favorita_13_beverages_add_v1.csv')
    ```

3.  Convert the date field to "yyyy-mm-dd hh:mm:ss" format with below commands if not in the right format
    Use this link https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior for other date time formats

    ```Python
    # modify date format
    df_primary['date'] = pd.to_datetime(df_primary['date'],
                                            format='%d/%m/%y').apply(lambda x: str(x))
    # modify date format
    df_add['date'] = pd.to_datetime(df_add['date'],
                                            format='%d/%m/%y').apply(lambda x: str(x))
    ```
4.  Sort the data

    ```Python
    df_primary.sort_values(by = "date" , inplace = True)  
    df_add.sort_values(by = "date" , inplace = True)      
    ```

5.  Setting variables to create forecast with below commands
    - prim_load : is the variable having inline primary data
    - add_load : is the variable having inline additional data 

    ```Python
    #primary data
    prim_load = df_primary.values.transpose().tolist()
    prim_load
    ```

    ```Json
    [['13_BEVERAGES',
      '13_BEVERAGES',
      '13_BEVERAGES',
      '13_BEVERAGES',
      '13_BEVERAGES',
      ...],
      ['2013-01-01 00:00:00',
      '2013-01-02 00:00:00',
      '2013-01-03 00:00:00',
      '2013-01-04 00:00:00',
      '2013-01-05 00:00:00',
      ...],
    [0,
      767,
      987,
      652,
      1095,
      ...]]
      ```
      ```Python
    #additional data
    add_load = df_add.values.transpose().tolist()
    add_load
    ```

    ```Json
    [['13_BEVERAGES',
      '13_BEVERAGES',
      '13_BEVERAGES',
      '13_BEVERAGES',
      '13_BEVERAGES',
      ...],
      ['2013-01-01 00:00:00',
      '2013-01-02 00:00:00',
      '2013-01-03 00:00:00',
      '2013-01-04 00:00:00',
      '2013-01-05 00:00:00',
      ...],
    [0,
      0,
      0,
      0,
      0,
      ...]]
      ```

## Task 7 : Create Project  
  Once, the data is prepared , you  will learn how to create the forecasting service project.

  In the payload:
  * compartmentId  will be same as tenancy id if is root compartment else provide desired compartment id. Please visit Lab1 API Key generation. In the below eg. we will be using root compartment
  * displayName can be given any custom name
  * description can be customized

    ```Python
    url = "https://forecasting.---------------------.oraclecloud.com/20220101/projects"

    payload = json.dumps({
      "displayName": "Forecast API Demo",
      "compartmentId": "ocid-------------------",
      "description": "Forecasting service API Demo",
      "freeformTags": None,
      "definedTags": None,
      "systemTags": None
    })
    headers = {
      'Content-Type': 'application/json'
    }
    response = requests.request("POST", url, headers=headers, data=payload, auth=auth)
    ```
    We store the response using below command :
    ```Python
    create_project_response = json.loads(response.text)
    create_project_response
    ```

    ```Json
    {"id":"ocid.forecastproject..-----------",
    "displayName":"Forecast API Demo",
    "compartmentId":"ocid.tenancy.----------",
    "description":"Forecasting service API Demo",
    "timeCreated":"2021-11-18T05:18:58.737Z",
    "timeUpdated":"2021-11-18T05:18:58.737Z",
    "lifecycleState":"ACTIVE",
    "freeformTags":{},
    "definedTags":{"Oracle-Tags":{"CreatedBy":"demo_user_2","CreatedOn":"2021-11-18T05:18:58.568Z"}},"systemTags":{}}
    ```
    We store the compartment id and project id which will be used when calling create forecast API using below command:
    ```Python
    project_id = create_project_response['id']
    compartment_id = create_project_response['compartmentId']
    ```


**Note** : It is not needed to create new projects everytime we run this notebook. A project id once created can be used again and again.

## Task 8: Train Model and Forecast
In this task, we will show you how to use create and get forecast APIs. 

1. Create a Forecast model

Creating a model requires 3 actions to kick off training the forecasting model.

  * Pass the inline data in the payload of the forecast train settings
  * Set other training parameters as show in below code snippet
  * Create Forecast API Call using the /forecasts url

  We pre-define some the parameters of the payload based on the example input data (the one we uploaded in previous lab session)

    ```Python 
    date_col = 'date'
    target_col = 'sales'
    id_col = 'item_id'
    data_frequency = 'DAY'
    forecast_frequency = 'DAY'
    forecast_horizon  = 14
    forecast_name = "LiveLabs Inline Forecasting Service API "
    ```

In the example below we show how to create the payload for calling create forecast API. 
- "compartmentId": is same as tenancy id(refer Task 5 : Create Project ID in Lab 2)
- "projectId": the one you get after creating a project (refer Task 5 : Create Project ID in Lab 2)
- "targetVariables": name of the column in primary data having the target values
- models: models selected for training. Here we are showing some the models implemented in our service.Our AutoML service selects the best model out of all the models selected for training. 
- "forecastHorizon": number of future timesteps for which to forecast 
- "tsColName": name of the timestamp column  
- "dataFrequency": 'MINUTE','HOUR', 'DAY', 'WEEK', 'MONTH' or 'YEAR'  and custom frequency depending on frequency of input data
- "forecastFrequency": 'HOUR', 'DAY', 'WEEK', 'MONTH' or 'YEAR' and custom frequency depending on forecast frequency required . For custom frequency : If input dataFrequency multiplier is more than 1, then the forecast frequency should be also at the same base frequency as the input. Eg.  If dataFrequency : 2HOURS  , then forecastFrequency: 24HOURS if you want forecastFrequency to be a DAY level
- "isDataGrouped": True if data is grouped or having additional data. False if using only one series with no additional data
- "columnData": inline data (Please refer Task 4: Inline Data preparation in Lab 2)
- "columnSchema": provide column name and data type for each column in the data source
- "additionalDataSource": column schema for additional data to be provided if using additional data.This field should be removed if there is no additional data
- "models" : We can use any of the available algorithms are univariate and multivariate methods. 

   - Univariate :"SMA","DMA","HWSM","HWSA","SES","DES","SA","SM","UAM","UHM","HWSMDAMPED","HWSADAMPED", "PROPHET", "ARIMA"
   
   - Multivariate : "PROBRNN","APOLLONET","EFE"               

    ```Python
    %%time

    url = "https://forecasting.aiservice.us-phoenix-1.oci.oraclecloud.com/20220101/forecasts"

    payload = simplejson.dumps(
    {
    "displayName": forecast_name,
    "compartmentId": compartment_id,
    "projectId": project_id,
    "forecastCreationDetails": {
        "forecastHorizon": forecast_horizon,
        "confidenceInterval": "CI_5_95",
        "errorMeasure": "RMSE",
        "forecastTechnique": "ROCV",
        "forecastFrequency": forecast_frequency,
        "isForecastExplanationRequired": True,
        "modelDetails": {
            "models": [
                    "SMA",
                    "DMA",
                    "HWSM",
                    "HWSA",
                    "SES",
                    "DES",
                    "PROPHET"
            ]
        },
        "dataSourceDetails": {
            "type": "INLINE",
            "primaryDataSource": {
                "columnData": prim_load,
                "isDataGrouped": True,
                "tsColName": date_col,
                "tsColFormat": "yyyy-MM-dd HH:mm:ss",
                "dataFrequency": data_frequency,
                "columnSchema": [
                        {
                            "columnName": id_col,
                            "dataType": "STRING"
                        },
                        {
                            "columnName": date_col,
                            "dataType": "DATE"
                        },
                        {
                            "columnName": target_col,
                            "dataType": "INT"
                        }
                    ]
            },
            "additionalDataSource": {
                "columnData": add_load,
                "isDataGrouped": True,
                "tsColName": date_col,
                "tsColFormat": "yyyy-MM-dd HH:mm:ss",
                "dataFrequency": data_frequency,
                "columnSchema": [
                        {
                            "columnName": id_col,
                            "dataType": "STRING"
                        },
                        {
                            "columnName": "date",
                            "dataType": "DATE"
                        },
                        {
                            "columnName": "onpromotion",
                            "dataType": "INT"
                        }
                    ]
            }
              
        },
        "targetVariables": [
            target_col
        ]
    }
    }
        , ignore_nan=True
    )

    headers = {
      'Content-Type': 'application/json'
    }
          
    response = requests.request("POST", url, headers=headers, data=payload, auth=auth)
    ```

  We store the response and get forecast id 
    ```Python
    create_forecast_response = json.loads(response.text)
    create_forecast_response
    ```
   
2. Get forecast and Prediction Intervals
- Take the forecast ID from response above and create a *Get forecast API* call using below code snippet
- Once the results are produced, the  'lifecycleState' changes to 'ACTIVE'. If it is 'CREATING', then you need to re-run the code below after sometimes.
- The ```forecastResult``` key in the below ```get_forecast_response``` gives us the forecast for the given horizon  
- We also get Prediction Intervals from ```predictionInterval``` key in the response

    It can take sometime to create the forecast depending on the models selected and the size of the input data.  For the dataset we have taken, it should take around 3-4 minutes to give results. Till then you can take a break or focus on other task.

    ```Python
    create_forecast_id = create_forecast_response['id']
    create_forecast_id
    url = "https://forecasting-------------------------.oci.oraclecloud.com/20220101/forecasts/{}".format(create_forecast_id)

    payload={}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload, auth=auth)
    get_forecast_response = json.loads(response.text)
    get_forecast_response
    ```  
    Forecast Response below :
    ```json
        {'description': None,
    'id': 'ocid1.aiforecast.oc1.phx.amaaaaaasxs7gpyaaeoiniiomm6b3wyl4tao5epvjh5qcxcjmuw765l6r35a',
    'responseType': None,
    'compartmentId': 'ocid1.tenancy.oc1..aaaaaaaadany3y6wdh3u3jcodcmm42ehsdno525pzyavtjbpy72eyxcu5f7q',
    'projectId': 'ocid1.aiforecastproject.oc1.phx.amaaaaaasxs7gpya64347fdyocgxvqvxkt5qxr5rr2axxlovvdzwavhks4bq',
    'displayName': 'Stat_Prophet Inline Forecasting Service API BETA V2 ',
    'createdBy': None,
    'timeCreated': '2022-04-27T09:14:15.209Z',
    'timeUpdated': '2022-04-27T09:16:03.221Z',
    'lifecyleDetails': None,
    'lifecycleState': 'ACTIVE',
    'failureMessage': None,
    'forecastCreationDetails': None,
    'forecastResult': {'dataSourceType': 'INLINE',
      'forecastHorizon': 14,
      'forecast': [{'targetColumn': '13_BEVERAGES',
        'dates': ['2017-07-29 00:00:00',
        '2017-07-30 00:00:00',
        '2017-07-31 00:00:00',
        '2017-08-01 00:00:00',
        '2017-08-02 00:00:00',
        '2017-08-03 00:00:00',
        '2017-08-04 00:00:00',
        '2017-08-05 00:00:00',
        '2017-08-06 00:00:00',
        '2017-08-07 00:00:00',
        '2017-08-08 00:00:00',
        '2017-08-09 00:00:00',
        '2017-08-10 00:00:00',
        '2017-08-11 00:00:00'],
        'forecast': [1794.423,
        1458.0826,
        1322.5546,
        1746.7986,
        1664.3289,
        1606.625,
        1436.7811,
        1594.2352,
        1343.2721,
        1264.662,
        1584.5563,
        1464.1411,
        1624.6233,
        1521.1838],
        'predictionInterval': [{'upper': 2310.6255, 'lower': 1274.0431},
        {'upper': 1970.2235, 'lower': 992.85834},
        {'upper': 1826.6882, 'lower': 816.79974},
        {'upper': 2230.6548, 'lower': 1218.3107},
        {'upper': 2158.7866, 'lower': 1162.2372},
        {'upper': 2111.322, 'lower': 1099.0563},
        {'upper': 1940.0271, 'lower': 941.1704},
        {'upper': 2074.8967, 'lower': 1097.0505},
        {'upper': 1815.2491, 'lower': 847.81165},
        {'upper': 1740.884, 'lower': 755.6372},
        {'upper': 2069.1372, 'lower': 1137.5074},
        {'upper': 1964.7842, 'lower': 963.93646},
        {'upper': 2153.4753, 'lower': 1094.3989},
        {'upper': 2050.892, 'lower': 995.7819}]}],
      'metrics': {'trainingMetrics': {'numberOfFeatures': 1,
        'totalDataPoints': 1670,
        'generationTime': '108 seconds'},
      'targetColumns': [{'targetColumn': '13_BEVERAGES',
        'bestModel': 'ProphetModel',
        'errorMeasureValue': 272.46014,
        'errorMeasureName': 'RMSE',
        'numberOfMethodsFitted': 9,
        'seasonality': 7,
        'seasonalityMode': 'ADDITIVE',
        'modelValidationScheme': 'ROCV',
        'preprocessingUsed': {'aggregation': 'NONE',
          'outlierDetected': 14,
          'missingValuesImputed': 0,
          'transformationApplied': 'NONE'}}]}},
    'freeformTags': None,
    'definedTags': None,
    'systemTags': None}
    ```
Using below code, we can save the forecast as tabular data in a csv file with prediction intervals.

    ```Python
    df_forecasts = pd.DataFrame({'forecast_dates':[],'upper':[],'lower':[],'forecast':[], 'series_id':[]})
    for i in range(len(get_forecast_response['forecastResult']['forecast'])):

        group = get_forecast_response['forecastResult']['forecast'][i]['targetColumn']
        point_forecast = get_forecast_response['forecastResult']['forecast'][i]['forecast']
        pred_intervals = pd.DataFrame(get_forecast_response['forecastResult']
                                  ['forecast'][i]['predictionInterval'],dtype=float)
        out = pred_intervals
        out['forecast'] = point_forecast
        forecast_dates = pd.DataFrame({'forecast_dates':get_forecast_response['forecastResult']['forecast'][i]['dates']})
        forecasts = pd.concat([forecast_dates,out],axis=1)
        forecasts['series_id'] = group
        df_forecasts = df_forecasts.append(forecasts, ignore_index = False)
    file_name = 'forecast_demo.csv'
    df_forecasts.to_csv(file_name, index = None)
    df_forecasts        
    ```
  The forecast.csv will be saved in the same folder as the notebook file.

![](images/lab1_task2.png " ")

3. Get Training Metrics report from the response

* We can also retrieve training metrics report from the response which shows the best model selected using AutoML based on performance on selected error metric. Eg. RMSE in this example. 
* We also get seasonality, outlier detected and other preprocessing methods applied to the series
    
    Code to execute:
    ```Python
    get_forecast_response['forecastResult']['metrics']['targetColumns']
    ```
    Output:
    ```Json
    [{'targetColumn': '13_BEVERAGES',
      'bestModel': 'ProphetModel',
      'errorMeasureValue': 272.46014,
      'errorMeasureName': 'RMSE',
      'numberOfMethodsFitted': 9,
      'seasonality': 7,
      'seasonalityMode': 'ADDITIVE',
      'modelValidationScheme': 'ROCV',
      'preprocessingUsed': {'aggregation': 'NONE',
      'outlierDetected': 14,
      'missingValuesImputed': 0,
      'transformationApplied': 'NONE'}}]
    ```

## Task 9: Get Explainability for Forecast

Forecast will also give explainability for each of the target time series in the dataset. Explainability report includes both global and local level explanations. Explanations provides insights on the features that are influencing the forecast. Global explanation represents the general model behaviour - e.g., which features does the model consider important ? Local explanation tells the impact of each feature at a single time step level. Forecast provides local explanations for all the forecasts that it generates

In this task, we will discuss how to get global and local explanation for the best model chosen by forecast, inorder to understand the features that are influencing the forecast

Here is a case study on using the forecast api to get the global and local explanations

### Get Global Explanation

1. Call the explanation API using below code as shown below:
    ```Python
    url = "https://forecasting----.------.------.---.oraclecloud.com/20220101/forecasts/{}/explanations/".format(create_forecast_id)

    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload, auth=auth)
    get_forecast_explanations = json.loads(response.text)
    get_forecast_explanations
    ```

2. Sample Json ouput

    The JSON format is also straight-forward, it contains a key `globalFeatureImportance` listing all the influencing features and their feature importance scores - raw and normalized scores

    ```Json
    {'dataSourceType': 'INLINE',
    'freeformTags': None,
    'definedTags': None,
    'systemTags': None,
    'explanations': [{'targetColumn': '13_BEVERAGES',
      'bestModel': 'PROPHET',
      'bestHyperParameters': {'changepoint_range': '0.8800000000000001',
        'seasonality_mode': 'additive',
        'changepoint_prior_scale': '0.21544346900318823',
        'seasonality_prior_scale': '2.4051320102374683',
        'holidays_prior_scale': '0.46415888336127775'},
      'hyperparameterSearchMethod': 'OPTUNA',
      'bestModelSelectionMetric': 'RMSE',
      'globalFeatureImportance': {'influencingFeatures': {'onpromotion': {'normalizedScore': 0.6431381,
          'rawScore': 159.37825},
        'trend': {'normalizedScore': 0.041080225, 'rawScore': 10.180231},
        'AgeFeature': {'normalizedScore': 0.055123076, 'rawScore': 13.660238},
        'se@7': {'normalizedScore': 0.26065862, 'rawScore': 64.5947}}},
      'localFeatureImportance': {'forecastHorizon': 14,
        'influencingFeatures': [{'onpromotion': {'normalizedScore': 0.046111915,
          'rawScore': 163.4498},
          'trend': {'normalizedScore': 0.0058014663, 'rawScore': 20.564068},
          'AgeFeature': {'normalizedScore': -0.007784638, 'rawScore': -27.593681},
          'se@7': {'normalizedScore': 0.011428176, 'rawScore': 40.508686}},
        {'onpromotion': {'normalizedScore': -0.026147036, 'rawScore': -92.68163},
          'trend': {'normalizedScore': 0.005916347, 'rawScore': 20.971275},
          'AgeFeature': {'normalizedScore': -0.007938789, 'rawScore': -28.14009},
          'se@7': {'normalizedScore': -0.011160823, 'rawScore': -39.561016}},
        {'onpromotion': {'normalizedScore': -0.044880837, 'rawScore': -159.08607},
          'trend': {'normalizedScore': 0.0060312278, 'rawScore': 21.378485},
          'AgeFeature': {'normalizedScore': -0.008092941, 'rawScore': -28.6865},
          'se@7': {'normalizedScore': -0.030622493, 'rawScore': -108.54549}},
        {'onpromotion': {'normalizedScore': 0.067521974, 'rawScore': 239.34059},
          'trend': {'normalizedScore': 0.0061461083, 'rawScore': 21.785694},
          'AgeFeature': {'normalizedScore': -0.008247092, 'rawScore': -29.23291},
          'se@7': {'normalizedScore': -0.023299698, 'rawScore': -82.58887}},
        {'onpromotion': {'normalizedScore': 0.016673084, 'rawScore': 59.099957},
          'trend': {'normalizedScore': 0.006260989, 'rawScore': 22.192904},
          'AgeFeature': {'normalizedScore': -0.008401243, 'rawScore': -29.77932},
          'se@7': {'normalizedScore': 0.0043223756, 'rawScore': 15.321233}},
        {'onpromotion': {'normalizedScore': -0.018118262, 'rawScore': -64.22258},
          'trend': {'normalizedScore': 0.0063758693, 'rawScore': 22.600113},
          'AgeFeature': {'normalizedScore': -0.008555395, 'rawScore': -30.32573},
          'se@7': {'normalizedScore': 0.022873763, 'rawScore': 81.07909}},
        {'onpromotion': {'normalizedScore': -0.06629089, 'rawScore': -234.97687},
          'trend': {'normalizedScore': 0.00649075, 'rawScore': 23.007322},
          'AgeFeature': {'normalizedScore': -0.008709546, 'rawScore': -30.872139},
          'se@7': {'normalizedScore': 0.023169866, 'rawScore': 82.12866}},
        {'onpromotion': {'normalizedScore': -0.010089491, 'rawScore': -35.763535},
          'trend': {'normalizedScore': 0.0066056303, 'rawScore': 23.414532},
          'AgeFeature': {'normalizedScore': -0.008863697, 'rawScore': -31.418549},
          'se@7': {'normalizedScore': 0.011428176, 'rawScore': 40.508686}},
        {'onpromotion': {'normalizedScore': -0.058262125, 'rawScore': -206.51782},
          'trend': {'normalizedScore': 0.006720511, 'rawScore': 23.821741},
          'AgeFeature': {'normalizedScore': -0.009017848, 'rawScore': -31.964958},
          'se@7': {'normalizedScore': -0.011160823, 'rawScore': -39.561016}},
        {'onpromotion': {'normalizedScore': -0.06093838, 'rawScore': -216.00417},
          'trend': {'normalizedScore': 0.0068353913, 'rawScore': 24.22895},
          'AgeFeature': {'normalizedScore': -0.009172, 'rawScore': -32.511368},
          'se@7': {'normalizedScore': -0.030622493, 'rawScore': -108.54549}},
        {'onpromotion': {'normalizedScore': 0.022025598, 'rawScore': 78.072655},
          'trend': {'normalizedScore': 0.006950272, 'rawScore': 24.63616},
          'AgeFeature': {'normalizedScore': -0.009326151, 'rawScore': -33.057777},
          'se@7': {'normalizedScore': -0.023299698, 'rawScore': -82.58887}},
        {'onpromotion': {'normalizedScore': -0.03952832, 'rawScore': -140.11337},
          'trend': {'normalizedScore': 0.0070651523, 'rawScore': 25.04337},
          'AgeFeature': {'normalizedScore': -0.009480302, 'rawScore': -33.604187},
          'se@7': {'normalizedScore': 0.0043223756, 'rawScore': 15.321233}},
        {'onpromotion': {'normalizedScore': -0.0127657475,
          'rawScore': -45.249886},
          'trend': {'normalizedScore': 0.007180033, 'rawScore': 25.450579},
          'AgeFeature': {'normalizedScore': -0.009634453, 'rawScore': -34.150597},
          'se@7': {'normalizedScore': 0.022873763, 'rawScore': 81.07909}},
        {'onpromotion': {'normalizedScore': -0.04220458, 'rawScore': -149.59973},
          'trend': {'normalizedScore': 0.0072949133, 'rawScore': 25.857788},
          'AgeFeature': {'normalizedScore': -0.009788604, 'rawScore': -34.697006},
          'se@7': {'normalizedScore': 0.023169866, 'rawScore': 82.12866}}]}}]}
    ```
*The above explanation shows features contributing towards the model output/prediction from the base value. The base value is nothing but the average model output computed over most recent 100 time steps in the training data. If the dataset size is less than 100, then the base value is computed over the whole dataset. The features which have positive feature importance scores, push the prediction higher and the features that have negative feature importance scores, push the prediction lower. The feature importance scores are raw scores and those features with high in magnitude influence the prediction most and the sign of the scores indicates whether the influence is positive or negative.*

3. Plotting the global feature importance 

    Here is a simple function to plot the global feature importance from the above json output.

    ```Python
    import plotly.express as px
    import plotly.graph_objects as go
    def plot_global_feature_importance(get_forecast_explanations, time_step):
        df_imps = pd.DataFrame()
        global_feature_importance = get_forecast_explanations['explanations'][0]['globalFeatureImportance']['influencingFeatures']
        df_imps['Feature_Importance'] = local_feature_importance.values()
        df_imps["Feature_Importance"] = df_imps["Feature_Importance"].apply(lambda x:x["normalizedScore"])
        feature_names = local_feature_importance.keys()
        df_imps['Features'] = feature_names

        title = "Global Feature Importance for Timestep " + str(time_step)
        fig = px.bar(df_imps, y="Features", x='Feature_Importance', title=title)
        fig.update_traces(marker_color='lightsalmon')
        fig.show()

    plot_global_feature_importance(get_forecast_explanations, time_step)
    ```

  ### Sample Global feature importance plot

  ![Global Feature Importance ](images/lab1-task1-global-feature-importance.png)

### Get Local Explanation

  To get local explanation, there is no seperate api call required. The api call for get explanation will fetch both global and local explanations.
  The key `localFeatureImportance` in the json output contains all the influencing features and their feature importance scores for all the time steps in the forecast horizon

1. Plotting the local feature importance 

    Here is a simple function to plot the local feature importance from the above json output.

    ```Python
    import plotly.express as px
    import plotly.graph_objects as go
    import numpy as np

    def plot_local_feature_importance(get_forecast_explanations, time_step):
        df_imps = pd.DataFrame()
        local_feature_importance = get_forecast_explanations['explanations'][0]['localFeatureImportance']['influencingFeatures'][time_step]
        df_imps['Feature_Importance'] = local_feature_importance.values()
        df_imps["Feature_Importance"] = df_imps["Feature_Importance"].apply(lambda x:x["normalizedScore"])
        feature_names = local_feature_importance.keys()
        df_imps['Features'] = feature_names

        title = "Local Feature Importance for Timestep " + str(time_step)
        fig = px.bar(df_imps, y="Features", x='Feature_Importance', title=title)
        fig.update_traces(marker_color='lightsalmon')
        fig.show()

    time_step = 1 

    plot_local_feature_importance(get_forecast_explanations, time_step)
    ```

    ### Sample Local feature importance plot for step 1 forecast

    ![Local Feature Importance for step 1 forecast](images/lab1-task2-local-feature-importance.png)

    Similarly, by changing the time step, you can get the local feature importance for that corresponding forecast.




## Acknowledgements
* **Authors**
    * Ravijeet Kumar - Senior Data Scientist - Oracle AI Services
    * Anku Pandey - Data Scientist - Oracle AI Services
    * Sirisha Chodisetty - Senior Data Scientist - Oracle AI Services
    * Sharmily Sidhartha - Principal Technical Program Manager - Oracle AI Services
    * Last Updated By/Date: Ravijeet Kumar, 19th-January 2022


