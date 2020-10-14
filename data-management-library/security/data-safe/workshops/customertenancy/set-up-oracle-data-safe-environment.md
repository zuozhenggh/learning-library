
# Set Up an Oracle Data Safe Environment

## Introduction

The following steps are intended for a tenancy administrator. The steps show you how to set up an Oracle Data Safe environment for a regular Oracle Cloud user.



### Objectives
- Create a cloud account for a regular Oracle Cloud user
- Create a user group and add the user to the group
- Create a compartment for the user
- Create a policy for the regular Oracle Cloud user that enables the user to manage the compartment
- Enable Oracle Data Safe in a region of your tenancy
- Grant all Oracle Data Safe privileges to the user group
- Send information to the user


### Prerequisites
- You require a tenancy administrator account to complete this setup.

### Assumptions

- You are a tenancy administrator.



## **STEP 1:** Create an Oracle Cloud account for a regular Oracle Cloud user

You can create a native or federated user account. Both are supported in Oracle Data Safe. The following steps show you how to create a native Oracle Cloud Infrastructure user account. If your tenancy uses federated user accounts, create the user account in the identity provider.

- Sign in to the Oracle Cloud Infrastructure Console using your tenancy administrator credentials.
- From the navigation menu, select **Identity**, and then **Users**. The **Users** page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.
- Click **Create User**.
- Enter a short form name for the user account, for example, `dsu01`.
- Enter a user description for the user account, for example, **Data Safe user 1**.
- Enter the email address for the user. Oracle will send an email to this address with instructions on how to sign in to the tenancy.

- Click **Create**. Details about the new user are displayed on the **User Information** tab. Notice that there is a **(Verification Pending)** message next to the email address.

- Click **Create/Reset Password**. The **Create/Reset Password** dialog box is displayed.

- Click the **Create/Reset Password** button. A new password is generated.

- Click the **Copy** link to copy the password to the clipboard. Save the password in your records.

- Click **Close**.




## **STEP 2:** Create a user group and add the user account to the group

- From the navigation menu, select **Identity**, and then **Groups**. The **Groups** page in IAM is displayed.

- Click **Create Group**. The **Create Group** dialog box is displayed.

- Enter a name for the group, for example, `dsg01` (short for Data Safe group 1)

- Enter a description for the group, for example, **User group for data safe user 1**. A description is required.

- (Optional) Create a tag.
- Click **Create**. The **Group Information** tab is displayed.

- Under **Group Members**, click **Add User to Group**. The **Add User to Group** dialog box is displayed.

- From the drop-down list, select the regular Oracle Cloud user account that you created (for example, `dsu01`), and then click **Add**. The user account is listed as a group member.



## **STEP 3:** Create a compartment for the user

  - From the navigation menu, select **Identity**, and then **Compartments**. The **Compartments** page in IAM is displayed.

  - Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

  - Enter a name for the compartment, for example, `dsc01` (short for Data Safe compartment 1).
  - Enter a description for the compartment, for example, **Compartment for Data Safe user 1**.
  - Click **Create Compartment**.


## **STEP 4:** Create a policy for the user group

Create a policy in IAM that grants permissions to the group to which the user belongs. The policy needs to allow the user to create and manage an Autonomous Database in the compartment.

- From the navigation menu, select **Identity**, and then **Policies**. The **Policies** page in IAM is displayed.

- Under **COMPARTMENT**, select the user's compartment.

- Click **Create Policy**. The **Create Policy** page is displayed.

- Enter a name for the policy. It is helpful to name the policy after the group to which the policy pertains, for example, `dsg01 `.

- Enter a description for the policy, for example, **Policy for Data Safe group 1**.

- Leave the **COMPARTMENT** field set to the user's compartment.

- In the **Policy Builder** section, do the following:

    - From the **POLICY USE CASES** drop-down list, select **Compartment Management**.

    - From the **COMMON POLICY TEMPLATES** drop-down list, select **Let compartment admins manage the compartment**.

    - From the **GROUPS** drop-down list, select the user group, for example, `dsg01`.

    - From the **LOCATIONS** drop-down list, select the user's compartment, for example, **dsc01**.

    - Verify that the policy statement generated reads: **Allow dsg01 to manage all-resources in compartment dsc01**.

- For **Policy Versioning**, leave **KEEP POLICY CURRENT** selected.

- Click **Create**.





## **STEP 5:** Enable Oracle Data Safe in a region of your tenancy

You can enable Oracle Data Safe in multiple regions of your tenancy, if needed. For the Oracle Data Safe Workshop, you need to enable Oracle Data Safe in at least one region of your tenancy. Be aware that you cannot disable Oracle Data Safe after it's enabled.

- From the navigation menu, select **Data Safe**. The **Overview** page is displayed.

- At the top of the page on the right, select the region in which you want to enable Oracle Data Safe, for example, **US East (Ashburn)**.
- Click **Enable Data Safe** and wait a couple of minutes for the Oracle Data Safe service to enable.

- Before continuing, verify that the following message is displayed in the upper-right corner: **Data Safe is enabled. Please click Service Console to use the features**.


## **STEP 6:** Grant all Oracle Data Safe privileges to the user group

- From the **Overview** page for Oracle Data Safe, click **Service Console** to access the Oracle Data Safe Console. As a tenancy administrator, you have all privileges in Oracle Data Safe.

- In the Oracle Data Safe Console, click the **Security** tab in the upper-right corner.

- From the **Compartment** drop-down list, select the user's compartment, for example, `dsc01`.

- For the user group that you created (for example, `dsg01`), select **Manage** from the **All Features** drop-down list.

- Click **Save**. The regular user can now access Oracle Data Safe.



## **STEP 7:** Send information to the user

When you are done setting up the environment, email the user with the following information:

- The user's password to access the Oracle Cloud Infrastructure Console.

- The user's compartment name.



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
