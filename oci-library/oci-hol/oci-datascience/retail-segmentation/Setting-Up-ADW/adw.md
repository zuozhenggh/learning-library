# Lab: Setting Up ADW

## Introduction

This guide shows you how to provision the Autonomous Data Warehouse service on the Oracle Cloud Console.


## Task 1: Provision ADW

1. In your Oracle CLoud Console, open the menu.

2. Select Oracle Database -> Autonomous Data Warehouse.

3. Click the Create Autonomous Database Button

4. Enter the correct information in the window.

- A display name and database name are optional but hopefully for visibility.
- For workload type, deployment type, and database configurations, default options are appropriate.
- Enter a password that you will remember for administrator credentials. This will be used later
- The Default Option for netwwork access is approrptiate.
- Choose the license type that suits you best.

5. Click Create Autonomous Database


## Task 2: Setting up Credentials

1. Once the Database is available, click the DB Connection to bring up a new page.

2. Click the Download Wallet button.
Wallet Type should be Instance Wallet.
This Wallet file will be used later.

3. Click the Tools option to move to the tools tab.

4. Click the Open Oracle ML User Administration Button.

We will be creating an account here to use later.

5. Enter your password to log in.

6. Click the "+ Create" button to create a new user. This will be used to access the ADW later.