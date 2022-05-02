# Provisioning the PeopleSoft Application

## Introduction

In this exercise, you will create your PeopleSoft application by provisioning the application from the OCI  Marketplace image for PeopleSoft.

Estimated Time: 1 hour 30 minutes

### Objectives

To deploy the PeopleSoft Instance, in this lab, you will:
*   Launching and deploying instance of PeopleSoft from Marketplace
*   Access PeopleSoft instance

### Prerequisites
* A user with 'manage' access to Networking and Compute, compartment, and marketplace access
* SSH key
* VCN setup from the previous lab

## Task:  Launching Instance of PeopleSoft from Marketplace

1. Make sure you are on the Oracle Cloud Infrastructure site

2. Navigate to ***Oracle Cloud Infrastructure Marketplace*** by using the dropdown menu on the left side of your screen and clicking the ***Marketplace*** and then all applications.

  ![From the menu bar in OCI console, click on Marketplace](./images/marketplace.png " ")

3. In the search bar type in PeopleSoft and hit search.There are 6 PeopleSoft DEMO environments which can be installed
   
    * PeopleSoft HCM
    * PeopleSoft FSCM
    * PeopleSoft ELM
    * PeopleSoft CRM
    * PeopleSoft Campus Solutions
    * PeopleSoft Interaction Hub

  ![Select any of the PeopleSoft images to install](./images/marketplace1.png " ")


4. In the instance page, select the PeopleSoft HCM Update Image Demo version and then select the compartment you made earlier. Then click ***Launch Instance***

  ![Select the desired compartment then select Launch Instance](./images/marketplace2.png " ")

5. In the Create Compute Instance page you will need to fill in additional info for your Instance

    a.  **Name:** You can name it whatever you like, such as "psfthcm"

    b.  **Select compartment:** Select the compartment that you created earlier

    c.  **Placement:** You can leave this as it is by default for this Lab

    d.   For the next **Configure networking** section you will choose the ***SELECT EXISTING VIRTUAL CLOUD NETWORK*** option and choose the ***SELECT EXSISTING SUBNET*** option before selecting the Network and Subnet you created in the prevous lab

    Make sure that ***ASSIGN A PUBLIC IP ADDRESS*** is also selected since we will use this to deploy our PeopleSoft application

    e. **Add SSH keys:** here you will need to selct the ssh key you created earlier. You can either use the

    *   ***CHOOSE PUBLIC KEY FILES*** and open the public key file you made if you know its location

        or you can use the

    *   ***PASTE PUBLIC KEYS*** and paste the data within the keyfile if you have the file open

    f.  **Configure boot volume:** You can leave this as default

    

    ![Fill in desired name, compartment, AD, and leave everthing else as is](./images/marketplace3.png " ")
    ![Select existing virtual cloud network, selct existing subnet, select assign a public IP adress, add your own ssh key then click create](./images/marketplace4.png " ")
    ![provide the ssh key created earlier](./images/marketplace5.png " ")

    g. Click Show advanced options, on the management tab select the option Paste cloud-init script and enter the configuration information using the JSON format in these examples.
      
          ```   
            <copy>{
            "connect_pwd":  "password",
            "access_pwd":  "password",
            "admin_pwd":  "password",
            "weblogic_admin_pwd":  "password",
            "webprofile_user_pwd":  "password",
            "gw_user_pwd":  "password",
            "domain_conn_pwd":  "password",
            "opr_pwd": "password"
            }</copy
          ```
    
    g. Now review your settings and click ***Create*** at the bottom of the page when you are ready
6. Now you will be taken to the Instance Page and will see that your newly created instance is provisioning

     Once you see the small orange box change to green your instance will have provisioned successfully and now you can move onto the next step in the Lab

     ![Once the orange box changes to a green box your intance will have been succesfully provisioned](./images/6.png " ")


## Task 3: Generating application domain URL

Generating the Application domain URL

1. You can create the application URL using the port 4430, that you opened in the previous lab, and the industry you selected while deployment

  **NOTE:** For this step you Google Chrome may not allow you to access the site, we recommend using an alternative such as Firefox for this step

  The url you will need to type into your browser's search bar should look like this:

  ```
https://<public IP address>:4430/PeopleSoft/app/<industry>/enu
```

  For example, if you selected Sales, your application URL for Sales industry  could be the following.

    https://111.111.111.11:4430/PeopleSoft/app/sales/enu

    **NOTE:** Make sure your url has ***"https"*** and not ***"http"*** at the beginning of it otherwise you will not obtain access

    ![Type the appropriate url into the firefox searchbar](./images/blast.png " ")

2. When accessing the url you may come across a "Potential Security Risk" warning message

    ![Click the advanced button on this warning screen](./images/bblast.png " ")

    Since this is the url and IP address that you created, you know that it is safe and that you can safely bypass the warning

    You can do this on Firefox by first clicking the ***Advanced Settings*** button and then clicking ***Accept Risk and Continue*** button

    ![Click the accept the risk and continue button](./images/aclast.png " ")

3. Now you should see the proper site where you can log in with the default PeopleSoft credentials

  USERNAME AND PASSWORD :    SADMIN/Welcome1

  ![On this login screen enter the default PeopleSoft credentials, username SADMIN andd the password Welcome1](./images/last.png " ")

  Please also note that the application URL will be specific to the Industry you select for deployment, for example, the URL could be:

  For Service - https://"your ip address":4430/PeopleSoft/app/callcenter/enu

  For PeopleSoft Management Console (SMC) - https://"your ip address":4430/PeopleSoft/smc

# Extension to provision
Verify PeopleSoft version on home screen
login home Page
from the health menu - check technical support Option
popup box will show PeopleSoft version, db connection, etc.

In this lab you launched an instance of PeopleSoft from the OCI marketplace, deployed the PeopleSoft application, and then deployed the PeopleSoft CRM Application.

***Congratulations*** on completing this interactive lab and integrating PeopleSoft with OCI. Please continue to work within the OCI environment using our other tutorials and explore our countless other features and possibilities


## Acknowledgements
* **Authors** - Deepak Kumar M, Principal Cloud Architect
* **Contributors** - Deepak Kumar M, Principal Cloud Architect
* **Last Updated By/Date** - Deepak Kumar M, Principal Cloud Architect, April 2022


