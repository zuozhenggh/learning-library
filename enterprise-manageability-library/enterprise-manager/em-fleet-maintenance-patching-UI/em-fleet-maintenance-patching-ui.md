# Automated Database Patching at Scale with Fleet Maintenance UI

## Introduction
The goal of this lab is to explore end-to-end automated patching and upgrades of the Oracle Database using Enterprise Manager UI feature (starting from 13.5 RU1).

*Estimated Lab Time*: 75 minutes


### About Database Fleet Maintenance UI

Starting from Enterprise Manager 13.5 RU1, Enterprise Manager is equipped with a new interface to patch(update) and upgrade Database Fleet as an end-to-end automated solution. Creation of Gold Image and Subscription of database to the Gold Image is to be done by using emcli commands. In upcoming releases of Enterprise Manager, we plan to integrate these tasks with UI.

### Objectives

In this lab you will perform the following steps:
| Step No. | Feature                                                    | Approx. Time | Details                                                                                                                                                                    | Value Proposition |
|----------------------|------------------------------------------------------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| 1                    | Detect Configuration Pollution                             | 10 minutes  | Analyze the database estate using Software Standardization.                                                                                                                |                   |
| 2                    | Oracle Database Patching with Fleet Maintenance | 50 minutes  | Patch a Database target using a Gold Image. As part of patching the Container Database, all Pluggable Databases in that Container Database will automatically get patched. |                   |


### Prerequisites
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

*Note*: This lab environment is setup with Enterprise Manager Cloud Control Release 13.5 and Database 19.10 as Oracle Management Repository. Workshop activities included in this lab will be executed both locally on the instance using Enterprise Manager Command Line Interface (EMCLI) or Rest APIs, and the Enterprise Manager console (browser)

## Task 1: Review Tasks Completed in Advance

In the interest of simplifying the setup and save time, the following steps were completed in advance and covered in this lab. Please review accordingly for reference

1. We have created and pre-patched an Oracle Home with 18.10 release using which will be use to create the gold image *[/u01/app/oracle/product/18/db\_home\_src, Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192]*

To ensure smooth execution of the intended use cases, we have pre-hosted the scripts to be used later at */home/oracle/fleet*

## Task 2: Detect Configuration Pollution with Software Standardization Advisor

This exercise enables us to analyze the database estate using Software Standardization.

Software Standardization Advisor enables administrators to understand various database configurations prevailing in their environment. Each deployment with a unique platform, release and patch level is identified as a distinct configuration. This provides the administrators a view of the configuration pollution in their estate. It also analyzes and provides a recommendation to standardize the environment and reduce the number of configurations required for managing the database estate.

  ![](images/em-fleet-maintenance-overview-2.png " ")

1. On the browser window on the right preloaded with *Enterprise Manager*, if not already logged in, click on the *Username* field and login with the credentials provided below.

    ```
    Username: <copy>sysman</copy>
    ```

    ```
    Password: <copy>welcome1</copy>
    ```

    ![](../initialize-environment/images/em-login.png " ")

2.  Click on ***Targets >> Databases***.

    ![](images/038585c9308635261ae7e4aa956525af.png " ")

3.  In the Databases targets page, click on ***Administration >> Software Standardization Advisor***

    ![](images/software-std-advisor.jpg " ")

4.  Software Standardization Advisor shows two graphs depicting current configuration and recommended configuration.

    ![](images/em-pollution-detection-1.png " ")

    A Software Configuration is identified by Database Release, Platform and set of Patches installed on the target.

    The Software Configuration Advisor run shows that there are 5 Unique Software Configurations in the environment as shown in the pie chart labelled as “Current Unique Software Configurations” and recommendation is to maintain 2 Software Configurations as shown in the pie chart labelled as “Recommended Software Configurations”.

    Let us observe details of the reports in next steps.

5.  Click on **Generate Report**.

6.  Click on **Current Configurations** to open the Excel report.

    ![](images/em-pollution-detection-2.png " ")

    When opening the downloaded Excel Spreadsheet report, a warning on XLS format and file extension mismatch may pop up (see below). Simply click on “Yes” to
    ignore the warning and open the file.

    ![](images/d9ea997d07c30f80083e097f6b578200.png " ")

    Current Configuration shows five different Oracle home software versions

    ![](images/84e0ac92b29e45e91b9d17a8e0b3a2da.jpg " ")

