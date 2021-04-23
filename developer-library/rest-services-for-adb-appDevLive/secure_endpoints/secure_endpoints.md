# Modern App Dev with Oracle REST Data Services - Securing a REST Endpoint

## Introduction

In this lab you will Securing the REST Endpoint XXX

Estimated Lab Time: 10 minutes

### Objectives

- XXX
- XXX
- XXX

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- Completed the [User Setups Lab](../user-setups/user_setups.md)
- Completed the [Create and auto-REST enable a table lab](../create_table/create_table.md)
- Completed the [Loading Data and Creating Business Objects Lab](../load_data_and_biz_objs/load_data_and_biz_objs.md)
- Completed the [REST Enable Business Logic and Custom SQL Lab](../REST_enable_objects/REST_enable_objects.md)

## **STEP 1**: Securing the REST Endpoint

**If this is your first time accessing the REST Workshop, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

1. If not already there from the previous lab, we need to be on the **REST Database Actions** page. To do this, use the Database Actions menu in the upper left of the page and choose **REST** in the Development list.

    ![Database Actions Menu, Development then REST](./images/sec-1.png)

2. Next, we want to select the **Security Tab** on the top of the page and then select **Roles**.

    ![On the Top Menu Bar, click Security Tab then select Roles](./images/sec-2.png)


3. On the **Roles** page, start by left clicking the **+ Create Role** button in the upper right of the page.

    ![Click the Create Role button](./images/sec-3.png)

4. The **Role Definition** modal will pop up.

    ![Role Definition Modal](./images/sec-4.png)

5.  Use the **Role Name** field to name our role. Let's use **oracle.livelabs.role.gary**.

    ![Role Name Field](./images/sec-5.png)

6.  When your **Role Definition** modal looks like the below image, click the **Create** button.

    ![Click the Create button](./images/sec-6.png)

7. We now must assign **privileges** to this role. Again using the REST Tab Bar on the top of the page, left click **Security** and select **Privileges**

    ![On the Top Menu Bar, click Security Tab then select privileges](./images/sec-7.png)

8. On the **Privileges** page, start by left clicking the **+ Create Privilege** button in the upper right of the page.

    ![Click the Create Privilege button](./images/sec-8.png)

9. The **Create Privilege** slider appears from the right.

    ![Create Privilege slider](./images/sec-9.png)

10. In the **Label** field, we can name this privilege **Livelabs REST Privilege**.

     ````
    <copy>Livelabs REST Privilege</copy>
    ````

    ![Label Field](./images/sec-10.png)

11. For the **Name** field, we can enter this **oracle.livelabs.privilege.gary**.

     ````
    <copy>oracle.livelabs.privilege.gary</copy>
    ````

    ![Name Field](./images/sec-11.png)

12. Next, in the **Description** field, enter **Livelabs Privilege for Business Logic REST Services**.

     ````
    <copy>Livelabs Privilege for Business Logic REST Services</copy>
    ````

    ![Description Field](./images/sec-12.png)

13. When your **Create Privilege** slider looks like the following image

    ![completcompleted Create Privilege** slider](./images/sec-13.png)

    left click the **Roles** tab on the top of the slider.

    ![Roles tab on the top of the slider](./images/sec-14.png)

14. On the **Roles** tab, use the shuttle to move the role we created, **oracle.livelabs.role.gary**, to the right side. We can do this by double left clicking on it or by left clicking it and then clicking the single arrow pointing to the right. Ensure the shuttle looks like the below image where **oracle.livelabs.role.gary** is on the right side.

    ![Roles shuttle](./images/sec-15.png)

    You can see that when we auto-REST enabled our table, privileges and roles where automatically created for us (oracle.dbtools.role.autorest.GARY.CSV_DATA)

15. When the single role have been moved to the right of the shuttle, left click the **Protected Modules** tab on the top of the **Create Privilege** slider.

    ![Protected Modules tab](./images/sec-16.png)

16. We see on the **Protected Modules tab** the module name we created in the pervious lab; **com.oracle.livelab.api**. Just as we did in the previous shuttle, move **com.oracle.livelab.api** from the left side to the right side. 

    ![Protected Modules shuttle](./images/sec-17.png)

    When done, left click the **Create** button on the **Create Privilege** slider.

    ![click the Create button on the Create Privilege slider](./images/sec-18.png)

2. Next, we want to select the **Security Tab** on the top of the page and then select **OAuth Clients**.

    ![On the Top Menu Bar, click Security Tab then select OAuth Clients](./images/sec-19.png)

3. To create our OAuth client we will secure our REST endpoints with, click the **+ Create OAuth Client** button in the upper right of the page.

    ![Click the Create OAuth Client button](./images/sec-20.png)

