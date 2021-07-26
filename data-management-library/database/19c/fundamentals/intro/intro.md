# Introduction

## About Oracle Database 19c

Oracle Database 19c provides the most advanced SQL engine on the planet. It complies with the latest ISO SQL standard, making it not only the most comprehensive database but also the most open one. It supports highly sophisticated analytics alongside and with no impact on OLTP workloads, eliminating the need to develop and orchestrate complex, fragile, and inconsistent data movement between different specialized data stores. Oracle’s SQL engine ships with integrated machine learning algorithms and allows developers to easily apply them on the data directly, hence moving the computation to the data—rather than having to pull the data out of the database and perform the calculation within the application. Using this capability, developers can create real-time prediction models directly on the data itself and act on insights more quickly and easily than ever before.

[](youtube:LcsPSJrZDrI)

Oracle Database 19c supports fully consistent data with ACID transaction guarantees and consistent queries. This greatly simplifies application development compared to NoSQL stores. Native JSON support makes up a cornerstone for flexible schema support and Internet of Things (IoT)workloads, enabling developers to simply load JSON documents into the database natively and analyze them later on, with the full power of Oracle SQL. Oracle’s PL/SQL engine is yet another powerful tool for bringing computations to the data and providing an easy and standardized interface to them via simple SQL function or procedure calls. Interfaces such as REST allow for easy communication and integration with Oracle Database. These can be created automatically on top of tables, as well as stored procedures, giving developers the flexibility on how and what data to expose to consuming services.

Extend this with the move to autonomy provided by Oracle Autonomous Database, a self-driving, self-securing, and self-repairing approach where the database itself decides on the steps to perform for the best of the user's workload or data. Machine learning algorithms are used to help the database to decide how to tune a workload, how to secure the data, and how to take countermeasures to preserve the agreed-on SLA levels.

With the Oracle Autonomous Database, developers can fully concentrate on the applications they write and the business’s requirements, rather than having to think about the data tier. And to make this even easier the Oracle Autonomous Database environment can be provisioned in minutes with a few simple clicks or an API call to the Oracle Cloud.

## About the Oracle Database 19c New Features Workshop

This workshop lets you try out many of the Oracle Database 19c new features, including general, security, performance, Big Data and Data Warehouse, and diagnose-ability enhancements. When you reserve this workshop in the LiveLabs tenancy, you are provided two Linux compute instances named `workshop-staged` and `workshop-installed`. One instance has the Oracle Database 19c installer files staged on it; the other has Oracle Database 19c already installed. Both compute instances have a noVNC desktop, which provides an easy-to-use interface.

To obtain your compute instances, you need to create SSH keys for yourself. When you reserve this workshop in the LiveLabs tenancy, you are asked to provide your public SSH key on the registration page. For help on generating SSH keys, see the lab called Generate SSH Keys. If you are working in your own tenancy, whether free or paid, you are guided through the steps to create the two compute instances using Resource Manager.

All labs are independent of each other, so you don't need to do them in any particular order.

## Labs

Currently, we have a set of labs that cover general database overall enhancements. Over time, more labs will be added to this workshop.

### General Database Overall Enhancements

The following labs cover general database overall enhancements in Oracle Database 19c:

- Install Oracle Database 19c with Automatic Root Script Execution
- Clone a PDB by Using DBCA in Silent Mode
- Relocate a PDB by Using DBCA in Silent Mode
- Duplicate a CDB by Using DBCA in Silent Mode
- Decrease the Transportable Tablespace (TTS) Import and Export Time
- Omit the Column Encryption Attribute During Import
- Use RMAN to Connect to a PDB to Use the Recovery Catalog
- Explore Automatic Deletion of Flashback Logs


## Cleaning Up PDBs at the beginning of each lab

The `workshop-installed` compute instance consists of three container databases (ORCL, CDB1, and CDB2). You only use CDB1 and CDB2 in this workshop. CDB1 contains one pluggable database (PDB1). CDB2 doesn't contain any pluggable database.

If you need to reset CDB1 back to its original state, you can run the `/home/oracle/labs/19cnf/cleanup_PDBs.sh` shell script. This script drops all PDBs that may have been created during the labs, and re-creates `PDB1` in CDB1. Enter the following command to run the script.

```nohighlighting
$ <copy>/home/oracle/labs/19cnf/cleanup_PDBs.sh</copy>
...
$
```

In case you need to recreate `CDB1` and `PDB1`, run the `/home/oracle/labs/19cnf/recreate_CDB1.sh` shell script.

```nohighlighting
$ <copy>/home/oracle/labs/19cnf/recreate_CDB1.sh</copy>
...
$
```

## Copying and pasting text

The instructions include a lot of code that you need to enter into a terminal window. Rather than enter the code manually, which often takes a long time and is prone to errors, you can copy and paste code from the workshop guide. There are several ways to do this.

If you copy text from an application on the compute instance itself, you can use the **Copy** and **Paste** options on the speed menu. You can also use **Ctrl+C** and **Ctrl+V**. Some instructions in the workshop guide may include a Copy button.

If you copy text from your local computer, then you need to use the clipboard utility on the compute instance to paste text into an application on the compute instance. Here is how you do it:

1. Copy text from your local machine.

2. On your compute instance, click the small grey arrow on the middle-left side of your screen to open the control bar.

    ![Small grey tab](images/small-grey-tab.png "Small grey tab")

3. On the control bar, click the **Clipboard** icon (5th button down).

    ![Clipboard](images/clipboard.png "Clipboard")

4. In the **Clipboard** dialog box, paste the copied text using **Ctrl+v** or the **Paste** option on your speed menu. The text is displayed in the Clipboard dialog box.

5. Position your cursor in the application where you want to paste the text, and click your middle mouse button.

> **Note**: The same method works in reverse. If you want to copy and paste text from your compute instance to your local computer, first paste the text into the **Clipboard** dialog box, and then copy and paste the text from it to your local computer.