7.  Next, click on **Recommended Configurations** to open the Excel Report.

    ![](images/em-pollution-detection-3.png " ")

    The EM Recommended Configuration report recommends reducing 5 configurations and standardizing the database estate on 2 configurations, one based on 18c and the other based on 19c. This means All Oracle Homes of Release 18c should uptake the corresponding 18c configuration and the 19c homes will use the one based on Release 19c

    ![](images/06ff90fdba8aa5abebd066086e33f700.jpg " ")

    Recommendation is based on union of all bugs included in the Patches in all OHs and based on configuration type.

  <!-- This completes Step 1. In this section, you learned how to perform the following:

    - Access the Database Software Standardization Advisor
    - View Configuration summary
    - Generate and download current and recommended configuration reports

  In the next section we will follow these recommendations to perform the following using Enterprise Manager 13c Fleet Maintenance.

    - Patch database “hr.subnet.vcn.oraclevcn.com” from 18.3 to 18.10 -->

## Task 3: Database Server patching with Fleet maintenance (Overview)

### **Database Fleet Maintenance**

Enterprise Manager Database Fleet Maintenance is a Gold Image Target subscription based out of place patching solution. Gold Image(s) are software library entities storing archive of a patched software home. Targets, to be patched, subscribe to a relevant Gold Image. Target subscription persists through the lifecycle of the Target or Gold Image unless modified by an administrator.

  ![](images/DB_Fleet_Patching.png " ")

### **Patching with Fleet Maintenance**

We will go through steps for patching database target ***hr.subnet.vcn.oraclevcn.com***, a Container Database that is currently at 18.3.0.0.0 version. The goal is to patch this target to 18.10.0.0.0. As part of the patching exercise this Container Database and all Pluggable Databases in that Container Database will automatically get patched.

1.  Log on to Enterprise Manager Console and review the status and version of DB Target.

    ![](images/ec0b6926d4f65b52a771483ace24055c.png " ")

    ![](images/c064eebf1a17dfd14d9c5921a88f93cb.jpg " ")

    You will see ***hr.subnet.vcn.oraclevcn.com*** Container Database has a pluggable database ‘HRPDB’. Both the Container Database and Pluggable database targets have status ‘UP’ and version 18.3.0.0.0. If target status is ‘DOWN’, start the target (using */home/oracle/start\_db\_hr.sh*).

## Task 4: Create Gold Image

1. Review reference home setup *[READ-ONLY– This step has already been implemented]*

    Gold Image represents a software end state. An Enterprise Manager Software Library Gold Image is a software archive created from a patched oracle home uploaded to EM Software Library.

    In order to create a Gold Image of the ‘recommended patch configuration’, you need to manually create such an Oracle Home as a pre-requisite step. As the goal is to patch Database 18.3 targets with Database 18.10 RU, a reference Oracle home fully patched to 18.10 *[/u01/app/oracle/product/18/db\_home\_src]* was created and used to create the initial version of the Gold Image as further described in the next steps..

    This patched reference Oracle Home is discovered in Enterprise Manager as shown below and will be used for Gold Image Creation.

2. Navigate to “***Targets >> All Targets***” and type in “*Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192*” in the “Search Target Name” box.

  ![](images/ea2416958193764cc47426f0ad8a0a67.jpg " ")

3. From the terminal on your remote desktop, Create the New Gold Image using the following emcli command

    ```
    <copy>cd fleet
    cat create_image_Tier2_sidb_x64.sh</copy>
    ```

    **OR**

    ```
    <copy>sh create_image_Tier2_sidb_x64.sh</copy>
    ```
    ![](images/1791b5df10396b908e81340d2c6abed4.png " ")

4. Click on ***Enterprise >> Provisioning and Patching >> Procedure Activity*** to review Execution details of this operation via Enterprise Manager Console

    ![](images/e9091a9e1e04a1a988cb61d9171a483d.png " ")

5. Click on ‘CreateGoldImageProfile\_...’ run and review the steps performed.  

    ![](images/f30e3920a7a7e18e4bdfffa328e9d483.png " ")

6. Use ‘Show’ filter ‘Steps Not Skipped’ ; View:‘Expand All’ for detailed view of all the steps performed to complete an operation.

    ![](images/c3d174049d514ac6c22ce65167d55776.png " ")

