# Get Started with OML4Py on Autonomous Database

## Introduction

This lab walks you through the steps to:
* Create an OML user
* Access OML Notebooks
* Create a Zeppelin Notebook
* Familiarize with the Zeppelin Notebook toolbar
* Familiarize with the Zeppelin Notebook interpreter bindings
* Familiarize with the Zeppelin Notebook interpreters
* Connect to the Python Interpreter
* Verify Connection to the Autonomous Database
* View help files  

Estimated Lab Time: 15 minutes

### About Product/Technology
Oracle Machine Learning for Python (OML4Py) is a component of Oracle Autonomous Database, that includes Oracle Autonomous Data Warehouse (ADW), Oracle Autonomous Transaction Processing (ATP), and Oracle Autonomous JSON Database (AJD). By using Oracle Machine Learning Notebooks, you can run Python functions on data for data exploration and preparation while leveraging Oracle Database as a high-performance computing environment. Oracle Machine Learning Notebooks is available through Autonomous Data Warehouse (ADW) , Autonomous Transaction Processing (ATP) and Autonomous JSON Database (AJD) services.

Oracle Machine Learning for Python (OML4Py) makes the open source Python scripting language and environment ready for the enterprise and big data. Designed for problems involving both large and small volumes of data, Oracle Machine Learning for Python integrates Python with Oracle Autonomous Database, including its powerful in-database machine learning algorithms, and enables deployment of Python code.

### Objectives

In this lab, you will learn how to:
* Create an OML user
* Access OML Notebooks
* Create a Zeppelin Notebook
* Familiarize with the Zeppelin Notebook toolbar
* Familiarize with the Zeppelin Notebook interpreter bindings
* Familiarize with the Zeppelin Notebook interpreters
* Connect to the Python Interpreter
* Verify Connection to the Autonomous Database
* View help files

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **STEP 1**: Create an OML User

An administrator creates a new user account and user credentials for Oracle Machine Learning in the User Management interface.
**Note:** You must have the administrator role to access the Oracle Machine Learning User Management interface. To create a user account:

1. Sign in to your OCI account, click the hamburger on the left to open the left navigation pane, and click **Autonomous Data Warehouse.**
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

## **STEP 3:** Create a Zeppelin Notebook

A notebook is a web-based interface for data analysis, data discovery, data visualization and collaboration. To create a notebook:
1. In the Oracle Machine Learning home page, click **Notebooks.** The Notebooks page opens.
2. In the Notebooks page, click **Create.** The Create Notebook window appears.
3. In the **Name** field, provide a name for the notebook.
4. In the **Comments** field, enter comments, if any.
5. In the **Connections** field, select a connection in the drop-down list. By default, the `Global` connection group is assigned.
6. Click **OK.** The notebook is created and it opens in the notebook editor.

**Note:** For Oracle Autonomous Database, a connection is automatically established provided you have the appropriate interpreter binding specified and import the oml package.    

### **Step 3.1** Familiarize with the Zeppelin Notebook toolbar
The Zeppelin notebook toolbar contains buttons to run code in paragraphs, for configuration settings, and display options.

For example, it displays the current status and the number of users connected to the notebook. It also contains a menu item for keyboard shortcuts and options to show or hide the markdown editor and paragraph output. Additional settings are shown in the illustration here.
    ![Image alt text](images/notebook_toolbar.png)

### **Step 3.2** Familiarize with the OML Notebook interpreter bindings
Oracle Machine Learning notebooks contain an internal list of bindings to fetch data from the database or another data source, such as Oracle Cloud Object Storage. For this lab, we set the interpreter binding to connect to the ADW database and run queries.

Click the interpreter bindings icon in the upper right-corner of the Notebook to view the list of available interpreter bindings.
  ![Image alt text](images/interpreter_bindings.png)

The default service is low. Click to bind or unbind an interpreter. Drag-and-drop individual interpreter binding settings up or down to order which binding will be used by default. The first interpeter on the list becomes the default. Those highlighted in blue are active.

