# Get Started with OML4Py on Autonomous Database

## Introduction
This lab walks you through the steps to create a Zeppelin notebook and connect to the Pyhton interpreter.

Estimated Lab Time: 15 minutes

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

<if type="livelabs">
## **Step 1:** Launch the workshop

*Note: it takes approximately 20 minutes to create your workshop environment.*

1. After you receive the e-mail stating that your environment is ready, go back to the My Reservations page and click **Launch Workshop**.

    ![](images/my-reservations.png)

2. Make a mental note of the compartment name assigned to you. Click **Copy Password** to copy your initial password. Note that this is also the admin password for your Autonomous Data Warehouse instance, so save the password for later use. Then click **Launch Console**.

    ![](images/launch-page.png)

3. On the login page, use the Oracle Cloud Infrastructure direct sign-in, paste the password and click **Sign In**.

    ![](images/login-console.png)

4. Change your password by pasting the initial password in the **Current Password** field, **New Password** field and **Confirm Password** field.

    ![](images/change-password.png)

5. Click on the menu icon and then select Autonomous Data Warehouse from the menu.

    ![](images/open-adw.png)

6. Select the compartment assigned to you from the **List Scope menu** and then click the ADW instance.

    ![](images/select-compartment.png)

    ![](images/adw-instance.png)

</if>

<if type="freetier">
## **Step 1**: Create an OML User

An administrator creates a new user account and user credentials for Oracle Machine Learning in the User Management interface.
**Note:** You must have the administrator role to access the Oracle Machine Learning User Management interface. To create a user account:

1. Sign in to your OCI account, click the hamburger on the left to open the left navigation pane, and click **Autonomous Data Warehouse.**
    ![Autonomous Data Warehouse option](images/adw.png)

2. Click on an Autonomous Database instance.

    ![Image alt text](images/adb_instance.png)

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
    - **Username:** Enter a username for the account (for example: `omluser`). Using the username, the user will log in to an Oracle Machine Learning instance.
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

</if>

## **Step 2:** Access Oracle Machine Learning Notebooks

You create notebooks in Oracle Machine Learning Notebooks. You can access Oracle Machine Learning Notebooks from Autonomous Database.

<if type="livelabs">
1. From the tab on your browser with your ADW instance, click **Service Console**, then select **Development** from the left.

    ![](images/service-console.png)

    ![](images/service-console-development.png)

2. Click **Oracle Machine Learning Notebooks**.

    ![](images/open-oml-notebooks.png)

3. Sign in with the **omluser** using the password `AAbbcc123456`.

    ![](images/signin-to-oml.png)

4. Click on Notebooks from the Quick Actions menu.

    ![](images/open-notebooks.png)

</if>
<if type="freetier">
1. Sign in to your OCI account using your OCI credentials.

2. Click Dashboard. Scroll down your dashboard and then click **Autonomous Data Warehouse.** Alternatively, you can click on the hamburger on the left and then click **Autonomous Data Warehouse.**
    ![Autonomous Data Warehouse option](images/adw.png)

3. On the Autonomous Databases page, click the ADW instance that you created. In this example, it is MH120920.
    ![Image alt text](images/adb_instance.png)    

4. The details of the ADW instance are displayed. Click **Service Console.**
    ![Image alt text](images/service_console.png)

    From the Tools page, you can access SQL Developer Web and Oracle ML User Administration pages.
    ![Image alt text](images/adw_tools.png)

5. Click **Development** on the left navigation menu, and then click **Oracle Machine Learning Notebooks.**
    ![Image alt text](images/dev_oml_notebooks.png)

6. On the Oracle Machine Learning Notebooks sign in page, enter your credentials and click **Sign in.**
    ![Image alt text](images/oml_sign_in.png)

    This opens the Oracle Machine Learning Notebooks home page.    
</if>

## **Step 3:** Create a Zeppelin Notebook

