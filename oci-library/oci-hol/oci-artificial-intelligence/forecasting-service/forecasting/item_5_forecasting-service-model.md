# Lab 3: Train Model and Forecast

## Introduction

In this session, we will show you how to train a forecasting model, and make forecast with new data. 

***Estimated Lab Time***: 30 minutes

### Objectives

In this lab, you will:
- Learn to train a forecasting model with created data asset 
- Learn to verify the trained model performance
- Generate forecast for desired horizon set in payload of forecast train settings

### Prerequisites
- A Free tier or paid tenancy account in OCI
- Understand basic forecast model training and model selection process


## Task 1: Create a Forecast model

Creating a model requires 3 actions to kick off training the forecasting model.

* Pass the inline data in the payload of the forecast train settings
* Set other training parameters as show in below code snippet
* Create Forecast API Call using the /forecasts url

```Python
%%time

url = "https://forecasting---------------------.oraclecloud.com/20220101/forecasts"

payload = simplejson.dumps({
  "compartmentId": compartment_id,
  "displayName": "Forecast Model",
  "description": "Training Forecast Model",
  "projectId": project_id,
  "forecastCreationDetails": {
    "targetVariables": [
      target_col
    ],
    "modelTrainingDetails": {
      "modelType": "UNIVARIATE",
      "models": [
        "SMA",
        "DMA"
      ]
    },
    "forecastHorizon": 7,
    "confidenceInterval": "CI_5_95",
    "errorMeasure": "RMSE",
    "forecastTechnique": "ROCV",
    "forecastFrequency": "DAY",
    "isForecastExplanationRequired": True,
    "dataSourceDetails": {
      "type": "INLINE",
      "dataSources": {
        "primaryDataSource": {
          "isDataGrouped": False,
          "columnData": prim_load,
          "columnSchema": [
            {
              "columnName": date_col,
              "dataType": "DATE"
            },
            {
              "columnName": target_col,
              "dataType": "INT"
            }
          ],
          "tsColName": date_col,
          "tsColFormat": "yyyy-MM-dd HH:mm:ss",
          "dataFrequency": "DAY"
        }
      }
    }
  }
}, ignore_nan=True)
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload, auth=auth)
create_forecast_response = json.loads(response.text)
create_forecast_response
```
The above code snippet give below response :
```json

{'description': 'Training Forecast Model',
 'id': 'ocid.aiforecast.----------------------------',
 'responseType': None,
 'compartmentId': 'ocid.---------------------------------',
 'projectId': 'ocid.forecastproject.-----------',
 'displayName': 'Forecast Model',
 'createdBy': None,
 'timeCreated': '2021-11-18T05:20:19.029Z',
 'timeUpdated': '2021-11-18T05:20:19.029Z',
 'lifecyleDetails': None,
 'lifecycleState': 'CREATING',
 'failureMessage': None,
 'forecastCreationDetails': {'targetVariables': ['gasoline purchase'],
  'modelTrainingDetails': {'modelType': 'UNIVARIATE',
   'models': ['SMA', 'DMA']},
  'dataSourceDetails': {'type': 'INLINE',
   'dataSources': {'primaryDataSource': {'dataAssetId': None,
     'isDataGrouped': False,
     'tsColName': 'period',
     'dataFrequency': 'DAY',
     'tsColFormat': 'yyyy-MM-dd HH:mm:ss',
     'columnSchema': [{'columnName': 'period', 'dataType': 'DATE'},
      {'columnName': 'gasoline purchase', 'dataType': 'INT'}],
     'columnData': [['2021-01-01 00:00:00',
       '2021-01-02 00:00:00',
       '2021-01-03 00:00:00',
       '2021-01-04 00:00:00',
       '2021-01-05 00:00:00',
       '2021-01-06 00:00:00',
       '2021-01-07 00:00:00',
       '2021-01-08 00:00:00',
       '2021-01-09 00:00:00',
       '2021-01-10 00:00:00',
       '2021-01-11 00:00:00',
       '2021-01-12 00:00:00',
       '2021-01-13 00:00:00',
       '2021-01-14 00:00:00',
       '2021-01-15 00:00:00',
       '2021-01-16 00:00:00',
       '2021-01-17 00:00:00',
       '2021-01-18 00:00:00',
       '2021-01-19 00:00:00',
       '2021-01-20 00:00:00',
       '2021-01-21 00:00:00',
       '2021-01-22 00:00:00',
       '2021-01-23 00:00:00',
       '2021-01-24 00:00:00',
       '2021-01-25 00:00:00',
       '2021-01-26 00:00:00',
       '2021-01-27 00:00:00',
       '2021-01-28 00:00:00',
       '2021-01-29 00:00:00',
       '2021-01-30 00:00:00'],
      ['275',
       '291',
       '307',
       '281',
       '295',
       '268',
       '252',
       '279',
       '264',
       '288',
       '302',
       '287',
       '290',
       '311',
       '277',
       '245',
       '282',
       '277',
       '298',
       '303',
       '310',
       '299',
       '285',
       '250',
       '260',
       '245',
       '271',
       '282',
       '302',
       '285']]},
    'additionalDataSource': None}},
  'forecastHorizon': 7,
  'confidenceInterval': 'CI_5_95',
  'errorMeasure': 'RMSE',
  'forecastTechnique': 'ROCV',
  'forecastFrequency': 'DAY',
  'isForecastExplanationRequired': True},
 'forecastResult': None,
 'freeformTags': {},
 'definedTags': {'Oracle-Tags': {'CreatedBy': 'demo_user',
   'CreatedOn': '2021-11-18T05:20:17.617Z'}},
 'systemTags': {}}

```

