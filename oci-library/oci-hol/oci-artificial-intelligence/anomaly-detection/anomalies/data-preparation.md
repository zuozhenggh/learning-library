## Lab 2: Prepare Training Data and Detection Data

Due to the natural of time-series anomaly detection, the data required for training any ML models needs to be formatted properly. Similarly here, our core ML algorithm behind our service has some requirements on the data to train an effective model. In this section, we can discuss the requirements and share some examples to show the user how to prepare and process raw data for training the model.  

# Introduction
The core of our Anomaly Detection service is the MSET algorithm, and at a high level, the MSET algorithm has two major data quality requirements on the training data:

* The training data should be anomaly-free (without outliers), containing observations that have normal conditions ONLY.
* The training data should cover all the normal scenarios which contain the full value ranges on all attributes.
Additionally, the algorithm also have format, minimum signals/observations, and order requirements as follows:

* The data should have a 2-D matrix shape for CSV format:
columns containing timestamp, and other numeric attributes/signals/sensors
** each row representing one observation of those attributes/signals/sensors at a given timestamp.
** The data should be strictly ordered by timestamp, and no duplicated timestamps.
* The data should have at least 3 highly correlated attributes.
* At least one attribute does not have a missing value.
* The number of observations/timestamps in training data should be at least 8 * number of attributes or 40, whichever is greater.
* The later sections are basically follow those requirements to preprocess the data and provide some recommendations.

## Objectives

* After this session, you should be able to learn some basic technicals to transform/preprocess the raw data into proper format for using our service to build AD models.

## Raw Data
For the purpose of time-series anomaly detection, the collected data should mainly contain timestamp field, any measurements from signals, sensors, which have values that changes over time etc. Those signals or sensors should naturally come from a coherent and unified system/process that are representing the status of such unified complicated system/process.

Any other auxiliary fields such as categorical features (e.g., city names, zip codes, brands) or non-time-series numeric features (e.g, size of city, population count, or GPS locations) are not recommended; they can be together with sensor data to help understand the data or preprocess the data, but typically won't be used when building the MSET models.

The collected data typically is a like 2-D matrix, where the first column stands for timestamp, and other columns are signals/sensors, and any additional supporting stationary/non-stationary attributes (which later will be suggested to remove). Each row should represent one observation of the whole system for a given timestamp, which contains the values for different signals captured in that timestamp, along with the other supporting columns.

However, in reality, the data may come from different data sources, with different formats that not match with our requirements. We first suggest user to understand the meaning of datasets, attributes, observations, and data types. Based on the actual scenario, they use may need to take the following recommendations and check the examples.

## Different Scenarios

**Combine different data sources**

If the data are coming from different sources (such as different resources/databases/tables, or files, etc.), they should be properly concatenated together based on the timestamp.

Note that the different data sources are collected for a single system that are highly correlated, and therefore should be combined. In case the data are from different systems which doesn't have strong correlation, it is not suggested to combine.

**Commingle different attributes**

In some cases that different attributes are collected without differentiating each other, it might make sense to commingle them into a single attribute, ordered by the timestamp and their collection id. In some cases, it could also be that the underneath sensors/signals are mis-labelled over time and no way of retrieving their original label.

**Align the frequency of timestamps**

If the timestamp is not aligned (e.g., one source is collecting data at every second, while another one is collecting at every minute), one should either use upsampling (repeating lower-frequency data points), or downsampling (randomly choosing from high-frequency data points) to make them align well.

**Handle large dataset**

In case that the datasets are very large (e.g., dozen of GB or more), and it is not able to fit into memory to prepare/analyze, we do suggest to use basic sampling strategy to reduce the dataset and estimate the data characteristics.

## Preprocessing


## Formatting
## CSV Format

## JSON Format
