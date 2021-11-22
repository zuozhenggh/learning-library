# Audit Direct User Activities

## Introduction
This 15-minute tutorial shows you how to audit top-level user activities in a database without collecting recursive user activity.

Before Oracle Database 19c, the audit policies records user activities including both directly issued events and recursive SQL statements.

In Oracle Database 19c, auditing can exclude recursive SQL statements. Top-level statements are SQL statements that users directly issue. These statements can be important for both security and compliance. SQL statements run from within PL/SQL procedures or functions are not considered top-level because they may be less relevant for auditing purposes.

Estimated Time: 15 minutes

### Objectives
1. Create The Table and The Procedure
2. Create and Enable The Audit Policy
3. Audit The User Activities Including Recursive Statements
4. Display the Activities Audited
5. Audit the Top-Level Statements Only
6. Display The Top-Level Activities Audited
7. Clean Up the Environment

### Prerequisites
- Oracle Database 19c installed
- A database, either non-CDB or CDB with a PDB
- The [create_proc.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-audit-top-level-user-activities/files/create_proc.sql) SQL script. Download the SQL script to the labs directory created on your server /home/oracle/labs

## Task 1: Create The Table and The Procedure
1. Execute the Oracle script $ORACLE_HOME/demo/schema/human_resource/hr_main.sql that creates the `HR` schema in `PDB1` in the tablespace `USERS`. The password in the command is the password for the `HR` schema.
```
<copy>sqlplus system@PDB1 @$ORACLE_HOME/demo/schema/human_resources/hr_main.sql password users temp /tmp </copy>
Enter password: password
```
2. Query the HR.EMPLOYEES table.
```
<copy>SELECT employee_id, salary FROM hr.employees; </copy>
```
Read the rows from the HR.EMPLOYEES table. Read the result from the [result1](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-audit-top-level-user-activities/files/result1.txt) text file.
3. Create a procedure that allows the HR user to raise the employees’ salaries in PDB1.
```
<copy>@/home/oracle/labs/create_proc.sql</copy>
```
Read the result from the [result2](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-audit-top-level-user-activities/files/result2.txt) text file.

## Task 2: Create and Enable The Audit Policy
1. Create the security officer. The security officer is the one responsible for managing audit policies.
```
<copy>CREATE USER auditor_admin IDENTIFIED BY password;</copy>
```
2. Grant the security officer the CREATE SESSION system privilege and the AUDIT_ADMIN role.
```
<copy>GRANT create session, audit_admin TO auditor_admin;</copy>
```
3. Connect to PDB1 as auditor_admin.
```
<copy>CONNECT auditor_admin@PDB1</copy>
Enter password: password
```
4. Create an audit policy that audits any salary increase.
```
<copy>CREATE AUDIT POLICY pol_sal_increase
                    ACTIONS UPDATE ON hr.employees;</copy>
```
5. Enable the audit policy.
```
<copy>AUDIT POLICY pol_sal_increase WHENEVER SUCCESSFUL;</copy>
```

## Task 3: Audit The User Activities Including Recursive Statements
1. In another session, session2, connect as HR and increase the salary for employee ID 106 through the RAISE_SALARY procedure.
```
<copy>sqlplus hr@PDB1</copy>
Enter password: password
```
```
<copy>EXEC emp_admin.raise_salary(106,10)</copy>
```
2. Still in session2, update the row directly and commit.
```
<copy>UPDATE hr.employees SET salary=salary*0.1
WHERE  employee_id = 106;</copy>
```
```
<copy>COMMIT;</copy>
```
3. Quit the session.
```
<copy>EXIT</copy>
```
## Task 4: Display the Activities Audited
1. Verify from session1 that the update actions executed through the PL/SQL procedure and directly by the UPDATE command are audited.
```
<copy>SELECT action_name, object_name, sql_text
     FROM   unified_audit_trail
     WHERE  unified_audit_policies = 'POL_SAL_INCREASE';</copy>
```
Read the result from the [result3](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-audit-top-level-user-activities/files/result3.txt) text file.
2. Disable the audit policy.
```
<copy>NOAUDIT POLICY pol_sal_increase;</copy>
```
3. Drop the audit policy.
```
<copy>DROP AUDIT POLICY pol_sal_increase;</copy>
```
## Task 5: Audit the Top-Level Statements Only
1. Create an audit policy that audits any salary increase executed directly with an UPDATE command only.
```
<copy>CREATE AUDIT POLICY pol_sal_increase_direct
                    ACTIONS UPDATE ON hr.employees ONLY TOPLEVEL;</copy>
```
2. Enable the audit policy.
```
<copy>AUDIT POLICY pol_sal_increase_direct WHENEVER SUCCESSFUL;</copy>
```
3. In session2, connect as HR to PDB1.
```
<copy>sqlplus hr@PDB1</copy>
Enter password: password
```
4. Increase the salary for employee ID 107 through the RAISE_SALARY procedure.
```
<copy>EXEC emp_admin.raise_salary(107,30)</copy>
```
5. Still in session2, update the row directly and commit.
```
<copy>UPDATE hr.employees SET salary=salary*0.1
WHERE  employee_id = 107;</copy>
```
```
<copy>COMMIT;</copy>
```
## Task 6: Display The Top-Level Activities Audited
1. Verify from session1 that the update actions executed through the PL/SQL procedure are not audited.
```
<copy>SELECT action_name, object_name, sql_text FROM unified_audit_trail
WHERE  unified_audit_policies = 'POL_SAL_INCREASE_DIRECT';</copy>

ACTION_NAME  OBJECT_NAME
------------ ------------
SQL_TEXT
---------------------------------------------------------
UPDATE       EMPLOYEES
UPDATE hr.employees SET salary=salary*0.1 WHERE employee_id = 107
```
Observe that only the direct UPDATE statement is audited as this is the purpose of the ONLY TOPLEVEL clause of the CREATE AUDIT POLICY command.

## Task 7: Clean Up the Environment
1. In session1, disable the audit policy.
```
<copy>NOAUDIT POLICY pol_sal_increase_direct;</copy>
```
2. Drop the audit policy.
```
<copy>DROP AUDIT POLICY pol_sal_increase_direct;</copy>
```
3. Connect as SYSTEM to PDB1.
```
<copy>CONNECT system@PDB1</copy>
Enter password: password
```
4. Drop the HR schema.
```
<copy>DROP USER hr CASCADE;</copy>
```
5. Drop the auditor_admin user.
```
<copy>DROP USER auditor_admin CASCADE;</copy>
```
6. Quit the session.
```
<copy>EXIT</copy>
```

## Acknowledgements
- **Last Updated By/Date** - Blake Hendricks, Austin Specialist Hub, November 12 2021
