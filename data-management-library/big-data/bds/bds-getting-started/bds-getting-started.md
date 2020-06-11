# Set Up Your BDS Environment

## Introduction

In this lab, you will perform few tasks that are required to get started with BDS. Several of these tasks need to be performed by the Cloud Administrator for your tenancy. There are also optional tasks that make it easier to manage your environment. For example, creating compartments and groups are optional; however, they will simplify administration tasks as your environment expands.

### Objectives

* Learn how to create a compartment.
* Learn how to create a user that will be your BDS administrator.
* Learn how to create a BDS Administrators group.
* Learn how to add the BDS administrator to the BDS Administrators group.
* Learn how to create policies.
* Learn how to create a Virtual Cloud Network (VCN).

### What Do You Need?

Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console.


## STEP 1: Login to the Oracle Cloud Console

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

   ![](./images/oracle-cloud-console-home.png " ")    


## STEP 2: Create a Compartment
A Cloud Administrator can optionally create a compartment in your tenancy to help organize the Big Data Service resources. In this lab, as a Cloud Administrator, you will create a new compartment that will group all of your BDS resources.

1. Click the **Navigation** menu in the upper left-hand corner of the **Oracle Cloud Console** Home page.

2. Under **Governance and Administration**, select **Identity > Compartments**.

   ![](./images/training-governance-identity-compartment.png " ")

   **Note:**
   You can alternatively select **Governance and Administration > Identity**. This displays the **Users** page with the **Identity** panel displayed on the left. This panel enables you to easily display the **Users**, **Groups**, **Policies**, and **Compartments** pages that you will need to create the resources required in this lab.

   ![](./images/alternative-access.png " ")

3. On the **Compartments** page, click **Create Compartment**.

4. In the **Create Compartment** dialog box, enter **`training-compartment`** in the **NAME** field and **`Training Compartment`** in the **DESCRIPTION** field.

5. In the **PARENT COMPARTMENT** drop-down list, select your parent compartment, and then click **Create Compartment**.

   ![](./images/create-compartment.png " ")

   The **Compartments** page is re-displayed and the newly created compartment is displayed in the list of available compartments.

   ![](./images/compartment-created.png " ")

## STEP 3: Create an IAM User to Be the BDS Administrator

A Cloud Administrator has complete control over all of the BDS resources in the tenancy; however, it's a good practice to delegate cluster administration tasks to one or more BDS administrators. To create a new BDS administrator for a new service, a Cloud Administrator must create a user, and then add that user to a BDS administrators group. You create Identity and Access Management (IAM) groups with access privileges that are appropriate to your needs.

For the simple case, you can create the following two groups:

* An **Administrators** group, whose members have complete administrative rights over the resources in the tenancy or compartment, and
* A **Users** group, whose members have read access to the cluster and appropriate rights for working with data.

In more complex situations, you may need multiple administrator groups whose access is restricted to certain compartments or to certain resources, such as networking, clusters, storage, and so on.

Create a new **Administrator** group that will have full access rights to the new compartment that you created earlier as follows:

1. In the **Oracle Cloud Console** Home page, click the **Navigation** menu.

2. Under **Governance and Administration**, select **Identity**, and then click **Users**.

3. On the **Users** page, click **Create User**.

4. In the **Create User** dialog box, enter **`training-bds-admin`** in the **NAME** field, **`training BDS Admin User`** in the  **DESCRIPTION** field, and an optional email address for the user in the **EMAIL** field, and then click **Create**.

  **Note:**
  An email address can be used as the user name, but it isn't required.

   ![](./images/create-user.png " ")

5. The **Users** page is re-displayed and the newly created user is displayed in the list of available users.

   ![](./images/user-created.png " ")

## STEP 4: Create an IAM BDS Administrators Group and Add the New User to the Group

Create a BDS group whose members will be granted permissions to manage the BDS cluster life cycle.

1. In the **Oracle Cloud Console** Home page, click the **Navigation** menu.

2. Under **Governance and Administration**, select **Identity**, and then click **Groups**.

3. On the **Groups** page, click **Create Group**.

   ![](./images/create-group.png " ")

4. In the **Create Group** dialog box, enter **`training-bds-admin-group`** in the **Name** field and **`Training BDS Admin. Group`** in the **Description** field, and then click **Create**.

   ![](./images/create-group-dialog-box.png " ")

5. The **Groups** page is re-displayed and the newly created group is displayed in the list of available groups. Click the _training-bds-admin-group_ name link.   

   ![](./images/group-created.png " ")

6. On the **Group Details** page, in the **Group Members** section, click **Add User to Group**.

   ![](./images/group-details.png " ")

7. In the **Add User to Group** dialog box, select the **`training-bds-admin`** user that you created earlier from the **USERS** drop-down list, and then click **Add**.

   ![](./images/add-user-group.png " ")

    **Note:**
    If you haven't created the user who will be an administrator yet, go back to **STEP 3: Create an IAM User to be the BDS Administrator to create the user**, and then return to this step.

8. The **Group Details** page is re-displayed and the newly added user to this group is displayed in the **Group Members** section.

   ![](./images/user-added-to-group.png " ")

## STEP 5: Create Policies for Administering Your Service
Create Oracle Cloud Infrastructure Identity and Access Management (IAM) policies to grant privileges to users and groups to use and manage Big Data Service resources. Before you can create a cluster, you must also create a policy that grants the system access to networking resources.

