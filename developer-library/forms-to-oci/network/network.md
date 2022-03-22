# Create the Virtual Cloud Network #

## Introduction

In this lab you will create a Virtual Cloud Network (VCN) and related network resources. A VCN is similar to your own on premise enterprise network.  In the Oracle Cloud, the network is software defined and virtual. This makes for very fast creation, but still providing high performance, and complete security. The architecture of your lab design follows.

Estimated Time: 10 minutes

### Objective

* Create virtual cloud network

### Prerequisites

* Laptop or desktop computer

* Web browser

* Account access to Oracle Cloud Infrastructure

* You will need an account that allows you to create a VCN, up to two cores of compute, and up to
  three cores of Autonomous Database.

* Always ensure you are in your correct Region and Compartment.


## Task 1: Create the VCN ##

In this step you will create a VCN with the quick start wizard. This will create all the related network resources including a public subnet, private subnet, internet gateway, NAT gateway, Service gateway, default security lists, and default route rules and table.

We are taking the quick option, but there is also a custom option to create resources individually.

1. Select your Region on the upper right of the OCI console

2. Select the cloud services hamburger menu on the top left corner and select Networking

    ![](./images/forms-hamburger-vcn.png)

3. Select Virtual Cloud Networks

4. Select your Compartment

5. Click Start VCN Wizard

  ![](./images/forms-vcn-start.png)

6. Enter a unique name for your VCN. Ex: **forms-vcn**

 ![](./images/forms-vcn-name.png)

7. Check the VCN CIDR block of 10.0.0.0/16.  Note: The CIDR Block is the range of IP addresses that can be used.

8. Click Next. 

  ![](./images/forms-vcn-create.png)

9. Then Create.

  ![](./images/forms-vcn-end.png)

  A summary is displayed. 

10. Click "View Virtual Cloud Network"

## Task 2: Security List for Database or Forms Builder on Windows (optional)   ##

In case that you will use separate Oracle Database Autonomous or VM. Open the port 1521-1522 
to allow Forms to access the database.

1. Click Security List

2. Choose the Security List Form Private Subnet-forms-vcn

   ![](./images/forms-private-seclist.png)

3. Add a rule for the Oracle Database listener. Click **Add Ingress Rule**

   ![](./images/forms-private-ingress-rule.png)

- In Source CIDR, type **10.0.0.0/16**
- In Destination port, **1521-1522**
- Then Click **Add Ingress Rules.**

4.. Add a rule for Remote Desktop. Click a second time **Add Ingress Rule**

   ![](./images/forms-private-ingress-rule-remote-desktop.png)

- In Source CIDR, type **10.0.0.0/16**
- In Destination port, **3389**
- Then Click **Add Ingress Rules.**

## Task 3: Install a Bastion   ##

1. In the Hamburger menu, choose **Compute / Instance**
2. Then Click **Create Instance**

   ![](./images/forms-instance.png)

3. In the name, type **bastion**

   ![](./images/forms-bastion-name.png)

4. In the network, check that :
- VCN: **forms-vcn**
- Subnet: **Public subnet for forms-vcn**
- Save the public and private SSH keys (##1##)
- Click Create
![](./images/forms-bastion-network-ssh.png)

5.. Get the Public IP

   ![](./images/forms-bastion-public-ip.png)

Write it down. (##2##)

## Acknowledgements ##

- **Author** - Marc Gueury - Application Development EMEA 
- March 2022
