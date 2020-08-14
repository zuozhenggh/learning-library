## Introduction
### About this Workshop

This workshop is part of Oracle Cloud Infrastructure's Move & Improve workshop series. This workshop will walk you through the process of migrating an existing on-premises WebLogic domain to WebLogic for Oracle Cloud Infrastructure. The WebLogic domain contains a couple Java applications and a datasource that we'll migrate without having to modify the underlying configuration. 

Attached below is a sample architecture of the final solution:
![](./images/Architecture.png)

Estimated Workshop Time:  3 hours

### Objectives

Perform the end-to-end migration of a local WebLogic domain to Oracle Cloud Infrastructure using provisioning with the OCI Marketplace.

- We'll start with a local WebLogic domain with an application backed by a local database, provisioned using Docker/docker-compose
- We'll prepare the OCI tenancy to provision WebLogic Server from the Marketplace, and perform the migration.
- We'll provision a new empty WebLogic domain on OCI with the Marketplace.
- We'll provision a database using the OCI DB as a service as the taregt to migrate the local application database.
- We'll migrate the local application database to the OCI DB as a service using DataPump, by backing up the local database schema, moving the files over to the DB provisioned on OCI and importing into it.
- Finally, we'll migrate the WebLogic domain using Weblogic Deploy Tooling (WDT). We'll discover the local domain, and after editing the model file to target the new domain, we'll update the new domain on OCI.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Kay Malcolm, August 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.