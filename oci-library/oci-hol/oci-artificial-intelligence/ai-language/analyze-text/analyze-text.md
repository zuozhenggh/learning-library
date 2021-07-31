# Lab 1: Analyzing Text with the Console

## Introduction

In this session, we will help users to get familiar to our OCI Language service and teach them to use our services via the cloud console.
You can use one or more of these text analysis tools to analyze your text with the Language service:
- Aspect-Based Sentiment Analysis
- Named Entity Recognition
- Key Phrase Extraction
- Language Detection
- Text Classification

***Estimated Lab Time***: 20 minutes

### Objectives

In this lab, you will:
- Understand a high level overview of the OCI Language Service
- Understand all the services to analyze the text.
- Understand how to analyze text using OCI Language service via cloud console.
### Prerequisites
- A Free tier or paid tenancy account in OCI (Oracle Cloud Infrastructure)
- Familiar with OCI object storage to upload data
- Tenancy is whitelisted to be able to use AI Language service


## **TASK 1:** Use the Console to analyze text

### 1: Navigate to OCI Language Service

Log into OCI Cloud Console. Using the Burger Menu on the top left corner, navigate to Analytics and AI menu and click it, and then select Language item under AI services.

![](./images/navigate-to-ai-langauge-menu.png " ")

### 2: Enter Text

Paste, or enter your text into the dialog box to analyze.
![](./images/text-box.png " ")


### 3: Select the text analysis tools

Select one or more of the text analysis tools to analyze your text with the Language service:
![](./images/lang-services.png " ")

### 4: Click Analyze

You can analyze text by clicking Analyze button.
![](./images/analyze-button.png " ")

### 5: Click Reset

You can reset the page by clicking Reset button.
![](./images/reset-button.png " ")

## **TASK 2:** Viewing the Results

After you analyze your text, the Language service displays the results by category for the selected tools as follows:

### 1: Sentiment Analysis

Renders the results in horizontal bar graphs as a percentage.
![](./images/sentiment-result.png " ")

### 2: Named Entity Recognition

Identifies the named entities that were found and their categories are indicated in square brackets.
![](./images/ner-result.png " ")

### 3: Key Phrase Extraction

Lists the key phrases in a double-quotes delimited list.
![](./images/kpe-result.png " ")

### 4: Language Detection

Lists, by confidence percentage, the languages detected.
![](./images/lang-result.png " ")

### 5: Text Classification

Lists the word, identified document category, and the confidence score.
![](./images/text-result.png " ")

## **TASK 3:** Viewing the Results in JSON

You can click Show JSON to view these results in JSON format. 
![](./images/show-json-button.png " ")

You can copy the JSON text or download it. Click Return to Standard Results to leave the JSON view. 
![](./images/copy-download-button.png " ")



Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Rajat Chawla  - Oracle AI Services
    * Ankit Tyagi -  Oracle AI Services
* **Last Updated By/Date**
    * Rajat Chawla  - Oracle AI Services, July 2021