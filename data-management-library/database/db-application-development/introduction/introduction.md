# Introduction
 
This workshop shows you how to connect Node.js applications to Oracle Database using the node-oracledb module. This lets you quickly develop applications that execute SQL or PL/SQL statements. Your applications can also use Oracle's document storage SODA calls. Node-oracledb can be used with TypeScript or directly with Node.js. We will also connect a Python application to Oracle Database using the cx\_Oracle interface. This interface lets you quickly develop applications that execute SQL or PL/SQL statements. Your applications can also use Oracle's document storage SODA calls. The cx\_Oracle API conforms to the Python Database API v2.0 Specification with many additions and a couple of exclusions. 

Oracle provides enterprise application developers with an end\-to\-end Java solution for creating, deploying, and managing Java applications. The total solution consists of client-side and server\-side programmatic interfaces, tools to support Java development, and a JVM integrated with Oracle Database. All these products are fully compatible with Java standards. JDBC is a database access protocol that enables you to connect to a database and run SQL statements and queries to the database. The core Java class libraries provide the JDBC APIs: java.sql and javax.sql. However, JDBC  enables vendors to supply drivers that offer the necessary specialization for a particular database

### Multitenant Architecture for Database Consolidation

A container is either a PDB (pluggable database) or the root. The root container is a collection of schemas, schema objects, and nonschema objects to which all PDBs belong.

Every multitenant container database (CDB) has the following containers:

* Exactly one root: The root stores Oracle-supplied metadata and common users. An example of metadata is the source code for Oracle-supplied PL/SQL packages. A common user is a database user known in every container. The root container is named CDB$ROOT.

* Exactly one seed PDB: The seed PDB is a system-supplied template that the CDB can use to create new PDBs. The seed PDB is named PDB$SEED. You cannot add or modify objects in PDB$SEED.

* Zero or more user-created PDBs

A PDB is a user-created entity that contains the data and code required for a specific set of features. For example, a PDB can support a specific application, such as a human resources or sales application. No PDBs exist at creation of the CDB. You add PDBs based on your business requirements.

Database consolidation is the process of consolidating data from multiple databases into one database on one computer. Starting in Oracle Database 12c, the Oracle Multitenant option enables you to consolidate data and code without altering existing schemas or applications.

The PDB/non-CDB compatibility guarantee means that a PDB behaves the same as a non-CDB as seen from a client connecting with Oracle Net. The installation scheme for an application back end that runs against a non-CDB runs the same against a PDB and produces the same result. Also, the run-time behavior of client code that connects to the PDB containing the application back end is identical to the behavior of client code that connected to the non-CDB containing this back end.

Operations that act on an entire non-CDB act in the same way on an entire CDB, for example, when using Oracle Data Guard and database backup and recovery. Thus, the users, administrators, and developers of a non-CDB have substantially the same experience after the database has been consolidated.

The following figure depicts the databases after consolidation onto one computer. With one CDB administrator managing the CDB while two PDB administrators split management of the PDBs. different applications can be using the same or different PDBs.

![PDB and CDB](images/pdb.png "PDB and CDB") 

## About this Workshop

In this workshop, we will install, configure and code in NodeJS, Python and Java to establish a connection with Oracle Database and run SQL queries.

Estimated Time:  2 hours
 
### Objectives
 
The objective of this workshop is:

* Create a compute instance
* Create an oracle user
* Install noVNC Desktop
* Install Oracle Database 19c on Oracle Enterprise Linux Operating system
* Configure and Install additional tools such as SQL Developer, VSCode, JDK, Node JS to make it developer-friendly
* Configure SQL Developer to access CDB and PDB
* Run sample queries on HR Schema

### Prerequisites  
* Free or paid Oracle cloud account with administrative access
> **Note:** Currently, this workshop is not supported in an Always Free environment. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)**  
> **Note:** This workshop is available in free or paid environments only.

You may now *proceed to the next lab*.
 
## More information and References 

* [Oracle database 19c introduction and overview whitepaper ](https://www.oracle.com/a/tech/docs/database19c-wp.pdf)  

## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** - Kevin Lazarz, Senior Principal Product Manager, Database
* **Last Updated By/Date** -  Madhusudhan Rao, Apr 2022