7. List Available Gold Images. Execute the following commands in the terminal to see the list of Gold Images available for deployment, locate ‘Tier \#2 SI DB Linux64*’* in the emcli command output:

    ```
    <copy>emcli db_software_maintenance -getImages</copy>
    ```

    ![](images/979c7a2ab44a65b0a6faf911cac1b64a.png " ")

    IMAGE ID retrieved from the output of above command is used in further operations like Target Subscription.

    After retrieving a list of the available images, one can view a list of versions available for a specific image with the following command:

    ```
    <copy>emcli db_software_maintenance -getVersions -image_id={Insert IMAGE ID from List available gold images}</copy>
    ```   

    This command lists Gold Image versions with their VERSION ID and STATUS.

    ![](images/a9b1233fb416f91b34518744dc0d7e9a.png " ")

    When a Gold Image is created for the first time, its first version is created as per the input and marked as current. Whenever we run a DEPLOY operation for a target, Gold Image version marked as CURRENT is used to deploy the new Oracle Home.

8.  Verify if Gold Image is Applicable

    This step verifies if the image can be used to patch a specified database target. This is done by comparing the bug fixes available in the current Oracle home of the database target and the image. In effect this check is run to identify patch conflicts.

    - Review and execute below emcli command:  
    ```
    <copy>emcli db_software_maintenance -checkApplicability -image_id={Insert IMAGE ID from List available gold images} -target_list=hr.subnet.vcn.oraclevcn.com -target_type=oracle_database > /home/oracle/applicability.out</copy>
    ```

    ```
    <copy>cat /home/oracle/applicability.out | more</copy>
    ```

    - Output of above emcli command is redirected to a file. You may review the output using any standard editor or tool of your choice.

    ![](images/5f050173735f58aabd279987996192ea.png " ")

    This command can show one of the following results:

    - Applicable: The image and database target contain the same set of bug fixes. The image can be applied on the specified target.
    - Applicable and Image has more bug fixes: The image contains more bug fixes than those applied on the database. The list of extra bugs is displayed. The image can be applied on the specified target.
    - Not Applicable: The database contains more bug fixes than those included in the image. The list of missing bugs is displayed. The administrator has to create a new version of the image that includes the missing bugs before the database can uptake the same.

## Task 5: Subscribe Database

1.  Review the flow on subscribing Targets to the Selected Gold Image

    ![](images/1168b19325ea9b9c0624cf404d0cb689.jpg " ")

2. Execute below command to subscribe the target hr.subnet.vcn.oraclevcn.com to Gold Image

    ```
    <copy>emcli db_software_maintenance -subscribeTarget -target_name=hr.subnet.vcn.oraclevcn.com -target_type=oracle_database -image_id={Insert IMAGE ID from List available gold images}</copy>
    ```

    Where:
   -  target\_name – Name of the Database target which needs to be patched
   -  target\_type – type of target to be patched. This should be oracle\_database in this case
   -  image\_id – ID of the Gold Image to which the target should be patched

    ![](images/ca94c4b76f9c24eee24f4d06b35c6764.png " ")

## Task 6: Deploy Image

1.  Navigate to ***Targets >> Databases***

    ![](images/2.png " ")

    and, then ***Administration >> Fleet Maintenance***

    ![](images/3.png " ")

2. In this page, we will select relevant ***Image Name***, ***Target Type*** and ***Operation***.

    ![](images/8.png " ")

    Where:
    -  Image = Desired version of Oracle home, which our target database should run after successful completion of operation. In this example, we will select ***Tier #2 SI DB Linux64***.
    -  Target Type = Desired target type, which can be Grid, RAC or SIDB. In this example, we will select ***Database Instance***.
    -  Operation = Name of the operation, which can be update (patch) or upgrade. In this example, we will select ***Update***.
    -  Type to filter = Selection criteria to highlight only those targets which qualify the selection, such as database naming.

3. In this page, we will provide ***new Oracle Home location***, select which ***tasks*** can be performed, select ***credential model***, provide ***log file location*** under options and select any   ***custom scripts*** to run as part of the operation.

    ![](images/9.png " ")

    In the above page, we have opted to ***Migrate Listener*** and ***Update Database*** by selecting the check box. This automatically takes care of Task 7 and Task 8 of the lab exercise. Deployment of new Oracle Home doesn't impact existing target and hence its scheduled to run immediately. We can schedule it to run at a later time by selecting later in start schedule and providing new time to run this operation.

    Once deployment of new Oracle Home is complete, we can change the schedule of the Deployment Procedure for migrate listener and update database to execute the tasks immediately.  

4. We can validate our entries (new Oracle Home, log file location, credentials) of previous page and validate the desired operation. Validation acts as a precheck before we submit the main operation.  There are two validation modes Quick and Full. We can select either of these. Full validation mode submits a deployment procedure.

      ![](images/11.png " ")

