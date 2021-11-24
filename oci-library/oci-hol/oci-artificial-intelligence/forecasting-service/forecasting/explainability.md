# Lab 5: (Advanced Session) How to Preprocess Raw Data for Training and Detection

## Introduction

Forecast will also give explainability for each of the individual time series in the dataset. Explainability report includes both global and local level explanations. Explanations provides insights on the features that are influencing the forecast. Global explanation represents the general model behaviour - e.g., which features does the model consider important ? Local explanation tells the impact of each feature at a single time step level. Forecast provides local explanations for all the forecasts that it generates

In this session, we will discuss how to get global and local explanation for the best model chosen by forecast, inorder to understand the features that are influencing the forecast

Here is a case study on using the forecast api to get the global and local explanations

***Estimated Lab Time***: 15 minutes

### Objectives
In this lab, you will:
- learn how to generate global explanation
- learn how to generate local explanation for all the time steps in the forecast forizon

### Prerequisites
- Forecast ID ?

## Task 1: Get Global Explanation


***Note***: All the data files needed in this session can be downloaded here:
* [Example data](../files/example.csv) : an example data to show missing values, data status, distributions, monotonic attributes, etc.
* [Building temperature data](../files/building_temperature.csv): temperature data for 2 buildings for later combination
* [Building pressure data](../files/building_pressure.csv): pressure data for 2 buildings for later combination

### Loading single data source

**Example of Data loading**


#### Task B: Join two dataframes together


### Separate data for different models

##  **STEP 2:** Exploring Data

After the data being loaded, we now can start basic exploration to validate and identify potential issues of the data.

There are many ways of data exploration, and can be very dependent on particular business scenarios.

Here we only introduce some basic methods which are appropriate to time-series data.

**Check data types and missing values**
#### Monotonic Attributes

Based on the graph of time-series, one may identify monotonic features, which may not be useful for model training, and can be removed.
```Python
example_df[['timestamp', 'sensor8', 'sensor9']].plot(x='timestamp', figsize=(14,3)) # Plot individual column
```
![](../images/lab2-time-series-plot2-motonic-signals.png)

**Example**

## Task 3: Preprocessing Data

After having basic understanding on the data, we can start to preprocess and clean the data to fit for model training.

### Keep only the timestamp and valid numeric sensor/signal attributes

### Remove invalid observations

### Remove known outliers/anomalies from training set

#### How much data to remove/clean?

##  **STEP 4:** Final Splitting and Formatting

### Data Splitting


### Formatting

Currently, our anomaly detection service takes 2 types of data format, CSV format, or JSON format.

#### CSV Format
The CSV format is similar to the dataframe preprocessed by above steps. No extra steps is needed.
* The CSV file need to head the header row, with first column as `timestamp`
* Each row is one observation of all attributes at the particular timestamp.
* Missing value is allowed, simple ignore it

Example of csv file:
```CSV
timestamp,signal1,signal2,signal3,signal4,signal5,signal6,signal7,signal8,signal9,signal10
2020-01-01 13:00:01,1,1.1,2,2.2,3,3.3,4,4.4,5,5.5
2020-01-01 13:01:00,1,1.1,2,2.2,3,3.3,4,4.4,,
2020-01-01 13:02:02,,1.12,2,2.02,3.01,3.32,4,,5.01,5.54
...
```

#### JSON Format
The JSON format is also straight-forward, it contains a key `signalNames` listing all attribute names, and a key `data` to list all actual values along with timestamp.

```Json
{
    "requestType": "INLINE",
    "signalNames": [ "sensor1", "sensor2", "sensor3", "sensor4", "sensor5", "sensor6", "sensor7", "sensor8", "sensor9", "sensor10" ],
    "data": [
        {
            "timestamp": "2018-01-03T16:00:01",
            "values": [ 0.8885, 0.6459, -0.0016, -0.9061, 0.1349, -0.4967, 0.4335, 0.4813, -1.0798, 0.2734 ]
        },
        {
            "timestamp": "2018-01-03T16:00:02",
            "values": [ 0.8825, 0.66, -0.01, -0.9161, 0.1349, -0.47, 0.45, 0.4234, -1.1339, 0.3423 ]
        }
      ]
}
```

Here is a simple function to convert the dataframe into this JSON format.

```Python
def convert_df_to_json(df, outfile_name):
# NOTE: Assume the first column or the index in dataframe is the timestamp, will force to change it as timestamp in output
    out_json = {'requestType': 'INLINE', 'signalNames': [], 'data': []}
    column_0 = list(df.columns)[0]
    if df.index.name == None:
        df.index = df[column_0]
        df.drop([column_0], inplace=True, axis=1)
    out_json['signalNames'] = list(df.columns)
    if df.index.dtype == 'O': # If the new index is string object
        out_json['data'] = [{'timestamp': index, 'values': list(row.values)} for index, row in df.iterrows()]
    else:
        out_json['data'] = [{'timestamp': index.strftime('%Y-%m-%dT%H:%M:%SZ'), 'values': list(row.values)} for index, row in df.iterrows()]

    with open(outfile_name, 'w') as file:
        file.write(json.dumps(out_json, indent=2))
    print(f"JSON output file save to {outfile_name}")
    return out_json
```

#### Final Data Samples
After those above steps, you should now be able to transform the raw data provided earlier to be like the following:

* [processed training csv data](../files/demo-training-data.csv)
    - 10 signals with timestamp column, with 10,000 observations
* <a href="../files/demo-testing-data.json" target="_blank" download>processed testing json data</a>
    - same 10 signals with timestamp column, 100 observations

Congratulations on completing this lab! You now have finished all the sessions of this lab, please feel free to contact us if any additional questions.


## Acknowledgements
* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
* **Last Updated By/Date**
    * Jason Ding - Principal Data Scientist, July 2021
