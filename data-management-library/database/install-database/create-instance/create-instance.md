# Create compute instance

## Introduction

TBD.

Estimated Time: 20 minutes

### About TBD

some content.. . 

### TBD

some content.. . 
  
### Objectives
 
In this lab, you will enable:
* some content.. . 
* some content.. .  

### Prerequisites 
This lab assumes you have:

* A LiveLabs Cloud account and assigned compartment
* The IP address and instance name for your DB19c Compute instance
* Successfully logged into your LiveLabs account
* A Valid SSH Key Pair
  
## Task 1: Create compute instance with virtual cloud network 

1. Create compute instance in the compartment of your choice

      ![Create Compute](images/create-compute.png "Create Compute") 

2. Select Image, Oracle Enterprise Linux 7.9 
 
      ![Select Image](images/select-image-shape.png "Select Image") 

3. Create a virtual cloud network in the same compartment as that of the instance created

      ![Create Network](images/create-network.png "Create Network") 

4. Make note of public IP address

      ![Compute Details](images/compute-details.png "Compute Details") 

## Task 2: SSH into instance

1. SSH into compute instance using the private key and public IP address of the instance

      ```
      <copy>
      ssh -i <private key> opc@<public ip address>
      </copy>
      ``` 

## Task 3: Create oracle user 

1. You can check the logged-in user with whoami. This will return opc
 
      ```
      <copy>
      whoami 
      </copy>
      ```  

      As the root user, add a user named oracle which is used later in this lab

      ```
      <copy> 
      groupadd oracle 
      </copy>
      ``` 

      ```
      <copy> 
      useradd -m -g oracle -d /home/oracle -s /bin/bash oracle 
      </copy>
      ``` 

      ```
      <copy> 
      passwd oracle
      < password > 
      </copy>
      ``` 

      ```
      <copy> 
      su - oracle
      Password: 
      </copy>
      ``` 


 
   You successfully made it to the end this lab. You may now *proceed to the next lab*.  

## Learn More

* [Create users and groups on Oracle Linux ](https://docs.oracle.com/en/learn/users_groups_linux8/index.html#administer-group-accounts) 
 
## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** - Kevin Lazarz, Senior Principal Product Manager, Database and Gregg Christman, Senior Product Manager
* **Last Updated By/Date** -  Madhusudhan Rao, Feb 2022 
