# Setup

## Introduction

In this lab, we will provision and setup the resources to execute microservices in your tenancy.  

Estimated Time: 25 minutes

### Objectives

* Clone the setup and microservices code
* Execute setup

### Prerequisites

- This workshop assumes you have an Oracle cloud account and have signed in to the account.

## Task 1: Launch Cloud Shell

Cloud Shell is a small virtual machine running a "bash" shell which you access through the Oracle Cloud Console. Cloud Shell comes with a pre-authenticated command line interface in the tenancy region. It also provides up-to-date tools and utilities.

1. Click the Cloud Shell icon in the top-right corner of the Console.

  ![Open Cloud Shell](images/open-cloud-shell.png " ")

  NOTE: Cloud Shell uses websockets to communicate between your browser and the service. If your browser has websockets disabled or uses a corporate proxy that has websockets disabled you will see an error message ("An unexpected error occurred") when attempting to start Cloud Shell from the console. You also can change the browser cookies settings for a specific site to allow the traffic from *.oracle.com

## Task 2: Make a Clone of the Workshop Source Code in your home directory

1. To work with the application code, you need to make a clone from the GitHub repository using the following command.  

    ```
    <copy>git clone -b 22.1.3 --single-branch https://github.com/oracle/microservices-datadriven.git
    </copy>
    ```

   You should now see the directory `microservices-datadriven` in the home directory.

2. Run the following command to edit your .bashrc file so that you will return to the workshop directory when you connect to cloud shell in the future.

    ```
    <copy>
    sed -i.bak '/travelagency/d' ~/.bashrc
    echo "source $PWD/microservices-datadriven/travelagency/env.sh" >>~/.bashrc
   export JAVA_HOME=~/graalvm-ce-java11-20.1.0
   export PATH=$JAVA_HOME/bin:$PATH
    </copy>
    ```

## Task 3: Start the Setup

1. Execute the following sequence of commands to start the setup.  

    ```
    <copy>cd ; 
   mvn install:install-file –Dfile=C:\dev\app.jar -DgroupId=com.roufid.tutorials -DartifactId=example-app -Dversion=1.0
    </copy>
    ```

   Note, cloud shell may disconnect after a period of inactivity. If that happens, you can reconnect and then run this command to resume the setup:

    ```
    <copy>
    source setup.sh
    </copy>
    ```
   The setup process will typically take around 20 minutes to complete.  

2. The setup will ask for you to enter your User OCID.  

   Be sure to provide the user OCID and not the user name or tenancy OCID.

   User information is available in the Oracle Cloud Console.

   The user OCID will look something like `ocid1.user.oc1..aaaaaaaanu5dhxbl4oiasdfasdfasdfasdf4mjhbta`. Note the "ocid1.user" prefix.

   Note, sometimes the name link is missing in which case select the `User Settings` link. Do not select the "Tenancy" link.

   Locate your menu bar and click the person icon at the far upper right. From the drop-down menu, select your user's name.

    ![Get User OCID](images/get-user-ocid.png " ")

   Click Show to see the details and then click Copy to copy the user OCID to the clipboard, paste in the copied data in console.

    ![Example OCID](images/example-user-ocid.png " ")

3. The setup will ask for you to enter your Compartment OCID.

    ![Get Comp OCID](images/get-comp-ocid.png " ")

4. The setup will automatically upload an Auth Token to your tenancy so that docker can log in to the Oracle Cloud Infrastructure Registry. If there is no space for a new Auth Token, the setup will ask you to remove an existing token to make room. This is done through the Oracle Cloud Console.

   Locate your menu bar and click the person icon at the far upper right. From the drop-down menu, select your user's name.

   ![Get User OCID](images/get-user-ocid.png " ")

   On the User Details console, click Auth Tokens under Resources.

   ![Auth Token](images/auth-token.png " ")

   On the Auth Tokens screen, highlight the existing token(s) and delete by clicking Delete from the drop-down menu.

   ![Delete Auth Token](images/delete-auth-token.png " ")