A notebook is a web-based interface for data analysis, data discovery, data visualization and collaboration. To create a notebook:
1. In the Notebooks page, click **Create.** The Create Notebook window appears.

    ![](images/create-notebook-1.png)

2. In the **Name** field, provide a name for the notebook.
3. In the **Comments** field, enter comments, if any.
4. In the **Connections** field, select a connection in the drop-down list. By default, the `Global` connection group is assigned.
5. Click **OK.** The notebook is created and it opens in the notebook editor.

    ![](images/create-notebook-2.png)

**Note:** For Oracle Autonomous Database, a connection is automatically established provided you have the appropriate interpreter binding specified and import the oml package.    

<details><summary>Familiarize with the Zeppelin Notebook toolbar</summary>
The Zeppelin notebook toolbar contains buttons to run code in paragraphs, for configuration settings, and display options.

For example, it displays the current status and the number of users connected to the notebook. It also contains a menu item for keyboard shortcuts and options to show or hide the markdown editor and paragraph output. Additional settings are shown in the illustration here.
    ![Image alt text](images/notebook_toolbar.png)
</details>

<details><summary>Familiarize with the OML Notebook interpreter bindings</summary>
Oracle Machine Learning notebooks contain an internal list of bindings to fetch data from the database or another data source, such as Oracle Cloud Object Storage. For this lab, we set the interpreter binding to connect to the ADW database and run queries.

Click the interpreter bindings icon in the upper right-corner of the Notebook to view the list of available interpreter bindings.
  ![Image alt text](images/interpreter_bindings.png)

The default service is low. Click to bind or unbind an interpreter. Drag-and-drop individual interpreter binding settings up or down to order which binding will be used by default. The first interpreter on the list becomes the default. Those highlighted in blue are active.
</details>

<details><summary>Familiarize with the Zeppelin interpreters</summary>
An interpreter is a plug-in that allows you to use a specific data processing language in your Oracle Machine Learning notebook. You can add multiple paragraphs, and each paragraph can be connected to different interpreters such as SQL or Python.

You create different paragraphs with different interpreters based on the code you want to run in the paragraphs. The interpreter is set at the top of the paragraph.
The available interpreters are:

  - `%sql` - To call the SQL interpreter and run SQL statements
  - `%script` - To call and run PL/SQL scripts
  - `%md` - To call the Markdown interpreter and generate static html from Markdown plain text
  - `%python` - To call the Python interpreter and run Python scripts
</details><p/>

## **Step 4:** Connect to the Python Interpreter

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

## **Step 5:** Verify Connection to the Autonomous Database  
Using the default interpreter bindings, OML Notebooks automatically establishes a database connection for the notebook.  

1. To verify the Python interpreter has established a database connection through the `oml` module, run the command:

   `oml.isconnected()`
   ![Image alt text](images/oml_connected.png)

  Once your notebook is connected, the command returns `True`.         


## **Step 6:** View Help Files    
The Python help function is used to display the documentation of packages, modules, functions, classes, and keywords. The help function has the following syntax:
    ```
    help([object])
    ```

For example,
  - To view the help files for the `oml.create` function, type:
    ```
    %python
    <copy>
    help(oml.create)</copy>
    ```

  - To view the help files for `oml` package, type:

    ```
    %python
    <copy>
    help(oml)</copy>
    ```  

## Learn More

* [Get Started with Oracle Machine Learning for Python](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/get-started-with-oml4py.html#GUID-B45A76E6-CE48-4E49-B803-D25CA44B09ED)
* [Oracle Machine Learning Notebooks](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/)


## Acknowledgements
* **Author** - Moitreyee Hazarika, Principal User Assistance Developer
* **Contributors** -  Mark Hornick, Senior Director, Data Science and Machine Learning; Marcos Arancibia Coddou, Product Manager, Oracle Data Science; Sherry LaMonica, Principal Member of Tech Staff, Advanced Analytics, Machine Learning
* **Last Updated By/Date** - Tom McGinn, March 2021
