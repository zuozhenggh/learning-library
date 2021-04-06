# Install the Oracle Database homes (working copies)

## Introduction
The main reason for starting using Oracle Fleet Patching and Provisioning is probably its ability to easily patch many databases with a single command.

In this Lab, we will provision two Oracle Homes, with different patch levels.

### In-place vs out-of-place patching
When it comes to patching the binaries, a common approach is **in-place patching**, where customers follow these macro-steps:
- Stage the latest `opatch` and patch bundle on the server (e.g. latest Realease Update)
- Stop the databases (downtime starts)
- Update `opatch`
- Apply the patch
- Restart the databases (downtime ends)
- Run `datapatch`

The downtime window must be large enough to accommodate the patching operation and its rollback in case of any problems.

**Our-of-place patching** is generally a better approach, that consists in the following steps:
- Prepare a new Oracle Home which contains the required patches
- Stop the databases (all, or one at he time)
- Restart the databases in the new Oracle Home
- Run `datapatch`

The downtime window can be scheduled separately for each database, because at any time, both Oracle Homes will be available. This gives more flexibility and allows an easier rollback (the previous Oracle Home is still there).
Customers do not always implement our-of-place patching because the new binaries preparation and installation require some additional steps before the patching campaign.

Fleet Patching and Provisioning takes this burden off by automating the Oracle Home provisioning for you, that's it, FPP use out-of-place patching, and helps you keeping your Oracle Homes under control, in a central and standardized way.

## Step 1: Provision the first workingcopy

From the FPP Server, verify that you have the images that you should have imported in the lab **Import Gold Images**.

```
[grid@fpps01 ~]$ rhpctl query image
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 10
Image name: gi_19_10_0_oci
Image name: db_19_10_0_oci
Image name: db_19_9_0
[grid@fpps01 ~]$
```

Then, provision the two images to the target.

First one, opc password is always `FPPll##123` unless you have changed it (Est. 8-9 minutes):

```
[grid@fpps01 ~]$ rhpctl add workingcopy -image db_19_9_0  -workingcopy WC_db_19_9_0_FPPC \
   -storagetype LOCAL -user oracle -oraclebase /u01/app/oracle \
   -targetnode fppc -path /u01/app/oracle/product/19.0.0.0/WC_db_19_9_0_FPPC \
   -sudouser opc -sudopath /bin/sudo ; date
Enter user "opc" password:
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 11
fpps01.pub.fpplivelab.oraclevcn.com: Storing metadata in repository for working copy "WC_db_19_9_0_FPPC" ...
fpps01.pub.fpplivelab.oraclevcn.com: Connecting to node fppc ...
fpps01.pub.fpplivelab.oraclevcn.com: Starting transfer for remote copy ...
fpps01.pub.fpplivelab.oraclevcn.com: Starting clone operation...
fpps01.pub.fpplivelab.oraclevcn.com: Using inventory file /etc/oraInst.loc to clone ...
fppc:
fppc:
fppc: [INFO] [INS-32183] Use of clone.pl is deprecated in this release. Clone operation is equivalent to performing a Software Only installation from the image.
fppc: You must use /u01/app/oracle/product/19.0.0.0/WC_db_19_9_0_FPPC/runInstaller script available to perform the Software Only install. For more details on image based installation, refer to help documentation.
fppc:
fppc: Starting Oracle Universal Installer...
fppc:
fppc: You can find the log of this install session at:
fppc:  /u01/app/oraInventory/logs/cloneActions2021-03-31_03-33-21PM.log
fppc: ..................................................   5% Done.
fppc: ..................................................   10% Done.
fppc: ..................................................   15% Done.
fppc: ..................................................   20% Done.
fppc: ..................................................   25% Done.
fppc: ..................................................   30% Done.
fppc: ..................................................   35% Done.
fppc: ..................................................   40% Done.
fppc: ..................................................   45% Done.
fppc: ..................................................   50% Done.
fppc: ..................................................   55% Done.
fppc: ..................................................   60% Done.
fppc: ..................................................   65% Done.
fppc: ..................................................   70% Done.
fppc: ..................................................   75% Done.
fppc: ..................................................   80% Done.
fppc: ..................................................   85% Done.
fppc: ..........
fppc: Copy files in progress.
fppc:
fppc: Copy files successful.
fppc:
fppc: Link binaries in progress.
fppc: ..........
fppc: Link binaries successful.
fppc:
fppc: Setup files in progress.
fppc: ..........
fppc: Setup files successful.
fppc:
fppc: Setup Inventory in progress.
fppc:
fppc: Setup Inventory successful.
fppc: ..........
fppc: Finish Setup successful.
fppc: The cloning of WC_db_19_9_0_FPPC was successful.
fppc: Please check '/u01/app/oraInventory/logs/cloneActions2021-03-31_03-33-21PM.log' for more details.
fppc:
fppc: Setup Oracle Base in progress.
fppc:
fppc: Setup Oracle Base successful.
fppc: ..................................................   95% Done.
fppc:
fppc: As a root user, execute the following script(s):
fppc:   1. /u01/app/oracle/product/19.0.0.0/WC_db_19_9_0_FPPC/root.sh
fppc:
fppc:
fppc:
fppc: ..................................................   100% Done.
fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed clone operation.
fpps01.pub.fpplivelab.oraclevcn.com: Executing root script on nodes fppc.
fppc: Check /u01/app/oracle/product/19.0.0.0/WC_db_19_9_0_FPPC/install/root_fppc_2021-03-31_15-36-00-066795642.log for the output of root script
fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed root script on nodes fppc.
fpps01.pub.fpplivelab.oraclevcn.com: Working copy creation completed.
[grid@fpps01 ~]$
```

