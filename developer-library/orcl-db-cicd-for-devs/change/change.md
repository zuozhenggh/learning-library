

Now issue the following git command:

> git checkout master

 

And look at the employees_table.xml again. You can see that the last column in this file is SUBMITION_DATE and no longer TREE_PICTURE.

         <COL_LIST_ITEM>
            <NAME>SUBMITION_DATE</NAME>
            <DATATYPE>TIMESTAMP</DATATYPE>
            <SCALE>6</SCALE>
         </COL_LIST_ITEM>
      </COL_LIST>

 

Why is that? It’s because you switched branches to the master branch where we have our baseline code. We have yet to merge this code into that main branch so the new column change only exists in our development branch. Let’s use this to our advantage. While on the master branch, start up SQLcl and login as the admin user:

> sql /nolog

SQL> set cloudconfig /Users/bspendol/Downloads/Wallet_ADB.zip

SQL> conn admin@ADB_high

 

And we will create a new schema

SQL> create user test identified by "PAssw0rd11##11" quota unlimited on data;

SQL> grant connect, resource to test;

SQL> conn test@ADB_high
Password? (**********?) **************
Connected.

 

We need to be in the database directory of our local project. We can use some of SQLcl built in functionality to get there if not already there. We can navigate directories with the cd command. If you are in the tables directory under the database directory, you can simply issue a:

SQL> host cd ..

 

And move up a directory into the database directory in our project home. We can also use the host command with SQLcl to see where we are:

SQL> host pwd
/Users/bspendol/git/db-cicd-project/database

 

Ensure you are in the /db-cicd-project/database directory where mine would be as above:
/Users/bspendol/git/db-cicd-project/database

You can also issue a host ls command to see the files in that directory:

SQL> host ls
controller.xml        index            table
database_files_here    procedure        trigger

 

we are looking to use the controller.xml file.

Quick checkpoint: We are logged into our database as the test user we just made, we are on the master code branch in the local repository and we are in the database directory in our project home. Once here, we are going to use Liquibase to create the objects from our master branch. Issue the following command:

SQL> lb update -changelog controller.xml

 

Once you issue this command, you will see all our objects being created in the database.

SQL> lb update -changelog controller.xml
ScriptRunner Executing: table/trees_table.xml::96726c6d630653c9a9169df8b67089f2cdee1135::(DEMO)-Generated -- DONE
ScriptRunner Executing:
procedure/admin_email_set_procedure.xml::9d1175a5b6ca6d0c969a2eb183062e0a873ee226::(DEMO)-Generated -- DONE
ScriptRunner Executing: index/tree_id_pk_index.xml::b4dd6c2359e7f1e881b55ba728056510d537967a::(DEMO)-Generated -- DONE
ScriptRunner Executing: trigger/set_date_bi_trigger.xml::3b0d8da4c19a11b80f035a748c9b40752f010110::(DEMO)-Generated -- DONE

######## ERROR SUMMARY ##################
Errors encountered:0

######## END ERROR SUMMARY ##################

 

Now, we can move to our development branch and apply that to this schema. Exit out of SQLcl:

SQL> exit

 

Change branches (remember your branch will be named different, unless you are a clone of me with the same name..if so email me please):

> git checkout sprint1_brian.spendolini
Switched to branch 'sprint1_brian.spendolini'
Your branch is up to date with 'origin/sprint1_brian.spendolini'.

 

And log back into the database as this test user:

> sql /nolog

SQL> set cloudconfig /Users/bspendol/Downloads/Wallet_ADB.zip

SQL> conn test@ADB_high

 

And now, using our development branch, we will apply the changes to this schema:

SQL> lb update -changelog controller.xml
ScriptRunner Executing: table/trees_table.xml::f81a149311b20a5a1dfe95a35108b8728df33b7f::(DEMO)-Generated -- DONE

######## ERROR SUMMARY ##################
Errors encountered:0

######## END ERROR SUMMARY ##################

 

There are 2 tables that Liquibase uses to track changes, DATABASECHANGELOG and DATABASECHANGELOG_ACTIONS. There is also a view that combines these tables for a more readable format, DATABASECHANGELOG_DETAILS. If we take a look at the DATABASECHANGELOG_DETAILS view, we can see that only an alter table was done and that the table was not dropped and recreated in the SQL column:

SQL
--------------------------------------------
ALTER TABLE "TREES" ADD ("TREE_PICTURE" BLOB)

 

This would be not only the behavior you would see in say a production instance, but more importantly the behavior you would expect a change management tool to be executing.

Merge Ahead

You now have the tools to start change management with SQLcl, Liquibase and a git repository for your development group or organization. As with all new processes, start slow. Maybe start with just getting everyone used to committing code to a central repository using git. But once we start adding these building blocks, we can continue down the CICD road to the next stages.

This process also allows you to start combining your database sprint code with stateless application code in the same repository setting the entire development team up for a CICD process. No longer are database developers and DBAs left out in the cold being called legacy when they can now uptake the same change management and repository practices that other development teams have enjoyed.

In part 2, we will be discussing the automated pipelines we should be using for testing this code; in essence, once a commit or merge request happens, we test the code on a new database.



## Acknowledgements

- **Authors** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Brian Spendolini, August 2021