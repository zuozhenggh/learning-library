# Provision Instances

## Introduction

This lab walks you through the process of provisioning a Visual Builder Studio instance and a separate Visual Builder instance, assuming you don't already have both available to you. If you do, you can skip this lab and move on to the next one.


Estimated Lab Time: 10 minutes

### Background
If you just created a new Cloud account following the instructions in Getting Started, you must wait at least 30 minutes before you attempt to create an instance of Visual Builder and Visual Builder Studio. (It could take anywhere between 10 and 30 minutes for a new user account to be fully provisioned and for the navigation menu to show.) If you already have a Cloud account, you don't need to wait. Either way, make sure you've signed in to the Oracle Cloud as an Oracle Identity Cloud Service user before proceeding. *Note: If you log in using an Oracle Cloud Infrastructure account, the navigation menu to Visual Builder won't show.*

## **STEP 1**: Create an Instance of Visual Builder
Provision a service instance of Visual Builder to deploy and host apps created in Visual Builder Studio. The Visual Builder instance serves as the runtime environment for the web app that you will create in Visual Builder Studio.

1.  On the Oracle Cloud Get Started page, click the menu in the upper left corner to display the services you can provision:

    ![](./images/hamburger.png)

2.  Click **OCI Classic Services**, then select **Visual Builder**:

    ![](./images/platform.png)

3.  On the Instances tab, click **Create Instance**:

    ![](./images/create_instance.png)


4.  On the Create Instance page, fill in the information required.  Give your instance a unique name, one that is unlikely to be chosen by another user.  Be sure to select the Region nearest to your location.  Click **Next**.

    ![](./images/detail.png)

    When the instance has finished provisioning, you'll receive an email.  

5. From the Action menu on the Instances page, click **Open Visual Builder Home Page**.

   ![](./images/open.png)

## **STEP 2:** Create an Instance of Visual Builder Studio
Provision a service instance of Visual Builder Studio to design and develop your web app. You can create only one Visual Builder Studio instance in an Oracle Cloud account. Before you attempt to create an instance, make sure there's no existing Visual Builder Studio instance in your account.

1. Navigate back to your Cloud Console and click on the hamburger menu on top left, click **OCI Classic Services**, then select **Developer**.

   ![](./images/oci-service-navigation-vbs.png)

2. On the Instances tab, click **Create Instance**:

    ![](./images/create_instance_vbs.png)

3. On the Create New Instance page, fill in the required information. Give your instance a unique name, then select the Region nearest to your location. Click **Next**.

   ![](./images/detail_vbs.png)

3. On the Confirmation page, click **Create**.

   ![](./images/confirm_vbs.png)

4. Once the service instance is created, click the Action menu icon on the Instances page and select **Access Service Instance**.

   ![](./images/access_instance_vbs.png)

   The Visual Builder Studio console opens on the Organization page. When you first log in, you see the Welcome page with a link to an introductory video, along with a news feed of additional screens. Close **X** to dismiss the news feed and expand your work area.
   ![](./images/vbs_home.png)  

5. Before you can create a project, you'll need to configure some OCI connections; select the **OCI Account** tab, then click **Connect**.

   ![](./images/vbs_oci_tab.png)

6. Configure OCI Account Credentials. You will need the following credentials:
    - Tenancy OCID
    - User OCID
    - Home Region
    - Private key
    - Fingerprint
    - Compartment OCID
    - Storage Namespace

   First, let's retrieve the **Tenancy OCID**, **Home Region**, and **Storage Namespace**.

7. Return to your Oracle Cloud Home page and in the navigation menu, select **Governance & Administration**, then under **Account Management**, select **Tenancy Details**.

   ![](./images/oci-credentials.png)

8. In a notepad, copy and paste the Tenancy OCID from the **OCID**, Home Region from the **Home Region**, and the Storage Namespace from the **Object Storage Namespace**.

   ![](./images/oci-credentials-tenancydetails.png)

   Now, let's retrieve the **User OCID** and **Fingerprint**.

9. Click the navigation menu again and select **Identity & Security**. Under **Identity**, select **Users**.

   ![](./images/oci-credentials-identity.png)

10. On the Users page, click your Oracle Cloud Identity Service user.

   ![](./images/oci-credentials-users.png)

11. On the Users page, copy the User OCID from **OCID**.

12. To retrieve the fingerprint of the public key associated with your OCI account, scroll down, select API Keys, and copy the fingerprint value.

13. Let's get the Compartment OCID. In the left navigation menu, select **Compartments**.

   ![](./images/oci-credentials-compartments.png)

14. Copy and paste the OCID to your notepad.

15. Finally, let's grab the private key. The private key file was generated and saved on your computer when you created the private-public key pair in the PEM format. As you recall, we copied the private key at the beginning of this lab and pasted it into a notepad. Copy the private key and make sure to include -----BEGIN RSA PRIVATE KEY----- and -----End RSA PRIVATE KEY-----

16. With all of the necessary information copied, go back to Visual Builder Studio and fill out the Configure OCI Account page. After entering the information, check the Visual Builder Studio Requirements box, click **Validate**, then **Save**.









## Acknowledgements
**Author** - Sheryl Manoharan, Visual Builder User Assistance

**Last Updated** - August 2021
