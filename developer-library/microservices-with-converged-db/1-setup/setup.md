# Lab 1: Setup

## Introduction

In this 25-minute lab we will provision and setup the resources to execute microservices in your tenancy.  

### Objectives

* Clone the setup and microservices code
* Execute setup

### What Do You Need?

* An Oracle Cloud paid account or free trial with credits. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).

Note, you will not be able to complete this workshop with the 'Always Free' account. Make sure that you select the free trial account with credits.

## **STEP 1**: Login to the OCI Console

Logon to the OCI console for your tenancy.  

## **STEP 2**: Select the Home Region

Be sure to select the **home region** of your tenancy.  Setup will only work in the home region.

  ![](images/home-region.png " ")
  
## **STEP 3**: Check Your Tenancy Quota

If you have a fresh free trial account with credits then you can be sure that you have enough quota to complete this workshop and you can proceed top the next step. 

If, however, you have already used up some of the quota on your tenancy, perhaps while completing other workshops, there may be insufficient quota left to run this workshop. The most likely quota limits you may hit are summarized in the following table. 

| Service          | Limit Name                                           | Requirement |
|------------------|------------------------------------------------------|:-----------:|
| Compute          | Cores for Standard.E2 based VM and BM Instances      | 3           |
| Container Engine | Cluster Count                                        | 1           |
| Database         | Autonomous Transaction Processing Total Storage (TB) | 2           |
|                  | Autonomous Transaction Processing OCPU Count         | 4           |
| LbaaS            | 10Mbps Load Balancer                                 | 3           |

Quota usage and limits can be check through the console:

  ![](images/limits-quota-usage.png " ")

The Tenancy Explorer may be used to locate existing resources:

  ![](images/tenancy-explorer.png " ")

Use the "Show resources in subcompartments" feature to locate all the resources in your tenancy:

  ![](images/show-subcompartments.png " ")

It may be necessary to remove some resources in order to make space to run this workshop.  When you have sufficent space you may proceed to the next step.

## **STEP 4**: Launch the Cloud Shell

Cloud Shell is a small virtual machine running a "bash" shell which you access through the OCI Console. Cloud Shell comes with a pre-authenticated command line interface which is set to the OCI Console tenancy region. It also provides up-to-date tools and utilities.

Click the Cloud Shell icon in the top-right corner of the Console.

  ![](images/open-cloud-shell.png " ")

## **STEP 5**: Create a Folder to Contain the Workshop Code

1. Create a directory to contain the workshop code. The directory name will also be used to create a compartment of the same name in your tenancy.  The directory name must have between 1 and 13 characters, contain only letters or numbers, and start with a letter.  Make sure that a compartment of the same name does not already exist in your tenancy or the setup will fail. For example:

    ```
    <copy>mkdir grabdish
    </copy>
    ```

   All the resources that are created by the setup will be created in this compartment.  This will allow you to quickly delete and cleanup afterwards.  

2. Change directory to the directory that you have created. The setup will fail if you do not complete this step. For example:

    ```
    <copy> cd grabdish
    </copy>
    ```

## **STEP 5**: Make a Clone of the Workshop Setup Scripta and Source Code

1. To work with the application code, you need to make a clone from the GitHub repository using the following command.  

    ```
    <copy>git clone -b 1.2 --single-branch https://github.com/oracle/microservices-datadriven.git
    </copy>
    ```

   You should now see the directory `microservices-datadriven` in the directory that you created.

2. Run the following command to edit your .bashrc file so that you will be returned to the workshop directory when you connect to the cloud shell in the future.

    ```
    <copy>
    sed -i.bak '/grabdish/d' ~/.bashrc
    echo "source $PWD/microservices-datadriven/grabdish/env.sh" >>~/.bashrc
    </copy>
    ```

## **STEP 6**: Run the Setup

1. Execute the following sequence of commands to start the setup.  

    ```
    <copy>
    source microservices-datadriven/grabdish/env.sh
    source setup.sh
    </copy>
    ```
   
   Note, The cloud shell will disconnect after a period of inactivity. If that happens, you may reconnect and then run this command to resume the setup:

    ```
    <copy>
    source setup.sh
    </copy>
    ```

   The setup process will typically take around 20 minutes to complete.  

2. The setup will ask for you to enter your User OCID.  This can be found in the OCI console.

  ![](images/get-user-ocid.png " ")

  ![](images/example-user-ocid.png " ")

3. The setup will automatically configure key based access to the OCI command line interface.  To do this it may need to generate and upload a new API Key to your tenancy.  

   To generate a key the setup will ask you to enter a passphrase.  If that happens then hit return (empty passphrase).  Do not enter a passphrase or setup will fail.
   
   If there is no space for a new key in OCI, the setup will ask you to remove an existing key to make room.  This can be done through the OCI console.

  ![](images/get-user-ocid.png " ")

  ![](images/delete-api-key.png " ")

4. The setup will automatically upload an Auth Token to your tenancy so that docker can login to the OCI Registry.  If there is no space for a new Auth Token, the setup will ask you to remove an existing token to make room.  This can be done through the OCI console.

  ![](images/get-user-ocid.png " ")

  ![](images/delete-auth-token.png " ")

5. The setup will ask you to enter an admin password for the databases.  For simplicity, the same password will be used for both the order and inventory databases.  Database passwords must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number. The password cannot contain the double quote (") character or the word "admin".

6. The setup will also ask you to enter a UI password that will be used to enter the microservice frontend user interface.  Make a note of the password as you will need it later.  The UI password must be 8 to 30 characters.

7. The setup will provision two databases (for orders and inventory), an Oracle Kubernetes Engine (OKE) cluster, OCI Registry Repositories and an OCI Object Storage wallet.  You can monitor its progress from a different browser window.  It is best not to use the original browser window as this may disturb the setup.  Most browsers have a "duplicate" feature that will allow you to quickly created a second window or tab.

  ![](images/duplicate-browser-tab.png " ")

   In the new tab, select the resources you are interested in and select your new compartment.  Here we show the database resources that have been created.

  ![](images/select-compartment.png " ")

8. Once the majority of the setup has been completed the setup will periodically provide a summary of the setup status.  Once everything has completed you will see the message "SETUP_VERIFIED completed".

   If any of the background setup jobs are still running you can monitor their progress with the following command.

    ```
    <copy>
    ps -ef | grep "$GRABDISH_HOME/utils" | grep -v grep
    </copy>
    ```

   Their log files are located in the $GRABDISH_LOG directory.

    ```
    <copy>
    ls -al $GRABDISH_LOG
    </copy>
    ```

   Once the setup has completed you are ready to move on to Lab 2.  Note, the non-java-builds.sh script may continue to run even after the setup has completed.  The non-Java builds are only required in Lab 3 and so we can continue with Lab 2 while the builds continue in the background.

## Acknowledgements

* **Authors** - Paul Parkinson, Dev Lead for Data and Transaction Processing, Oracle Microservices Platform, Helidon; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Richard Exley, April 2021