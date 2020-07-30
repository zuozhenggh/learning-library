# Setup ATP Connectivity, Data, and Messaging

## Introduction

This lab will show you how to create kubernetes secrets for the two existing Autonomous Transaction Processing
databases. This way we will be able to connect the OKE Helidon microservices to
the ATP instances.

### Objectives
-   Create secrets to connect to existing ATP instances
-   Setup data and Oracle Advanced Queuing in existing ATP instances

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* OKE cluster and the ATP databases created
* Microservices code from GitHub (or zip) built and deployed

## **STEP 1**: Create Secrets To Connect To ATP PDBs
You will run a script that will download the connection information (wallet, tnsnames.ora, etc.) and then create kubernetes secrets from the information that will be used to connect to the ATP instrances provisioned earlier.

1.  Verify values are set in $MSDATAWORKSHOP_LOCATION/msdataworkshop.properties 

2.  cd into atp-secrets-setup dir.

    ```
        <copy>cd $MSDATAWORKSHOP_LOCATION/atp-secrets-setup</copy>
        ``` 

3.  execute createAll.sh and notice output creating secrets.

    ```
        <copy>./createAll.sh</copy>
        ``` 

  ![](images/createAll.png " ")

4.  execute msdataworkshop and notice secrets for order and inventory database and users.

    ```
        <copy>msdataworkshop</copy>
        ``` 

  ![](images/createAll.png " ")

  If there is an issue, execute deleteAll.sh to delete all secrets in workshop namespace

    ```
        <copy>./deleteAll.sh</copy>
        ``` 

  ![](images/deleteAll.png " ")
    ```

## **STEP 2**: Verify and understand ATP connectivity via Helidon microservice deployment in OKE
You will verify the connectivity from the frontend Helidon microservice
    deployment to the ATP using the previously created service broker binding.

1.  First, let’s analyze the Kubernetes deployment YAML file: `atpaqadmin-service.yaml`.

    ```
    <copy>cat $MSDATAWORKSHOP_LOCATION/atpaqadmin/atpaqadmin-service.yaml</copy>
    ```

    The volumes are set up and credentials are brought from each of the bindings
    (inventory and order). The credential files in the secret are base64 encoded
    twice and hence they need to be decoded for the program to use them, which
    is what the `initContainer` takes care. Once done, they will be mounted for
    access from the container `helidonatp`. The container also has the DB
    connection information such as the JDBC URL, DB credentials and Wallet,
    created in the previous step.

2.  Let’s analyze the `microprofile-config.properties` file.

    ```
    <copy>cat $MSDATAWORKSHOP_LOCATION/atpaqadmin/src/main/resources/META-INF/microprofile-config.properties</copy>
    ```

    This file defines the `microprofile` standard. It also has the definition of
    the data sources that will be injected. You will be using the universal
    connection pool which takes the JDBC URL and DB credentials to connect and
    inject the datasource. The file has default values which will be overwritten
    with the values specific for our Kubernetes deployment.

3.  Let’s also look at the microservice source file `ATPAQAdminResource.java`.

    ```
    <copy>cat $MSDATAWORKSHOP_LOCATION/atpaqadmin/src/main/java/oracle/db/microservices/ATPAQAdminResource.java</copy>
    ```

    Look for the inject portion. The `@Inject` will have the two data sources
    under `@Named` as “orderpdb” and “inventorypdb” which were mentioned in the
    `microprofile-config.properties` file.

4.  Go into the ATP admin folder.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/atpaqadmin</copy>
    ```

  ![](images/6ba636763c8534771619ae9a55d3322c.png " ")

5.  Create the `atpaqadmin` deployment and service using the following command.

    ```
    <copy>./deploy.sh</copy>
    ```

  ![](images/2d0ad754b2c2fa85abe1f3dd6dbdf367.png " ")