1. In the **Identity** pane on the left, select **Policies**. Alternatively, in the **Oracle Cloud Console** Home page, click the **Navigation** menu, and then navigate to **Governance and Administration > Identity > Policies**.

2. On the **Policies** page, if your compartment is not selected, use the **COMPARTMENT** drop-down list in the **List Scope** section to search for and select the **`training-compartment`** where the new policies will reside.  

   ![](./images/search-box.png " ")

   **Note:** You can use the **Search compartments** text box to quickly find your compartment.

3.  Click **Create Policy**.  

    ![](./images/policies-page.png " ")

4. In the **Create Policy** dialog box, provide the following information:

      + Enter **`training-admin-policy`** in the **NAME** field.
      + Enter **`Training Admin Group Policy`** in the **DESCRIPTION** field.
      + Select the **KEEP POLICY CURRENT** option.
      + Use the **COMPARTMENT** drop-down list to select your compartment, if you have not done that yet.
      + In the **Policy Statements** section, copy the following policy statement, and then paste it in the **STATEMENT 1** box:

        ```
        <copy>allow group training-bds-admin-group to manage virtual-network-family in compartment training-compartment</copy>
        ```
      + Click **+ Another Statement** to add a **STATEMENT 2** text box to the **Policy Statements** section. Copy the following policy statement, and then paste it in the **STATEMENT 2** box:    

        ```
        <copy>allow group training-bds-admin-group to manage bds-instance in compartment training-compartment</copy>
        ```

       ![](./images/create-policy-1-dialog.png " ")

      + Click **Create**. The newly created policy is displayed in the list of available policies.

        ![](./images/policy-1-created.png " ")


10. Create a new policy granted on the compartment that contains the network resources that will be used by the BDS cluster(s). The policy statement in this new policy grants the system the rights to interact with various networking components. Click **Create Policy**.  

11. In the **Create Policy** dialog box, provide the following information:

    + Enter **`training-bds-policy`** in the **NAME** field.
    + Enter **`Training BDS Service Policy`** in the **DESCRIPTION** field.
    + Select the **KEEP POLICY CURRENT** option.
    + Use the **COMPARTMENT** drop-down list to select your compartment, if it's not yet selected.
    + In the a **Policy Statements** section, copy the following policy statement and paste it in the **STATEMENT 1** box:

        ```
        <copy>allow service bdsprod to {VNIC_READ, VNIC_ATTACH, VNIC_DETACH, VNIC_CREATE, VNIC_DELETE,VNIC_ATTACHMENT_READ, SUBNET_READ, VCN_READ, SUBNET_ATTACH, SUBNET_DETACH, INSTANCE_ATTACH_SECONDARY_VNIC, INSTANCE_DETACH_SECONDARY_VNIC} in compartment training-compartment</copy>
        ```
    ![](./images/create-policy-2-dialog.png " ")

    + Click **Create**.
    + The newly created policy is displayed in the list of available policies.

      ![](./images/policy-2-created.png " ")


## STEP 6: Create a Virtual Cloud Network (VCN)
Setup (create) the Virtual Cloud Network to be used by your Big Data Service; alternatively, if you already have an existing VCN, you can use it instead of creating a new one. Your existing VCN must be  using a Regional subnet and the appropriate ports must be opened. In this section, you will create a new VCN.       

1. In the **Oracle Cloud Console** Home page, click the **Navigation** menu, and then navigate to **Networking > Virtual Cloud Networks**.

   ![](./images/navigate-to-vcn-page.png " ")

2. On the **Virtual Cloud Networks** page, click **Start VCN Wizard**.  

   ![](./images/vcn-page.png " ")

3. In the **Start VCN Wizard** dialog box, select **VCN with Internet Connectivity**, and then click **Start VCN Wizard**.

   ![](./images/start-vcn-wizard.png " ")        

3. The **Configuration** page of the wizard is displayed.

    In the **Basic Information** section, provide the following information:
    + **VCN Name:** Enter **`training-vcn`**.
    + **Compartment:** Select **`training-compartment`**.

    ![](./images/basic-information.png " ")        

    In the **Configure VCN and Subnets** section, provide the following information:
    + **VCN CIDR BLOCK:** Enter the range of IP addresses for the network as a Classless Inter-Domain Routing (CIDR) block such as **`10.0.0.0/16`**.
    + **Public Subnet CIDR Block:** Enter the CIDR block for the public subnet such as **`10.0.0.0/24`**.
    + **Private Subnet CIDR Block:** Enter the CIDR block for the private subnet such as **`10.0.1.0/24`**.
    + In the **DNS RESOLUTION** section, select the **USE DNS HOSTNAMES IN THIS VCN** check box. This allows the use of host names instead of IP addresses for hosts to communicate with each other.

    ![](./images/configure-vcn-subnets.png " ")        

4. Click **Next**. The **Review and Create** wizard's page is displayed. Review the details of the VCN. If you need to make any changes, click **Previous** and make the desired changes.

   ![](./images/vcn-review.png " ")

5. Click **Create**.

   ![](./images/create-vcn.png " ")

6. When the VCN is created, you can click **View Virtual Cloud Network** to see the details of the network on the **Virtual Cloud Network Details** page.

   ![](./images/view-vcn.png " ")

7. The newly created VCN details page is displayed.

   ![](./images/vcn-details.png " ")

## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)

## Acknowledgements
* **Author** - Martin Gubar, Director, Oracle Big Data Product Management
* **Last Updated By/Date** - Lauran Serhal, Oracle Database and Big Data User Assistance, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
