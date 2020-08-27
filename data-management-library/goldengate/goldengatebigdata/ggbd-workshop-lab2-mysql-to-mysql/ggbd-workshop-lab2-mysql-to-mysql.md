<<<<<<< HEAD
#  Lab 2 -  MySQL  -> MySQL unidirectional replication

## Introduction

=======
# Lab 2 -  MySQL  -> MySQL unidirectional replication
Aug 6, 2020

Lab Architecture

![](images/200/image200_1.png)

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md


### Introduction

=======
## Introduction
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa
This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

<<<<<<< HEAD
### Objectives
Replication from relational source to a relational target using GoldenGate

=======

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
### Time to Complete
Approximately 30 minutes

=======
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa
Lab Architecture

  ![](./images/image200_1.png)

Time to Complete -
Approximately 30 minutes

<<<<<<< HEAD
If at a terminal session:

User and Password
User ID: ggadmin
Password:  oracle

'>su – ggadmin
Password = oracle

or Execute the alias ‘labmenu’

The following Lab Menu will be displayed:
Select Option 2

## Steps


  ![](./images/a_labmenu2.png)


(If you are just starting the Labs, you don’t need to reset the environment).

1. Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.


2. The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator can review the content of each of these files to explain how GoldenGate is being configured.
=======
## Steps

1. If at a terminal session:

>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md
User and Password

User ID: ggadmin
Password: Data1Integration! or oracle

If already at a Unix prompt, you can access the Lab Menu by typing:

su – ggadmin
Password = Data1Integration! or oracle
Execute the alias ‘labmenu’

2. The following Lab Menu will be displayed:
Select Option 2

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
## Lab 2


![](images/ALL/A_LabMenu2.png)

=======
  ![](./images/a_labmenu2.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

(If you are just starting the Labs, you don’t need to reset the environment).

3. Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.


4. The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator can review the content of each of these files to explain how GoldenGate is being configured.
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa

view /u01/gg4mysql/dirprm/create_mysql_gg_procs.oby
view /u01/gg4mysql/dirprm/mgr.prm
view /u01/gg4mysql/dirprm/extmysql.prm
view /u01/gg4mysql/dirprm/pmpmysql.prm
view /u01/gg4mysql/dirprm/repmysql.prm

<<<<<<< HEAD
Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

3. Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

  ![](./images/a_2.png)
  ![](./images/a3.png)

4. Login to ggsci (GG command line interface), to create and start the GG extract, pump and replicat
processes:

  ![](./images/a4.png)

5. Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.

6. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt), and execute the following commands. (We’ve provided aliases to avoid errors, and focus on GoldenGate, rather than MySQL or Hadoop commands.)

   ![](./images/a5.png)
   ![](./images/a6.png)

7. At this point GoldenGate should have replicated all the data from database ggsource to database
ggtarget, for all 3 tables. The rows should match. Let’s confirm that from within GoldenGate. Go back to the session where you have ./ggsci running, and execute the following commands to see what data GG has processed:

    ![](./images/a7.png)

8. The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.

  ![](./images/a8.png)
  ![](./images/a9.png)

=======
5. Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
![](images/ALL/A_2.png)
![](images/ALL/A3.png)
=======
  ![](./images/a_2.png)
  ![](./images/a3.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

6. Login to ggsci (GG command line interface), to create and start the GG extract, pump and replicat
processes:

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
![](images/ALL/A4.png)

Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.
=======
  ![](./images/a4.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

7. Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
![](images/ALL/A5.png)

![](images/ALL/A6.png)
=======
8. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt), and execute the following commands. (We’ve provided aliases to avoid errors, and focus on GoldenGate, rather than MySQL or Hadoop commands.)

   ![](./images/a5.png)
   ![](./images/a6.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

9. At this point GoldenGate should have replicated all the data from database ggsource to database
ggtarget, for all 3 tables. The rows should match. Let’s confirm that from within GoldenGate. Go back to the session where you have ./ggsci running, and execute the following commands to see what data GG has processed:

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
![](images/ALL/A7.png)
=======
    ![](./images/a7.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

10. The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.

<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
![](images/ALL/A8.png)
![](images/ALL/A9.png)
=======
  ![](./images/a8.png)
  ![](./images/a9.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

![](images/200/image2xx_1.png)
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa

In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local GG trail file. The pump process
‘pmpmysql’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ read the remote trail files, and applied the changes to the MySQL database ‘ggtarget’.


End of Lab 2.

## Acknowledgements

<<<<<<< HEAD
=======
<<<<<<< HEAD:developer-library/goldengateforbigdata/golden-gate-for-big-data-workshop/GGBDWorkshop_GG4BD_210.md
 - ** Authors ** - Brian Elliott
 - ** Contributors ** - Brian Elliott
 - ** Team ** - Data Integration Team
 - ** Last Updated By ** - Brian Elliott
 - ** Expiration Date ** – July 2021
=======
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa
  * Authors ** - Brian Elliott, Data Integration
  * Contributors ** - Brian Elliott
  * Team ** - Data Integration Team
  * Last Updated By/Data ** - Brian Elliott, August 2020

## See an issue?
<<<<<<< HEAD

Please submit feedback using this link: [issues](https://github.com/oracle/learning-library/issues) 
  
  We review it regularly.
=======
>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa:data-management-library/goldengate/goldengatebigdata/ggbd-workshop-lab2-mysql-to-mysql/ggbd-workshop-lab2-mysql-to-mysql.md

>>>>>>> effbed5588b422109a348be92b8f51cbcddbeefa