6.  Once successfully deployed, verify the existence of the deployment and
    service using the following command. You should notice that we now have the
    `atpaqadmin` pod up and running.

    ```
    <copy>pods</copy>
    ```

  ![](images/33ed0b2b6316c6cdbbb2939947759119.png " ")

7.  Use the URL `http://<external-IP>:8080` to open the frontend webpage.

  ![](images/490686705b79e262def7f41968498d8a.png " ")

8. Click **testdatasources**.

  ![](images/430872b9b99ce788dddb45c5e1de71ce.png " ")

  *If you do not see the correct results immediate wait a few minutes and click testdatasources again.*

  The frontend is calling the `atpaqadmin` service and has successfully established
  connections to both databases `orderpdb` and `inventorypdb`.

## **STEP 3**: Setup AQ in the database
In this step you will set up the AQ messaging queue by creating database
    links between the two ATP databases, and perform queue propagation. Advanced
    Queuing provides database-integrated message queuing functionality. We are
    going to download the connection information zip file for each of the ATP
    instances.

1.  Go to the Cloud Console and click **Autonomous Transaction Processing**.

  ![](images/8b3a05eecdbc4b140ac4fc81c8d49c89.png " ")

2.  If you don’t see the two ATP instances, make sure you have selected the
    right compartment.

  ![](images/4097cb788800a3a28dcd3a349698d0f0.png " ")

3.  Click on the `InventoryDB` name.

  ![](images/6873d607319af22e64d0aa11f8bd2ed8.png " ")

4.  On the InventoryDB page click **DB Connection**, select the regional Wallet and download the zip file.

  ![](images/d4ffd87731799f3961dfa13f36dd44a1.png " ")

  *Note: Make sure you select Regional Wallet.*

  ![](images/1b05d273a509a51f681e0efc514f09f4.png " ")

5. On the next page you will be asked to provide the password, please type the same password used when you created the instance and click **Download**.

  ![](images/73b7e7e550731c525b8a93939ef67188.png " ")

6.  Once downloaded, extract the zip file on your computer, and upload the
    `cwallet.sso` into object storage. Go to the Object Storage page and click **Create
    Bucket**. Make sure you are in the `msdataworkshop` compartment.

  ![](images/6fcb7b50a017498192e3d3b268e416b8.png " ")

  ![](images/9f3e11006885ae7e63ddbfd7d1c8fb77.png " ")

7.  Name the compartment `msdataworkshopbucket`, leave the defaults and click
    **Create Bucket**. You should see the newly created bucket in the list.

  ![](images/b40c72b4a398854e5a07c9c219075d73.png " ")

8.  Click `msdataworkshopbucket`, under Object, click **Upload Objects**, select
    the extracted `cwallet.sso` file from your computer and click **Upload
    Objects**.

  ![](images/438426876ac0d4ebbb964ae25d24c8f0.png " ")

  ![](images/8dcb5509c1ff0d7adef8fdde1042c0a5.png " ")

  ![](images/f65f8096ed72e77fe51111fd1a687f44.png " ")

  ![](images/04fa91b2738e69df048f38e9e562a198.png " ")

  ![](images/48599172582ed1a60b4d47307a5c04fc.png " ")

9. Once uploaded, go back to the `msdataworkshopbucket` page, and you should see the uploaded file in the list.

  ![](images/e7d97fd1eeae32cf65f68072fbb497b3.png " ")

10.  For convenience, create a pre-authenticated URL to the Object eliminating
    the need to sign-in when accessing the object. Click the other options icon
    located to the right of the `cwallet.sso` object, and select **Create
    Pre-Authenticated Request**.

  ![](images/ed954be119a3586da81bc9ee928da70c.png " ")

11. On the next page confirm the defaults and click **Create Pre-Authenticated Request**. Once created, copy the Pre-authenticated request URL, as it will not be shown again. Save the URL in your text file.

  ![](images/3caac1410392a9c844675c60b166a371.png " ")

