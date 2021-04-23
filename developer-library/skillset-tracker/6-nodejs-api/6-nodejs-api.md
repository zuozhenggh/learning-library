# Build NodeJS APIs to make calls to the database

## Introduction

Intro about NodeJS and APIs

Estimated Lab Time: 25 minutes

### Objectives

* Provision a Linux Instance in OCI and install the needed packages.
* Build a basic NodeJS application that will make calls to the database.
* Run & test the application.


### What Do You Need?
* An IDE, such as **Visual Studio Code**
* An OCI Account
* A tenancy where you have the resources available to provision a Linux Instance.
* An existing compartment and a VCN in which the Instance will reside.

### Prerequisites
* Lab 2 - Step 1 - Creating the Virtual Cloud Network

## **Step 1:** Creating a Linux Instance in OCI
1. From the top-left hamburger menu, locate and select **Compute -> Instances**. Click the blue button **Create Instance**.
2. Make sure you are in the desired compartment (here _skillset_).
3. Configure your instance by naming it, choosing your AD, image, shape, VCN, subnet, public IP address.
4. Since you need to authenticate as a remote user to the instance, you should upload your SSH public key from your SSH key pair generated on your local environment.
5. Click the **Create** button.

## **Step 2:** Connecting to the Instance and installing the needed packages
1. From the OCI Console, copy the public IP address of your new created instance and open a CMD or Windows PowerShell screen.
2. The user is `opc`, so the next step for connecting to the instance is to run the following command in CMD or Windows PowerShell
```
ssh opc@<your_public_ip>
```
3. After the connection was successful we need to run the some commands in order to make the configuration complete.
* Before beginning to install anything on the instance, run the following command.
```
sudo yum update
```
* Open the port needed for the application. In this case, 8000, the default port for an Oracle Jet application.
```
sudo firewall-cmd --permanent --zone=public --add-port=8000/tcp
sudo firewall-cmd --reload
```
* Install **curl** package
```
sudo yum install curl
sudo curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
```
* Install **NodeJS** package
```
sudo yum install -y nodejs
```
4. [Optional] If there are going to be more people that would need to connect to the instance, their SSH keys need to be added on the instance as well. In order to do this, connect to the instance using SSH and run the following commands.
```
ssh opc@<instance_public_ip>
cd ~/.ssh
nano authorized_keys
```
Paste the key that needs to be added at the end of the file on the instance and save the file (**Ctrl+O** then **Ctrl+X**).

## **Step 3:** Installing Oracle Instant Client
1. Before downloading **Instant Client**, create a new directory for it and navigate to that directory.
```
sudo mkdir /opt/oracle
cd /opt/oracle
```
2. Download Oracle Instant Client.
```
sudo wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linuxx64.zip
```
3. Unzip the archive downloaded at the previous step.
```
sudo unzip instantclient-basic-linuxx64.zip
```
4. Install **libaio** package and add Instant Client to the environment variables using the following commands.
```
sudo yum install libaio
sudo sh -c "echo /opt/oracle/instantclient_21_1 > /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig
sudo export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_1:$LD_LIBRARY_PATH
```
5. Open OCI Console and navigate to the Autonomous Database Created in Lab 1. Download the wallet by choosing **DB Connection**, then select **Instance Wallet** for the **Wallet Type** field and click **Download Wallet**.
6. After downloading the wallet to you local machine, unzip the archive. Now all its content can be copied to the instance using the following commands (these should be ran from your local machine).
```
cd <path_to_the_wallet_folder>
scp -r <wallet_folder_name>/ opc@<instance_public_ip>:/home/opc/
```
7. After all the files were uploaded to the instance you can connect to it using SSH, as done previously.
```
ssh opc@<instance_public_ip>
```
8. Navigate to the Instant Client directory (**/opt/oracle/instantclient_21_1/**) and check if there is a directory **./network/admin**. If not, you will need to create these two directories so that you will be able to access the following path: **/opt/oracle/instantclient_21_1/network/admin/** using the following commands.
```
cd /opt/oracle/instantclient_21_1/
sudo mkdir network
cd network
sudo mkdir admin
```
9. Navigate to the wallet directory and copy all its content to **/opt/oracle/instantclient_21_1/network/admin/**
```
cd /home/opc/<wallet_folder_name>
sudo cp * /opt/oracle/instantclient_21_1/network/admin/
```
10. In the wallet folder, check the **sqlnet.ora** and update it, if necessary, so that it will have the correct path to **/network/admin** directory. The content of the file should look similar to this.
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="?/network/admin")))
SSL_SERVER_DN_MATCH=yes
```
## **Step 4:** TBD - NodeJS code
TBD


## Want to Learn More?
[Basic Writing and Formatting Syntax](https://docs.github.com/en/github/writing-on-github/basic-writing-and-formatting-syntax)
[LiveLabs Markdown Template Features](https://confluence.oraclecorp.com/confluence/display/DBIDDP/LiveLabs+Markdown+Template+Features)

## Acknowledgements

**Authors/Contributors** -
