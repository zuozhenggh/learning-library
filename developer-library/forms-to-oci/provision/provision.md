# Title of the Lab

## Introduction

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Install the needed network to start Forms
* Install an Oracle Forms Server 
* Connect to it via SSH

### Prerequisites 

This lab assumes you have:
* Followed the previous lab

## Task 1: Install the Forms Server

Go to the Marketplace. 

1. In the Hamburger menu, look for Marketplace
2. In the search, look for Forms

   ![](./images/forms-marketplace-search.png)

3. Check "I have reviewed and accept the conditions". Then click **Launch Instance**

   ![](./images/forms-marketplace.png)

4. Enter the machine name, ex: **forms***

   ![](./images/forms-instance-name.png)

5. Then check that:
- VCN: **forms-vcn**
- Subnet: **Private subnet for forms-vcn**
- Change Upload the public key and upload the key that you got from the Bastion in Lab1 (##1##)
- Click Create

![](./images/forms-instance-network.png), 

5.. Get the Private IP

   ![](./images/forms-instance-private-ip.png)

Write it down. (##3##)

## Task 2: Start the Provisioning 

Let's provision the installation.

1. SSH to the Forms Server

Ideally, you should SSH to you Forms Server from your laptop.

There are several way to do this. We will use a Bastion

It is a lot easier on a day to day like to use a VPN or Fastconnect. 
But for our simple test here, we will stick to the Bastion.

```
ssh -J opc@&lt;bastion-ip&gt; opc@&lt;Forms Private IP&gt;

Ex:
ssh -J opc@130.131.132.133 opc@10.0.1.130
```

2. The provisioning will start

   ![](./images/forms-local-provision-start.png)

3. Enter the passwords. By example:
- Vnc Password: LiveLab1
- FMW Repository Schema password: LiveLab__123 
- WLS Admin password: LiveLab1
- Database System Password: LiveLab1

   ![](./images/forms-local-provision-password.png)

4.. Run the installation

   ![](./images/forms-local-provision-end.png)

Then wait that it is finished.

## Task 3: Port Forwarding

Since we use a Bastion, do not have direct access to the Forms machine. We will use port forwarding to access
the different ports of the installation.

```
With port forwarding:
ssh -i &lt;ssh-private-key&gt; -J opc@&lt;bastion-ip&gt; opc@&lt;Forms Private IP&gt; -L5901:localhost:5901 -L9001:0.0.0.0:9001 -L7001:0.0.0.0:7001

Ex:
ssh -i ssh-key-2022-03-21.key -J opc@130.131.132.133 opc@10.0.1.130 -L5901:localhost:5901 -L9001:0.0.0.0:9001 -L7001:0.0.0.0:7001
```

## Learn More

* [Forms on OCI](https://docs.oracle.com/en/middleware/developer-tools/forms/12.2.1.4/forms-oci/index.html)

## Acknowledgements
* Marc Gueury - Application Development EMEA
* Last Updated - March 2022
