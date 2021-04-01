# Provision and Register an OML Model into Oracle Analytics Cloud[Workshop Under Construction]

## Introduction

This lab walks you through the steps provision an Oracle Analytics Cloud(OAC) instance, establish connection between the provisioned ADW and OAC. Then register the OML model created, in OAC to run our model on entire data set to get more insights by visualizations.

Estimated Lab Time: n minutes

### Objectives

In this lab, you will:
* Provision an Oracle Analytics Cloud instance
* Establish connection between the Autonomous Data Warehouse and Oracle Analytics Cloud
* Register the OML model created in the OAC.

### Prerequisites

* Provisioned ADW
* Created the Oracle Machine Learning Model

## **STEP 1**: Provision an Oracle Analytics Cloud instance

1. In order to create an Oracle Analytics Cloud instance, you must login to the tenancy as a federated user. Log out of Oracle Cloud and login again using Single Sign-On (SSO).

    ![](./images/sso-login.png " ")

2. Enter your **Username** and **Password** and click **Sign In**.

    ![](./images/sso-login1.png " ")

3. In the upper left, click the **Hamburger Button** and scroll down to **Solutions and Platform** in the menu. Then expand **Analytics** select **Analytics Cloud**.

    ![](./images/analytics-cloud.png " ")

4. Under **Compartment**, make sure you select the same compartment you created the Good Wine Autonomous Database instance in. Then click **Create Instance**. 

    ![](./images/analytics-create-instance.png " ")

5. This bring up the **Create Analytics Instance** screen, specify the configuration of the instance:
    - **Compartment** - Select the compartment that houses the ADW Good Wine instance from Lab 1 in the drop-down list.
    - **Instance Name** - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) This lab uses **OACWINE** as the instance name.
    - **Description** - This is an optional field to add a description or note to remind yourself of what the instance is for. We added **Oracle Analytics Instance for Good Wine Workshop** for our own reference.

    ![](./images/sso-login1.png " ")

    ![](./images/sso-login1.png " ")

## **STEP 2**: Establish connection between the ADW and OAC

## **STEP 3**: Register the OML model created in the OAC

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Charlie Berger & Siddesh Prabhu, Data Mining and Advanced Analytics
* **Contributors** -  Anoosha Pilli & Didi Han, Database Product Management
* **Last Updated By/Date** - Didi Han, Database Product Management,  March 2021
* **Workshop Expiry Date** - March 2022