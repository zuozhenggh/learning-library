# Building your app - Using the Create Application Wizard

## Introduction
In this lab, You will learn how to create the apex application and learn how to modernize the Customer Form.  The objective is to show you the options for these sample forms and then you can get an idea to modernize your own Forms Application.

Depending on your requirements you can take advantage of this modernization to update also the business rules, not just the screens. Because this is not a trivial process, so it's the right moment to review the business logic and check what you need to update or remove.

Having said that, let's focus on creating the APEX Application.

Estimated Time: 30 minutes


## Creating an App

1. In the App Builder menu, click **App Builder**.
2. Click **Create**.

    ![](images/go-create-app.png " ")

3. Click **New Application**.

    ![](images/new-app.png " ")

4. Enter the application name, select appearance (template needed for app.) and add pages needed for the application.
    ![](images/create-app.png " ")

## Modernizing Customer Form


We will be walking through series of steps on how to create Customer Summary Report in Interactive Report and Tree Report along with a modal form to create/update/delete customers. We will also be comparing with APEX migration project on how we can transform the Forms  Blocks/Triggers/LOV and Alerts into APEX.


1. From the Application Home Page, click **Create Page**.
    ![](images/create_page.png " ")

2. From the Create Page Screen, Click **Form** and proceed to Next step
    ![](images/create_form.png " ")

3. From the Create Page Screen, Click **Report with Form** and proceed to next step
    ![](images/report_with_form.png " ")

4. From  the Create Report with Form Screen , Enter **Form Page Name** and proceed to next step
    ![](images/interactive_report_create.png " ")

5. Create navigation menu entry and Enter the name for menu you would like to navigate and proceed to next step
    ![](images/new_form.png " ")

6. From the Data Source Screen, Table/View owner would be defaulted to **DEMO** schema and Select the table **S_CUSTOMER** from the list of tables , and choose all the items that you would like to be displayed in the Create/Update/Delete Form,  **S_CUSTOMER** is the same table that the customer form was also based on Form Builder, proceed to next step
    ![](images/items.png " ")

7. From the Create Form - Columns and Primary Key Screen, Choose the **Primary key Column** and proceed to next step
    ![](images/primary_key.png " ")

8. You will see the Page Created Successfully , you will see 2 pages created
    ![](images/success_form.png " ")

9. When you run the Page, you will be able to see Report with all the customers listed and you can edit or create new customer from the Report page
    ![](images/interactive_report.png " ")

10. **Customer Form** works in the similar way as **Forms Data Block**.
    If you want to manage the create/update operation from the **Interactive Reports** Page you can make the **Customer Form** to be a modal page.
    To make the **Customer Form** to be a modal page , you will have to make few changes to Page setting
    From the Application Home Page, Click on Customer Form Page
    ![](images/customer_form.png " ")
    Change the **Page Mode** to **Modal Dialog** and click save
    ![](images/modal-form.png " ")
    From the Application Builder, Go to **Customer-Interactive Report** and run the page and click on **Create Button** or **Pencil Icon** , the customer modal window opens , you will be able to make changes or create new customer from the form.
    ![](images/creat-edit-customer-form.png " ")

    ![](images/customer-modal-form.png " ")

    Creating Customer Modal Form takes care of **Data Block** conversion and **Items** from Forms to APEX


