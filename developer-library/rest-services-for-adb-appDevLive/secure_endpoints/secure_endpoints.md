# RESTful Services for your Autonomous Database

## Introduction

In this lab you will use the SQL Developer Web browser-based tool, connect to your Autonomous Database and REST enable tables and views and/or develop custom RESTful Services based on your SQL and PL/SQL code.

Estimated Lab Time: 30-45 minutes

### Objectives

- Enable a user for REST access
- Publish a RESTful service for a database table
- Secure the REST service

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.


## **STEP 4**: Securing the REST Endpoint

**If this is your first time accessing the REST Workshop, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

1. So, we have a REST enabled table ready to be used by our applications but we need to ensure not just anyone can use it; we need to secure access to the table. To do this, let's use the Database Actions menu in the upper left of the page and choose REST.

    ![Database Actions Menu, Development then REST](./images/sdw-44.png)

2. The REST pages let you create REST endpoints just as we did with the auto REST option. Here, we want to select the Security Tab on the top of the page and then select OAuth Clients.

    ![On the Top Menu Bar, click Security Tab then select OAuth Clients](./images/sdw-45.png)

3. To create our OAuth client, we will secure our REST endpoints with, click the Create OAuth Client button in the upper right of the page.

    ![Click the Create OAuth Client button](./images/sdw-46.png)

4. The Create OAuth Client slider will come out on the right of the page. In this form we first need to name our OAuth Client. We can name it **garysec**. Next we can give it a description; anything will do here. The follow field, support URI, is where a client will be taken upon an authorization error or failure. Finally, we need an support email for contacting someone. Once your form looks similar to the image below:

    ![The OAuth Client Slide Out Panel](./images/sdw-47.png)

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