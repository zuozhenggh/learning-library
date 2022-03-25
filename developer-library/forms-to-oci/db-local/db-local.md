# Option 1: Local Database

## Introduction

Estimated Time: 15 minutes

### Objectives

In this lab, you will: 
- Install the database
- Run the forms configuration

### Prerequisites 

This lab assumes you have:
* Followed the previous lab

## Task 1:  Install a Local DB

Nothing to do, the Database is already installed in the same machine than Forms

## Task 2: Start Forms Configuration 

The Forms and Database should be started. Let's provision the installation.

1. SSH to the Forms Server

Ideally, you should SSH to you Forms Server from your laptop.

There are several way to do this. For this tutorial, we will use a Bastion.
But note that it is a lot easier on a day to day like to use a VPN or Fastconnect. 

```
# Add the key to ssh-agent
ssh-add &lt;ssh-private-key&gt;
# Connect via the bastion
ssh -J opc@&lt;bastion-ip&gt; opc@&lt;Forms Private IP&gt;

Ex:
ssh-add ssh-key-2022-03-21.key
ssh -J opc@130.131.132.133 opc@10.0.1.130
```

2. The provisioning will start. 

## Task 3: Forms Configuration with a Local DB

1. Choose Local Database: **1** 

![](./images/forms-local-provision-start.png)

2. Enter the passwords. By example:
- Vnc Password: **LiveLab1**
- FMW Repository Schema password: **LiveLab__123**
- WLS Admin password: **LiveLab1**
- Database System Password: **LiveLab__123**

![](./images/forms-local-provision-password.png)

3.. Run the installation

   ![](./images/forms-local-provision-end.png)

Wait that the installation finishes. It takes about 10 mins.

## Learn More

* [Forms on OCI](https://docs.oracle.com/en/middleware/developer-tools/forms/12.2.1.4/forms-oci/index.html)

## Acknowledgements
* Marc Gueury - Application Development EMEA
* Last Updated - March 2022
