# Get Started with OML4Py on Autonomous Database

## Introduction

This lab walks you through the steps to
* Create an OML user
* Access OML Notebooks
* Create a Zeppelin Notebook
* Connect to the Python Interpreter
* Verify Connection to the Autonomous Database  

Estimated Lab Time: 60 minutes

### About Product/Technology
Enter background information here..

### Objectives

In this lab, you will learn how to:
* Create an OML user
* Access OML Notebooks
* Create a Zeppelin Notebook
* Connect to the Python Interpreter
* Verify Connection to the Autonomous Database

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

## **STEP 1**: Create an OML User

An administrator creates a new user account and user credentials for Oracle Machine Learning in the User Management interface.
**Note:** You must have the administrator role to access the Oracle Machine Learning User Management interface. To create a user account:

1. Sign in to your OCI account, click the hamgurger on the left to open the left navigation pane, and click **Autonomous Data Warehouse.**
    ![Autonomous Data Warehouse option](images/adw.png "Autonomous Data Warehouse")

2. Click on an Autonomous Database instance.

    ![Image alt text](images/adb_instance.png "ADB Instance")

3. On the Autonomous Database Details page, click **Service Console.**

    ![Image alt text](images/service_console.png)

4. On the Service Console click **Administration.**
    ![Image alt text](images/administration.png)

5. Click **Manage Oracle ML Users** to open the Oracle Machine Learning User Administration page.
    ![Image alt text](images/manage_oml_users.png)
6. Click **Create** on the Oracle Machine Learning User Administration page.
    ![Image alt text](images/create_option.png)
7. In the Create User page, enter the following details to create the user:
    ![Image alt text](images/create_user_page.png)
    - **Username:** Enter a username for the account. Using the username, the user will log in to an Oracle Machine Learning instance.
    - **First Name:** Enter the first name of the user.
    - **Last Name:**  Enter the first name of the user.
    - **Email Address:** Enter the email ID of the user.
    - Select the option **Generate password and email account details to user. User will be required to reset the password on first sign in.** to auto generate a temporary password and send an email with the account credentials to the user.
    If you select this option, you need not enter values in the **Password** and **Confirm Password** fields; the fields are grayed out.
    - **Password:** Enter a password for the user, if you choose to create a password for the user.
    This option is disabled if you select the Generate password... option to auto generate a temporary password for the user.
    - **Confirm Password:** Enter a password to confirm the value that you entered in the Password field.
    By doing so, you create the password for the user. The user can change the password when first logging in.
8. Click **Create.**     

## **STEP 2:** Access Oracle Machine Learning Notebooks

You create notebooks in Oracle Machine Learning Notebooks. You can access Oracle Machine Learning Notebooks from Autonomous Database.

1. Sign in to your OCI account using your OCI credentials.

2. Click Dashboard. Scroll down your dashboard and then click **Autonomous Data Warehouse.** Alternatively, you can click on the hamburger on the left and then click **Autonomous Data Warehouse.**
    ![Autonomous Data Warehouse option](images/adw.png "Autonomous Data Warehouse")

3. On the Autonomous Databases page, click the ADW instance that you created. In this example, it is MH120920.
    ![Image alt text](images/adb_instance.png "ADB Instance")    

4. The details of the ADW instance are displayed. Click **Service Console.**
    ![Image alt text](images/service_console.png)

    From the Tools page, you can access SQL Developer Web and Oracle ML User Administration pages.
    ![Image alt text](images/adw_tools.png)

5. Click **Development** on the left navigation menu, and then click **Oracle Machine Learning Notebooks.**
    ![Image alt text](images/dev_oml_notebooks.png)

6. On the Oracle Machine Learning Notebooks sign in page, enter your credentials and click **Sign in.**
    ![Image alt text](images/oml_sign_in.png)

    This opens the Oracle Machine Learning Notebooks home page.    

## **STEP 3:** Create a Notebook

A notebook is a web-based interface for data analysis, data discovery, data visualization and collaboration. To create a notebook:
1. In the Oracle Machine Learning home page, click **Notebooks.** The Notebooks page opens.
2. In the Notebooks page, click **Create.** The Create Notebook window appears.
3. In the **Name** field, provide a name for the notebook.
4. In the **Comments** field, enter comments, if any.
5. In the **Connections** field, select a connection in the drop-down list. By default, the `Global` connection group is assigned.
6. Click **OK.** The notebook is created and it opens in the notebook editor.

**Note:** For Oracle Autonomous Database, a connection is automatically established provided you have the appropriate interpreter binding specified and import the oml package.    

### **Step 3.1** Connect to the Python Interpreter

To run Python commands in a notebook, you must first connect to the Python interpreter. This occurs as a result of running your first `%python` paragraph. To use OML4Py, you must import the `oml` module, which automatically establishes a connection to your database.
In an Oracle Machine Learning notebook, you can add multiple paragraphs, and each paragraph can be connected to different interpreters such as SQL or Python. This example shows you how to:

    * Connect to a Python interpreter to run Python commands in a notebook
    * Import the Python modules - oml, pandas, numpy, and matplotlib
    * Check if the oml module is connected to the database

**Note:** `z` is a reserved keyword and must not be used as a variable in `%python` paragraphs in Oracle Machine Learning Notebooks. You will see `z.show()` used in the examples to display Python object and proxy object content.

1. Open the notebook and click the interpreter bindings icon. View the available interpreter bindings.  The "low" priority binding runs operations serially (no parallelism). You can drag-and-drop individual interpreter binding settings up or down to order which binding will be used by default. Those highlighted in blue are active. Click to toggle to inactive.

![Image alt text](images/interpreter_bindings.png)

The available interpreter bindings are:
    * `%sql` - To call the SQL interpreter and run SQL statements
    * `%script` - To call and run PL/SQL scripts
    * `%md` - To call the Markdown interpreter and generate static html from Markdown plain text
    * `%python` - To call the Python interpreter and run Python scripts

2. To connect to the Python interpreter, type `%python` at the top of a new paragraph in your notebook.
   You are now ready to run Python scripts in your notebook.

3. To use OML4Py module, you must import the oml module. Type the following Python command to import the   oml module, and click the run icon. Alternatively, you can press Shift+Enter keys to run the notebook.   

    `import oml`

    ![Image alt text](images/import_oml.png)

### **Step 3.2** Verify Connection to the Autonomous Database    

1. To verify if the oml module is connected to the Autonomous Database, type:

   `oml.isconnected()`
   ![Image alt text](images/oml_connected.png)

   Once your notebook is connected, the command returns TRUE. The notebook is now connected to the Python interpreter, and you are ready to run python commands in your notebook.         


You may now [proceed to the next lab](#next).

## Learn More

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