12. Open the Cloud Shell and go to the `atpaqadmin` folder.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/atpaqadmin</copy>
    ```

  ![](images/7b2c01d83a10447de8761c7843183d16.png " ")

13. Edit the Kubernetes deployment file `atpaqadmin-deployment.yaml` with nano.

    ```
    <copy>nano atpaqadmin-deployment.yaml</copy>
    ```

  ![](images/341f75a208337ea66db5a007dc7c1664.png " ")

14.  We need to provide values in the section marked with “\# PROVIDE VALUES FOR
    THE FOLLOWING...”. Provide values for the following items:

    - cwalletobjecturi
    - orderhostname
    - orderport
    - orderservice\_name
    - orderssl\_server\_cert\_dn
    - inventoryhostname
    - inventoryport
    - inventoryservice\_name
    - inventoryssl\_server\_cert\_dn

    `cwalletobjecturi` – is the pre-authenticated URL which we’ve created in the previous step, when uploading `cwallet.sso` to the Object storage.

  The rest of the values should be in the `tnsnames.ora` file which was extracted from the zip file. When looking for the information in `tnsnames.ora` look for the information under the \_HIGH TNS aliases, so for `orderdb` look for values in `orderdb_high` connection string, and for `inventorydb` look for values in `inventorydb_high` connection string.

  ![](images/dd5993c4b3d9fd0bf606fd467c0b5c3f.png " ")

  Once you have edited the lines, the result should look like this:

  ![](images/e0cc650777e2d759de02ed49f6fcc8b8.png " ")

15. Redeploy the `atpaqadmin` image.

    ```
    <copy>./redeploy.sh</copy>
    ```

  ![](images/280c423cdfa5b825b704e8a2bdee2621.png " ")

15.  Once created, run the `pods` command to check that the `atpaqadmin` pod is
    in running state. You should see the `atpaqadmin` pod up and running

    ```
    <copy>pods</copy>
    ```

  ![](images/1f226568abdce39d7fc9eacd9279fbab.png " ")

16.  Open the frontend microservice home page and click the following buttons in
    order: **createUsers**, **createInventoryTable**, **createDBLinks**,
    **setupTablesQueuesAndPropagation**.

  ![](images/3041592eb42deecf17bb9012b09ace18.png " ")

  ![](images/7ecbfad49b0fe271b2d18e7fa297a112.png " ")

  ![](images/cb73b47be1514662756e2dbc5128aebf.png " ")

  ![](images/28321f572e02aaa349e1edc5c89fe1c5.png " ")

  ![](images/17754016120ef6c74ab84c0981eb274f.png " ")

  ![](images/20f00980ce66e36ff6f5992e25e98c4d.png " ")

  ![](images/a9c9c8224138421e5f5e53c9f1ff8a8d.png " ")

  ![](images/b992c2c86bca0ef278b6d608042997e2.png " ")

  The results of `setupTablesQueuesAndPropagation` should take a couple of minutes
  to complete, therefore we could open the Cloud Shell and check the logs, as we
  are waiting until all the messages have been received and confirmed.

17. (Optional) While waiting for `setupTablesQueuesAndPropagation` to complete, open the Cloud Shell and check the logs using the following command:

    ```
    <copy>logpod admin</copy>
    ```

  ![](images/6edf793e660c40736681881d4d59362e.png " ")

  We will see testing messages going in both directions between the two ATP
  instances across the DB link

  ![](images/cf0526b6ef1c3f21bb865947462bdb17.png " ")

18. (Optional) If it is necessary to restart, rerun the process or clean up the
    database:

    If **setupTablesQueuesAndPropagation** was executed, you need to run
    **unschedulePropagation** first.

  ![](images/6198a8af3b2c821a9378d493c60880ae.png " ")

  Afterwards, click **deleteUsers**.

  ![](images/76d791ffeb225ff0249f72b9d74595d8.png " ")