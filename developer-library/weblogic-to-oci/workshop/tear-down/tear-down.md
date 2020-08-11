# Tearing down the workshop environment

## Introduction

Congratulations! You've come so far and completed the workshop, and you might wonder how to clean up resources.

Note:
You should not keep the instances deployed on OCI as part of this workshop running once your are done, or use in any way for actual workloads: since the DB and WebLogic credentials are publically available it would be a security issue.

## Step 1: Cleaning up the 'on-premises' environment

### If you used Docker

To stop the services:

<copy>
```bash
docker-compose stop
```
</copy>

to remove the containers, run:

<copy>
```bash
docker-compose rm
```
</copy>

### If you used the Workshop image from the marketplace

- Go to **Resources Manager**

- Select the **compartment** where you deployed the stack originally

- Click the stack name for the **Workshop on-premises environment**

  <img src="./images/stack.png"  width="50%">

- In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

- Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

- Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">

## Step 2: Tear down the WebLogic environment

- Go to the Resources Manager

- Click the stack name for the **WebLogic Server deployment**

- In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

- Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

- Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">

## Step 3: Tear down the database instance

- Go to the Bare Metal, VM and Exadata Menu

- Click the **Database System** to terminate

- Click **Terminate**
