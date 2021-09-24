# Oracle Database Vault on Autonomous DB

## Introduction
This workshop introduces the various features and functionality of Oracle Database Vault (DV). It gives the user an opportunity to learn how to configure those features in an Autonomous Database to prevent unauthorized privileged users from accessing sensitive data.

Managed database services run the risk of 'Admin snooping', allowing privileged users - and especially compromised privileged user accounts - access to sensitive data. Oracle Autonomous Database with DB Vault provides powerful security controls, restricting access to application data by privileged database users, reducing the risk of insider and outsider threats and addressing common compliance requirements.

You can deploy controls to block privileged account access to application data and control sensitive operations inside the database. Trusted paths can be used to add additional security controls to authorized data access and database changes. IP addresses, usernames, client program names and other factors can be used as part of Oracle Database Vault security controls to increase security. **Oracle Database Vault secures existing database environments transparently, eliminating costly and time consuming application changes.**

*Estimated Time:* 35 minutes

*Version tested in this lab:* Oracle Autonomous Database 19c

### Video Preview
Watch a preview of "*Oracle Database Vault Introduction (May 2021)*" [](youtube:vSVr7avZ4Hg)

### Objectives
- Enable Database Vault in an Autonomous Database
- Protect sensitive data using a Database Vault realm
- Create an audit policy to capture realm violations
- Test Database Vault Controls with Simulation mode

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed "Prepare Your Environment" step previously

### Lab Timing (estimated)
| Step No. | Feature | Approx. Time |
|--|------------------------------------------------------------|-------------|
| 1 | Enable Database Vault | <5 minutes |
| 2 | Enable Separation of Duties (SoD) | 5 minutes |
| 3 | Create a Simple Realm | 10 minutes |
| 4 | Audit Policy to Capture Realm Violations | 5 minutes |
| 5 | Simulation Mode | 10 minutes |
| 6 | Disable Database Vault | <5 minutes |

**Note: In this workshop, the Configure/Enable/Disable DV command syntax is only for Autonomous Database Shared. Other Oracle Database deployments, including Autonomous Database Dedicated, Exadata Cloud Service, Database Systems, and on-premises database, use a slightly different syntax.**

## Task 1: Enable Database Vault

Oracle Database vault comes pre-installed with your Autonomous database. In this lab we will enable Database Vault (DV), add required user accounts and create a DV realm to secure a set of user tables from privileged user access.

The `HR` schema contains multiple tables such as `CUSTOMERS` table which contain sensitive information and need to be protected from privileged users such as the schema owner (user `HR`) and DBA (user `ADMIN`). But the data in these tables should be available to the application user (user `APPUSER`).

   ![](./images/adb-dbv_001.png " ")

We start by creating two DV user accounts - Database Vault owner (`DV_OWNER`) and Database Vault account manager (`DV_ACCTMGR`). The `DV_OWNER` account is mandatory as an owner of DV objects. The `DV_ACCTMGR` account is an optional but recommended role. Once DV is enabled, it immediately begins enforcing separation of duties - the user `ADMIN` loses its ability to create/drop DB user accounts and that privilege is then with the DV account manager role. While DV Owner can also become DV account manager, Oracle recommends maintaining separation of duties via two different accounts.

1. Open a SQL Worksheet on your **ADB Security** as *admin* user
    
    - In OCI, select your ADB Security database created during the "Prepare Your Environment" step

       ![](./images/adb-dbv_002.png " ")

    - In your ADB Security database's details page, click the **Tools** tab

       ![](../prepare-setup/images/adb-set_010.png " ")

    - The Tools page provides you access to database administration and developer tools for Autonomous Database: Database Actions, Oracle Application Express, Oracle ML User Administration, and SODA Drivers. In the Database Actions box, click [**Open Database Actions**]

       ![](../prepare-setup/images/adb-set_011.png " ")

    - A sign-in page opens for Database Actions. For this lab, simply use your database instance's default administrator account (user *`admin`*) and click [**Next**]

       ![](../prepare-setup/images/adb-set_012.png " ")

    - Enter the admin Password you specified when creating the database (here *`WElcome_123#`*)
    
      ````
      <copy>WElcome_123#</copy>
      ````

    - Click [**Sign in**]

       ![](../prepare-setup/images/adb-set_013.png " ")

    - The Database Actions page opens. In the Development box, click [**SQL**]

       ![](../prepare-setup/images/adb-set_014.png " ")