4. The **Create OAuth Client** slider will come out on the right of the page. 

    ![Create OAuth Client slider](./images/sec-21.png)

    In this form we first need to name our OAuth Client. Enter **oauthclient** into the **Name** field. 
    
    ![Name Field](./images/sec-22.png)
    
    Next we can give it a description. Let use **Security on my REST Service** as a value in the **Description Field**.
    
    ````
    <copy>Security on my REST Service</copy>
    ````

    ![Description Field](./images/sec-23.png)

    The following field, **Support URI**, is where a client will be taken upon an authorization error or failure. For this lab, we will use "https://www.oracle.com/rest/"
    
     ````
    <copy>https://www.oracle.com/rest/</copy>
    ````
    
    ![Support URI Field](./images/sec-24.png)

    Finally, we need an **support email** for contacting someone. You can enter your email address or use gary@dinosaurfootball.com in the **Support Email** field of the form.
    
    ![Support Email Field](./images/sec-25.png)

    Once your form looks similar to the image below:

    ![Support Email Field](./images/sec-26.png)    
    
    left click the Roles Tab on the top of the Create OAuth Client slider.

    ![Roles Tab on the OAuth Client Slide Out Panel](./images/sec-27.png)

5. Click the Roles tab on the top of the Create OAuth Client slider

    ![Click the Roles tab on the top of the Create OAuth Client slider](./images/sdw-48.png)

6. Now, use the shuttle to move the Role **oracle.dbtools.role.autorest.GARY.MAY2018** over to the right side, then click the Create button on the lower right. Moving the Role says that we want all REST services with this role to be secure and by using the auto REST feature, the service has created a role for us and all the endpoints we have used in this lab.

    ![use the shuttle to move the Role over to the right side, then click the Create button](./images/sdw-49.png)

    We now have an OAuth Client we can secure our REST service with.

    ![Created OAuth Client Details Tile](./images/sdw-50.png)

7. Before we secure the REST endpoint, we need to get a token to pass to the secured REST service once its enabled. To get this token, we can click the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) on our OAuth tile and select **Get Bearer Token**.

    ![click the pop out menu icon on our OAuth tile and select Get Bearer Token](./images/sdw-51.png)

8. The OAuth Token modal will provide the token text in **Current Token** field. You can use the copy icon ![copy icon](./images/copy-copy.png) to copy this text. Save it because we will need it when calling the secured REST service. The modal also gives us a curl command to get a token if we need to include this in our applications.

    ![Click the copy icon to save the Token Text](./images/sdw-52.png)

9. Time to secure the REST service. Using the tab bar on the top of the page, select AutoREST.

    ![Use the tab bar on the top of the page, select AutoREST](./images/sdw-53.png)

10. Here we can see the table we autoREST enabled previously. Click the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) on the MAY2018 title and select Edit.

    ![Click the pop out menu icon on the MAY2018 title and select Edit](./images/sdw-54.png)

11. In the REST Enable Object slider, click the Require Authentication toggle button, then click Save in the lower right of the slider. That's it, the service it now secure.

    ![click the Require Authentication toggle button then click Save in the lower right of the slider](./images/sdw-55.png)

12. We can try out this security using curl and the OCI Cloud Shell. We can immediately see that we have a new green lock icon on out autoREST table tile. To see the new curl commands, use the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) and select Get Curl.

    ![Use the pop out menu icon and select Get Curl](./images/sdw-56.png)

13. We are going to use the GET Single curl command just as we did before. Start by clicking on Get Single, enter **hv70116556** in the ID field and click the Next button on the lower right of the slide out.

    ![clicking on Get Single, enter the above value in the ID field and click the Next button on the lower right of the slide out](./images/sdw-39.png)

14. On the following page of the slider, we can see the curl command now contains some header information:

    **--header 'Authorization: Bearer VALUE'**

    ![curl command now contains some header information](./images/sdw-57.png)

    and if we run the original curl command using the OCI Cloud Shell without this information, we get Unauthorized:

    ````
    > curl --location \
    'https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556'

    {
        "code": "Unauthorized",
        "message": "Unauthorized",
        "type": "tag:oracle.com,2020:error/Unauthorized",
        "instance": "tag:oracle.com,2020:ecid/c755a84b26f02aba9ce630f831ee721c"
    }
    ````

15. Take the token text we previously copied and replace <VALUE> in the curl command with that text. Then run the curl command using the OCI Cloud Shell:

    ````
    > curl --location '\
    https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556' \
    --header 'Authorization: Bearer yuNINeg1uqHIivqDDgJnfQ' 
    ````

16. We can see that we have been authenticated and are able to use the REST endpoint to retrieve the record.

    ````
    {"id":"hv70116556","time":"2018-05-04T22:32:54.650Z","latitude":19.3181667,"longitude":-154.9996667,"depth":5.81,
    "mag":6.9,"magtype":"mw","nst":"63","gap":"210","dmin":"0.11","rms":"0.11","net":"hv","updated":"2020-08-15T02:55:22.135Z",
    "place":"19km SSW of Leilani Estates, Hawaii","type":"earthquake","horizontalerror":"0.52","deptherror":"0.31",
    "magerror":null,"magnst":"10","status":"reviewed","locationsource":"hv","magsource":"hv","links":[{"rel":"self",
    "href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556"},{"rel":"edit",
    "href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556"},
    {"rel":"describedby","href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/metadata-catalog/may2018/item"},
    {"rel":"collection","href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/"}]}
    ````

## Conclusion

In this lab, you had an opportunity to get an introduction to REST services using an easy to follow User Interface. REST enable your tables and database objects in minutes with zero code.

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - February 2021
- **Workshop Expiry Date** - February 2022