
# Set Up an Oracle Data Safe Environment

## Introduction

The following steps are intended for a tenancy administrator. The steps show you how to set up an Oracle Data Safe environment for a regular Oracle Cloud user.



### Objectives
- Create a cloud account for a regular Oracle Cloud user
- Create a user group and add the user to the group
- Create or dedicate a compartment for a regular Oracle Cloud user
- Create a policy for the regular Oracle Cloud user that enables the user to manage the compartment
- Enable Oracle Data Safe in a region of your tenancy
- Grant all Oracle Data Safe privileges to the user group


### Prerequisites
- You require a tenancy administrator account to complete this setup.

### Assumptions

- You are a tenancy administrator.



## **STEP 1:** Create an Oracle Cloud account for a regular Oracle Cloud user

You can create a native or federated user account. Both are supported in Oracle Data Safe. The following steps show you how to create a native Oracle Cloud Infrastructure user account. If your tenancy uses federated user accounts, create the user account in the identity provider.

- Sign in to Oracle Cloud Infrastructure using your tenancy administrator credentials.
- From the navigation menu, select **Identity**, and then **Users**. The **Users** page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.
- Click **Create User**.
- Enter a short form name for the user account, for example, `dsu01`.
- Enter a user description for the user account, for example, **Data Safe user 1**.
- Enter the email address for the user. Oracle will send an email to this address with instructions on how to sign in to the tenancy.

- Click **Create**. The user account is listed on the **Users** page.
- Click the name of the user account. Details about the account are displayed. Notice that there is a **(Verification Pending)** message next to the email address.


## **STEP 2:** Create a user group and add the user account to the group

- From the navigation menu, select **Identity**, and then **Groups**. The **Groups** page in IAM is displayed.

- Click **Create Group**. The **Create Group** dialog box is displayed.

- Enter a name for the group, for example, `dsg01` (short for Data Safe group 1)

- Enter a description for the group, for example, **User group for data safe user 1**. A description is required.

- (Optional) Create a tag.
- Click **Create**. The group is listed on the **Groups** page.

- Click the name of the group.
- Under **Group Members**, click **Add User to Group**. The **Add User to Group** dialog box is displayed.

- From the drop-down list, select the regular Oracle Cloud account that you created (for example, `dsu01`), and then click **Add**. The account is listed as a group member.



## **STEP 3:** Create or dedicate a compartment to a regular Oracle Cloud user

  - From the navigation menu, select **Identity**, and then **Compartments**. The **Compartments** page in IAM is displayed.

  - Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

  - Enter a name for the compartment, for example, `dsc01` (short for Data Safe compartment 1).
  - Enter a description for the compartment, for example, **Compartment1 for the Oracle Data Safe Workshop**.
  - Click **Create Compartment**.


## **STEP 4:** Create a policy for the user group

Create a policy in IAM that grants permissions to the group to which the user belongs. The policy needs to allow the user to create and manage an Autonomous Data Warehouse database in the compartment.

- From the navigation menu, select **Identity**, and then **Policies**. The **Policies** page in IAM is displayed.

- Click **Policies**.

- Under **COMPARTMENT**, select the compartment created for the regular Oracle Cloud user.

- Click **Create Policy**. The **Create Policy** dialog box is displayed.

- Enter a name for the policy. It is helpful to name the policy after the group to which the policy pertains, for example, `dsg01 `.

- Enter a description for the policy, for example, **Policy for Data Safe group 1**.

- For **Policy Versioning**, leave **KEEP POLICY CURRENT** selected.

- In the **STATEMENT** field, enter the following policy statement:

    `allow group dsg01 to manage all-resources in compartment dsc01`

    If you are using a different compartment name than `dsc01`, change the name above to it.

- Click **Create**.




## **STEP 5:** Enable Oracle Data Safe in a region of your tenancy

You can enable Oracle Data Safe in multiple regions of your tenancy, if needed. Be aware that you cannot disable Oracle Data Safe after it's enabled.

- From the navigation menu, select **Data Safe**. The **Overview** page is displayed.

- At the top of the page on the right, select the region in which you want to enable Oracle Data Safe, for example, **US East (Ashburn)**.
- Click **Enable Data Safe** and wait a couple of minutes for Oracle Data Safe to enable. When Oracle Data Safe is enabled, a confirmation message is displayed in the upper right corner.


## **STEP 6:** Grant all Oracle Data Safe privileges to the user group

- From the **Overview** page for Oracle Data Safe, click **Service Console** to access the Oracle Data Safe Console. As a tenancy administrator, you have all privileges in Oracle Data Safe.

- Click the **Security** tab.
- From the drop-down list, select the compartment for the regular Oracle Cloud user (for example, `dsc01`).
- Next to the user group that you created (for example, `dsg01`), select **Manage** from the **All Features** drop-down list.
- Click **Save**. The regular user can now access Oracle Data Safe.



## Learn More

- [Managing Compartments](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcompartments.htm)
- [Managing Users](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingusers.htm)
- [Managing Groups](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managinggroups.htm)
- [Map IdP Groups to IAM Groups](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/configure-access-oracle-data-safe-federated-users.html#GUID-FCDB76DE-CF45-4959-99DB-3A47FB89335C)
- [Enable Oracle Data Safe](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/enable-oracle-data-safe.html#GUID-409260CE-2D7B-4029-B7CA-2EDD6E961CEB)
- [Configure Authorization Policies](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/configure-authorization-policies.html#GUID-7C242B7D-EC37-4AE0-B060-73386E0BCF7F)


## Acknowledgements



- **Author**- Jody Glover, UA Developer, Oracle Data Safe Team
- **Last Updated By/Date** - Jody Glover, Oracle Data Safe Team, October 14, 2020


## See an issue?

Please submit feedback using this <a  href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" >form</a>. Please include the **workshop name**, **lab**, and **step** in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the **Feedback Comments** section.
