# Install Oracle Forms 

## Introduction

Estimated Time: 5 minutes

### Objectives

In this lab, you will:
* Install an Oracle Forms Server 

### Prerequisites 

This lab assumes you have:
* Followed the previous lab

## Task 1: Install the Forms Server

Go to the Marketplace. 

1. Go to the Oracle Cloud home page. In the Hamburger menu, look for **Marketplace**
2. In the search, look for **Forms**

   ![](./images/forms-marketplace-search.png)

3. Check "I have reviewed and accept the conditions". Then click **Launch Instance**

   ![](./images/forms-marketplace.png)

4. Enter the machine name, ex: **forms**

   ![](./images/forms-instance-name.png)

5. Then check that:
- VCN: **forms-vcn**
- Subnet: **Private subnet for forms-vcn**
- Check the button **Upload the public key** and upload the public key that you got from the Bastion in Lab1 (##1##)
- Click Create

![](./images/forms-instance-network.png), 

5.. Get the Private IP

   ![](./images/forms-instance-private-ip.png)

Write it down. (##3##)

## Task 2: Decide your next step

Here you have several choices. Install the Forms Server with
- a Local Database (database in the same VM than Forms)
- a Database Cloud Service (with automatic backup, easy dataguard setup ...)
- Autonomous database (not contained in this document)

  ![architecture](../introduction/images/forms-architecture.png)

Choose your next Lab accordingly.

## Learn More

* [Forms on OCI](https://docs.oracle.com/en/middleware/developer-tools/forms/12.2.1.4/forms-oci/index.html)

## Acknowledgements
* Marc Gueury - Application Development EMEA
* Last Updated - March 2022
