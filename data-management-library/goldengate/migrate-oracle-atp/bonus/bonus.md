# Migrate HR Application

## Introduction

Oracle Application Express (APEX) is a feature of Oracle Database, including the Autonomous Data Warehouse (ADW) and Autonomous Transaction Processing (ATP) services. We successfully have migrated our on-premise database to ATP, and now we will need to migrate the APEX Application in that database.

*Estimated lab time*: 25 minutes

### Objectives

* Setup Oracle APEX Workspace with wizard
* Import HR application
* Explore APEX pages and components

### What is an APEX Workspace?
An APEX Workspace is a logical domain where you define APEX applications. Each workspace is associated with one or more database schemas (database users) which are used to store the database objects, such as tables, views, packages, and more. APEX applications are built on top of these database objects.

## **Step 1**: Create an APEX workspace
In this part, you will create an APEX workspace in the target *Autonomous Transaction Processing* database. 

1. You already have a pre-created APEX environment in Oracle Autonomous database but not configured. Open your Target ATP in web browser Click on **Tools** tab, in which you will see **Oracle Application Express** link. Click on **Open APEX** button.

    ![](images/1.apex_0.PNG)
    
2. Enter the ADMIN user password and click **Sign In to Administration**.

    ![](images/1.apex_1.PNG)

3. When you sign-in first time, it will ask you to create a workspace, click **Create Workspace**.

    ![](images/1.apex_2.PNG)

4. In the Create Workspace dialog, enter the following information:

    | Property | Value |
    | --- | --- |
    | Database User | HR |
    | Password | **`GG##lab12345`** |
    | Workspace Name | HR_APP |

    _**NOTE:** Workspace ID will be automatically generated for you, ignore and click **Create Workspace**.

    ![](images/1.workspace_0.PNG)

5. In the APEX Instance Administration page, click the **HR_APP** link in the success message. This will redirect you to the APEX sign-in page.

    ![](images/1.workspace_1.PNG)

6. On the APEX Workspace log in page, your username and workspace name is same. Enter **`GG##lab12345`** for the password and then click **Sign In**.

    ![](images/1.workspace_2.PNG)

7. You need to configure APEX user password for application authorization. Click on **Set APEX account password**.

    ![](images/1.workspace_3.PNG)

8. Set an email address as **hr@myhr.com**, enter **`GG##lab12345`** in password fields. Click on **Apply Changes** to save.

    ![](images/1.workspace_4.PNG) 


## **Step 2**: Import HR app in APEX workspace

1. After you successfully logged in the newly created APEX workspace and updated APEX password, you may explore that there are many components and tools included in APEX workspace. Now let's import our HR application. Click on **App Builder** in APEX workspace homepage.

    ![](images/2.apex_8.PNG)

2. Click **Import** to start the wizard.

    ![](images/2.apex_9.PNG)

3. Download our sample HR application **[from here](./files/f103.sql)**. Make sure to save this file with the correct extension **.sql** not txt! 

4. Now click on **Drag and Drop** area, then choose the downloaded file. Make sure File type is Database Application and click **Next** button.

    ![](images/2.apex_10.PNG)

5. Click **Next** button.

    ![](images/2.apex_11.PNG)

6. Check **Parsing Schema** and **Build Status** selections are same as the below, then **Next** button.

    ![](images/2.apex_12.PNG)

7. Installation of the application will take few seconds.

    ![](images/2.apex_13.PNG)

8. Once it is ready and, you will see **Run Application** option. Click to run, it will open in a new tab.

    ![](images/2.apex_14.PNG)

9. Provide **HR** user and password to login to the application.

    ![](images/2.apex_15.PNG)

## **Step 3**: Add work anniversaries in dashboard page

1. This is the HR sample application we created for you. We want you to click on **Dashboard** page where you will see 3 charts in there. 

    ![](images/3.cards_main.png)

    Oracle APEX has integrated charting based on Oracle JavaScript Extension Toolkit (JET) Data Visualizations. For more information on Oracle JET and the Data Visualizations components, please refer to the Oracle JET Get Started documentation and ojChart API guide.

2. Now there are 3 charts and let's add one more chart which shows work anniversary. Go to previous APEX application installation page (tab) and click **Edit Application** button. 

    ![](images/3.cards.png)

3. Take a moment to look at what options and pages available in the application home page. This is basically main container, collection of pages, menus, tabs, buttons etc,  building block of our database application. **2 - Dashboard** is the page which contains our charts. Click on it.

    ![](images/3.cards_0.png)

3. Dashboard page will be opened in page designer. This is a full featured Integrated Development Environment (IDE) that includes a toolbar and multiple panes. There are multiple tabs in the left pane. Select the rendering tab and find Content Body area. This is the area which contains our 3 charts. 

    ![](images/3.cards_1.png)

