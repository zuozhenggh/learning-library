# Workshop Introduction and Overview

The labs in this workshop, walk you through all the steps to get started using the Oracle Universal Installer (OUI) to install the Oracle Database software and create a single instance Oracle Database. You will also learn how you can use the Database Configuration Assistant (DBCA) to create additional databases.

There are two types of installation: container database and non-container database. Non-container database installations are currently deprecated.

The characteristics of the two types of installation are:
- Container databases allow you to implement a multi-tenant design by separating the system dictionary from the user dictionary. You can have several pluggable databases created in the same root container.
- Non-container databases store all system and user information in the same dictionary.

**Note**: The non-container architecture was deprecated in Oracle Database 12c. It is desupported in Oracle Database 21c. Oracle Universal Installer can no longer be used to create non-CDB Oracle Database instances.


### About Product/Technology

The Oracle Universal Installer (OUI) is a graphical user interface utility that enables you to install new Oracle Database software on your machine. During the installation process, you are given the opportunity to create a database. If you select database creation, OUI does installation of software first followed by automatic invocation of Oracle Database Configuration Assistant (DBCA) to guide you through the process of creating and configuring a database. If you choose to only install the database software using OUI, then you must run DBCA manually after the installation to create and configure the database.

In Oracle Database 12c Release 2 the concept of multitenant environment has been introduced. The multitenant architecture enables an Oracle database to function as a multitenant container database (CDB) that includes zero, one, or many customer-created Pluggable Databases (PDBs). A PDB is a portable collection of schemas, schema objects, and nonschema objects that appears to an Oracle Net client as a non-CDB. All Oracle databases before Oracle Database 12 were non-CDBs.

A CDB includes the following components:

* Root: The root, named CDB$ROOT, stores Oracle-supplied metadata and common users. An example of metadata is the source code for Oracle-supplied PL/SQL packages. A common user is a database user known in every container. A CDB has exactly one root.
* Seed: The seed, named PDB$SEED, is a template that you can use to create new PDBs. You cannot add objects to or modify objects in the seed. A CDB has exactly one seed.
* PDBs: A PDB appears to users and applications  as if it  were a non-CDB. For example, a PDB can contain the data and code required to support a specific application. A PDB is fully backward compatible with Oracle Database releases before Oracle Database 12c.
Each of these components is called a container. Therefore, the root is a container, the seed is a container, and each PDB is a container. Each container has a unique container ID and name within a CDB.


## Workshop Objectives

* Install Container Database
* Create a Container Database Using DBCA


## Lab Breakdown

    Lab 1: Perform Basic Installation for Container Database
    Lab 2: Perform Advanced Installation for Container Database
    Lab 3: Create a Container Database Using DBCA (Typical Mode)
    Lab 4: Create a Container Database Using DBCA (Advanced Mode)


After reading the following workshop prerequisites, get started by clicking Lab 1 in the Contents menu on the right.

## Workshop Prerequisites

Before installing the software, OUI performs several automated checks to ensure that your computer fulfills the basic hardware and software requirements for an Oracle Database installation. If your computer does not meet a requirement, then an error message is displayed. The requirements may vary depending upon the type of computer and operating system you are using, but include the following:

  * Minimum of 1 GB of physical memory
  * Sufficient paging space
  * Installation of appropriate service packages and/or patches
  * Use of appropriate file system format
  * Access to the Oracle Database 21c
  * General knowledge of product installation


## Want to Learn More About Oracle Database?

Use these links to get more information about OML and OCI:

* [Oracle Database Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/index.html)
* [Oracle Autonomous Database](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)


## Acknowledgements

* **Author**:

* **Last Updated By/Date**: Dimpi Sarmah, December 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.
