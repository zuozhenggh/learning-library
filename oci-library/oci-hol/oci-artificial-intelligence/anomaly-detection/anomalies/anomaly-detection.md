# Anomaly Detection

## Introduction

Anomaly Detection is the identification of rare items, events, or observations in data that differ significantly from the expectation. This can be used for several scenarios like asset monitoring, maintenance and prognostic surveillance in industries such as utility, aviation and manufacturing.

The core of our Anomaly Detection service is built on the MSET algorithm, which is a multivariate anomaly detection algorithm originally developed by Oracle Labs and patented at Oracle and had been successfully used in several industries for prognosis analysis.

The Anomaly Detection Service will create customized Machine Learning models, by taking the data uploaded by users, using MSET to train the model, and deploying the model into the cloud environment to be ready for detection. Users can then send new data to the detection endpoints to get the detected anomaly results.

[Anomaly Detection Demonstration Video](youtube:aL_05XKProc)


The first version of *OCI Anomaly Detection Service* which is serverless, multi-tenant service, will cover multivariate *time series data, accessible over public REST APIs* by authenticated users via OCI CLI, SDK or Cloud Console.

*Estimated Lab Time*: 60 minutes

### Objectives:

* Understand a high level overview of the OCI Anomaly Detection Service
* Learn how to train the ML models for multivariate anomaly detection using our OCI ADS
* Learn how to do basic data transformation and processing to prepare raw data for model training with OCI ADS
* Learn how to explain the model training results and iteratively training new models
* Learn how to deploy the trained model into production for future anomaly detection
* Time series is a series of data points ordered by time.  Time series analysis and modeling have a wide range of industry applications from finance, retail to transportation.   In time series modeling, the goal is to create a model that describes the pattern of the data as it changes over time.  

### Prerequisites:
* An Oracle Free Tier, Always Free, or Paid Cloud Account
* Approved access to be whitelisted to use OCI ADS
* Additional prerequisites (cloud services) are mentioned per lab
* Comfortable with local PC-based file system for Windows or Mac
* Familiar with services on Oracle Cloud Infrastructure (OCI), such as Object Storage
* Familiar with machine learning, data processing, statistics is desirable, but not required
* Familiar with Python/Java programming is strongly recommended, but not required
* Familiar with local shell environments (cmd, bash, cshell, etc) (Optional for API integration)
* Familiar with local editing tools, vi and nano for (Optional for API integration)

### AD Service Concepts
* Project: Projects are collaborative workspaces for organizing data assets, models, deployments, and detection portals .
* Data Assets: An abstracted data format to contain meta information of the actual data source for model training; it supports multiple types of data sources (currently only Oracle Object Storage is supported, but other formats are on the way).
* Model: The ML model that trained by our Oracle patented algorithms that can detect anomalies in multivariate time-series data. A few parameters are exposed so user can choose to select, but also default values are suggested.
* Deployment: When model training are finished and users are satisfied with the training performance, they can deploy the selected model into a production model to be ready for new API calls for detection.
* Detection: When a model is deployed, user can use send new data to the API or upload to the cloud portal to get anomaly detection results.
