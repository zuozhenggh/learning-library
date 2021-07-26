# Import the Web Application and Test the Blockchain Table Features

## Introduction

In the lab, you will create an APEX workspace, define the rest end points and enable ORDS for the workspace. Then import the APEX application and run the application to test the blockchain functionality.

Estimated lab time: 20 minutes

### Objectives

In this lab, you will:

- Create APEX Workspace
- Define REST end points for the workspace
- Import an APEX application
- Run the APEX application and test the blockchain functionality

### Prerequisites

- Have successfully completed all the previous labs.

## **STEP 1:** Create APEX Workspace

1. Navigate back to the tab with Oracle Cloud console. Click on the hamburger menu, search for **Oracle Database** and click **Autonomous Transaction Processing**.

2. Click on the Display Name of your ADB instance to navigate to your ADB instance details page. In this lab, click on the provisioned **DEMOATP** instance.

3. Within your database, APEX is not yet configured. Therefore, when you first access APEX, you will need to log in as an APEX Instance Administrator to create a workspace.

    Click the **Tools** tab. Click **Open APEX**.

4. Enter the password for the Administration Services and click **Sign In to Administration**. The password is the same as the one entered for the ADMIN user when creating the ATP instance. 

    In the lab, provide the **password - WElcome123##** for the ADMIN user you created when you provisioned your ADB instance and click **Sign in to Administration** to sign in to APEX Workspace.

4. Click **Create Workspace**.

5. In the Create Workspace dialog, enter the following and click **Create Workspace**.
    - Database User: DEMOUSER
    - Password : WElcome123## *Note:* The password field will be disabled as DEMOUSER is an existing database user.
    - Workspace Name : DEMOUSER

6. In the APEX Instance Administration page, click the **DEMOUSER** link in the success message.

    Note: This will log you out of APEX Administration so that you can log into your new workspace.

7. On the APEX Workspace log in page, enter the **Password - WElcome123##** for the DEMOUSER workspace, check the Remember workspace and username checkbox, and then click **Sign In**.

8. Click on **Set APEX Password**.

9. Navigate to the tab with Oracle cloud console, click on Profile icon, click on User Setting and Copy the email address.

10. Navigate back to the APEX workspace, paste the email address in the Email Address field, provide the **Password - WElcome123##** and confirm the password for the `demouser` and click on **Apply Changes**.

## **STEP 2** Define the REST End Points and Enable the Schema

By default the schema is not registered with ORDS. Let's define REST endpoints for the bank_ledger schema and enable the schema.

1. Click on **SQL Workshop**.

2. Select **RESTful Services**.

3. <!--Notice that the Schema Alias is `DEMOUSER` and there are no module defined.--> Click [here]() to download the ORDS-REST-Blockchain.sql file that has the SQL Script to REST Enable this schema and also to create modules for the bank_ledger table with the appropriate handlers.

4. Let's import the modules by clicking on **Import**.

5. Click on **Choose File** and upload the ORDS REST Blockchain file that you just downloaded. Click on **Import**.

6. Click on **Modules** to expand and notice that now you have the `blockchain` module created.

9. Click on the blockchain module to see the Templates - `rowdata` and `signdata` templates.

10. Click on `rowdata` and `signdata` templates to expand and view the POST Methods.

11. Click on the **POST** under the rowdata to expand. Notice the sign PL/SQL procedure under Source field takes the seqId, instaceId, chainId as input parameters and give the row data when you do a POST.

12. After receiving the rowdata, the Node.js application which will install in the next lab will use that row data to do the signing using the other rest point -  POST method under the signdata.

13. Click on the **POST** under the signdata to expand. Notice the sign PL/SQL procedure under Source field takes the cert_guid, chainId, instanceId, sedId as input parameters along with the rowdata to sign the row.

## **STEP 3:** Import and Run the APEX Application

Now we the blockchain module, the handlers and templates defined let's import the apex application.

1. Click [here]() to download the blockchain-tables-apex.sql file.

2.  Click on **App Builder**.

3. Click on **Import**.

4. In the Import page, Drag and drop or click on **Drag and Drop** to upload the blockchain-tables-apex.sql file you just downloaded.

    Leave the default File Type - Database Application, page or Component Export and click **Next**.

6. Click **Next**.

7. In the Install Database Application page, notice that it will use the schema DEMOUSER, leave the defaults and click **Install Application**.

8. Once the application is installed, click on **Run Application** to run the application.

9. In the Blockchain APEX application sign in page, provide the **Username - DEMOUSER**, **Password - WElcome123##** and click **Sign In**.

## **STEP 4:** Test the Blockchain functionality in APEX Application

2. Click on **List of Transactions**.

3. The List of Transactions page displays all the existing transactions from the database. The transactions with the `X` in Is Signed column implies that the records are not signed. As the rows are not verified, it shows the message - `No Verification Process has been run!`.

4. Click on **Create Transaction** button to create a new transaction. A Bank Ledger dialog box pops up.

5. In the Bank Ledger dialog box, fill the values of your choice in the Bank, Deposit Date and Deposit Amount fields or type the values `Bank - 999`, `Deposit Date - 7/7/21` and `Deposit Amount - 1000` and click on **Insert Transaction** to create a new transaction.

6. Notice that a new row is created with the details provided which is not signed and is shown on the List of Transactions.

7. To update a record, click on the pencil icon of a row of your choice and update a value and click **Save Transaction**. It will throw an error - 

    In this example, let's try to edit the record with 

8. To delete a record, click on the pencil icon of a row of your choice, click **Delete** and confirm the delete operation by clicking on **OK**. It throws an error - 

    In this example, let's try to delete the record with 

9. Click on **Verify Rows** button and click **OK** on the dialog box to verify all the rows in the blockchain table. 

10. After the verification is finished, notice that the *Verify Row Message* now shows the total number of rows and the number of records verified successfully. If the Total Rows and Verified Rows values are same means all the rows in table are verified successfully.

11. Make note the Instance ID, Chain ID and Seq ID of a row that you want to sign. In the demo, we are going to sign the row with Instance ID - , Chain ID - and Seq ID - .
<!---
12. Replace the number 1 for the instanceId, chainId and seqId and update with your notes values in the below command.

    ```
    curl --location --request POST 'http://localhost:8080/transactions/row' --header 'Content-Type: application/json' --data '{"instanceId":1,"chainId":1,"seqId":1}'
    ```

    After replacing the instanceId, chainId and seqId values in the command, it should look like this:

    ```
    curl --location --request POST 'http://localhost:8080/transactions/row' --header 'Content-Type: application/json' --data '{"instanceId":1,"chainId":1,"seqId":1}'
    ```

13. Save this command in a noted to run which we will run in the next lab and sign the row.

--->

## Acknowledgements

* **Author** - Salim Hlayel, Mark Rakhmilevich, Anoosha Pilli
* **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
* **Last Updated By/Date** - Anoosha Pilli, July 2021