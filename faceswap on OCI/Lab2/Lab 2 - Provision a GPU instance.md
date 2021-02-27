# Provision a GPU instance

## Introduction

In this lab, we will walk through the required steps to provision a GPU instance on OCI with Ubuntu running on it.

**Note:** A PAYG account is required to provision GPU instances on OCI. If you are using the Oracle Free Tier that consists of the Always Free offering and a 30-day free trial, you can make use of the VM.Standard.E2.1.Micro (included in the Always Free Offering) and all available VM and BMs instances (included in the 30-Day trial).

### Objectives

- Login to Oracle Cloud
- Provision a GPU instance on OCI

### What Do You Need?

- An user (with a username and password) that is part of a user group on OCI. Check the page [Managing users](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingusers.htm) to read how **To create a user** and how **To add a user to a group** using the console.
- Cloud Account Name - The name of your tenancy (supplied by the administrator or in your Oracle Cloud welcome email)
- A user group. Check the page [Managing groups](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managinggroups.htm#three) to read how **To create a group** using the console.
- Assigned policies to the group that let the users launch compute instances. Check the page [Common Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/Concepts/commonpolicies.htm#top) to read which policies you need **To let users launch Compute instances** using the console.
- A compartment for the user. Check the page [Managing Compartments](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcompartments.htm#uscons) to read how **To create a compartment** using the console.
- Check service limits for the allowed maximum number of GPU instances per availability domain in the region you wish to provision the GPU instance. To increase the service limit, follow the steps in the page [Service Limits](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm#top).

## **Step 1:** Login to Oracle Cloud

If you've signed out of the Oracle Cloud, use these steps to sign back in.

1. Go to [cloud.oracle.com](https://cloud.oracle.com) and enter your Cloud Account Name and click **Next**. This is the name you chose while creating your account in the previous section. It's NOT your email address. If you've forgotten the name, see the confirmation email.

   ![](images/cloud-oracle.png " ")

2. Expand the arrow after _"Oracle Cloud Infrastructure Direct Sign-In"_ to reveal the login input fields.

   ![](images/cloud-login-tenant.png " ")

3. Enter your Cloud Account credentials and click **Sign In**. Your username is your email address. The password is what you chose when you signed up for an account.

   ![](images/oci-signin.png " ")

4. You are now signed in to Oracle Cloud!

   ![](images/oci-console-home-page.png " ")

## **Acknowledgements**

- **Created By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
- **Last Updated By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a _New Discussion_ or _Ask a Question_. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
