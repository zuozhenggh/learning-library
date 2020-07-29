# Module 1: Introduction to Oracle SOA suite

Oracle SOA suite is is a comprehensive, standards-based software suite to build, deploy and manage integration following the concepts of service-oriented architecture(SOA). The components of the suite benefit from consistent tooling, a single deployment and management model, end-to-end security and unified metadata management you can skip this module and go straight to Module 2 by clicking the navigation menu icon, in the upper-left corner of the header.

## What is SOA - Service Orientated Architecture?
SOA is is a style of software design where services are provided to the other components by application components, through a communication protocol over a network. A SOA service is a discrete unit of functionality that can be accessed remotely and acted upon and updated independently, such as retrieving a credit card statement online. SOA is also intended to be independent of vendors, products and technologies

## Concepts Oracle SOA
Oracle SOA Suite provides easy-to-use, reusable, and unified application development tooling and life cycle management support to further reduce development and maintenance costs and complexity. Businesses can improve efficiency and agility through rules-driven, process connectivity and automation with Oracle SOA Suite.

SOA Suite functional architecture

![](images/1/soa-architecture.png)

Critical business services, such as customer, financial, ordering information, and others that were previously accessible only in packaged application user interfaces can now be rapidly repurpose for digital-enabled channel such as: smart phone and tablets.

## How to Run the Labs
You can run exercises in this lab as per instruction provided during live session 

Below are steps on how to sign-up for either an Oracle cloud service o. The always free Oracle Compute on OCI is ideal for learning about the Oracle Cloud Infrastructure. This service can readily be upgraded to a paid service as necessary. 

Detail can be found on https://docs.cloud.oracle.com/en-us/iaas/Content/FreeTier/resourceref.htm 

For conducting these labs you've been granted access to an OCI compute resource.

Click one of the options below to proceed.

### **Option 1**: Oracle SOA on Marketplace

In this part, you are assigned an Oracle OCI resource. Please check your inbox email to find details regarding access to your respective compute resource.


To gain access to free tier compute resource, follow these steps:
1.  Please [click this link to create your free account](https://myservices.us.oraclecloud.com/mycloud/signup?language=en&sourceType). When you complete the registration process you'll receive an account with a $300 credit and several "forever free" services that will enable you to complete the lab for free. You can then use any remaining credit to continue to explore the Oracle Cloud. The forever free services will continue to work after the trial expires.

2.  Soon after requesting your trial you will receive a  **Get Started Now with Oracle Cloud** email.   
    Make note of your **Username**, **Password**, and **Cloud Account Name**.

    ![](images/1/get-started-email.png)

3. Now that you have a service, you will log into your Oracle Cloud account so that you can start working with various services.        
    From any browser go to https://cloud.oracle.com/en_US/sign-in.

    Enter your **Cloud Account Name** in the input field and click the **Next** button.

    ![](images/1/enter-oracle-cloud-account-name.png)

4. Enter your **Username** and **Password** in the input fields and click **Sign In**.

    ![](images/1/enter-user-name-and-password.png)

5. From within your Oracle Cloud environment, you will create an instance of the Autonomous Transaction Processing database service.

    From the Cloud Dashboard, select the navigation menu icon in the upper left-hand corner and then select **Autonomous Transaction Processing**.

    ![](images/1/select-atp-in-nav-menu.png)

6. Click **Create Autonomous Database**.

    ![](images/1/click-create-autonomous-database.png)

7. Select the **Always Free** option, enter **```SecretPassw0rd```** for the ADMIN password, then click **Create Autonomous Database**.

    ![](images/1/atp-settings-1.png)
    ![](images/1/atp-settings-2.png)
    ![](images/1/atp-settings-3.png)

8. After clicking **Create Autonomous Database**, you will be redirected to the Autonomous Database Details page for the new instance. 

    Continue when the status changes from:

    ![](images/1/status-provisioning.png)
    
    to:

    ![](images/1/status-available.png)


    
### **Option 2**: apex.oracle.com
Signing up for apex.oracle.com is simply a matter of providing details on the workspace you wish to create and then waiting for the approval email.

1. Go to https://apex.oracle.com
2. Click **Get Started for Free**

    ![](images/1/get-started.png)

3. Scroll down until you see details for apex.oracle.com.  Click **Request a Free Workspace**

    ![](images/1/request-workspace.png)

3. On the Request a Workspace dialog, enter your Identification details – First Name, Last Name, Email, Workspace  
   *{Note: For workspace enter a unique name,
such as first initial and last name}*

    Click **Next**.
    
    ![](images/1/request-a-workspace.png)

3. Complete the remaining wizard steps.

4. Check your email. You should get an email from oracle- application-express_ww@oracle.com
within a few minutes.  
   *{Note: If you don’t get an email go
back to Step 3 and make sure to enter
your email correctly}*

    Within the email body, click **Create Workspace**

    ![](images/1/create-aoc-workspace.png)

3. Click **Continue to Sign In Screen**.
4. Enter your password, and click **Apply Changes**.
5. You should now be in the APEX Builder.

    ![](images/1/apex-builder.png)


### **Summary**

This completes the lab setup. At this point, you know how ...........  to start building amazing apps, fast.

Go to Module 2 of this lab by clicking the navigation menu icon, in the upper-left corner of the header.

 [Click here to navigate to Module 2](2-Build-composite-to-validate-payment.md)