![](media/rdwd-emheader.png) 

**DATABASE PERFORMANCE MANAGEMENT OF ON-PREMISES & ORACLE CLOUD INFRASTRUCTURE USER MANAGED SYSTEMS using Oracle Enterprise Manager** 
================================================================

The objective is to become familiar with on-premise and Oracle Cloud Database performance management (Virtual Machine/Bare Metal/Exadata Cloud Service) capabilities using Oracle Enterprise Manager Cloud. 

============================================================

### Contents





- **Activity 1:** Performance Hub

- **Activity 2:** Real-time database operation monitoring

- **Activity 3:** Tuning a SQL in a PDB

- **Activity 4:** SQL Performance Analyzer Optimizer Statistics

- **Activity 5:** Database Workload Replay (optional, time permitting)

Estimated time to complete all activities is 60 minutes.

| **No** | **Feature**                                   | **Approx. Time** | **Details**                                                                                                                                                                                                                    | **Value proposition**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|--------|-----------------------------------------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **1**  | Performance Hub                               | 15 minutes       | Oracle Enterprise Manager 13c includes a new Jet based unified Performance Hub Jet interface for performance monitoring.                                                                                           | Performance Hub is a single pane of glass view of database performance with access to Active Session History (ASH) Analytics, Real-time SQL Monitoring and SQL Tuning together. The time picker allows the administrator to switch between Real-Time and Historical views of database performance.                                                                                                                                                                                                                                                                      |
| **2**  | Real-time database operation monitoring       | 10 minutes       | Real-Time Database Operations Monitoring, introduced in Oracle Database 12c, enables an administrator to monitor long running database tasks as a composite business operation.                                                | Developers and DBAs can define business operations for monitoring by explicitly specifying the start and end of an operation or implicitly with tags that identify the operation.                                                                                                                                                                                                                                                                                                                                                                                              |
| **3**  | Tuning a SQL in a Pluggable Database (PDB)                         | 10 minutes       | In this activity see how a pluggable database administrator can tune queries in a PDB.                                                                                                                                        | The DBA for the PDB will not have access to the Container so their view is restricted to the queries running in the PDB assigned to them. This activity identifies a Top SQL in a PDB and then tune it using SQL Tuning Advisor.                                                                                                                                                                                                                                                                                                                                  |
| **4**  | SQL Performance Analyzer Optimizer Statistics | 10 minutes       | The objective of this activity is to demonstrate and use the SQL Performance Analyzer functionality of Real Application Testing capabilities in Oracle Enterprise Manager Cloud Control 13c with Oracle Database 18c. | SQL Performance Analyzer gathers Oracle Database Optimizer statistics for validation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| **5**  | Database Workload Replay                      | 10 minutes       | The objective of this activity is to is to demonstrate and use the Database Replay functionality of Real Application Testing capabilities in Oracle Enterprise Manager Cloud Control 13c and Oracle Database 18c.                | **Scenario:** You've been asked to add three new indexes for an application, but before adding, you want proof that database performance is improved. Use of SQL Performance Analyzer (SPA) isn't enough becuase there is also the cost of maintaining the indexes. Replay will be performed against the **Sales** Container Database and changes need to be performed in the OLTP Container against the **DWH_TEST** schema. The database version is 18c so the capture and replay are performed using a CDB. |


_____________________________________
### **Running your Workload**


Option 1:
1. Log into an Enterprise Manager VM (using provided IP). The Enterprise Manager credentials are “sysman/welcome1”.

2. From the upper left, navigate from **Enterprise** to **Job** to then **Library**
![](media/emjobnav.png)
3. Locate and select the job name **1-DB_LAB_START**, and Click the Submit  button.
![](media/emdbstartjob.png)

4. Then Click the Submit button in the upper right of your window.
![](media/emjobsubmitbutton.png)

5. The workload is now started and takes a few minutes to ramp up.
![](media/emjobcom.png)



Option 2:

- •	$ sudo su - oracle

- •	Change directory to scripts

- •	$ cd scripts

- •	Set the environment for the database by runnings

- •	$ source SALESENV

- •	Execute the script 1-db_lab_start.sh as shown below
![](media/emopt2start.jpg)

# *Database Performance Management*


<br>**Activity 1: Performance Hub**
======================================================================