2. Create the Database Vault owner and account manager users

      ````
      <copy>
      -- Create dbv_owner
      CREATE USER dbv_owner IDENTIFIED BY WElcome_123#;
      GRANT CREATE SESSION TO dbv_owner;
      GRANT DV_OWNER TO dbv_owner;
      GRANT DV_ADMIN TO dbv_owner;
      GRANT SELECT ANY DICTIONARY TO dbv_owner;
        
      -- Create dbv_acctmgr
      CREATE USER dbv_acctmgr IDENTIFIED BY WElcome_123#;
      GRANT CREATE SESSION TO dbv_acctmgr;
      GRANT DV_ACCTMGR TO dbv_acctmgr;
      GRANT AUDIT_ADMIN to dbv_acctmgr;

      -- Enable SQL Worksheet for the users just created
      BEGIN
         ORDS_ADMIN.ENABLE_SCHEMA(p_enabled => TRUE, p_schema => UPPER('dbv_owner'), p_url_mapping_type => 'BASE_PATH', p_url_mapping_pattern => LOWER('dbv_owner'), p_auto_rest_auth => TRUE);
         ORDS_ADMIN.ENABLE_SCHEMA(p_enabled => TRUE, p_schema => UPPER('dbv_acctmgr'), p_url_mapping_type => 'BASE_PATH', p_url_mapping_pattern => LOWER('dbv_acctmgr'), p_auto_rest_auth => TRUE);
      END;
      /
      </copy>
      ````

    **Note:**
       - Copy/Paste the following SQL queries into SQL Worksheet
       - Press [**F5**] or click on the "Run Scripts" icon
       - Check that there are no errors

       ![](./images/adb-dbv_003.png " ")

3. Configure the Database Vault user accounts

      ````
      <copy>EXEC DBMS_CLOUD_MACADM.CONFIGURE_DATABASE_VAULT('dbv_owner', 'dbv_acctmgr');</copy>
      ````

   ![](./images/adb-dbv_004.png " ")


4. Verify that Database Vault is configured but not yet enabled

      ````
      <copy>SELECT * FROM DBA_DV_STATUS;</copy>
      ````

   ![](./images/adb-dbv_005.png " ")

    **Note:** `DV_CONFIGURE_STATUS` must be **TRUE**

5. Now, enable Database Vault

      ````
      <copy>EXEC DBMS_CLOUD_MACADM.ENABLE_DATABASE_VAULT;</copy>
      ````

       ![](./images/adb-dbv_006.png " ")
    
6. You must “restart” the database to complete the Database Vault enabling process

    - Restart the database from the console by selecting "**Restart**" in "More Actions" drop-list as shown

       ![](./images/adb-dbv_007.png " ")

    - Once restart completes, log in to SQL Worksheet as *`ADMIN`* user and verify DV is enabled

      ````
      <copy>SELECT * FROM DBA_DV_STATUS;</copy>
      ````

       ![](./images/adb-dbv_008.png " ")

    **Note:** `DV_ENABLE_STATUS` should be **TRUE**

7. Now, Database Vault is enabled!

## Task 2: Enable Separation of Duties (SoD)

In Autonomous DB, the `ADMIN` user has all privileges, including the privileges required to administer Database Vault security policies. In some cases, you may wish to separate security administration, user administration, and database administration into different accounts.

In Task 1 you created two new users:
- `DBV_OWNER`, this user has the `DV_OWNER` and `DV_ADMIN` roles and can configure database vault policies
- `DBV_ACCTMGR`, this user has the `DV_ACCTMGR` role and can create users and change user passwords

In this lab we will remove the ability to create users, change user passwords, and configure database vault policies from the `ADMIN` user.

1. In order to demonstrate the effects of the SoD, it's important to execute the SQL queries from the 3 DB Vault users:

    - To proceed, **open SQL Worksheet in 3 web-browser pages** connected with a different user (*`ADMIN`*, *`DBV_OWNER`* and *`DBV_ACCTMGR`*) as shown in Task 1 previously
   
       **Note:**
          -  Attention, only one SQL Worksheet session can be open in a standard browser window at the same time, hence **open each of your sessions in a new browser window using the "Incognito mode"!**
          - As reminder, the password of these users is the same (here *`WElcome_123#`*)
    
             ````
             <copy>WElcome_123#</copy>
             ````

