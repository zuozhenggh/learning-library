
<p align="center">
  <img width="650" height="300" src="./media/banner.png">
</p>



# Getting Started

## Lab Purpose and Rules

These labs are designed to provide you with an introduction to Visual Builder and Digital Assistant to prepare you to showcase these services.

Here are some general guidelines that will help you get the most from
these lab exercises.

  - Read through an entire exercise before executing any of the steps.
    Becoming familiar with the expected flow will enhance your learning
    experience.

  - Ask before you do. If you have any questions, please ask the
    instructor before you march down a path that may lead to wasting
    your time.

  - Follow the steps as shown in the Lab Guide. This is a live
    environment. If you want to do something that is not in the labs,
    ask the lab instructor first. In particular, do not create, delete,
    or alter any cloud objects without asking first.

  - There is no prize for finishing first; there is no penalty for
    finishing last. The goal is to gain a firm understanding of Oracle
    Visual Builder.

  - Ask questions freely. The only dumb questions are those that are not
    asked.



# Create a VBCS Instance

As part of the lab, we expect learns to create the VBCS instance before the session delivery.
If you are creating a new instance either for the lab purposes or a customer demonstration, please follow the next steps; the process is simple but require several minutes to complete.

In this lab you will make sure you can access the VBCS instance for your classroom and supporting lab files.


## Video


[![Creating a Visual Builder Cloud Service Instance](./media/playback_creating_instance_vbcs.png)](https://otube.oracle.com/media/Oracle+Sales+and+Partner+Academy+-+AppDev+Virtual+Workshop/1_xryvhe4k)

*Note: By clicking the video, this will redirects you to OTube. Remember to get back to this page to continue with the Lab*


## Guide

1. First, go to cloud.oracle.com, click on **View Accounts** and select **Sign in to cloud**
![](./media/cloudoracle.png)

1. Enter your tenant account
![](./media/tenant.png)

1. On the login screen select SSO and provide your credentials *(Contact your tenant admin if you are using a different login mechanism)*
![](./media/credentials.png)
![](./media/credentials_2.png)

1. Once in the main dashboard, open the **General Menu** located at the top left hand side of the screen, select **Platform Services**, and click on **Visual Builder**
![](./media/vb_dashboard.png)

1. Log into your tenancy using cloud.oracle.com; be sure it has been provisioned to allow Visual Builder Cloud Service and the database and object storage instances also required.  (check with your tenancy admin if unsure)


1. From the “Visual Builder” service box there are two ways to open a service console.
![](./media/image_a_3.png)


1. One method is to click on the box’s “Visual Builder” text to display an overview page.
![](./media/image_a_7.png)

1. From the overview page, click the “Open Service Console” button to continue.
![](./media/image_a_8.png)


1. Another method is to click the **General Menu** icon
![](./media/image_a_9.png) in the lower-right corner of the  “Visual Builder” service box to display a menu.
![](./media/image_a_3.png)


1. Select “Open Service Console” from the menu.
![](./media/image_a_10.png)


1. If you have not created any services the Service Console prompts you to begin the process.
**DO NOT** CLICK “CREATE INSTANCE” at this time, we will be using **Quick Starts** (see step 5).
![](./media/image_a_11.png)


1. Visual Builder provides a “Quick Starts” capability to build an instance complete with supporting database and object storage. Click the “Quick Starts” button to get started it is located in the upper-right portion of the Service Console display inside the big blue bar.
![](./media/image_a_13.png)


1. Click on **Custom**
 ![](./media/vbcs_instance_custom.png)

1. Provide an instance name, description, and region. Once complete, click next and confirm. The instance creation can take up to 10 min.
![](./media/vbcs_instance_data.png)
![](./media/vbcs_instance_creation.png)

That’s it, you’ve created an instance that can support many VBCS applications and user.


NOTE:
If others will be sharing your VBCS instance you will need to use Oracle Identity Cloud Service (IDCS)
to make sure they have `ServiceDeveloper` (Visual Builder Administrator) role for your instance if they are developers or 'ServiceAdministrator' (Visual Builder Administrator) role if they need to administer other's applications. 
See Oracle Documentation for more information.


# Create an Digital Assistant Instance

As part of the lab, we expect learns to create the Digital Assitant instance before the session delivery.
If you are creating a new instance either for the lab purposes or a customer demonstration, please follow the next steps; the process is simple but require several minutes to complete.

## Video


[![Creating a Digital Assistant Instance](./media/playback_creating_instance_oda.png)](https://otube.oracle.com/media/Oracle+Sales+and+Partner+Academy+-+AppDev+Virtual+Workshop+-+Creating+an+ODA+Instance/1_ee3m2ce9)

*Note: By clicking the video, this will redirects you to OTube. Remember to get back to this page to continue with the Lab*


## Guide

1. First, go to cloud.oracle.com, click on **View Accounts** and select **Sign in to cloud**
![](./media/cloudoracle.png)

1. Enter your tenant account
![](./media/tenant.png)

1. On the login screen select SSO and provide your credentials *(Contact your tenant admin if you are using a different login mechanism)*
![](./media/credentials.png)
![](./media/credentials_2.png)

1. Once in the main dashboard, open the **General Menu** located at the top left hand side of the screen and click on **Digital Assitant**
![](./media/creating_oda_1.png)

1. In the Digital Assistant console, select the compartment where to deploy the new instance and click on **Create Digital Assistant Database**
![](./media/creating_oda2.png)

1. In the Digital Assistant creation screen, provide a name, description, and shape (For the lab purposes select `Production`), and click **Create**
![](./media/creating_oda_3.png)

1. The process might take a few minutes. Once created, you should see the instance as **Active**
![](./media/creating_oda_4.png)


That’s it, you’ve created your first Oracle Digital Assistant instance.


# Create and ATP Instance

As part of the lab, we expect learns to create the ATP instance before the session delivery.
If you are creating a new instance either for the lab purposes or a customer demonstration, please follow the next steps; the process is simple but require several minutes to complete.

## Video


[![Creating a ATP Instance](./media/playback_creating_instance_atp.png)](https://otube.oracle.com/media/Oracle+Sales+and+Partner+Academy+-+AppDev+Virtual+Workshop+-+Creating+and+ATP+Instance/1_r47n3ers)

*Note: By clicking the video, this will redirects you to OTube. Remember to get back to this page to continue with the Lab*


## Guide

1. First, go to cloud.oracle.com, click on **View Accounts** and select **Sign in to cloud**
![](./media/cloudoracle.png)

1. Enter your tenant account
![](./media/tenant.png)

1. On the login screen select SSO and provide your credentials *(Contact your tenant admin if you are using a different login mechanism)*
![](./media/credentials.png)
![](./media/credentials_2.png)

1. Once in the main dashboard, open the **General Menu** located at the top left hand side of the screen, click on **Autonomous Data Processing**
![](./media/creating_atp_1.png)

1. In the ATP console, select the compartment where to deploy the new instance and click on **Create Autnomous Database**
![](./media/creating_atp_2.png)

1. In the database creation screen, provide a display name, database name, password, the license type. and click **Create Autonomous Database**
![](./media/creating_atp_3.png)
![](./media/creating_atp_4.png)


1. The process might take a few minutes. Once created, you should see the instance as **Available**
![](./media/creating_atp_5.png)

That’s it, you’ve created your first ATP instance.

[Return to Main Page](README.md)