4. Under the central pane, there are APEX components. Click on **Cards** component and drag to the empty area next to **Employees by City**. More precisely in darker orange area as shown in the below image. 

    ![](images/3.cards_2.png)

5. This will bring a new empty cards component in the dashboard page. We need to configure it to our needs. Click on this new **Cards** componenent. 

    ![](images/3.cards_3.PNG)

6. After you selected the cards, in the right pane, you will see the Property Editor. The **Region** tab displays the attributes and attributes are organized in groups. Let's change title to **Anniversaries** in Identification, then change type to **SQL Query** in Source. Paste the below code in the **SQL Query** field:

     ```
    <copy>
    SELECT first_name, last_name, job_id, employee_id, ceil(months_between(sysdate, hire_date) /12) as anniversary, hire_date, extract(day from hire_date)
    FROM hr.employees
    WHERE EXTRACT(month FROM (hire_date)) = extract(month from (sysdate)) and EXTRACT(year FROM (hire_date)) != extract(year from (sysdate))
    ORDER BY 7;
    </copy>
    ```

    ![](images/3.cards_4.PNG)

7. Then now, click on the **Atributes** tab, to modify how the cards would look in the Dashboard page. Find the appropriate attributes and change them as the below image:

    ![](images/3.cards_5.PNG)

8. Attributes tab has many properties, scroll down and change more fields as the below image:

    ![](images/3.cards_6.PNG)

9. After you finish editing, click **Save** and hit the green **play** button.

    ![](images/3.cards_8.PNG)

10. My HR application will reload the changes we've made. 

    ![](images/3.cards_7.PNG)

## **Step 4**: Create an employee maintenance page 

1. As you probably have noticed that there is no page to edit employee details or add new employee in our application. So let's create a page. Go to your APEX application home page. Find **Create Page** button

    ![](images/4.create_0.PNG)

2. The Create Page Wizard includes two types of pages components and feature. We will choose **Report** component and click next button.

    ![](images/4.create_1.PNG)

3. Then choose **Report and Form on Table** 
    
    ![](images/4.create_2.PNG)

4. We will choose **Interactive Report**, then name the main report list as **Employee list**, and form page name as **Employee Maintenance**. Set the form page mode as **Modal Dialog**, this option is nice pop-up type page when you select a record to edit.

    ![](images/4.create_3.PNG)

5. Let's add this page to the navigation menu of our application. Choose **Create a new navigation menu entry** option.

    ![](images/4.create_4.PNG)

6. This interactive report is a formatted result of a SQL query and you need to choose a table from database on which to build a report, or provide a custom SQL SELECT statement. Choose **Table** as source type and choose table name **Employees**.  End users can customize the both report layout and control how the data that displays. All columns automatically added to be shown in report. Click **Next** button.

    ![](images/4.create_5.PNG)

7. Now let's check how form page, in our case **Employees Maintenance** page, will find the record. Choose **Select Primary Key Column(s)** option and select **EMPLOYEE_ID** as the primary key column. Then click **Create** button.

    ![](images/4.create_6.PNG)

8. Page Designer page will open newly created report, let's see how it looks like, click green **play** button on right top of property editor.

    ![](images/4.create_7.PNG)

9. You can now edit a record by clicking on blue icons in front of the rows.

    ![](images/4.update_row_1.PNG)

10. Let's update Steven King's salary to 25000 and click **Apply Changes**
    
    ![](images/4.update_row_2.PNG)

11. You will see small notification appear on the top-right corner. 

    ![](images/4.update_row_3.PNG)

## **Step 5**: Modify employee id

1. Our Employees table doesn't have automatic identity column to maintain *`employee_id`*. If you create an employee in APEX, it will insert a record without *`employee_id`*. Let's fix this. Go to application home page and click on **6 - Employee Maintenance** 

    ![](images/5.maintenance_0.PNG)

2. Let's re-arrange items first, this will make the page look better. Click on each items and move them as shown in the below image.

    ![](images/5.maintenance_1.gif)

3. Now select **`P6_EMPLOYEE_ID`** column from the left pane, then edit its attribute type from Hidden to **Select List**.

    ![](images/5.maintenance_1.png)

4. Then scroll down to find **List of values**, choose type **Shared Component** and List of Values **`EMP_ID`**. Unset **Display Extra Values** and **Display Null Value**, then save the page.

    ![](images/5.maintenance_2.PNG)

## **Step 6**: Duplicate the employee maintenance page

1. The **Employee Maintenance** page is currently serving for two purposes, _edit_ a record and _create_ a new record. Let's create a new page where we can add new employees only. Idea to have another page is to delegate the tasks separately. Click on **+** button and **Page as Copy** as shown in the below image.

    ![](images/5.maintenance_3.png)

2. Select **Page in this application** option and click next.

    ![](images/5.maintenance_4.PNG)