5. Review the validation result.

    ![](images/12.png " ")

    Incase of any error, we can fix it and choose revalidate.

6. ***Submit*** the operation. Here, we can see that we have opted to deploy, migrate and update the database at once. These tasks will be performed independently based on their schedule.

    ![](images/15.png " ")    

    We need to provide a name to the task, which will help us to view these tasks under Procedure Activity Page.

    ![](images/16.png " ")
    ![](images/17.png " ")

    Clicking on Monitor Progress will take us to Procedure Activity Page. Alternate navigation to review the submitted deployment procedures is ***Enterprise >> Provisioning and Patching >> Procedure Activity***

7. Review the Deployment Procedures.

    ![](images/18.png " ")

   Select deployment procedure(dp) related to Deploy and click on it. It will show details of the activity performed by the dp.

   ![](images/22.png " ")

   Here, we see that the dp has successfully installed new Oracle Home.(putty screen show the new oracle home layout)

## Task 7: Migrate Listener

1.  In the above task 6, we had submitted migrate listener already. If this needs to be submitted separately, then we had to uncheck migrate listener task ( review step 3 of previous task). As we have already submitted the dp to migrate listener, we can now change its schedule to run immediately. Navigate to  ***Enterprise >> Provisioning and Patching >> Procedure Activity*** and select migrate dp.
Click on reschedule.

  ![](images/24.png " ")

  In the new page, select immediately for start and reschedule.

  ![](images/25.png " ")

  We can now see that migrate operation is running. We can select it and see the various steps performed by it.

  ![](images/27.png " ")

  ![](images/28.png " ")

## Task 8: Update Database – Patch 18.3 to 18.10

1.  Similar to migrate listener, we had submitted Update Database in task 6. If this needs to be submitted separately, then we had to uncheck update database task ( review step 3 of task 6). As we have already submitted the dp to update database, we can now change its schedule to run immediately. Navigate to  ***Enterprise >> Provisioning and Patching >> Procedure Activity*** and select update.

    Click on reschedule.

   ![](images/29.png " ")

   In the new page, select immediately for start and reschedule.

   We can now see that update operation is running. We can select it and see the various steps performed by it.Here we can see that ***hr*** database is down for Oracle Home switch over. Now, ***hr*** database will run from new Oracle Home.

   ![](images/31.png " ")

   Update operation was completed successfully.

   ![](images/32.png " ")


## Task 9:  Rollback Database – Reversed Patch 18.10 to 18.3

Once the database is updated, we will perform a rollback to 18.3. Rollback operation is not supported by UI for EM 13.5 RU1 but it will be part of UI in upcoming release.

1. Review and execute below command from the terminal to rollback DB Target ***hr.subnet.vcn.oraclevcn.com***

    ```
    <copy>curl -i -X POST https://emcc.marketplace.com:7803/em/websvcs/restful/emws/db/fleetmaintenance/performOperation/rollback -H "Content-Type:application/json" -u sysman:welcome1 --data-binary "@/home/oracle/fleet/rollback_hr_payload.json" --insecure</copy>
    ```

    **OR**

    ```
    <copy>sh rollback_hr.sh</copy>
    ```

    ![](images/acb8ad0f4fb9ad39503081f5cdfb9e79.png " ")

2. Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘Fleet\_ROLLBACK\_...’ deployment procedure instance.

    ![](images/6999f44a0845085f3660f365bb24d7d3.png " ")

3. Review the Procedure Activity steps performed         

    ![](images/6a12674bdf0e9535535b90cf043a1605.png " ")

4. Verify the rolled back target by going to ***Targets >> Databases*** as shown
below.

    ![](images/7afa56b6cb5fee053c57b141a5c08245.png " ")

## Task 10:  Cleanup Old Homes

1. Clean up Database HR. Clean up operation is not supported by UI for EM 13.5 RU1 but it will be part of UI in upcoming release.

   In order to have an old empty home previously used by “***hr.subnet.vcn.oraclevcn.com***” at our disposal to demonstrate a cleanup operation, we will now re-update the database by running the commands from Step 8.