Second one (Est. 8-9 minutes):
```
[grid@fpps01 ~]$ rhpctl add workingcopy -image db_19_10_0_oci -workingcopy WC_db_19_10_0_FPPC \
  -storagetype LOCAL -user oracle -oraclebase /u01/app/oracle   -targetnode fppc \
  -path /u01/app/oracle/product/19.0.0.0/WC_db_19_10_0_FPPC  \
   -sudouser opc -sudopath /bin/sudo

Enter user "opc" password:
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 12
fpps01.pub.fpplivelab.oraclevcn.com: Storing metadata in repository for working copy "WC_db_19_10_0_FPPC" ...
fpps01.pub.fpplivelab.oraclevcn.com: Connecting to node fppc ...
fpps01.pub.fpplivelab.oraclevcn.com: Starting transfer for remote copy ...
fpps01.pub.fpplivelab.oraclevcn.com: Starting clone operation...
fpps01.pub.fpplivelab.oraclevcn.com: Using inventory file /etc/oraInst.loc to clone ...
fppc:
fppc:
fppc: [INFO] [INS-32183] Use of clone.pl is deprecated in this release. Clone operation is equivalent to performing a Software Only installation from the image.
fppc: You must use /u01/app/oracle/product/19.0.0.0/WC_db_19_10_0_FPPC/runInstaller script available to perform the Software Only install. For more details on image based installation, refer to help documentation.
fppc:
fppc: Starting Oracle Universal Installer...
fppc:
fppc: You can find the log of this install session at:
fppc:  /u01/app/oraInventory/logs/cloneActions2021-03-31_03-53-02PM.log
fppc: ..................................................   5% Done.
fppc: ..................................................   10% Done.
fppc: ..................................................   15% Done.
fppc: ..................................................   20% Done.
fppc: ..................................................   25% Done.
fppc: ..................................................   30% Done.
fppc: ..................................................   35% Done.
fppc: ..................................................   40% Done.
fppc: ..................................................   45% Done.
fppc: ..................................................   50% Done.
fppc: ..................................................   55% Done.
fppc: ..................................................   60% Done.
fppc: ..................................................   65% Done.
fppc: ..................................................   70% Done.
fppc: ..................................................   75% Done.
fppc: ..................................................   80% Done.
fppc: ..................................................   85% Done.
fppc: ..........
fppc: Copy files in progress.
fppc:
fppc: Copy files successful.
fppc:
fppc: Link binaries in progress.
fppc: ..........
fppc: Link binaries successful.
fppc:
fppc: Setup files in progress.
fppc: ..........
fppc: Setup files successful.
fppc:
fppc: Setup Inventory in progress.
fppc:
fppc: Setup Inventory successful.
fppc: ..........
fppc: Finish Setup successful.
fppc: The cloning of WC_db_19_10_0_FPPC was successful.
fppc: Please check '/u01/app/oraInventory/logs/cloneActions2021-03-31_03-53-02PM.log' for more details.
fppc:
fppc: Setup Oracle Base in progress.
fppc:
fppc: Setup Oracle Base successful.
fppc: ..................................................   95% Done.
fppc:
fppc: As a root user, execute the following script(s):
fppc:   1. /u01/app/oracle/product/19.0.0.0/WC_db_19_10_0_FPPC/root.sh
fppc:
fppc:
fppc:
fppc: ..................................................   100% Done.
fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed clone operation.
fpps01.pub.fpplivelab.oraclevcn.com: Executing root script on nodes fppc.
fppc: Check /u01/app/oracle/product/19.0.0.0/WC_db_19_10_0_FPPC/install/root_fppc_2021-03-31_15-55-33-579124466.log for the output of root script
fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed root script on nodes fppc.
fpps01.pub.fpplivelab.oraclevcn.com: Working copy creation completed.
[grid@fpps01 ~]$
```