2. Go to the SQL Worksheet as the *`ADMIN`* user

3. View ADMIN's roles

      ````
      <copy>SELECT * FROM session_roles ORDER BY 1;</copy>
      ````

       ![](./images/adb-dbv_101.png " ")

    **Note:** Notice that ADMIN have several roles

4. Create a test user *`DEMO1`*

      ````
      <copy>CREATE USER demo1;</copy>
      ````

       ![](./images/adb-dbv_102.png " ")

    **Note:**
       - Notice that `ADMIN` is able to create a user, even with Database Vault enabled
       - This is because `ADMIN` has the DV_ACCTMGR role
                
5. Let's go to the SQL Worksheet as *`DBV_ACCTMGR`* and **revoke** `DV_ACCTMGR` **role from** `ADMIN` **user**

      ````
      <copy>revoke DV_ACCTMGR from ADMIN;</copy>
      ````

       ![](./images/adb-dbv_103.png " ")
                
6. And go to the SQL Worksheet as *`DBV_OWNER`* and **revoke** `DV_OWNER` **role from** `ADMIN` **user**

      ````
      <copy>
      revoke DV_OWNER from ADMIN;
      </copy>
      ````

       ![](./images/adb-dbv_104.png " ")
                
7. Now, go back the SQL Worksheet as *`ADMIN`* and check what happens

    - Create a second test user *`DEMO2`*

          ````
          <copy>
          CREATE USER demo2;
          </copy>
          ````

       ![](./images/adb-dbv_105.png " ")
                
       **Note:** Notice that this now fails!

    - Alter the user *`DEMO1`*

          ````
          <copy>
          ALTER USER demo1 IDENTIFIED BY WElcome_123#;
          </copy>
          ````

       ![](./images/adb-dbv_106.png " ")
                
       **Note:** `ADMIN` can no longer change a user's passwords!
                
8. As you continue with the lab, you will use `DBV_OWNER` and `DBV_ACCTMGR` for all database vault actions. The duties of database administration (done by `ADMIN`) are now separate from the duties of user administration (`DBV_ACCTMGR`) and security administration (`DBV_OWNER`)

## Task 3: Create a Simple Realm

Next we create a realm to secure the `HR.CUSTOMERS` table from access by `ADMIN` and `HR` (table owner) and grant access to `APPUSER` only.

A realm is a protected zone inside the database where database schemas, objects, and roles can be secured. For example, you can secure a set of schemas, objects, and roles that are related to accounting, sales, or human resources. After you have secured these into a realm, you can use the realm to control the use of system and object privileges by specific accounts or roles. This enables you to enforce context-sensitive access controls for anyone who wants to use these schemas, objects, and roles.

1. In order to demonstrate the effects of this realm, it's important to execute the same SQL query from these 3 users before and after creating the realm:
    - To proceed, **open SQL Worksheet in 3 web-browser pages** connected with a different user (*`ADMIN`*, *`HR`* and *`APPUSER`*) as shown in Task 1 previously
   
       **Note:**
          -  Attention, only one SQL Worksheet session can be open in a standard browser window at the same time, hence **open each of your sessions in a new browser window using the "Incognito mode"!**
          - As reminder, the password of these users is the same (here *`WElcome_123#`*)
    
             ````
             <copy>WElcome_123#</copy>
             ````

    - Copy/Paste and execute the following query

      ````
      <copy>
         SELECT cust_id, cust_first_name, cust_last_name, cust_email, cust_main_phone_number
           FROM hr.customers
          WHERE rownum < 10;
      </copy>
      ````
 
       - as user "**`ADMIN`**"

          ![](./images/adb-dbv_009.png " ")

       - as user "**`HR`**"

          ![](./images/adb-dbv_010.png " ")

       - as user "**`APPUSER`**"

          ![](./images/adb-dbv_011.png " ")

       **Note:**
          - **These 3 users can see the `HR.CUSTOMERS` table!**
          - `HR` because `HR` owns it
          -	`ADMIN` and `APPUSER` because they have the "`READ ANY TABLE`" system privilege

