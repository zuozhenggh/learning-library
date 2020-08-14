# Choose a Path

## Introduction

For this migration workshop, we need an environment to migrate *from*.

We're offering 2 ways to provision this environment:

- Using a demo Marketplace image for this workshop.
- Using locally on your development machine, using Docker

Estimated Lab Time:  5 minutes

### About the Paths
Both paths provide a pre-packaged 'on-premises' simulated environment which includes an Application Database and a WebLogic domain including 2 web applications and a datasource to connect to the database.

The Marketplace image deployment is simpler and faster, while the Docker environment provides a way to more realistically simulate an 'on-premises' environment as it runs on your local machine. 

Note that this is a demo environment pre-packaged with a WebLogic Domain, demo applications and a Database inside a single VM. This is for demo/training purpose only and is not production ready. The environment we will be migrating to on OCI is also provisioned through the Marketplace, but is a production-ready environment as one would migrate to from an on-premises production environment.

*When you are done with the workshop, you should tear down the 'on-premises' environment.*


## **Step**:  Make your selection

There are two ways to simulate the on-premises environment that you will be migrating from.  
1.  Choose one of the links below or the Lab 2 options in the menu.
    - [Using OCI Marketplace Image (10min)](?lab=lab-2-option-setup-on-premises-environment)
    - [Using Docker (25min)](?lab=lab-2-option-b-setup-local-(on-premises))

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Kay Malcolm, August 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.