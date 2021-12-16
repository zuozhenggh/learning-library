# Lab 1: Data Science Notebook Set up

## Introduction

 In this lab, we will learn how to set up a Data Science notebook session to start using the Forecasting service APIs. Also, we will learn about API key generation which are needed for authentication purpose.

*Estimated Lab Time*: 30 minutes

### Objectives:

In this lab, you will:
*	Learn how to generate API key 
*	Learn how to create a project in Data Science service 
*	Learn how to set up a notebook session inside a data science project 

### Prerequisites:
*	A free tier or paid tenancy account in OCI
*   You have completed tasks in "Getting Started" 

## Task 1: API key generation  

### Step 1:

Log in to your oracle cloud account, expand the Profile menu and click on User Settings:
![](../images/Lab1_task1_step1_login.png " ")

### Step 2: 
Under User Settings click on the API Keys under Resources on the left :
![](../images/Lab1_task1_step2_apikey.png " ")

### Step 3: 

Click on the Add API Key

![](../images/lab1_task1_step3_addkey.png " ")

### Step 4: 

Download the private key on your system. We will use this later for authorization when using the forecasting APIs. After downloading, click on Add button. By clikcing on Add, this key would get listed under API Keys and become active.  

![](../images/lab1_task1_step4_savekey.png " ")

### Step 5:
Save the contents of the configuration file preview in a text file on your system. Details such as user, fingerprint, tenancy, region etc. will be needed when setting up authorization for using the forecasting APIs.

![](../images/lab1_task1_step5_configurationfile.png " ")

## Task 2: Create a Data Science project

### Step 1:
Log in to your OCI account and search for data science in the top search bar. Click on the Data Science under Services:

![](../images/lab1_task2_step1_login.png " ")

### Step 2:
Select the root compartment and press the create project button. 
![](../images/lab1_task2_step2_createproject.png " ")

### Step 3:
Fill the name and description field and press the create button: 

![](../images/lab1_task2_step3_project_details.png " ")

## Task 3: Create a notebook session
### Step 1:
Log in to your OCI account and search for data science in the top search bar. Click on the Data Science under Services:

![](../images/lab1_task3_step1_search.png " ")

### Step 2:
Select the root compartment and open the project where you want to create a notebook session. 
![](../images/lab1_task3_step2_access.png " ")

### Step 3:
On opening a project, you will see the button to create a notebook session. Click the create notebook session: 
![](../images/lab1_task3_step3_notebooksession.png " ")

### Step 4:
Give a name to the notebook session. Select appropriate compute, storage, VCN and subnet. Press the create button
![](../images/lab1_task3_step4_sessiondetails.png " ")

### Step 5:
It takes a few minutes (5-10 minutes) for the newly created notebook session to become active. It can be seen under the project. Once it has become active, open it.

![](../images/lab1_task3_step5_wait.png " ")

### Step 6:
Click on the open button:
![](../images/lab1_task3_step6_open.png " ")

### Step 7:
A New Notebook can be created by using Python 3 kernel. Also a new folder can be created and given a custom name by using the + button:
![](../images/lab1_task3_step7_python3.png " ")

### Step 8: Setting Up Authorization for to use forecasting APIs
Use the tenancy, user and fingerprint from the configuration file as shown in API key generation step. Also upload the private API key that you downloaded in the API key generation step and give its path to private_key_file. Don’t change the pass_phrase. 

![](../images/lab1_task3_step9_authorization.png " ")


[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Ravijeet Kumar - Senior Data Scientist - Oracle AI Services
    * Anku Pandey - Data Scientist - Oracle AI Services
    * Sirisha Chodisetty - Senior Data Scientist - Oracle AI Services
    * Sharmily Sidhartha - Principal Technical Program Manager - Oracle AI Services