1.  Log into an Enterprise Manager VM (using provided IP). The Enterprise Manager credentials are “sysman/welcome1”.



![](media/1876be1823ca17d9ab7e663e128859c4.jpg)

2.  **Click** on the Targets, then Databases. You will be directed to the list of
    Databases in EM.

![](media/9b88b0ba0cefae75a2374d91dcbd4e2e.jpg)


3. Here you will notice different databases listed, such as SALES, HR etc., we will work the sales container database. **Select** the Sales database from the list, this will take you to the DB home page
    for this database

![](media/95063e3082e730e54d957b9ff7575f49.jpg)



![](media/89801010273a62f99a3da10de8bf5c71.jpg)

4.  **Click** on the Containers tab. It is located at the upper right-hand corner of
    the page, underneath the Performance tile. This will show the list of
    pluggable databases in the CDB and their activity



![](media/c6bc11e91d6db9627a146b3e79d0ce19.jpg)



5.  Notice that the PSALES database is the busiest. We focus our attention to this
PDB. Let us now navigate to Performance Hub. **Select** Performance Hub from the Performance Menu and **Click** on ASH Analytics
    and use the sales_system credential name from the database login screen

![](media/e131e1ce965ab5bb248d5439529fc921.jpg)

![](media/d4ec276ea05aceb2ff86f5b7ea71c36e.jpg)


![](media/58e81976fa9957ee57f89139a06c4841.jpg)

6. Make sure to slide the time picker on an area of high usage (e.g., CPU, IO or
Waits). Notice how the corresponding selected time window also changes in the
summary section. You can also resize the slider to entirely cover the time period of your interest. 

    Notice the graph at bottom, it is providing more detailed view of the time window you selected. By Default the wait class dimension is selected. On the right hand side of the graph you have a list of wait classes for the time window you selected (blue for user I/O, green for CPU etc.). Notice how the color changes if you hover over either the menu or the graph to highlight the particular wait class. 
    
    Wait class isn’t the only dimension you can drill into the performance issue by. Let’s say you wanted to identify the SQL that was causing the biggest
performance impact. You can do that by **Clicking** the drop down list and changing
the top dimension from wait class to SQL ID.



7.  **Select** the SQL ID dimension from the list of available dimensions (Under Top
    Dimensions) using the dropdown box that is currently displaying Wait Class.
    Top Dimensions SQL ID

![](media/32b079f89c002058721d0c8a3e41f993.jpg)

8. **Hover** your mouse on top of the SQL (one at the bottom) and you will be able
to see how much activity is consumed by this SQL. Now using the same list of filters select the PDB dimension. Session
Identifiers PDB



![](media/95cce3b331aa85fc893b8eecc9a6c0a6.jpg)

9. What do you see? The chart changes to activity by the different pluggable databases created
in this Container database. **Click** on the ‘PSALES” pluggable database on the
list to add it to the filter by list and drilldown to activity by this PDB
on the same page.



![](media/384fdb12e234cbc0d60df1639079dc3e.jpg)

![](media/07dcb138dcb6773ee6b560681a62ec5f.jpg)

10.  **Click** on the SQL Monitoring Tab

![](media/6e47bf2703c3c1e4adffd39d2202045f.jpg)



11. You can see all the executed SQL during that time along with different
attributes like ‘user’,’Start’,’Ended’ etc. The test next to the \@ sign
indicates the name of the PDB. **Click** on any SQL of your choice (e.g.
6kd5jj7kr8swv)

![](media/533523dca8453a0ce246ac933fdb639c.jpg)

12. It will navigate you to show the details of this particular query. You can see
the plan, parallelism and activity of the query. “Plan Statistics” tab is
selected by default. You can see the plan of this query in graphical mode. In some cases, the Monitored SQL may have aged out and no rows are displayed, in
this case try using the time-picker and pick last 24 hrs. time period to
identify the historical SQL that was monitored. 

13. **Select** “Parallel” tab. This will give details about parallel coordinator and parallel slaves.

14. **Click** on the SQL Text tab. You can see the query text which got executed.

15. **Click** on the activity tab to understand about the activity breakdown for this SQL
    
16. **Click** on “Save” button on top right corner of the page. This will help you
    to save this monitored execution in “.html” format, which you can use it to
    share or to diagnose offline.