3. New page number should be **7** but it can be different in your case, and name this page **Create new employee**.

    ![](images/5.maintenance_6.PNG)

4. We really don't want this page to be seen in the navigation menu, choose **Do not associate** option.

    ![](images/5.maintenance_7.PNG)

5. APEX will ask you what items do you need to inherit from parent page. Let's scroll down and give a new name **Create new employee** and click **Copy** button.

    ![](images/5.maintenance_8.PNG)

6. The newly created page will be opened in page editor. It is done, however I'd like to remind you of that this new page has not been yet associated to **Create** button in your report. It means when you click on **Create** button, this will open **Employee Maintenance** page, not **Create new employee**. Let's fix this before you run the application. Click at page finder, and choose **5 Employee List** page. 

    ![](images/5.maintenance_9.PNG)

7. Click on the region button **CREATE** in the left pane and find **Behaviour** in property editor located at the right pane.

    ![](images/5.maintenance_11.PNG)

8. You can see that target link of this button is currently **6** and we want you to change this to **7** (Create new employee page). Don't forget to save the page!

    ![](images/5.maintenance_12.PNG)

9. Let's go back to **Employee Maintenance** page once again. Click at page finder, and choose **6 Employee Maintenance** page. I want you to change **`P6_EMPLOYEE_ID`** type back to **HIDDEN**. Because it is not practical to edit ID field everytime you make some update.

    ![](images/5.maintenance_13.PNG)

10. Now run your application and test out the changes you've made. If you click on **Create** button, **Create new employee** page will pop up open.

    ![](images/5.maintenance_14.PNG)

    Also if you'd click on edit button in front of a record, **Employee Maintenance** page will pop up.

    ![](images/5.maintenance_15.PNG)

    Did you notice that there are some fields, precisely **Job id**, **Manager id**, and **Department id** doesn't look meaningful? Let's change this in the next Step.

## **Step 7**: List of Values

1. Go back to APEX editor and let's edit **7 - Create new employee** page.

    ![](images/6.popup_1.PNG)

2. In the page editor, select **`P7_DEPARTMENT_ID`** and edit properties. Choose **Popup LOV** type, change label to **Department Name**. Then scroll down to **List of Values**, choose **Shared Component** type and **DEPT_LIST** as LOV.

    ![](images/6.popup_dept.PNG)

3. Next, select **`P7_MANAGER_ID`** and edit properties. Choose **Popup LOV** type, change label to **Manager Name**. Then scroll down to **List of Values**, choose **Shared Component** type and **MGR_NAME** as LOV.

    ![](images/6.popup_mr.PNG)

4. As you noticed, you selected our pre-created list of values. However, it can be custom query too. Select **`P7_JOB_ID`** and edit properties. Choose **Popup LOV** type, change label to **Job Title**. Then scroll down to **List of Values**, choose **SQL Query** as type and insert the below query:

	```
	<copy>
    SELECT JOB_TITLE, JOB_ID FROM JOBS
    </copy>
	```
    ![](images/6.popup_job.PNG)

5. Now save and run the application. Click on **Create** button again, and check that **Job id**, **Manager id**, and **Department id** changed to meaningful fields. You can insert a sample record as shown as the below image.

    ![](images/6.popup_check.PNG)

6. Repeat these sub step 2,3 and 4 in **Employee Maintenance** page also! Because employee maintenance page also need this. Make sure you save it. After finish editing **Employee Maintenance** page, run the application. Try edit a record, it will also be shown as the below.

    ![](images/6.popup_check_2.PNG)

Congratulations! You have completed this workshop!

You successfully migrated the source 12c database to Autonomous Database in Oracle Cloud Infrastructure, also sample HR application. We hope you enjoyed!

If you would like to download and compare with the final version of HR application, please get it **[from here](./files/f102.sql)**.

**This concludes this workshop.**

## **Summary**

Here is a summary of resources we created and used in our workshop.

1. Virtual Cloud Network

    - Public Subnet, Internet Gateway
    - Private Subnet, NAT Gateway, Service gateway

2. Compute Virtual Machines and Shapes, OS Images

    - Source 12c database instance using Oracle Database Marketplace image

3. Autonomous database

    - Target ATP instance

4. Oracle Application Express

    - APEX 20.2 version application

## Acknowledgements

I'd like to thank to Vahidin, who is experienced APEX developer and Tsengel, GenO lift implementation engineer. These gentlemen have shown their dedication and hardwork to support my workshop.

* **Author** - Bilegt Bat-Ochir - Senior Technology Solution Engineer
* **Contributors** - Vahidin Qerimi - Principal Technology Solution Engineer, Tsengel Ikhbayar - GenO lift implementation
* **Last Updated By/Date** - Bilegt Bat-Ochir 9/1/2021