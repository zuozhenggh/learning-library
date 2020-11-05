# Teardown Your JDE Environment

## Introduction
Now that the lab has been completed, we will use the OCI Console to destroy your JDE Trial Edition in order to make sure all resources are properly managed. 

Estimated Lab Time: 5 minutes


### Objectives
* Delete your JDE instance
* Destroy all associated OCI resources

### Prerequisites
* Tenancy Admin User
* Tenancy Admin Password

## **STEP 1:** Delete the JDE instance

To delete instances:

1)	If you are not already, sign in to OCI tenancy

    On the Oracle Cloud Infrastructure Console Home page, click the Navigation Menu   in the upper-left corner and hover over Compute then select Instances


2)	Navigate to your Compartment. Select the JDE trial instance in the list of Instances
 

    ![](./images/delete.png " ")

3)	Next click on More Actions. From there select Terminate to terminate the instance

    ![](./images/delete2.png " ")

4)	Wait for the instance to terminate. Once terminated your instance should be gone from the instance list