<br>**Activity 2: Real-Time Database Operations Monitorings**
======================================================================

**Start the Database Operation.**

The DBOP script is started through a job in Enterprise manager and includes content such as

-   Create Table SH2.CUSTOMER_NEW

-   Insert /\*+APPEND \*/ into SH2.CUSTOMER_NEW

-   Add Primary key to SH2.CUSTOMER_NEW

-   Create table SH2.CUSTOMER_TARGET

-   Merge into SH2.CUSTOMER_TARGET using SH2.CUSTOMER_NEW

-   PL/SQL block performing two SQL statements

-   Select statement on SH2.SALES

**Before any of these statements are executed then we tag the operation with**

    var eid number

    exec :eid := dbms_sql_monitor.begin_operation(dbop_name =\> 'DBOP_DEMO');

    **When the operation has ended we end the tagging with exec**

    dbms_sql_monitor.end_operation('DBOP_DEMO',:eid);

    **This makes it possible to monitor the complete operation as one unit in
    SQL monitoring**

**Now execute the Database Operation job**

1.  Go to Enterprise \> Job \> Library

    ![](media/af24a363db75caa6bd0139d955c65811.tiff)

2.  Select job RUN_DATABASE_OPERATIONS

    ![](media/32024d8b72b182d210c910445d286080.png)

3.  Click Submit button

    ![](media/f5b7c3cfc72e29b94f73337fb9891087.png)

4.  The workload has started.

    ![](media/b7205f571157879583d090af34c0f96f.png)

5.  Now go to the Sales database by select Targets \> Databases

    ![](media/216559c32d78ee5c8c291858da897c19.png)

6.  Right click on Sales database to take a shortcut directly to SQL Monitoring

    Hover over **Performance** then **Performance Hub** , Click on SQL Monitor

![](media/68245f38f9c9011a41eaa75ef0f3cbd1.png)

7.  Select the Monitored SQL tab.

    Review the list of currently executing SQLs are visible click on the
    DBOP_DEMO name. This will open the DBOP named DBOP_DEMO.

>   Note: You may need to scroll down or select “Database operations” from the
>   type dropdown