2. Review and execute below command to update DB Target ***hr.subnet.vcn.oraclevcn.com*** again to 18.10 version

    ```
    <copy>emcli db_software_maintenance -performOperation -name="Update DB" -purpose=UPDATE_DB -target_type=oracle_database -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -database_credential=sales_SYS:SYSMAN</copy>
    ```

    **OR**

    ```
    <copy>sh update_hr.sh</copy>
    ```

    ![](images/05dc434c461c068b157f9dd7cd6b10ce.png " ")

    Where:
      -  Name – Name of the operation. This is a logical name and should be kept unique Purpose – There are standard purposes defined which can be performed by Fleet Operations. “UPDATE\_DB” is one of them.


3. Verify that the update has been completed successfully before proceeding with any cleanup action, Same as done in step \#8, this should complete within 10\~15 minutes.

    ![](images/444749cbf21602a501446fe9c14b1949.png " ")

4. Verify and confirm that the target has been re-patched to 18.10 by going to Targets Databases as shown below

    ![](images/05d8c8153c8c990ac80810fef434baa3.png " ")

5. Review and execute the following command as a dry-run to report on cleanup impact for *hr.subnet.vcn.oraclevcn.com*  

    ```
    <copy>emcli db_software_maintenance -performOperation -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE -target_type=oracle_database -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -target_list=hr.subnet.vcn.oraclevcn.com -workDir=/tmp -reportOnly=true</copy>
    ```

    **OR**

    ```
    <copy>sh cleanup_hr_report.sh</copy>
    ```

    ![](images/9b5d405577571043afe9ead1fc723392.png " ")

6. Review and execute the following command to cleanup *hr.subnet.vcn.oraclevcn.com*   
    ```
    <copy>emcli db_software_maintenance -performOperation -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE -target_type=oracle_database -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -target_list=hr.subnet.vcn.oraclevcn.com -workDir=/tmp</copy>
    ```

    **OR**

    ```
    <copy>sh cleanup_hr.sh</copy>
    ```

    ![](images/f0443cb23cec56d4d3c3818720c73c80.png " ")

7. Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘CLEANUP\_SOFTWARE\_...’ deployment procedure instance.

    ![](images/1ffb1bc964b9ca980d6f6034d4882156.png " ")

8. Review the Procedure Activity steps performed        

    ![](images/c2062c09719c5c4b41ceff3138b3d44e.png " ")

9. Verify to confirm the old Oracle Home has been removed

    ```
    <copy>ls -l /u01/app/1806/hr</copy>
    ```

    ![](images/31324fdd072b03be848fa9362de9ae7b.png " ")

10.  As part of the cleanup operation, LISTENER\_1522 which support “***hr.subnet.oraclevcn.com***” is shutdown. Set your environment by passing “***hr***” to “***oraenv***” when prompted and start the listener back up.

    ```
    <copy>. oraenv </copy>
    ```

11. Start LISTENER\_1522 back up

      ```
      <copy>lsnrctl start LISTENER_1522</copy>
      ```

  ![](images/465b2cea9ae4e176c314eff253ef4b68.png " ")

12. Force Listener registration and confirm that it is now servicing “***hr.subnet.vcn.oraclevcn.com***”

    ```
    <copy>sqlplus '/as sysdba'<<EOF
    alter system register;
    EOF
    </copy>
    ```

13. Check status of LISTENER\_1522

    ```
    <copy>lsnrctl status LISTENER_1522</copy>
    ```

    ![](images/b95a982c86b233dfa1af34d29c03aa6e.png " ")

<!-- This completes Step 2. In this section, you learned how to perform the following:
-   Create Oracle Database Software Gold Image
-   Subscribe Database to Gold Image
-   Deploy Gold Image to Database Host
-   Migrate Oracle Database Listener from old Oracle Home to newly Deployed Oracle Home
-   Update (Patch) Database from 18.3 to 18.10
-   Rollback (Un-patch) Database from 18.10 to 18.3
-   Clean up old Oracle Homes -->

This completes this lab.

You may now [proceed to the next lab](#next).

## Learn More
  - [Oracle Enterprise Manager](https://www.oracle.com/enterprise-manager/)
  - [Oracle Enterprise Manager Fleet Maintenance](https://www.oracle.com/manageability/enterprise-manager/technologies/fleet-maintenance.html)
  - [Enterprise Manager Documentation Library](https://docs.oracle.com/en/enterprise-manager/index.html)
  - [Database Lifecycle Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/lifecycle.html)
  - [Database Cloud Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/cloud.html)

## Acknowledgements
  - **Authors**
    - Shefali Bhargava, Oracle Enterprise Manager Product Management
    - Rene Fontcha, LiveLabs Platform Lead, NA Technology
  - **Contributors** -
  - **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, July 2021
