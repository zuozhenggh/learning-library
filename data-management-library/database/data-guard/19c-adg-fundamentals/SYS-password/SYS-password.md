# Change the Passwords

## Introduction

In this lab, we will use the cloud interface to change the passwords.

In a cloud environment it is important to use the provided cloud tooling as much as possible. It is possible to maintain your own passwords, however this can break the automation in the cloud interface. 

This lab will show you how to correctly change the SYS password in a Data Guard environment.

Doing this right is important. When you change the SYS password in a Data Guard environment, Data Guard will propagate password changes for the SYS user to the standby database.

Estimated Lab Time: 5 Minutes

### Objectives
- Change the SYS password
- Log in to the database as the SYS user

### Prerequisites
- An Oracle LiveLabs, Free Tier or Paid Oracle Cloud account
- Lab: Connect to the Database
- Lab: Perform a switchover
- Lab: Perform a failover
- Lab: Enable Active Data Guard DML Redirection
- Lab: Automatic block media recovery
- Lab: Restore point propagation

## **STEP 1**: Change the SYS password

1. Navigate to the HOLDG primary database following 

    Overview
    -> Bare Metal, VM and Exadata
    -> DB Systems (choose ADGHOLAD1)
    -> DB System Details

2. At the bottom click on the HOLDG database.

    ![](./images/SYS-01.png)

3. Find the drop down which lists **More Actions** and click on **Manage Passwords**.

    ![](./images/SYS-02.png)

4. Enter the new SYS password. Keep in mind that the Password must be 9 to 30 characters and contain at least 2 uppercase, 2 lowercase, 2 special, and 2 numeric characters. The special characters must be _, #, or -.

    As the password for this lab, use: **WelC0me1##**

    And click **Apply**

    ![](./images/SYS-03.png)

## **STEP 2**: Verify 

1. Using SQL Developer, try to log in to the database as the SYS user. This will fail if you previously stored the password. The tool prompts you for the new password. 

    ![](./images/SYS-04.png)

2. When you specify the new password, the connection succeeds.

    ![](./images/SYS-05.png)


You have now successfully changed the SYS password. You may now [proceed to the next lab](#next).


## Acknowledgements

- **Author** - Pieter Van Puymbroeck, Product Manager Data Guard, Active Data Guard and Flashback Technologies
- **Contributors** - Robert Pastijn, Database Product Management
- **Last Updated By/Date** -  Kamryn Vinson, March 2021