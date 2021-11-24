# Lab 1: Understand Data And Download Samples

## Introduction

Due to the nature of time-series forecast, the data required for training any ML models needs to be formatted properly. Similarly here, our core ML algorithm behind our service has few basic requirements on the data to train an effective model.

In this session, we will discuss the data requirements and formats, and provide sample dataset as examples. 


***Estimated Lab Time***: 20 minutes

### Objectives

In this lab, you will:
- Understand the data requirements and data formats for training and detecting with the model
- Be able to download prepared sample datasets
- Upload the downloaded dataset into OCI (Oracle Cloud Infrastructure)

### Prerequisites
- A Free tier or paid tenancy account in OCI

## Task 1: Understand Data Requirements

The core of forecasting is an auto ML solution with multiple univariate/ multivariate algorithms that can run on single series or multiple series at once. 

* The training data should have a target series with date and target values defined.
* The training data can have an additional covariates that can help, to forecast target series.

Additionally, the algorithm also has some requirements on data type, minimum number of  attributes and observations on the training data as follows:

* Number of rows >= 10 and <= 5000
* Series length >= 3 X Forecast Horizon
* Series length >= 2 X Major Seasonality
* If the series is non-seasonal, at least one non-seasonal method needs to be available for running
* If ensemble method is selected, at least 2 other methods need to be selected as well
* Number of missing values <= 10% of series length
* If there are missing values for 5 consecutive time steps, throw an error
* All the timestamps in the primary data source should exist in the secondary data source also the number of rows in the additional data source should be equal to the number of rows in the primary data source + forecast horizon size (adjusted by input and output frequency).
* Check is there any duplicate date exists in Timeseries after grouping also(Check for both additional and primary data)
* All values have to be >= 0

### Data format requirement

The service currently accepts *Inline Data* that can be generated from csv files.Detailed document on how to use  generate inline data from csv file and how to upload csv files in Data Science notebook can be referred in Task 3 below 

Here we will use csv file as example to explain the requirement, since the main content are similar across different types of data source.

The data should only contain one timestamp and other numeric attributes, and timestamp has to be the first column, which satisfy the [ISO 8601 format](https://en.wikipedia.org/wiki/ISO_8601).

#### CSV format
CSV-formatted data should have comma-separated lines, with first line as the header, and other lines as data. Note the first column is the timestamp column.

**Note:**
* Missing value is permitted(with empty), data is sorted by timestamp, and boolean flag values should be converted to numeric (0/1).
* Do not have a new line as the last line. The last line should still be an observation with other attributes/signals.

Here is an example of CSV-formatted data:
```csv
timestamp,sensor1,sensor2,sensor3,sensor4,sensor5
2020-07-13T14:03:46Z,,0.6459,-0.0016,-0.6792,0
2020-07-13T14:04:46Z,0.1756,-0.5364,-0.1524,-0.6792,1
2020-07-13T14:05:46Z,0.4132,-0.029,,0.679,0
```

#### JSON format
Similarly, JSON-formatted data should also contain timestamps and numeric attributes only, with the following keys:

**Note:**
* Missing value is coded as null without quote.

```json
{ "requestType": "INLINE",
  "signalNames": ["sensor1", "sensor2", "sensor3", "sensor4", "sensor5", "sensor6", "sensor7", "sensor8", "sensor9", "sensor10"],
  "data": [
      { "timestamp" : "2012-01-01T08:01:01.000Z", "values" : [1, 2.2, 3, 1, 2.2, 3, 1, 2.2, null, 4] },
      { "timestamp" : "2012-01-02T08:01:02.000Z", "values" : [1, 2.2, 3, 1, 2.2, 3, 1, 2.2, 3, null] }
  ]
}
```

**Prerequisites**
* The training data should cover all the normal system conditions with the full value ranges for all attributes/signals.
* The training data should not have abnormal conditions, which may contains anomalies.
* The attributes in the data should be correlated well or belong to the same system or asset. Attributes from different systems are suggested to train separate models.

## Task 2: Download Sample Data

Here are two prepared sample datasets to help you to easily understand how the training and testing data looks like, Download the two files to your local machine.

* [training csv data](../files/demo-training-data.csv)
    - 10 signals with timestamp column, with 10,000 observations
* <a href="../files/demo-testing-data.json" target="_blank" download>testing json data for detection</a>
    - same 10 signals with timestamp column, 100 observations


## Task 3: Upload Data to Data Science Notebook

You need to upload the sample training data into data science note book, to be prepared for model training in next steps.








Click on Upload and then browse to file which you desire to upload.
![](../images/upload-sample-file.png " ")


## Task 4: Inline Data preparation

You need to load the data. Specify the correct path for the csv file that has the time series data.

// upload image named "Loading_csvdata.png" //


convert the date field to "yyyy-mm-dd hh:mm:ss" format
Use this link https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior for other date time formats

// upload image named "Loading_csvdata1.png"//

### Setting variables for create forecast
Specify the column having dates in date_col
Specify the time-series of interest in target_col
Specify the forecast horizon in terms of number of timesteps for which forecast to be made

// upload image named "setting_variable.png"
// upload image named "setting_variable1.png"

## Task 5 : Create Project ID forecast
Follow the below steps to create project
Create new compartment - Give same compartment 
Create new project
Change displayName to - Give a custom name
Note : It is not needed to create new projects everytime we run this notebook. A project id once created can be used again and again.

// upload the image named " Create_Project_Response.png"
// upload the image named "Create_Project_Response1.png"







Congratulations on completing this lab!

[Proceed to the next section](#next).







## Acknowledgements
* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
* **Last Updated By/Date**
    * Jason Ding - Principal Data Scientist, July 2021

