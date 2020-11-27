# Enforcing Unified Audit Policies on the Current User

## Introduction
This lab shows how unified audit policies are enforced on the current user who executes the SQL statement.

### About Product/Technology
Until Oracle Database 21c, only the set operator UNION could be combined with ALL. Oracle Database 21c introduces two set operators, MINUS ALL (same as EXCEPT ALL) and INTERSECT ALL.

 ![Set Operators](images/set-operators.png "Set Operators")

- The 1st and 2nd statements use the EXCEPT operator to return only unique rows returned by the 1st query but not the 2nd.  
- The 3rd and 4th statements combine results from two queries using EXCEPT ALL reteruning only rows returned by the 1st query but not the 2nd even if not unique.
- The 5th and 6th statement combines results from 2 queries using INTERSECT ALL returning only unique rows returned by both queries.


Estimated Lab Time: XX minutes

### Objectives
In this lab, you will:
* Setup the environment
* Test the set operator with the EXCEPT clause
* Test the set operator with the EXCEPT ALL clause
* Test the set operator with the INTERSECT clause
* Test the set operator with the INTERSECT ALL clause

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Create an OCI VM Database
* Lab: 21c Setup


## Step 1 : Create the users and a procedure

- Connect to `PDB21` as `SYSTEM` and verify which predefined unified audit policies are implemented.

  
  ```
  
  $ <copy>cd /home/oracle/labs/M104781GC10</copy>
  
  $ <copy>/home/oracle/labs/M104781GC10/setup_audit_policies.sh</copy>
  
  ...
  
  Connected to:
  
  Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production
  
  Version 21.2.0.0.0
  
  SQL> drop user u1 cascade;
  
  drop user u1 cascade
  
            *
  
  ERROR at line 1:
  
  ORA-01918: user 'U1' does not exist
  
  SQL> drop user u2 cascade;
  
  drop user u2 cascade
  
            *
  
  ERROR at line 1:
  
  ORA-01918: user 'U2' does not exist
  
  SQL> create user u1 identified by password;
  
  User created.
  
  SQL> grant create session, create procedure to u1;
  
  Grant succeeded.
  
  SQL> create user u2 identified by password;
  
  User created.
  
  SQL> grant select on hr.employees to u1, u2;
  
  Grant succeeded.
  
  SQL> grant create session to u2;
  
  Grant succeeded.
  
  SQL> grant select on unified_audit_trail to u1,u2;
  
  Grant succeeded.
  
  SQL>
  
  SQL> CREATE OR REPLACE PROCEDURE u1.procemp (employee_id IN NUMBER)
  
    2  AS
  
    3     v_emp_id  NUMBER:=employee_id;
  
    4     v_sal NUMBER;
  
    5  BEGIN
  
    6     SELECT salary INTO v_sal FROM hr.employees WHERE employee_id=v_emp_id;
  
    7     dbms_output.put_line('Salary is : '||v_sal || ' for Employee ID: '||v_emp_id);
  
    8  END procemp;
  
    9  /
  
  Procedure created.
  
  SQL>
  
  SQL> grant execute on u1.procemp to u2;
  
  Grant succeeded.
  
  SQL>
  
  SQL> exit
  
  $
  
  ```

## Step 2 : Create and enable an audit policy 

- In `PDB21`, create and enable an audit policy so as to audit any query on `HR.EMPLOYEES` table executed by the login user `U2`.

  
  ```
  
  $ <copy>sqlplus system@PDB21</copy>
  
  Copyright (c) 1982, 2019, Oracle.  All rights reserved.
  
  Enter password: <i><copy>password</copy></i>
  
  Oracle Database 20c Enterprise Edition Release 21.0.0.0.0 - Production
  
  Version 21.2.0.0.0
  
  SQL> <copy>CREATE AUDIT POLICY pol_emp ACTIONS select on hr.employees;</copy>
  
  Audit policy created.
  
  SQL> <copy>AUDIT POLICY pol_emp BY u2;</copy>
  
  Audit succeeded.
  
  SQL> 
  
  ```

## Step 3 : Test

- Connect to `PDB21` as the user `U2` and execute the `U1.PROCEMP` procedure.

  
  ```
  
  SQL> <copy>CONNECT u2@PDB21</copy>
  
  Enter password: <i><copy>password</copy></i>
  
  SQL> <copy>SET SERVEROUTPUT ON</copy>
  
  SQL> <copy>EXECUTE u1.procemp(206)</copy>
  
  Salary is : 8300 for Employee ID: 206
  
  PL/SQL procedure successfully completed.
  
  SQL> 
  
  ```

- Display the `DBUSERNAME` (the login user) and the `CURRENT_USER` being the user who executed the procedure from the unified audit trail.

  
  ```
  
  SQL> <copy>SELECT dbusername, current_user, action_name
  
       FROM   unified_audit_trail
  
       WHERE  unified_audit_policies = 'POL_EMP';</copy>
  
  no rows selected
  
  SQL> <copy>EXIT</copy>
  
  $
  
  ```
  
  *Observe that the unified audit policy is enforced on the current user who executed the SQL statement, `U1`. Because only `U2` is audited and `U1` is the current user executing the query, there is no audit record generated that would give to the auditor the impression that the statement is executed by the user who owned the top-level user session.*
  
You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, Database Product Management

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
