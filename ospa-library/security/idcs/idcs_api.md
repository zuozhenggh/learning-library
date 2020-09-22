# Working with Oracle Identity Cloud Service APIs

The Oracle Identity Cloud Service REST APIs support SCIM 2.0 compliant endpoints with standard SCIM 2.0 core schemas and Oracle schema extensions to programmatically manage users, groups, applications, and identity functions, such as password management and administrative tasks. To make REST API calls to your Oracle Identity Cloud Service environment, you need an OAuth2 access token to use for authorization. The access token provides a session, that your client application can use to perform tasks in Oracle Identity Cloud Service.

As part of the following exercise you will use IDCS APIs to make queries to the back end and modify your Luna user id parameters. For the purposes of this lab we have already created a confidential application that you will interact with. You will find the information within the next steps.


## STEP 1: Downlow and Configure Postman

1. Open Firefox once your virtual desktop is fully loaded.

    ![](./images/luna_1.png)

2. We need first to download the API client. For the purpose of this lab we will use **Postman**. Copy the following URL and past it in Firefox. `https://www.postman.com/downloads/`. Click **Download** and select **Linux 64-bit**. 

    ![](./images/p_1.png)

3. Confirm the download by clicking **OK**.

    ![](./images/p_2.png)

4. Once downloaded, open a terminal window and execute the following commands from your home directory:

*Note: Your package version might vary, please verify the file name before continue.*

`cd Downloads`

`tar xvzf Postman-Linux-x64-7.29.1.tar.gz`


![](./images/p_3.png)

5. Now that the package has been extracted, you should be able to run the client. Go to the Postman directory using the following command `cd Postman` and run `./Postman`    

    ![](./images/p_4.png)

6. In the welcome screen click **Skip signing in and take me straight to the app** option located at the bottom of the window.

    ![](./images/p_5.png)

7. First we need to import IDCS Postman environment variables, global variables and IDCS API collection. Click the **Import** button on the left upper corner

    ![](./images/p_6.png)

8. Select **Import from Link** and provide the following URL to import the environment variables. Click **Continue** and click **Import**.

`https://github.com/oracle/idm-samples/raw/master/idcs-rest-clients/example_environment.json`


9. To import the Oracle Identity Cloud Service REST API Postman collection, on the Postman main page, click **Import**.

10. In the Import dialog box, select **Import From Link**, paste the following GitHub Postman collection URL into the box, click **Continue** and then click **Import**:

`https://github.com/oracle/idm-samples/raw/master/idcs-rest-clients/REST_API_for_Oracle_Identity_Cloud_Service.postman_collection.json`

11. You should see the Oracle Identitiy Cloud Service REST API collection listed in the **Collections** tab.
    ![](./images/p_7.png)


13. To import the global variables file, click **Import**.

14. In the Import dialog box, select **Import From Link**, paste the following GitHub Postman Globals URL into the box, click **Continue** and then click **Import**:

`https://github.com/oracle/idm-samples/raw/master/idcs-rest-clients/oracle_identity_cloud_service_postman_globals.json`

*NOTE: You might not receive a notification once the variables have been imported*

15. Click on the Settings button (cogwheel icon) to Manage Environments

    ![](./images/p_8.png)

16. Click on the newly created environment which will be like **Oracle Identity Cloud Service Example Environment with Variables** to set the environment variables.

    ![](./images/p_9.png)

17. Set the following parameters values in order to be able to obtain an IDCS access token and click **Update**:

*Note: You can obtain your Luna Lab username and Luna Lab password from the Luna-Lab.html file located in your luna desktop*

---

**OSPATRAINING1**

`HOST:https://idcs-8c7a0db6cebe440284c099d028407e26.identity.oraclecloud.com`

`CLIENT_ID: 09fb9a4be6b149d898fea4bc31e9e21d`

`CLIENT_SECRET: 050a2e31-064b-45e4-ade1-8a839ea47270`

`USER_LOGIN: Your Luna User id`

`USER_PW: Your Luna User password`


![](./images/p_10.png)

18.  Click the Environment drop-down list, and then select the updated environment from the list.

    ![](./images/p_11.png)

19.  On the Collections tab, expand **OAuth**, and then **Tokens**.

20.  Select **Obtain access_token (client credentials)**, and then click **Send**. The access token is returned in the response from Oracle Identity Cloud Service.

21.  Highlight the access token content between the quotation marks, and then **right-click**. In the shortcut menu, select Set: **Oracle Identity Cloud Service Example Environment with Variables**.

22.  In the secondary menu, select **access_token**. The highlighted content is assigned as the access token value as part of your local variables.

    ![](./images/p_12.png)


## STEP 2: Modifying users via Oracle Identity Cloud Service API

1. On the Collections tab, expand **Users**, and then **Search**.
2. Click on **Search all users (return specific attributes)**
3. Add the key `count` and the Value `1000`
4. Click on **Send**
5. On the result windown search your Luna user id and copy the **id** value without the quotes

    ![](./images/p_13.png)

6. On the user collection select **Modify, and Update user (replace single attribute)**
   
7. On the patch parameters replace **{{userID}}** with your **ID** string copied in the previous step.
   
8. Select the **Body** Tab and update the **Phone value number** as shown on the screen and click **Send**

    ![](./images/p_14.png)

9.  You will receive an email with the profile update confirmation.

    ![](./images/p_15.png)

---

***
**What You have done**

You have used with REST application programming interface (API) calls to Oracle Identity Cloud Service using Postman to create, delete and modify users. For further information about using IDCS REST interface with postman, please visit Using the [Oracle Identity Cloud Service REST APIs with Postman](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/idcs/idcs_rest_postman_obe/rest_postman.html)
***