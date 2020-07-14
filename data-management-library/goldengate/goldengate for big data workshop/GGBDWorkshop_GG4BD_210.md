# Lab 2 -  MySQL  -> MySQL unidirectional replication
updated July 69, 2020

![](images/200/image200_1.png)

## Before You Begin
For the Lab terminal session:

![](images/200/Lab2Menu.png)

### Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’



### Objectives
  

### Time to Complete
Approximately 30 minutes

### What Do You Need?
Your will need:

User and Password

User ID: ggadmin
Password: oracle

If already at a Unix prompt, you can access the Lab Menu by typing
su – ggadmin
Password = oracle
Execute the alias ‘labmenu’

The following Lab Menu will be displayed:
Select Option 2

## Lab 2
![](images/200/image201_1.png)

(If you are just starting the Labs, you don’t need to reset the environment).

Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.


The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to explain how GoldenGate is being configured.

Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

![](images/200/image2xx_1.png)

Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

![](images/200/image2xx_1.png)

Login to ggsci (GG command line interface), to create and start the GG extract, pump and replicat
processes:

![](images/200/image2xx_1.png)

Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt), and execute the following commands. (We’ve provided aliases to avoid errors, and focus on GoldenGate, rather than MySQL or Hadoop commands.)

![](images/200/image2xx_1.png)

![](images/200/image2xx_1.png)

At this point GoldenGate should have replicated all the data from database ggsource to database
ggtarget, for all 3 tables. The rows should match. Let’s confirm that from within GoldenGate. Go back to the session where you have ./ggsci running, and execute the following commands to see what data GG has processed:


![](images/200/image2xx_1.png)

The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.

![](images/200/image2xx_1.png)

![](images/200/image2xx_1.png)

In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local GG trail file. The pump process
‘pmpmysql’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ read the remote trail files, and applied the changes to the MySQL database ‘ggtarget’.


End of Lab 2.

## Ackknoledgements
- ** Authors ** - Brian Elliott, Zia Khan
- ** Contributors ** - Brian Elliott, Zia Khan
- ** Team ** - Data Integration Team
- ** Last Updated By ** - Brian Elliott, Zia Khan
- ** Expiration Date ** – July 2021


