# Connnect to Database via SSH

## Introduction

*This lab walks you through the steps required to connect to the database using SSH. This connection will be used as a prerequisite for many labs that require an SSH. 

Estimated Time: 20 minutes

### About <Product/Technology> (Optional)


### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Access tenancy
* Create database instance
* Open terminal and connect via SSH

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account with access to a tenancy 
* Have existing VCN connection 


*Below, is the "fold"--where items are collapsed by default.*

## Task 1: Create Compute Instance

(optional) Step 1 opening paragraph. In this step you will create an instance in your OCI tenancy in order to connect to the database via SSH.

1. Access cloud.oracle.com and login to your tenancy 


2. Click the hamburger menu on the left hand side and select "Compute" then "Instances" 


![Image alt text](images/compute_instance.png)


4. Click create instance and follow steps below.

Change name of Instance to your specification.


![Image alt text](images/name_instance.png)

Upload your public key. (If you don't have a public and private key, generate them and save them on a preferred location on your computer. Then follow previous step of uploading that public key)

![Image alt text](images/private_public_key.png)


Leave everything else as is and make sure you have a VCN specified. 

Hit create instance and wait approximately 5 minutes to provision. 

![Image alt text](images/create_instance.png)


## Task 2: Connect to instance via SSH

1. Open terminal window

2.  ssh -i <Location of Private SSH key> opc@<Your Public IP Address>
Remove brackets when writing out IP Address. 
Example: ssh -i .ssh/test opc@132.226.31.189

![Image alt text](images/terminal.png)





## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