5. The setup will ask you to enter an admin password for the databases. For simplicity, the same password will be used for both the order and inventory databases. Database passwords must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number. The password cannot contain the double quote (") character or the word "admin".

6. The setup will also ask you to enter a UI password that will be used to enter the microservice frontend user interface. Make a note of the password as you will need it later.  The UI password must be 8 to 30 characters.

7. The setup will ask you to confirm that there are no other un-terminated OKE clusters exist in your tenancy.

    ```
    <copy>
    You are limited to only one OKE cluster in this tenancy. This workshop will create one additional OKE cluster and so any other OKE clusters must be terminated.
    Please confirm that no other un-terminated OKE clusters exist in this tenancy and then hit [RETURN]?
    </copy>
    ```
   To confirm that there are no other un-terminated OKE clusters, click the Navigation Menu in the upper left of Oracle Cloud Console, navigate to Developer Services and click on Kubernetes Clusters (OKE).

    ![Dev Services Menu](images/dev-services-menu.png " ")

    ![Get OKE Info](images/get-oke-info.png " ")

   If there are any un-terminated OKE cluster(s), please delete it(them) and continue with setup steps.

    ![Get OKE Details](images/get-oke-details.png " ")


## Task 7: Monitor the Setup

1. The setup will provision the following resources in your tenancy:

    | Resources              | Oracle Cloud Console Navigation                                               |
    |------------------------|-------------------------------------------------------------------------------|
    | Object Storage Buckets | Storage --> Object Storage --> Buckets                                        |
    | Databases (2)          | Oracle Database -- Autonomous Database -- Autonomous Transaction Processing   |
    | OKE Cluster            | Developer Services -- Containers -- Kubernetes Clusters (OKE)                 |
    | Registry Repositories  | Developer Services -- Containers -- Container Registry                        |

2. You should monitor the setup progress from a different browser window or tab.  It is best not to use the original browser window or not to refresh it as this may disturb the setup or you might lose your shell session. Most browsers have a "duplicate" feature that will allow you to quickly created a second window or tab.

     ![Duplicate Browser](images/duplicate-browser-tab.png " ")

    From the new browser window or tab, navigate around the console to view the resources within the new compartment. The table includes the console navigation for each resource. For example, here we show the database resources:

    ![Select Compartment](images/select-compartment.png " ")

    Note, Cloud Shell sessions have a maximum length of 24 hours, and time out after 20 minutes of inactivity.

## Task 8: Complete the Setup

1. Once the majority of the setup has been completed the setup will periodically provide a summary of the setup status. Once everything has completed you will see the message: **SETUP_VERIFIED completed**.

    If any of the background setup jobs are still running you can monitor their progress with the following command.

    ```
    <copy>
    ps -ef | grep "$TRAVELAGENCY_HOME/utils" | grep -v grep
    </copy>
    ```

2. Their log files are located in the $TRAVELAGENCY_LOG directory.

    ```
    <copy>
    ls -al $TRAVELAGENCY_LOG
    </copy>
    ```

3. You can also cat through the logs by using the `showsetuplogs` shortcut command.

    ```
    <copy>
    showsetuplogs
    </copy>
    ```

## Task 9: Setup Oracle Saga Support and Application Queues

1. Obtain the DB OCID and download the wallet 

    ```
    <copy>
    oci db autonomous-database generate-wallet --autonomous-database-id "ocid1.autonomousdatabase.oc1.phx.anyhqljtoxm32yia3ejhfox4tcpcvuqkpg5y2kosaq34soqlmpbrccr7co3q" --file 'sagadb1_wallet.zip' --password 'Welcome1' --generate-type 'ALL'
    </copy>
    ```
    ```
    <copy>
    oci db autonomous-database generate-wallet --autonomous-database-id "ocid1.autonomousdatabase.oc1.phx.anyhqljroxm32yia4y3ncqpoecip5sfu3grglrwh2gm7zh37tjjwpqs2xziq" --file 'sagadb2_wallet.zip' --password 'Welcome1' --generate-type 'ALL'
    </copy>
    ```

2. need to replace 
    - preauth link from objectstore or find better way
    - values for dblink connection from tnsnames.ora
    - pw for DBMS_CLOUD.CREATE_CREDENTIAL

admin@saga2db
    createusers,  walletupload
admin@saga2
    create , queue, walletupload, and link

particpantadmins@saga2db
    create queue, link

sql /nolog 
   set cloudconfig sagadb1_wallet.zip
   connect admin@sagadb1_tp
   @infra-setup/createtravelagencyuser.sql
   set cloudconfig sagadb2_wallet.zip
   connect admin@sagadb2_TP
   @infra-setup/createparticipantusers.sql
   connect flightuser@sagadb2_TP
   @infra-setup/flight.sql
   connect hoteluser@sagadb2_TP
   @infra-setup/hotel.sql
   connect caruser@sagadb2_TP
   @infra-setup/car.sql
   connect travelagencyuser@sagadb1_TP
   @infra-setup/travelagencyqueue.sql
   
   connect travelagencyadmin run travelagencyqueue.sql
   connect admin@sagadb2 run createusersdb2.sql


You may now **proceed to the next lab.**.

## Acknowledgements

* **Authors** - Paul Parkinson, Architect and Developer Advocate
* **Last Updated By/Date** - Paul Parkinson, December 2021