## Task 2: Get forecast and Prediction Intervals
- Take the forecast ID from response above and create a *Get forecast API* call using below code snippet
- Keep refreshing the code cell till the 'lifecycleState' changes from CREATING to ACTIVE 
- The ```forecastResult``` key in the below ```get_forecast_response``` gives us the forecast for the given horizon of 7 time steps 
- We also get Prediction Intervals from ```predictionInterval``` key in the response

```Python
create_forecast_id = create_forecast_response['id']
create_forecast_id
url = "https://forecasting-int.aiservice.us-ashburn-1.oci.oraclecloud.com/20220101/forecasts/{}".format(create_forecast_id)

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload, auth=auth)
get_forecast_response = json.loads(response.text)
get_forecast_response
```

```Json
{'description': 'Training Forecast Model',
 'id': 'ocid1.aiforecast.--------------------',
 'responseType': None,
 'compartmentId': 'ocid.---------------------',
 'projectId': 'ocid1.---------------------',
 'displayName': 'Forecast Model',
 'createdBy': None,
 'timeCreated': '2021-11-18T05:20:28.797Z',
 'timeUpdated': '2021-11-18T05:20:28.815Z',
 'lifecyleDetails': None,
 'lifecycleState': 'ACTIVE',
 'failureMessage': None,
 'forecastCreationDetails': None,
 'forecastResult': {'dataSourceType': 'INLINE',
  'forecast': [{'targetColumn': 'gasoline purchase',
    'dates': ['2021-01-31 00:00:00',
     '2021-02-01 00:00:00',
     '2021-02-02 00:00:00',
     '2021-02-03 00:00:00',
     '2021-02-04 00:00:00',
     '2021-02-05 00:00:00',
     '2021-02-06 00:00:00'],
    'forecast': [299.0, 285.0, 250.0, 260.0, 245.0, 271.0, 282.0],
    'predictionInterval': [{'upper': 326.71725, 'lower': 271.28275},
     {'upper': 312.99637, 'lower': 257.00363},
     {'upper': 278.42215, 'lower': 221.57785},
     {'upper': 288.15268, 'lower': 231.8473},
     {'upper': 273.7455, 'lower': 216.25449},
     {'upper': 299.89047, 'lower': 242.10951},
     {'upper': 311.59213, 'lower': 252.40787}]}],
  'metrics': {'trainingMetrics': {'numberOfFeatures': 1,
    'totalDataPoints': 30},
   'targetColumns': [{'targetColumn': 'gasoline purchase',
     'bestModel': 'SeasonalNaiveModel',
     'errorMeasureValue': 19.163588,
     'errorMeasureName': 'RMSE',
     'numberOfMethodsFitted': 4,
     'seasonality': 9,
     'seasonalityMode': 'MULTIPLICATIVE',
     'preprocessingUsed': {'aggregation': 'NONE',
      'outlierDetected': 0,
      'missingValuesImputed': 0,
      'transformationApplied': 'NONE'}}]}},
 'freeformTags': {},
 'definedTags': {'Oracle-Tags': {'CreatedBy': 'demo-user',
   'CreatedOn': '2021-11-18T05:20:17.617Z'}},
 'systemTags': {}}

```

Using below code , we can save the forecast as tabular data in a csv file with prediction intervals

```Python
for i in range(len(get_forecast_response['forecastResult']['forecast'])):
    
    group = get_forecast_response['forecastResult']['forecast'][i]['targetColumn']
    point_forecast = get_forecast_response['forecastResult']['forecast'][i]['forecast']
    pred_intervals = pd.DataFrame(get_forecast_response['forecastResult']
                              ['forecast'][i]['predictionInterval'],dtype=float)
    out = pred_intervals
    out['forecast'] = point_forecast
forecast_dates = pd.DataFrame({'forecast_dates': get_forecast_response['forecastResult']['forecast'][0]['dates']})
forecasts = pd.concat([forecast_dates,out],axis=1) 
file_name = target_col + '_forecast.csv'
forecasts.to_csv('./Output/'+file_name, index = None)          
```

## Task 3: Get Training Metrics report from the response
* We can also retrieve training metrics report from the response which shows the best model selected using auto ml based on performance on selected error metric. Eg. RMSE in this example. 
* We also get seasonality , outlier detected and other preprocessing methods applied to the series


```Python
get_forecast_response['forecastResult']['metrics']['targetColumns']
```

```Json
[{'targetColumn': 'gasoline purchase',
  'bestModel': 'SeasonalNaiveModel',
  'errorMeasureValue': 19.163588,
  'errorMeasureName': 'RMSE',
  'numberOfMethodsFitted': 4,
  'seasonality': 9,
  'seasonalityMode': 'MULTIPLICATIVE',
  'preprocessingUsed': {'aggregation': 'NONE',
   'outlierDetected': 0,
   'missingValuesImputed': 0,
   'transformationApplied': 'NONE'}}]
```

**Congratulations on completing this lab!**

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Ravijeet Kumar - Senior Data Scientist - Oracle AI Services
    * Anku Pandey - Data Scientist - Oracle AI Services
    * Sirisha Chodisetty - Senior Data Scientist - Oracle AI Services
    * Sharmily Sidhartha - Principal Technical Program Manager - Oracle AI Services