2. Now, let's create a realm to secure `HR` tables by executing this query below as *`DBV_OWNER`* user. So, please **open a 4th web-browser window using the "Incognito mode"!**

      ````
      <copy>
      -- Create the "PROTECT_HR" DV realm
         BEGIN
            DVSYS.DBMS_MACADM.CREATE_REALM(
                realm_name => 'PROTECT_HR'
                ,description => 'A mandatory realm to protect HR tables'
                ,enabled => DBMS_MACUTL.G_YES
                ,audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL
                ,realm_type => 1); 
         END;
         /

      -- Show the current DV realm
      SELECT name, description, enabled FROM dba_dv_realm WHERE id# >= 5000 ORDER BY 1;
      </copy>
      ````

       ![](./images/adb-dbv_012.png " ")
 
    **Note:**
       - Now the Realm `PROTECT_HR` is **created as mandatory and enabled**!
       - The difference between a **mandatory vs regular realm** is regular realms block system privileges (and allows direct object grants) while mandatory realms block direct object grants (even by the object owner) in addition to system privileges

3. Add objects to the realm to protect (here, the `CUSTOMERS` table)

      ````
      <copy>
      -- Set HR objects as protected by the DV realm "PROTECT_HR"
         BEGIN
             DVSYS.DBMS_MACADM.ADD_OBJECT_TO_REALM(
                 realm_name   => 'PROTECT_HR',
                 object_owner => 'HR',
                 object_name  => 'CUSTOMERS',
                 object_type  => 'TABLE');
         END;
         /

      -- Show the objects protected by the DV realm PROTECT_HR
      SELECT realm_name, owner, object_name, object_type
        FROM dvsys.dba_dv_realm_object
       WHERE realm_name IN (SELECT name FROM dvsys.dv$realm WHERE id# >= 5000);
      </copy>
      ````

   ![](./images/adb-dbv_013.png " ")

       **Note:** Now the table `CUSTOMERS` is protected and no one can access on it!

4. Check the effect of this realm
   
      - Execute again the following query in SQL Worsheet of each the 3 users (*`ADMIN`*, *`HR`* and *`APPUSER`*)

      ````
      <copy>
         SELECT cust_id, cust_first_name, cust_last_name, cust_email, cust_main_phone_number
           FROM hr.customers
          WHERE rownum < 10;
      </copy>
      ````
 
       - as user "**`ADMIN`**"

          ![](./images/adb-dbv_014.png " ")

       - as user "**`HR`**"

          ![](./images/adb-dbv_015.png " ")

       - as user "**`APPUSER`**"

          ![](./images/adb-dbv_016.png " ")

       - **Objects in the realm cannot be accessed by any database users**, including the DBA (`ADMIN`) and the schema owner (`HR`)!

5. Now, go back to SQL Worksheet as the *`DBV_OWNER`* user and make sure you have an authorized application user (`APPUSER`) in the realm by executing this query

      ````
      <copy>
      -- Grant access to APPUSER only for the DV realm "PROTECT_HR"
         BEGIN
             DVSYS.DBMS_MACADM.ADD_AUTH_TO_REALM(
                 realm_name   => 'PROTECT_HR',
                 grantee      => 'APPUSER');
         END;
         /
      </copy>
      ````

   ![](./images/adb-dbv_017.png " ")

6. Re-execute the SQL query to show that only `APPUSER` now can read the data

      ````
      <copy>
         SELECT cust_id, cust_first_name, cust_last_name, cust_email, cust_main_phone_number
           FROM hr.customers
          WHERE rownum < 10;
      </copy>
      ````
 
       - as user "**`ADMIN`**"

          ![](./images/adb-dbv_014.png " ")

       - as user "**`HR`**"

          ![](./images/adb-dbv_015.png " ")

       - as user "**`APPUSER`**"

          ![](./images/adb-dbv_011.png " ")

       - **`APPUSER` must be the only user who has access to the table from now!**

## Task 4: Create an Audit Policy to Capture Realm Violations

You may also want to capture an audit trail of unauthorized access attempts to your realm objects. Since the Autonomous Database includes Unified Auditing, we will create a policy to audit database vault activities

1. Open a SQL Worksheet as the *`DBV_ACCTMGR`* user - as reminder, the password is *`WElcome_123#`*
    
      ````
      <copy>WElcome_123#</copy>
      ````

2. Check that no audit trail log exists

      ````
      <copy>
      -- Display the audit trail log
      SELECT os_username, dbusername, event_timestamp, action_name, sql_text 
        FROM unified_audit_trail
       WHERE DV_ACTION_NAME='Realm Violation Audit' order by 3;
      </copy>
      ````

   ![](./images/adb-dbv_018.png " ")

    **Note:** The query should return no rows!

3. Create an audit policy on the DV realm `PROTECT_HR` created earlier in Step 2

      ````
      <copy>
      -- Create the Audit Policy
         CREATE AUDIT POLICY dv_realm_hr
            ACTIONS SELECT, UPDATE, DELETE
            ACTIONS COMPONENT=DV Realm Violation ON "PROTECT_HR";

      -- Enable the Audit Policy
         AUDIT POLICY dv_realm_hr;
      </copy>
      ````

   ![](./images/adb-dbv_019.png " ")


4. Like in Step 2, let's see the effects of the audit

    - To proceed, **re-execute the same SQL query in 3 different SQL Worksheet opened in 3 web-browser window** connected with a different user (*`ADMIN`*, *`HR`* and *`APPUSER`*)
   
       **Note:**
          -  Attention, only one SQL Worksheet session can be open in a standard browser window at the same time, hence **open each of your sessions in a new browser window using the "Incognito mode"!**
          - As a reminder, the password of these users is the same (here *`WElcome_123#`*)
    
             ````
             <copy>WElcome_123#</copy>
             ````

    - Copy/Paste and execute the following query

      ````
      <copy>
         SELECT cust_id, cust_first_name, cust_last_name, cust_email, cust_main_phone_number
           FROM hr.customers
          WHERE rownum < 10;
      </copy>
      ````
 
       - as user "**`ADMIN`**"

       ![](./images/adb-dbv_014.png " ")

       - as user "**`HR`**"

       ![](./images/adb-dbv_015.png " ")

       - as user "**`APPUSER`**"

       ![](./images/adb-dbv_011.png " ")

       - `ADMIN` **and** `HR` **users cannot access the** `HR.CUSTOMERS` **table and should generate an audit record of their failed attempt to violate policy!**

5. Go back to the SQL Worksheet as "*`DBV_ACCTMGR`*" to review realm violation audit trail 

      ````
      <copy>
      -- Display the audit trail log
      SELECT os_username, dbusername, event_timestamp, action_name, sql_text 
        FROM unified_audit_trail
       WHERE DV_ACTION_NAME='Realm Violation Audit' order by 3;
      </copy>
      ````

   ![](./images/adb-dbv_020.png " ")

    **Note:** You should see the `ADMIN` and `HR` failed attempts

6. When you have completed this lab, sign in as  as "*`DBV_OWNER`*" to reset the environment

      ````
      <copy>
      -- Show the current DV realm
      SELECT name, description, enabled FROM dba_dv_realm WHERE id# >= 5000 order by 1;

      -- Purge the DB Vault audit trail logs
      DELETE FROM DVSYS.AUDIT_TRAIL$;

      -- Purge the audit trail logs
      BEGIN
          DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL(
             audit_trail_type         =>  DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
             use_last_arch_timestamp  =>  FALSE);
      END;
      /

      -- Display the audit trail log
      SELECT os_username, dbusername, event_timestamp, action_name, sql_text 
        FROM unified_audit_trail
       WHERE DV_ACTION_NAME='Realm Violation Audit' order by 3;
       
      -- Disable the audit policy
      NOAUDIT POLICY dv_realm_hr;

      -- Drop the audit policy
      DROP AUDIT POLICY dv_realm_hr;
      
      -- Drop the "PROTECT_HR" DV realm
      BEGIN
          DVSYS.DBMS_MACADM.DELETE_REALM_CASCADE(realm_name => 'PROTECT_HR');
      END;
      /

      -- Show the current DV realm
      SELECT name, description, enabled FROM dba_dv_realm WHERE id# >= 5000 order by 1;

      </copy>
      ````

   ![](./images/adb-dbv_021.png " ")

7. Now, you have no longer audit policy and DV realm!

## Task 5: Simulation Mode

We will use simulation mode to find the factors to use for our "trusted path" connection to the `HR.EMPLOYEES` table. We will do that by completely disabling access to the table – but then put the realm policy into simulation mode. Since simulation mode won’t block the actual SQL commands – the SQL commands will work. However, if the SQL command should have been blocked by the new command rule – then it will create an entry in the simulation mode. Then you can review the simulation log to find if it captured the correct violations and the factors and associated rules.

1. Open a SQL Worksheet as *`DBV_OWNER`* user - as reminder, the password is *`WElcome_123#`*
    
      ````
      <copy>WElcome_123#</copy>
      ````

2. First, query the simulation log to show that it has no current values

      ````
      <copy>
         SELECT violation_type, username, machine, object_owner, object_name, command, dv$_module
         FROM dba_dv_simulation_log;
      </copy>
      ````

   ![](./images/adb-dbv_022.png " ")

3. Next, create a **Command Rule** that will simulate blocking all `SELECT` from the `HR.COUNTRIES` table

      ````
      <copy>
      BEGIN
          DBMS_MACADM.CREATE_COMMAND_RULE(
             command 	 => 'SELECT',
             rule_set_name   => 'Disabled',
             object_name       => 'COUNTRIES',
             object_owner       => 'HR',
             enabled         => DBMS_MACUTL.G_SIMULATION);
      END;
      /
      </copy>
      ````

   ![](./images/adb-dbv_023.png " ")

4. Like in Step 2, let's see now the effects of the simulation

    - To proceed, **re-execute the same SQL query in 3 different SQL Worksheet opened in 3 web-browser pages** connected with a different user (*`ADMIN`*, *`HR`* and *`APPUSER`*)
   
       **Note:**
          -  Attention, only one SQL Worksheet session can be open in a standard browser window at the same time, hence **open each of your sessions in a new browser window using the "Incognito mode"!**
          - As reminder, the password of these users is the same (here *`WElcome_123#`*)
    
             ````
             <copy>WElcome_123#</copy>
             ````

    - Copy/Paste and execute several time the following SELECT query to HR.COUNTRIES table

      ````
      <copy>
         SELECT * FROM hr.countries WHERE rownum < 20;
      </copy>
      ````
 
       - as user "**`ADMIN`**"

       ![](./images/adb-dbv_024.png " ")

       - as user "**`HR`**"

       ![](./images/adb-dbv_025.png " ")

       - as user "**`APPUSER`**"

       ![](./images/adb-dbv_026.png " ")

       - **All the users can access the** `HR.CUSTOMERS` **table!**
      
5. Now, go back to the SQL Worksheet as "*`DBV_OWNER`*" user to see what new entries we have. Remember we created a command rule to simulate blocking user select!

      ````
      <copy>
         SELECT violation_type, username, machine, object_owner, object_name, command, dv$_module
         FROM dba_dv_simulation_log;
      </copy>
      ````

   ![](./images/adb-dbv_027.png " ")

    **Note:**
      - Although each user can see the results, the log shows all users who selected and would have been blocked by the rule
      - It also shows where they connected from and what client they used to connect

6. Before moving to the next lab, we will clean out the simulation logs and remove the Command Rule

      ````
      <copy>
      -- Purge simulation logs
      DELETE FROM DVSYS.SIMULATION_LOG$;

      -- Current simulation logs after purging
      SELECT count(*) FROM dba_dv_simulation_log;
      </copy>
      ````

   ![](./images/adb-dbv_028.png " ")

      ````
      <copy>
      -- Delete the Command Rule
      BEGIN
          DBMS_MACADM.DELETE_COMMAND_RULE(
             command        => 'SELECT', 
             object_owner   => 'HR', 
             object_name    => 'COUNTRIES',
             scope          => DBMS_MACUTL.G_SCOPE_LOCAL);
      END;
      /
      </copy>
      ````

   ![](./images/adb-dbv_029.png " ")


## Task 6: Disable Database Vault

1. Log as "*`ADMIN`*" user and disable DB Vault on the Autonomous Database

      ````
      <copy>EXEC DBMS_CLOUD_MACADM.DISABLE_DATABASE_VAULT;</copy>
      ````

   ![](./images/adb-dbv_030.png " ")
    
2. You must restart the database to complete the Database Vault enabling process

    - Restart the database from the console by selecting "**Restart**" in "More Actions" drop-list as shown

       ![](./images/adb-dbv_007.png " ")

    - Once restart completes, log in to SQL Worksheet as *`ADMIN`* user and verify DV is enabled

      ````
      <copy>SELECT * FROM DBA_DV_STATUS;</copy>
      ````

       ![](./images/adb-dbv_031.png " ")

    **Note:** `DV_ENABLE_STATUS` must be **FALSE**

3. Now, because DB Vaut is disabled, you can drop the Database Vault owner and account manager users

      ````
      <copy>
      DROP USER dbv_owner;
      DROP USER dbv_acctmgr;
      </copy>
      ````

   ![](./images/adb-dbv_032.png " ")

4. Now, Database Vault is correctly disabled!

You may now [proceed to the next lab](#next).

## **Appendix**: About the Product
### **Overview**
Oracle Database Vault provides controls to prevent unauthorized privileged users from accessing sensitive data. It also prevents unauthorized database changes.

The Oracle Database Vault security controls protect application data from unauthorized access, and help you comply with privacy and regulatory requirements.

   ![](./images/dv-concept.png " ")

You can deploy controls to block privileged account access to application data and control sensitive operations inside the database with Database Vault.

Through the analysis of privileges and roles, you can increase the security of existing applications by using least-privilege best practices.

Oracle Database Vault secures existing database environments transparently, eliminating costly and time-consuming application changes.

Oracle Database Vault enables you to create a set of components to manage security for your database instance.

These components are:

- **Realms**

A realm is a protection zone inside the database where database schemas, objects, and roles can be secured. For example, you can secure a set of schemas, objects, and roles that are related to accounting, sales, or human resources.
After you have secured these into a realm, you can use the realm to control the use of system and object privileges to specific accounts or roles. This enables you to provide context-aware access controls for anyone who wants to use these schemas, objects, and roles.

- **Command rules**

A command rule is a special security policy that you can create to control under which conditions users can execute almost any SQL statement, including SELECT, ALTER SYSTEM, database definition language (DDL), and data manipulation language (DML) statements.
Command rules work with rule sets to determine whether the statement is allowed.

- **Factors**

A factor is a named variable or attribute, such as a user location, database IP address, or session user, which Oracle Database Vault can recognize and use to make access control decisions.
You use factors in rules to control activities such as authorizing database accounts to connect to the database or the execution of a specific database command to restrict the visibility and manageability of data.
Each factor can have one or more identities. An identity is the actual value of a factor.
A factor can have several identities depending on the factor retrieval method or its identity mapping logic.

- **Rule**

The rule within a rule set is a PL/SQL expression that evaluates to true or false. You can have the same rule in multiple rule sets.

- **Rule sets**

A rule set is a collection of one or more rules that you can associate with a realm authorization, command rule, factor assignment, or secure application role. The rule set evaluates to true or false based on the evaluation of each rule it contains and the evaluation type (All True or Any True).


- **Secure application roles**

A Database Vault secure application role is a special Oracle Database role that can be enabled based on the evaluation of an Oracle Database Vault rule set.

Oracle Database Vault provides a set of PL/SQL interfaces and packages that let you configure these components.
In general, the first step you take is to create a realm composed of the database schemas or database objects that you want to secure.
You can further secure your database by creating rules, rule sets, command rules, factors, identities, and secure application roles.
In addition, you can run reports on the activities these components monitor and protect.

### **Benefits of using Database Vault**
- Addresses compliance regulations to minimize access to data
- Protects data against misused or compromised privileged user accounts
- Design and enforce flexible security policies for your database
- Addresses Database consolidation and cloud environments concerns to reduce cost and reduce exposure sensitive application data by those without a true need-to-know
- Protect access to your sensitive data by creating a trusted path (see more by performing the [Full Database Vault lab](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=682&clear=180&session=4531599220675))

## Want to Learn More?
Technical Documentation:
  - [Oracle Database Vault 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/dvadm/introduction-to-oracle-database-vault.html#GUID-0C8AF1B2-6CE9-4408-BFB3-7B2C7F9E7284)

Video:
  - *Understanding Oracle Database Vault (March 2019)* [](youtube:oVidZw7yWIQ)
  - *Oracle Database Vault - Use Cases (Part1) (October 2019)* [](youtube:aW9YQT5IRmA)
  - *Oracle Database Vault - Use Cases (Part2) (November 2019)* [](youtube:hh-cX-ubCkY)

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Alan Williams, Rene Fontcha
- **Last Updated By/Date** - Hakim Loumi, Database Security PM - September 2021
