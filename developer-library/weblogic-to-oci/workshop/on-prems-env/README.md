# Setup an 'on-premises' environment

## Introduction: 

For this migration workshop, we need an environment to migrate from.

We're offering 2 ways to provision this environment:

- Using a demo Marketplace image for this workshop.
- Using locally on your development machine, using Docker

Both paths provide a pre-packaged 'on-premises' simulated environment which includes an Application Database and a WebLogic domain including 2 web applications and a datasource to connect to the database.

The Marketplace image deployment is simpler and faster, while the Docker environment provides a way to more realistically simulate an 'on-premises' environment as it runs on your local machine. 

Note that this is a demo environment pre-packaged with a WebLogic Domain, demo applications and a Database inside a single VM. This is for demo/training purpose only and is not production ready. The environment we will be migrating to on OCI is also provisioned through the Marketplace, but is a production-ready environment as one would migrate to from an on-premises production environment.

*When you are done with the workshop, you should tear down the 'on-premises' environment.*

Choose one or the other:

- [On-premises environment using Marketplace image (10min)](?lab=lab-2-option-setup-on-premises-environment)
- [On-premises environment using Docker (25min)](?lab=lab-2-option-b-setup-local-(on-premises))
