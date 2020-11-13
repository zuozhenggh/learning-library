# Introduction

## About Oracle's Converged Database
The Oracle Database converges support for multiple data models and workloads into a single database, while supporting popular development tools and techniques like events and REST interfaces. As opposed to using multiple single purpose databases for each data type, using a converged database results in a `unified data tier`, enabling real-time analytics and machine learning on production data.

![](images/single-vs-converged.png " ")

You don't need to manage and maintain multiple systems or worry about having to provide unified security across them. To learn more, see this [blog](https://blogs.oracle.com/database/many-single-purpose-databases-versus-a-converged-database).

*Estimated Workshop Time:*  2.5 hours

You will also download Oracle SQL Developer to help execute the programs associated with the lab. We will use Docker containers and demonstrate multiple use cases with a Node.js application.

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
- Oracle SQL Developer client
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account

### Lab Overview

- **Lab: NODE.JS** -
    This lab walks you through the STEPS to start the Docker and Node.js Retail application. You will connect to a Node.js running in a Docker container on an Oracle Cloud Compute instance. While you can connect the Oracle Database instance using any client of your choice, in this lab you will connect using `Oracle SQL Developer`.

- **Lab: JSON** -
    This lab is setup into multiple steps.
    In the first step you will setup the environment for `JSON lab`. In this lab, you will connect using Oracle SQL Developer.
    The second step has already been completed but has been included for reference. This step creates the schema.
    The third step walks you through the steps of inserting and updating JSON data. We can use standard database APIs to insert or update JSON data. We can also work directly with JSON data contained in file-system files by creating an external table that exposes it to the database. You will add a row to our JSON table using insert query and then the Oracle SQL function `json_mergepatch` to update specific portions of a JSON document.
    The final section of this lab walks you through modules where we will see improvements in the simplicity of querying JSON documents using SQL. We will also see materialized views query rewriting has been enhanced so that queries with `JSON_EXISTS`, `JSON_VALUE `and other functions can utilize a materialized view created over a query that contains a `JSON_TABLE` function.

- **Lab: XML** -
    There are several steps within this lab.
    The first step walks you through the steps of setting up the environment for XML lab . You can connect Oracle Database instance using any client you wish. In this lab, you will connect using Oracle SQL Developer.
    The second step shows different ways to query XML data. XQuery is a very general and expressive language, and SQL/XML functions `XMLQuery`, `XMLTable`, `XMLExists`, and XMLCast combine that power of expression and computation with the strengths of SQL. We can query XMLType data, possibly decomposing the resulting XML into relational data using function XMLTable.
    The third set of steps you will get to insert and update XML contents. We can update XML content or replace either the entire contents of a document or only particular parts of a document. The ability to perform partial updates on XML documents is very powerful, particularly when we make small changes to large documents, as it can significantly reduce the amount of network traffic and disk input-output required to perform the update. The Oracle UPDATEXML function allows us to update XML content stored in Oracle Database.

- **Lab: Spatial** -
    This lab walks you through the steps of setting up the environment for Spatial lab. You can connect to the Oracle Database instance using any client of your choice. In this lab, you will connect using `Oracle SQL Developer`.

- **Lab: Graph** -
    This lab walks you through the steps of setting up the environment for property graph. You will then get to run queries and publish your graph. In the rest of the lab you will get a chance to use GraphViz and explore visualizing your graph.

- **Lab: Cross Data Types** -
    This lab will show you how to use cross data functions.
    - `JSON with Relational`
    - `XML with Relational`
    - `JSON with Spatial`

- **Lab: ORDS** -
    This lab walks you through the steps of creating RESTful Services for `JSON`, `XML` and `Spatial` data using Oracle REST data services. As part of this lab, `ORDS is pre-installed` and you will walk through the steps of rest enabling schema and its tables.
    Also later in the steps you will perform activities like `retrieving data`, `inserting data`, `updating  data` and `deleting data` using `GET`, `POST`, `PUT` and `DELETE` methods respectively.

*Please proceed to the first lab.*

## More Information
Feel free to share with your colleagues.

1. Blogs
      - [What is a converged database?](https://blogs.oracle.com/database/what-is-a-converged-database)
      - [Many single purpose database vs a converged database](https://blogs.oracle.com/database/many-single-purpose-databases-versus-a-converged-database)

## Acknowledgements
* **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
* **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K, Robert Ruppel, David Start, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, September 2020
  
## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
