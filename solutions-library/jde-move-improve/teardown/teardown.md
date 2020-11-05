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

## **Step 1:** Delete the JDE instance

To delete instances:

1)	If you are not already, sign in to OCI tenancy

3)  On the Oracle Cloud Infrastructure Console Home page, click the Navigation Menu   in the upper-left corner and hover over Compute then select Instances


3)	Navigate to your Compartment. Select the JDE trial instance in the list of Instances
    ![](./images/delete.png " ")

4)	Next click on More Actions. From there select Terminate to terminate the instance
    ![](./images/delete2.png " ")

5)	Wait for the instance to terminate. Once terminated your instance should be gone from the instance list

## **Step 2:** Delete the Associated OCI Resources

To delete the Virtual Cloud Network:

1) On the Oracle Cloud Infrastructure Console homepage, click on the *Navigation Menu*   in the upper-left corner and hover over *Networking* then select *Virtual Cloud Network*
    ![](./images/VCNdelete1.png " ")

2) Under the list of Virtual Cloud Networks (VCN), click on the *Action* button on the right hand side and select *Terminate*.
    ![](./images/VCNdelete2.png " ")

3) Wait for the Virtual Cloud Network (VCN) to finish terminating and reload the page. The item should be removed from the list. 

**4) You're all set!**
    **:)**