11. Next step is to Create **List of Values** in APEX page

    From the App Builder Home Page, Click on **Migrations**
    ![](images/migration.png " ")

    Click on **Forms Migration** Project you have created

    ![](images/migration-project.png " ")

    Click on **List of Values** on the **customers_fmb.xml** file name row
    ![](images/LOV.png " ")

    There is only one LOV for **Sales Rep LOV** , Click on the pencil icon , Copy the **Record Group Query**
    ![](images/record-group-details.png " ")

    ````
    <copy>
    select id, first_name||' '||last_name Name from s_emp where title='Sales Representative' order by last_name
    </copy>
    ````
    Go to your Application Home Page, Click on Customer Form page
    ![](images/customer_form.png " ")

    Identify the **Customers** Region and Click on **P3_SALES_REP_ID** Item,Under the Page item Section , Change the **Type** to **Select List** and Scroll down to **List of Values** Section, Change the type to **Shared Component** and for **List of Values** select S_EMP.LAST_NAME , this **List of Values** has been automatically created by APEX
    ![](images/sales-rep-lov.png " ")
    ![](images/list-of-values.png " ")

    Change the **List of Values** to add where clause to limit by **Sales Rep**, Click on the **Shared Component** Icon
    ![](images/shared-component.png " ")

    Click on **List of Values**
    ![](images/sc-lov.png " ")

    Click on **S_EMP.LAST_NAME** and Review the Query , if you would like to change the name or add where clause you can do it here.
    ![](images/lov-summary.png " ")

    To limit only to Sales Rep , add the following condition in the where clause section
    ````
    <copy>
    title='Sales Representative'
    </copy>
    ````
    ![](images/edit-salesrep-lov.png " ")

    That completes the List of Values section of the Migration.


  12. Next step is to Migrate **Alerts** from Forms to APEX  
      From the App Builder Home Page, Click on **Migrations**
      ![](images/migration.png " ")

      Click on **Forms Migration** Project you have created
      ![](images/migration-project.png " ")

      Click on **Alerts** on the **customers_fmb.xml** file name row
      ![](images/alerts.png " ")

      You will see two Alerts **DELETE_ALERT** and **CONFIRM_REVERT**
      ![](images/alert-summary.png " ")

      To See how we can migrate to APEX,
      Go to your Application Home Page, Click on Customer Form page
      ![](images/customer_form.png " ")

      Navigate to **DELETE** button Page item Property, you will see **DELETE_ALERT** is automatically handled by APEX
      ![](images/delete-alert.png " ")

      **CONFIRM_ALERT** is handled by Page setting , Change the **Warn on unsaved changes** to **Page Default**
      ![](images/confirm-revert-alert.png " ")


  12. **Program Units** and **Triggers** logic of customer form does not apply to APEX as it is handled by default processing of APEX.

  13. **Customer Form** in the Oracle Forms Service was represented in a **Tree** Structure , You can easily recreate the tree structure in APEX.

      From the Application Home Page, click **Create Page** and Click **Next**
      ![](images/create_page.png " ")

      From the Create Page, click **Blank Page** and Click **Next**
      ![](images/create_tree_blank_page.png " ")

      From the Create Blank Page, Enter the page **Name** and Click **Next**
      ![](images/create_blank_page.png " ")

      Enter the name for the menu entry and Click **Next**
      ![](images/blank_page_menu.png " ")     

      Finish the page
      ![](images/blank_page_success.png " ")   

      From the Blank Page, Click on **Create Region**
      ![](images/create-region.png " ")   

      Choose the **Tree** type under the **Identification** section of the region settings and **Source** as **SQL Query**
      ![](images/customer_tree.png " ")  

      Enter the below SQL
      ````
      <copy>
      SELECT CASE
         WHEN connect_by_isleaf = 1 THEN 0
         WHEN LEVEL = 1 THEN 1
         ELSE -1
       END  AS status,
       LEVEL,
       name AS title,
       icon,
       id   AS value,
       NULL AS tooltip,
       NULL AS LINK,
       parent_id,
       name,
       id_c
        FROM   (SELECT DISTINCT To_char (d.country) id,
                                To_char (NULL)      parent_id,
                                d.country           name,
                                'fa fa-globe'       icon,
                                NULL                id_c
                FROM   s_customer d
                UNION
                SELECT e.id
                       ||'_'
                       ||e.name,
                       e.country,
                       e.name
                       ||' - '
                       || e.address AS name,
                       'fa fa-user' icon,
                       id           id_c
                FROM   s_customer e)
        START WITH parent_id IS NULL
        CONNECT BY parent_id = PRIOR id
      </copy>
      ````
      In order for the Tree to show up , make the changes as shown below to **Settings** under **Attributes** Section
      ![](images/change_tree_attribute.png " ")   and save the form.

      Link the tree node to **Customer Modal Form**
      ![](images/link_to_customer_form.png " ")

      Save and Run the Page
      ![](images/customer_tree_runtime.png " ")

      Click on the tree node will open the **Customer Modal Form**
      ![](images/customer-modal-form.png " ")

  Great Job !! You have successfully completed transforming the **Customer** Form to **Interactive Report and Form** in APEX and also recreated the **Tree** Structure similar to **Oracle Forms Structure**.



## **Acknowledgements**

 - **Author** -  Vanitha Subramanyam, Senior Solution Architect
 - **Contributors** -
 - **Last Updated By/Date** - Vanitha Subramanyam, Senior Solution Architect, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/forms-to-apex-migration-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
