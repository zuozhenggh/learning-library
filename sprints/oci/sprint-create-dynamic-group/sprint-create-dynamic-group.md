# How do I create a dynamic group?
Duration: 5 minutes

Dynamic groups allow you to group Oracle Cloud Infrastructure compute instances as "principal" actors (similar to user groups).

### Prerequisites
* An Oracle Cloud Account.

## Create a Dynamic Group Policy

You can create a dynamic group policy that includes the specific compartment OCID as a resource in the group as follows:

1. Sign in to the Console.

2. Open the **Navigation** menu and click **Identity & Security**. Under **Identity**, click **Dynamic Groups**.

3. On the **Dynamic Groups** page, click **Create Dynamic Group**. The **Create Dynamic Group** dialog box is displayed.

    ![The Create Dynamic Group dialog box is displayed.](./images/dynamic-group-db.png " ")

4. Specify the following:

    + **Name:** Enter a unique name.
    + **Description:** Enter an optional description.
    + In the **Matching Group** section, accept the default **Match any rules defined below** option.
    + Click the **Copy** button in the following code box to copy the dynamic rule, and then paste it in the **Rule 1** text box. This rule specifies that any _resource defined in this compartment is a member of this dynamic group_. You will substitute the _your-compartment-ocid_ with your own compartment OCID that you will identify in the next step. Make sure you don't delete the single quotation marks around the OCID value.

        ```
        <copy>resource.compartment.id='your-compartment-ocid'</copy>
        ```

5. To find your _Compartment OCID_, copy the URL in the address bar of your current browser tab where the **Create Dynamic Group** page is displayed. Open a new browser tab. For example, in Chrome, you click the **New tab** icon.

    ![The URL on the current tab in Chrome is highlighted and copied and labeled as 1. The New tab icon (plus icon) is clicked to create a new tab anxd labeled as 2.](./images/copy-url-new-tab.png " ")

6. Paste the copied URL into the address bar of the new tab.

    ![The copied URL is pasted in the new tab's address bar.](./images/paste-url-new-tab.png " ")

7. In the new tab, open the **Navigation** menu and click **Identity & Security**. Under **Identity**, click **Compartments**. On the **Compartments** page, in the row for _your own compartment_ (**training-dcat-compartment** in this example), hover over the **OCID** link in the **OCID** column, and then click the **Copy** link to copy the OCID for your compartment (**training-dcat-compartment** in this example).

    ![In the row for the training-dcat-compartment, hover over the OCID link in the OCID column, and then click the Copy link.](./images/copy-compartment-ocid.png " ")

8. Click the original tab where you were creating the dynamic group policy. Paste the copied compartment OCID value to replace the **'your-compartment-ocid'** placeholder in the **Rule 1** text box.

9. Click **Create**.

    ![The completed Create Dynamic Group dialog box is displayed. Rule 1 field and the Create button are highlighted.](./images/moviestream-dynamic-group-db.png " ")

10. The **Dynamic Group Details** page is displayed. Click **Dynamic Groups** in the breadcrumbs to re-display the **Dynamic Groups** page.

    The newly created dynamic group is displayed.

    ![The new dynamic group is displayed on the Dynamic Groups page.](./images/dynamic-group-created.png " ")

## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Managing Dynamic Groups](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm)
* [Data Catalog Policies](https://docs.oracle.com/en-us/iaas/data-catalog/using/policies.htm)