![https://github.com/oracle/learning-library/raw/master/enterprise-manageability-library/enterprise_manager/media/b10c056370e56dd1286ca1f556118c8f.jpg](media/b10c056370e56dd1286ca1f556118c8f.jpg)

8. Review the details of the Database Operations.

![https://github.com/oracle/learning-library/raw/master/enterprise-manageability-library/enterprise_manager/media/a59f28bdd1166978c41e9c9c6a5d9b93.jpg](media/a59f28bdd1166978c41e9c9c6a5d9b93.jpg)

9.  Click on the Activity tab. You will see all the activity for this operation.

![https://github.com/oracle/learning-library/raw/master/enterprise-manageability-library/enterprise_manager/media/1a32fbdd89e519c2b8401e7dd0626890.jpg](media/1a32fbdd89e519c2b8401e7dd0626890.jpg)





<br>**Activity 3: Tuning a SQL in a PDB**
======================================================================

1. Log into an Enterprise Manager VM (using provided IP). The Enterprise Manager credentials are “sysman/welcome1”.

![](media/8e45436e4fa48b9a5bda495da7b0a674.jpg)

2.  Once logged into Enterprise Manager, **Select** Targets, then Databases . **Click** on
    the expand icon on the left and click on the database
    **sales.subnet.vcn.oraclevcn.com**

![](media/63f4072fb3b311db561d2c284bc93ffe.png)

3.  You should now see the Database Home page.

![](media/611d814ca29dfc9f327a7c8159608093.jpg)

4.  From the Performance Menu **Click** on Performance Hub, then ASH Analytics.



![](media/ea10a67618855f3e0ce1a5f5c7157d71.jpg)

5.  In the bootm left of the page, **Click** on the activity bar for the SQL showing highest activity.

![](media/1530ad41444abf8120ba3a6bce8d9ba1.jpg)

6.  Now schedule the SQL Tuning Advisor by **Clicking** on the **Tune SQL** button.

![](media/4532cfdb72eeef8ade51f86d9974061e.jpg)

7.  Accept the default and **Submit** the SQL tuning Job.

![](media/528d1e6ee4c55f477811c554c2eeff99.jpg)

![](media/8aaa9d1d202302cd87c3870ffe51b956.png)

8.  Once the job completes. You should see the recommendations for either creating a profile or an index.

![](media/64e4e02ca8258d7c1fc54bec446b691a.png)

9.  Implement the SQL Profile recommendation. SQL Profiles are a great way of tuning a SQL without creating any new objects or making any code changes. 

10. At this point let’s now turn off the load: Change directory to scripts and execute the script *1-db_lab_stop.sh* as shown below

![](media/e032d591c5b1132ac156974c6abbe2f4.jpg)

>Alternatively you can use the Enterprise Manager Job Scheduler capability to stop the job.

11. Navigate to Enterprise, then Job, then to Library

![](media/emjoblibnav.png)

12. Select the job *1-DB_LAB_STOP*

![](media/emjoblabstop.png)

13. And then Submit the job

![](media/emlabstopsubmit.png)

14. When the job is completed, the workload stops

![](media/emlabstopped.png)

This concludes the Database Performance Management lab activity. You can now move on to Real Application Testing lab activity.


<br>**Activity 4: SQL Performance Analyzer Optimizer Statistics**
======================================================================

In this activity we need to configure the database to set up optimizer statistics to be stale. So the first step is to create and submit a job that will configure the statistics to be stale.

1.  Execute SPA task using optimizer statistics - Login using username and password **sysman/ welcome1**



![](media/6dc92e956b3d9cd7b140a588219ee285.jpg)

2.  Navigate to the Job library, from **Enterprise**, to **Job**, to **Library**

![](media/4037bd7209e67b936206da6f43991120.jpg)

3.  Select SPA_STAT_SETUP and **Click** the **Submit** button

![](media/emspasetup.png)

4. Select OS Command in the Create library Job drop down list **Click** Go

![](media/a04978f5e6e7d3e03d34685c7212f413.jpg)

5. **Click** the **Submit** button 

![](media/spasubmit.png)

6. The job then runs and completes

![](media/emspajobconfirm.png)

7. The job is now running. Continue with configuring SPA Quick Check. Navigate to Databases: from the menu, **Targets**, then **Databases**

![](media/baa21e15a952e1b090944051c919d47e.jpg)

8. Expand the sales.subnet.vcn.oraclevcn.com database. **Click** on “sales.subnet.vcn.oraclevcn.com_HR” pluggable database.

![](media/6273897d2614da4d3babab73299d5bc5.jpg)

9. In sales.subnet.vcn.oraclevcn.com_HR database Navigate to **Performance**, to **SQL**, to **SQL Performance Analyzer Quick Check Setup**

![](media/52d28e53edc6e12a26eefd6df1487d20.jpg)

10.  This is the page where you configure SPA Quick Check. Make sure that the selected SQL Tuning Set includes as many SQL statements as possible. If the application has specific workloads that are executed during End of Month, End of Year or even certain period during the day, then make sure to collect the workload in separate SQL Tuning Sets and merge them into a “Total Workload Tuning set”

11. In this example we are working with a SQL Tuning Set called PENDING_STATS_WKLD. Select: SQL Tuning Set: PENDING_STATS_WKLD. Select “Comparision Metric”: Buffer Gets **Click** Save.

![](media/dd8e59451bf9d2de14f07592d390da6a.jpg)

12.  Navigate To **Performance** , to **SQL** , to **Optimizer Statistics**

![](media/4e82b571a46f839223bca1f879643bb0.jpg)

13.  **Click** “Gather”

![](media/1e54f21d483e95189477069278b54053.jpg)

14.  Select “Schema”. Check “Validate the impact of statistics on…..” **Click**  “Next”

![](media/1d4b3ee3678078564de13336896fbe34.jpg)

15.  **Click**  “Add”

![](media/07c9dde006c7bc0a1fc804ef62f5cd5a.jpg)

16.  **Click**  “Search”. **Select:** STAT1, STAT2 **Click**  “OK”

![](media/5f8e1b0229f48747aa96998dbbe0aa87.jpg)

17.  **Click**  “Next”

![](media/47d4db96f2a225723e405f06171d2c7d.jpg)

18.  **Click**  “Next”

![](media/a4faddf1878e9f72df40f1bde4e54bdf.jpg)

19.  **Click**  “Submit”

![](media/d2c4f87d66682e3ecbb6b9c62e639281.jpg)

20. In the confirmation section on top, click on the SQL Performance Analyzer
    Task that was started. If you accidentally closed or lost this page, navigate to **DB Target** , then **Performance Menu** ,  then **SQL Performance Analyzer Home** , then **Select** the latest SPA task you just
created at the bottom of the page.

![](media/24fee673a5a32b19e55b92dae376c233.jpg)

21. You now have now a running SQL Performance Analyzer task. Wait until its Last
    Run Status is Completed. **Click**  on “Name”

![](media/d7b97d687f8d9a904ed2e7ee68f5da89.jpg)

22.  As you can see there have been four SQL trials executed. The first two have
    identified SQL statements with plan changes. In the last two trials it is
    only statements with plan changes that have been executed. This will reduce
    the amount of time and resources used in a production system. **Click** on the eyeglasses icon for the second report.

![](media/e74bda3508f98dbfb69f1e9e196d9c01.jpg)

23.  As we can see the majority of our statements had unchanged performance. We
    have a significant improvement but most important to notice is that we have
    no regression. If there had been regression then we have the ability to tune the regressed
statement or use SQL Plan Baselines to remediate the identified regressions.
Note you can also use SQL Tuning Advisor to remediate regressions by
implementing SQL Profile recommendations

![](media/2d5e94962e6a26f9d9442e09870cde04.jpg)



24.  Since this application has used stale statistics for a long period, then it would be good to have new statistics implemented. **Click** on “Publish Object Statistics”

![](media/bfd46716f39ec820e1c9c0c9982d5218.jpg)

25. We can now change statistics for all tables where we have pending
    statistics. For the scope of this exercise we will only change statistics
    for schema STAT1. **Click** the Checkbox for schema STAT1 **Click** Publish

![](media/1d3a02d5d46d720eefbe226143471f2c.jpg)

26. **Click** “Yes”

![](media/a8dc3af7bcf1c5b473e4f0037dd722a4.jpg)

![](media/e75f7e6b78aafd328d6b57f505245622.jpg)

You have now learned how to work with SPA. As you can see there are Guided Workflows that will help you during your analysis and verify that you can implement new changes in production with confidence.

Details about newly published statistics can be found if you navigate **Schema** , to **Database Object** , to **Tables** , and Select tables for schema ‘STAT1’

<br>**Activity 5: Database Workload Replay** 
======================================================================

We have already created a capture and we have created a Replay task where we have preprocessed the capture and created a draft replay to minimize input errors.

1. From the **Enterprise** menu, navigate to **Quality Management** then **Database Replay** 

    ![](media/cfff68203edd150c7b9293eb770e1691.png)

2.  Select the Tab Replay Task

3.  Click on **Workshop_REPLAY_BB1**

    ![](media/2f17a56eee2a6c3321799cc0747b852a.png)

4.  Select **BB_REPLAY_1** and click **Create Like**

    ![](media/db4b7e0a639c9cfba92cbfab724fd94c.png)

5.  Provide an unique replay name

    ![](media/6596242a12cffca093fed1f38df58902.png)

6.  Click on **Replay Workload**

    ![](media/8535707b3d8224edc8bfb9bbe3d97653.png)

7.  Since this is a Create Like it will remember all settings from previous
    replay. On this page we provide Oracle Database credentials and Oracle
    Database host credentials, then Click the **Next** button.

    ![](media/0e453f8f22b7564176981d873dc5e39e.png)

8.  This page contains information about the replay directory storage location,and directory object used. Click the **Next** button.

    ![](media/4a5ec458704bebc33c7039c0d4739cfa.png)

9.  The check validates we have been preprocessing against the same version we
    have been replaying against, but identifies it may not work on all versions
    due to changed behavior in the RDBMS code. So we will allow to override this
    check. In this case we have preprocessed against same Oracle Database so we
    know that versions are same. Preprocess reports 18.0 while database version
    is 18.3. Click the **OK** button.

    ![](media/64b5a3171c5a513896dc14bfbe294e8d.png)

10.  A new row appears with Ignore Preprocess warning and continue to check only
    major database version. Check the **Check** box and click the **Next** button.

    ![](media/945e4dd4f68429f39e1380bf4309f91f.png)

11.  The remap connection page allow us to remap any connections from the production connect string to the test connect string. From Enterprise Manager there are three different methods. Provide a single connect descriptor for all connections. Use a single TNS net service name or separate connect descriptors. In this case we have captured the workload from all PDB’s in a CDB and cannot use single connect descriptors. Each connect descriptor needs to be mapped to its own descriptor. Click the **Next** button.
![](media/eb111749b3668082f01706dca6bf7bc5.png)

12.  The replay option screen provides the ability to change characteristics of the replay. Enterprise Manager provides three synchronization modes for backward compatibilities. Object ID is deprecated and functionality has been incorporated into SCN synchronization. Off which is used for this replay, is for later release changed to Time. 
With Synchronization = Time each session tries to replay each call according to the timing it was captured. If there are delays if will just impact the delayed session. This may increase the divergence since some sessions may execute SQL/DML statements on data that has either been changed or not been changed by delayed sessions. Click the **OK** button.
![](media/5622fcdf25136254031e239742b34036.png)

13.  This is the page where we provide information about replay clients. Replay client are the drivers of the workload and consumes CPU, Memory and I/O. When replaying a production workload with several thousands of connections it is not uncommon to start 50 – 100 or even more replay clients. The calculation is that you can run 50 concurrent sessions on a replay client and you can start 4 replay clients/CPU thread so in reality if you have 1000 concurrent sessions then we will consume about 5 CPU threads in a system. We do not want to put this load on the database host since it will reduce the capacity for the database. Replay client should always be located on one or more separate servers. In this exercise we are limited to one server and will therefore start replay clients from same machine. Click the **Edit** tab.
![](media/f9981a1d763f7df29baa4dc48ff26539.png)


14.  Normal inputs are the hostname and host credentials, replay client Oracle Home directory, client replay directory (this is the path to the replay directory from where replay clients can find the replay files and connect descriptor for how replay clients access the database and login credentials to the database. Click the **OK** button.
![](media/4c079724ce5641755d1c8dee28898b6b.png)


15.  Click the **Next** button.
![](media/a262f4fab0faf98ffabe13f7c5997f40.png)

16.  Then click **Start Clients**
![](media/6a67a661334140caf044e321283b69a0.png)

17.  Wait until the popup box displays a *Completed Successfully* message, then
    click its **Close** button

18.  Click the **Next** button.
![](media/75976e71870bee08169de0e71f9ae6df.png)

19.  Review and click the **Submit** button.
![](media/d7c2e4aec6c40bebcfdd371101a4cc1c.png)

20.  The replay is now running and the progress can be viewed by refreshing the page. The data is only refreshed once a minute from the server so you don’t have to update the page too often. The replay will take about 12 minutes to finish and after there are a few background jobs that will generate the reports. From the **Replay** page we can see that the replay was successful and that the replay used less database time than the capture. This is promising and so it should be possible to implement the new indexes. Click on the **Reports** tab.
![](media/50202305daf3e58d1fc6c3c6625c27c6.png)

21.  There are several different reports that provide further details of the replay. The Database Replay Report provides similar information as the Replay home page you viewed, but this report can be distributed to stakeholders who doesn’t have access to Enterprise Manager.
![](media/36d60b9ddd7d1291d76385afd4169f0d.png)
![](media/932300976a4f6b71ccad72d4debdc456.png)

22.  The Compare Period Report Capture vs. Replay provides detailed information about the replay on how the database handles top SQL Statements and if there are any gains on using the new indexes. You can see that top queries improved from 1940 s of DBtime to 40 s of DBtime. 
![](media/b22fe0e617785101126d746dc1e2844c.png)
![](media/6ec795093b3c257b8ab7fcb0a49beab6.png)

Further familiarize yourself with the different reports including the AWR compare period report which provides a detailed analysis of waits, time models, operating system statics and SQL comparisons on different metrics to identify and pinpoint performance issues.

You have learned how Real Application Testing Database Replay can be used to validate changes that may impact performance on both SQL statements and DML statements and seen its reporting functionality that helps you find and analyze workload bottlenecks, peaks or trends.

That concludes this HOL activities.

>   [Return back to top menu listing all available labs](../readme.md)