## Step 3: Verify the working copies
On the server:
```
[grid@fpps01 ~]$ rhpctl query workingcopy
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 16
Working copy name: WC_gi_19_10_0_FPPC
Working copy name: WC_db_19_9_0_FPPC
Working copy name: WC_db_19_10_0_FPPC
[grid@fpps01 ~]$
```
On the client:
```
[grid@fpps01 ~]$ ssh opc@fppc
opc@fppc's password:
Last login: Tue Apr  6 15:49:57 2021 from fpps01.pub.fpplivelab.oraclevcn.com
[opc@fppc ~]$ sudo su - oracle
Last login: Wed Mar 31 15:55:33 GMT 2021
[oracle@fppc ~]$
[oracle@fppc ~]$
[oracle@fppc ~]$ cat /u01/app/oraInventory/ContentsXML/inventory.xml
<?xml version="1.0" standalone="yes" ?>
<!-- Copyright (c) 1999, 2021, Oracle and/or its affiliates.
All rights reserved. -->
<!-- Do not modify the contents of this file by hand. -->
<INVENTORY>
<VERSION_INFO>
   <SAVED_WITH>12.2.0.7.0</SAVED_WITH>
   <MINIMUM_VER>2.1.0.6.0</MINIMUM_VER>
</VERSION_INFO>
<HOME_LIST>
<HOME NAME="WC_gi_19_10_0_FPPC" LOC="/u01/app/grid/WC_gi_19_10_0_FPPC" TYPE="O" IDX="1" CRS="true"/>
<HOME NAME="WC_db_19_9_0_FPPC" LOC="/u01/app/oracle/product/19.0.0.0/WC_db_19_9_0_FPPC" TYPE="O" IDX="2"/>
<HOME NAME="WC_db_19_10_0_FPPC" LOC="/u01/app/oracle/product/19.0.0.0/WC_db_19_10_0_FPPC" TYPE="O" IDX="3"/>
</HOME_LIST>
<COMPOSITEHOME_LIST>
</COMPOSITEHOME_LIST>
</INVENTORY>
[oracle@fppc ~]$
```

All the database homes are there! Now they are ready to run databases. You may now [proceed to the next lab](#next) and provision a database.
