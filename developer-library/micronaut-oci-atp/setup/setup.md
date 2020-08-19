# Setup for Local Development

## Introduction

In this lab you are going to get setup to develop a Micronaut application locally that communicates with an Autonomous Datatabase instance.

Estimated Lab Time: &lt;10&gt; minutes

### Objectives

In this lab you will:

* Create the Necessary Database schema
* Download the Wallet for Autonomous Database access
* Create and configure a Micronaut application

## **STEP 1**: Create DB Schema

1. Click on the Cloud Shell button to start a Cloud Shell intance:

   ![Open Cloud Shell](images/cloudshell.png)

2. From Cloud Shell, download the script and run it:

   ```shell script
   wget -O setup.sh https://github.com/recursivecodes/micronaut-data-jdbc-graal-atp/releases/latest/download/setup.sh
   chmod +x setup.sh
   ./setup.sh

   ```

3. Enter the values that you copied from the Terraform output in the previous lab when prompted. The script will produce several snippets of output to be used to build, run and deploy.

## **STEP 2**: Download and Configure Wallet

The Oracle Autonomous Database uses an extra level of security in the form of a wallet containing access keys for your new Database.

TODO: Todd provides steps to download the Wallet through the UI


## **STEP 3**: Create a new Micronaut application and configure

TODO