# Integrate OCM & APEX

## Introduction

By now you have both Oracle Content Management & Oracle APEX application running, in this lab you will change the configure to experience the integration between two system. There are two mode of integration explained,  one is using REST API and another is by embedding the OCM interface within APEX.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:
* Configure Web Credentials
* Change OCM Endpoint URL
* Run end-to-end demonstration

### Prerequisites 

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed



## Task 1: Configure OCM REST API web credentials

(optional) Step 1 opening paragraph.

1.	Login to APEX and click **App Builder** Icon. Click **Customer Tracker** from the list of application.

2.	Click **Shared Components** icon and then click **Rest Data Source**s under Data source section as shown below

    ![Datasource Menu](images/ds-menu.png)

3.	Click **ContractDS** REST data source

4.	Click Edit pencil icon as highlighted in below screen

    ![Datasource Details](images/datasource-details.png)

5.	Change value of **Endpoint URL** to your Oracle Content Management Instance URL. (Refer Lab 1 - Task 1.9 for OCM instance URL)

6.	Click **Apply Changes**

7.	Click **Authentication** tab
  
    ![Authentication](images/authentication.png)

8. Click “Edit” pencil icon for “Credentials”
  Change below attributes
    * OAuth Scop: https://\<your-OCM-instanceurl>.oraclecloud.com/urn:opc:cec:all
    * Client ID : Use the Client ID (Refer Lab 1 – Task 2.18)
    * Client Secret : Use the Client Secret (Refer Lab 1 – Task 2.18)
    * Valid for URLS: Add your OCM Instance URL (Refer Lab 1 - Task 1.9)

9. Click **Apply Changes**

10. Click **Edit** pencil icon for **Authentication Server**
Change below attributes
    * Endpoint URL : https://\<your-idcs-guid>.identity.oraclecloud.com
    * *HTTPS Host name : \<your-idcs-guid>.identity.oraclecloud.com (Please do not prefix with http or https)

11. Click **Apply Changes**

## Task 2: Change Embed content URL

1.	Login to APEX and click **App Builder** Icon. Click **Customer Tracker** from the list of application.

2.	Use search box and search for **50** as shown below
  
    ![Find Page](images/find-page.png)

3.	Click “50-Customer” , this will open the page.

4.	Search for “Resource” within page search box as shown below

5.	Click the search result **Region->Assets->Source->Text**

6.	Replace the above highlighted URL above under Source->Text with your Site URL created which was created in Lab 4- Task 3.7

7.	Click “Save” and then run the application.

## Task 3 : Allow Cross Origin Resource Sharing (CORS)

1. Login to IDCS and Navigate to **Settings** > **Session Settings**

  ![IDCS Settings](images/idcs-settings.png)
2. Enable **Allow Cross-Origin Resource Sharing (CORS)** 

3. Provide APEX instance domain name within **Allowed CORS Domain Names**. For example https://\<your-instance-specific>.**oraclecloudapps.com**

4. Click **Save**

## Task 4: Allow OCM embedding within APEX

1. Login to OCM & Navigate to **System > Security**

  ![Security Navigation](images/security-menu.png)

2. Select Radio option **Enabled**

  ![Security Settings](images/allow-domain.png)

3. Add domain name of APEX application under **Allowed Domains** .For example https://\<your-instance-specific>.**oraclecloudapps.com**


## Task 4: Run end-to-end demonstration.

1.	Login to Customer Tracker application

2.	Click   icon to navigate to dashboard page.

3.	Click the customer name “Café Supremo”

4.	Click “Contract” tab and it should show you available 
contract documents from OCM as shown below

5.	Click “Resources” tab and it will show you list of content from Site created in previous lab. 

## Learn More


* [OCM API Documentation](https://docs.oracle.com/en/cloud/paas/content-cloud/apisdk.html)
* [Embed User Interface](https://docs.oracle.com/en/cloud/paas/content-cloud/solutions/embed-web-user-interface-other-applications.html)

## Acknowledgements
* **Author** - Vinay Kumar, Director - Product Management, Oracle Content Management
* **Last Updated By/Date** - Vinay Kumar, Feb 2022
