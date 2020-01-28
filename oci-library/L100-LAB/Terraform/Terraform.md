# Terraform Lab

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Install Terraform](#install-terraform)

**Note:** *Some of the UIs might look a little different than the screen shots included in the instructions, but you can still use the instructions to complete the hands-on labs.*

## Overview

Terraform is a cloud-neutral scripting language. Here is an example of the types of cloud tasks that you can script using Terraform:

1. Create a single asset, like a compute instance or a load balancer
2. Create a fully defined solution, incuding the VCN, compute instances, load balancers, secruity rule, provision users, etc.
3. Script te startup or shutdown of any of your cloud assets. For example, you may want to shutdown your entire development and test environments each night at a certain time. You would create a second script to start the dev and test environments in the morning.

In this lab, you will create a script that essentially does all of the work defined in the other Lab-100 labs.

## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, and Tenant)
- To sign in to the Console, you need the following:
  - Tenant, User name and Password
  - URL for the Console: [https://cloud.oracle.com/](https://cloud.oracle.com/)
  - Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11

## Install Terraform

Terraform needs to be installed on an OCI compute instance.

### Create the Bastion Server

1. Log into OCI. If you are unsire how to do this, refer to the [Identity](https://github.com/jdavies/learning-library/blob/master/oci-library/L100-LAB/Identity_Access_Management/IAM_HOL.md) lab.

2. Using the "hamburger" menu, click on the `Compute -> Instances` menu item.

3. Click on the `Create Instance` button. Name the instance `Bastion-Server` and ensure it has a public IP address. You may need to specifiy a public RSA key ***ToDo***

4. Use `mkdr lab` from the home directory of the OPC user. The cange into that directory with the `cd lab` command.

### Create the env-vars file

You will to create an env-vars flle that contains the variables specific to your cloud instance. Execute the following command to download the template `env-vars` file into the `lab/` folder

Copy the OCIDs You Will Need

ToDo

## Run the Terraform Script

ToDo

## Conclusion

Conclusion here.

> Notes Ths lab was heavily based on the [Medium article by Jamal Arif](https://medium.com/@j.jamalarif/oracle-cloud-infrastructure-automation-with-terraform-f920df259504)
