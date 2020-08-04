# Setup Oracle Database 19c Compute Image - First time

## Introduction
This lab will show you how to manually setup a compute instance running Oracle Database 19c and accept the terms and conditions for the first time

Estimated Lab Time:  10 minutes

### Objectives
In this lab, you'll:
* Setup a compute instance running the DB19c 
* Login to your compute instance

### Prerequisites

This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account
- Lab: Generate SSH Keys
- Lab: Environment Setup - VCN Setup

## **STEP 1**: Create Compute Instance

The first time a compute instance running the Database 19c marketplace image is used in a tenancy, the [terms and conditions](https://cloudmarketplace.oracle.com/marketplace/content?contentId=18088784&render=inline) need to be accepted.  


1. Click on the hamburger menu.  Click on **Compute**-> **Instance**
   ![](./images/db19c-first-time-1.png " ")
   
2. Enter the name for your instance and choose your compartment.  Click on **Change Image** to select the image.  
   ![](./images/db19c-first-time-2.png " ")
3. Click on the **Oracle Images** tab.  Check **Database**
   ![](./images/db19c-first-time-3.png " ")
4. Click on the down arrow to expand the options. Select the Oracle 19c version.
   ![](./images/db19c-first-time-4.png " ")
5. Scroll down to accept the terms and conditions.  Click OK. 
   ![](./images/db19c-first-time-5.png " ")
6. Select one of the Availability Domains.  
   ![](./images/db19c-first-time-6.png " ")
7. Click the **Virtual Machine** instance type.  Select the **Specialty and Legacy** tab.  Select **VMStandard.E2.2**.
   ![](./images/db19c-first-time-7.png " ")
8. Select te Virtual Cloud Network you created in an earlier step.  The subnet should automatically be selected for you.  Accept all other defaults, especially *Assign a Public IP Address*
   ![](./images/db19c-first-time-8.png " ")
9. Paste the SSH Keys you created in the earlier lab.
    ![](./images/db19c-first-time-9.png " ")
10. Your instance will begin provisioning.  ![](./images/db19c-first-time-10.png " ")

You may now return to Step 5 of the Environment Setup lab to *Connect to your instance*.  To run any future Database 19c workshops, you will be able to use resource manager to create the instance.    

## Acknowledgements
- **Author** - Kay Malcolm, Director, DB Product Management
- **Last Updated By/Date** - Kay Malcolm, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *STEP* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.
