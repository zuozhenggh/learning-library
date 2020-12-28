# Introduction
This Lab walks you through the steps to create a new PL/SQL procedure. And also make a change to the table that is referenced in the procedure.

Estimated Lab Time: 10 minutes

## Background

As a database administrator (DBA), you may be asked to revalidate schema objects that have become invalid. Schema objects (such as triggers, procedures, or views) might be invalidated when changes are made to objects on which they depend.

### What Do You Need?

* Oracle Database 19c
* cr_add_po.sql file


## **STEP 1**: Validate Invalid Schema Objects

1. Download the `cr_add_po.sql` file.
2. Log in to SQL*Plus as the `SYSTEM` user. Alter the session and set container as pdb (orclpdb in this case).

    ```
    $ . oraenv
    ORACLE_SID = [oracle] ? orcl
    The Oracle base has been set to /scratch/u01/app/oracle
    ```

    ```
    $ sqlplus system

    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Jul 15 03:01:37 2019
    Version 19.3.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: Enter password here
    Last Successful login time: Mon Jul 15 2019 03:01:34 -07:00

    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0


    SQL>
    ```

    ```
    $ SQL>  alter session set container=orclpdb;

    Session altered.

    SQL>
    ```

3. Execute the cr_add_po.sql script to create a new PL/SQL procedure named APPUSER.ADD_PO_HISTORY. Exit from SQL*Plus.

    ```
    SQL> set echo on
    SQL> @/home/oracle/2daydba/cr_add_po
    SQL> --------------------------------------------------------
    --------------------------------------------------------
    SQL> --  File created - Monday-July-09-2012
    SQL> --------------------------------------------------------
    SQL> --------------------------------------------------------
    SQL> --  DDL for Procedure ADD_PO_HISTORY
    SQL> --------------------------------------------------------
    SQL> set define off;
    SQL>
    SQL>   CREATE OR REPLACE PROCEDURE "APPUSER"."ADD_PO_HISTORY"
      2    (  p_po_number          purchase_orders.po_number%type
      3     , p_po_description     purchase_orders.po_description%type
      4     , p_po_date            purchase_orders.po_date%type
      5     , p_po_vendor          purchase_orders.po_vendor%type
      6     , p_po_date_received   purchase_orders.po_date_received%type                                                                                                                                 
      7     )                                                                                                                                                                                            
      8  IS                                                                                                                                                                                              
      9  BEGIN                                                                                                                                                                                           
     10    INSERT INTO purchase_orders (po_number, po_description, po_date,                                                                                                                              
     11                             po_vendor, po_date_received)                                                                                                                                         
     12      VALUES(p_po_number, p_po_description, p_po_date,

    p_po_vendor, p_po_date_received);                                                                                                          
     13                                                                                                                                                                                                  
     14  END add_po_history;                                                                                                                                                                             
     15  
     16  /

    Procedure created.
    SQL>
    ```

4. Return to SQL Developer. Expand Procedures for the APPUSER user. Select your new ADD_PO_HISTORY procedure to view it in SQL Developer.

5. Expand Tables for the APPUSER user. Right-click the PURCHASE_ORDERS table and select Edit.
6. Select the PO_DESCRIPTION column. Change the value of Size to 250. Click OK.

7. In the Reports pane, expand Data Dictionary Reports. Expand All Objects and select Invalid Objects.

8. In the Select Connection dialog box, click the green plus sign to create a new connection.

9. Enter appuser in the Connection Name and Username field. Enter the password for appuser. Select the Service name radio button and enter orclpdb.us.oracle.com in the Service name field. Click Connect.

10. In the Select Connection window, verify that the Connection is set to appuser and click OK.
11. Click Apply in the Enter Bind Values window.

12. The Invalid Objects tab appears in the object pane. Note that the ADD_PO_HISTORY procedure is now invalid.

13. In the Invalid Objects page, select the ADD_PO_HISTORY procedure. Right-click and select Compile.

14. The Compile window appears. Click Apply. You will receive a success message. Click OK.
15. Close the Invalid Objects tab. Select Invalid Objects again in the Reports pane. Connect as the APPUSER and reapply Bind Values. Because you recompiled ADD_PO_HISTORY, there are no longer any invalid objects.



## Acknowledgements
* **Last Updated By/Date** - Dimpi Sarmah, Senior UA Developer

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