### **Step 3.3** Familiarize with the Zeppelin interpreters
An interpreter is a plug-in that allows you to use a specific data processing language in your Oracle Machine Learning notebook. You can add multiple paragraphs, and each paragraph can be connected to different interpreters such as SQL or Python.

You create different paragraphs with different interpreters based on the code you want to run in the paragraphs. The interpreter is set at the top of the paragraph.
The available interpreters are:

  - `%sql` - To call the SQL interpreter and run SQL statements
  - `%script` - To call and run PL/SQL scripts
  - `%md` - To call the Markdown interpreter and generate static html from Markdown plain text
  - `%python` - To call the Python interpreter and run Python scripts

## **STEP 4:** Connect to the Python Interpreter

To run Python commands in a notebook, you must first connect to the Python interpreter. This occurs as a result of running your first `%python` paragraph. To use OML4Py, you must import the `oml` module, which automatically establishes a connection to your database.
In an Oracle Machine Learning notebook, you can add multiple paragraphs, and each paragraph can be connected to different interpreters such as SQL or Python. This example shows you how to:

* Connect to a Python interpreter to run Python commands in a notebook
* Import the Python modules - oml, pandas, numpy, and matplotlib
* Check if the `oml` module is connected to the database

**Note:** `z` is a reserved keyword and must not be used as a variable in `%python` paragraphs in Oracle Machine Learning Notebooks. You will see `z.show()` used in the examples to display Python object and proxy object content.

1. Open the notebook and click the interpreter bindings icon. View the available interpreter bindings.  The "low" priority binding runs operations serially (no parallelism). You can drag-and-drop individual interpreter binding settings up or down to order which binding will be used by default. Those highlighted in blue are active. Click to toggle to inactive.

    ![Image alt text](images/interpreter_bindings.png)

    The available interpreter bindings are:
    - `%sql` - To call the SQL interpreter and run SQL statements
    - `%script` - To call and run PL/SQL scripts
    - `%md` - To call the Markdown interpreter and generate static html from Markdown plain text
    - `%python` - To call the Python interpreter and run Python scripts

2. To connect to the Python interpreter, type `%python` at the top of a new paragraph in your notebook.
   You are now ready to run Python scripts in your notebook.

3. To use OML4Py module, you must import the oml module. Type the following Python command to import the   oml module, and click the run icon. Alternatively, you can press Shift+Enter keys to run the notebook.   

    `import oml`

    ![Image alt text](images/import_oml.png)

## **STEP 5:** Verify Connection to the Autonomous Database  
Using the default interpreter bindings, OML Notebooks automatically establishes a database connection for the notebook.  

1. To verify the Python interpreter has established a database connection through the `oml` module, run the command:

   `oml.isconnected()`
   ![Image alt text](images/oml_connected.png)

  Once your notebook is connected, the command returns `True`.         


## **STEP 6:** View Help Files    
The Python help function is used to display the documentation of packages, modules, functions, classes, and keywords. The help function has the following syntax:
    ```
    help([object])
    ```

For example,
  - To view the help files for the `oml.create` function, type:
    ```
    %python
    help(oml.create)
    ```

  - To view the help files for `oml` package, type:

    ```
    %python
    help(oml)
    ```  

You may now [proceed to the next lab](#next).

## Learn More

* [Get Started with Oracle Machine Learning for Python](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/get-started-with-oml4py.html#GUID-B45A76E6-CE48-4E49-B803-D25CA44B09ED)
* [Oracle Machine Learning Notebooks](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/)


## Acknowledgements
* **Author** - Moitreyee Hazarika, Principal User Assistance Developer
* **Contributors** -  Mark Hornick, Senior Director, Data Science and Machine Learning; Marcos Arancibia Coddou, Product Manager, Oracle Data Science; Sherry LaMonica, Principal Member of Tech Staff, Advanced Analytics, Machine Learning
* **Last Updated By/Date** - Moitreyee Hazarika, February 2021
* **Workshop (or Lab) Expiry Date**

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
