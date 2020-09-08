# Provision Resources

## Introduction

In the lab we will provision the resources required for the next lab. 

## Objectives

<!--Provision a stack comprising of an Autonomous Datawarehouse and an Analytics Cloud instance.-->
Provision an Autonomous Datawarehouse instance and an Analytics Cloud instance.

## Required Artifacts

- IDCS Access Token to provision an analytics instance as part of the stack.
- Necessary permissions to provision the stack in a compartment.

## Method 1: Using a Resource Manager Stack

In order to provision an analytics cloud instance as part of a **Resource Manager** stack, an IDCS access token is required. If you do not have the required access level then proceed to Method 2. 

### STEP 1: Obtain IDCS Access Token

- Login to the OCI console and go the Navigation menu using the Menu button in the top left.

    ![](./images/1.1.png " ")

- Scroll down to the **Governance and Administration** section and under **Identity**, select **Federation**.

    ![](./images/1.2.png " ")

- Click on the link to the **OracleIdentityCloudService**. 
    
    ![](./images/1.3.png " ")

- In the page that opens, click on the Service Console URL. 

    ![](./images/1.4.png " ")

- In the Identity Cloud Service Console, click on the user icon in the top right corner and select **My AccessTokens**.

    ![](./images/1.5.png " ")

- If you have access to the relevant APIs, you should be able to select them, under the **Invokes Identity Cloud Service** radio button. Thereafter, enter the duration of validity of the token in minutes and click on the **Download Token** button.

    ![](./images/1.6.png " ")

**Note:** If you don't have access to the required APIs, follow **Method 2**.

- Open the token.tok file that you just downloaded. Keep it handy because in a few minutes you wll need to copy the contents of this file.

    ![](./images/1.7.png " ")

You may follow the video [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/OVQA-GCUjlO9VwEdWqHSre02rNj4K6wZ3VsacpzsXNg/n/oradbclouducm/b/bucket-20200907-1650/o/mdw%20-%20idcs.mp4), if you are unsure of the steps above.

### STEP 2: Provision the Stack

- In the navigation menu, scroll down to the **Solutions and Platform** section. Under **Resource Manager**, select **Stacks**. 
    
    ![](./images/1.13.png " ")

- Click on the **Create Stack** button.

    ![](./images/1.14.png " ")

- Select the **Sample Solution** radio button. Then, click on the **Select Solution** button.

    ![](./images/1.15.png " ")

- In the side menu that opens up, check the **Departmental Data Warehousing** solution and hit the **Select Solution** button.

    ![](./images/1.16.png " ")

- Provide a name to the stack and hit **Next**.

    ![](./images/1.17.png " ")

- On the **Configure Variables** screen, enter the admin password, database name and database display name.![](./images/1.18.png " ")

- Check the **Auto Scaling** box to enable auto-scaling of hte database. Enabling this is optional, but recommended. Also, enter 0.0.0.0/0 in the public IP address field. 

    ![](./images/1.19.png " ")

- Scroll down and provide a name to the analytics instance and paste the access token that you had downloaded, earlier. Now, hit **Next**.

    ![](./images/1.20.png " ")

- Review all the details and click on the **Create** button.

    ![](./images/1.21.png " ")

- Now that the stack has been created, click on **Terraform Actions** and select **Apply**. In the iframe that pops-up, click on **Apply**, again.

    ![](./images/1.22.png " ")

    ![](./images/1.23.png " ")

**Note**:  If you have followed the steps above the job should succeed without any issues. Keep an eye on the logs to monitor the progress. If the job fails, please fix the issues and proceed.

![](./images/1.24.png " ")

- You could either check tjhe logs for the links to the resources that were provisioned as part of the stack or you can click on **Associated Resources** on the job details page. 

    ![](./images/1.25.png " ")

- Clicking on the links to the resources should take you to their pages. 
    
    ![](./images/1.26.png " ")

**Note**: In case there is no link to get to analytics instance, follow the two steps given below, else proceed to the next lab.

- From the Navigation menu, under **Solutions and Platform**, go to **Analytics** and select **Analytics Cloud**.

    ![](./images/1.27.png " ")

- Click on the analytics instance to get to its page. Thereafter, click on the **Open URL** button to access the instance.

    ![](./images/1.28.png " ")

    ![](./images/1.29.png " ")


## Method 2: Independently Provision the Resources

### STEP 1: Provision the Autonomous Data Warehouse 

- Login to the OCI console and go the Navigation menu using the Menu button in the top left.

    ![](./images/2.1.png " ")

- Choose **Autonomous Data Warehouse** from the **Oracle Database** section.

    ![](./images/2.2.png " ")

- Click on the **Create Autonomous Database** button. 

    ![](./images/2.3.png " ")

- Choose a compartment, enter the **Display Name** and also enter a name for the **Database**. Leave everything else set to the default values. 

    ![](./images/2.4.png " ")

- Scroll down and provide a password for the administrator.

    ![](./images/2.5.png " ")

- Thereafter, hit **Create Autonomous Database**.

    ![](./images/2.6.png " ")

- The database should be up and running in a couple of minutes. 

    ![](./images/2.7.png " ")

**Note:** Keep this page open or make note of how to get here, since you would need to visit this page for information needed to connect to the database.

### STEP 2: Provision the Analytics Cloud Instance 

- From the Navigation menu, under **Solutions and Platform**, go to **Analytics** and select **Analytics Cloud**.

    ![](./images/2.8.png " ")

- On the next page, click on the **Create Instance** button. 

    ![](./images/2.9.png " ")

- Choose a compartment and provide a name for the instance. Let everything else stay the same. Then click on **Create**.

    ![](./images/2.10.png " ")

- The instance will be up in 12-14 minutes. Once the instance is available, click on the **Open URL** button to gain access to the instance.

    ![](./images/2.11.png " ")
