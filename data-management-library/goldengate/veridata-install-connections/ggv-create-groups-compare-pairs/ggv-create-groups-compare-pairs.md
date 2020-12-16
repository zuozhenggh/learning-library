# Create Groups and Compare Pairs

## Introduction
This lab describes how to groups and compare pairs. Groups are logical containers for one or more compare pairs. They help you to organize and partition large or diverse sets of data into more manageable units. Groups are linked to jobs when jobs are created. Any group can be linked to one or more jobs, allowing you complete control over how and when data is compared.

A group is associated with a set of connections to the source and target data.

A compare pair is the logical relationship between a source table or file and a target table or file for the purpose of comparing their data. Compare pairs are linked to groups. Because of this, all of the source and target objects that you configure into compare pairs for any given group must be accessible from the datasource connections that are associated with that group.

### What Do You Need?

+ **Oracle GoldenGate Veridata installed**
+ **Source and Target connections as described in Lab 2**

## **STEP 1:** Create a Group

  To create a group:
1. From the left navigation pane, click **Configuration** and then click **Group Configuration** to display the **Group configuration** page.
    ![](./images/1-group-configuration.png " ")
2. Click **New** to display the **New Group Assistant** page to create a group.
3. Click **Browse** to select a template for the group from the **From** drop-down list.
4. Enter the **Name** and **Description** for the Group and click **Next**.
  ![](./images/2-new-group-from-name-description.png " ")
4. Click **Next** to enter the connection information.
5. Browse to select the **Source Connection** and **Target Connection** (that you have created in Lab 2).
  ![](./images/3-new-group-connection-information.png " ")
6. Click **Finish**.
Your new Group has been created.

## **STEP 2:** Create Compare Pairs (on Manual Mapping Tab)
Use the **Manual Mapping** tab to map source objects to target objects one at a time. This method is useful when source and target names differ vastly and cannot be mapped by using wildcards.
To create compare pairs on the **Manual Mapping** tab:
1. After you have created the Group, click **Go to Compare Pair Configuration...** check box in the **New Group Assistant** page to display the **Compare Pair Configuration** page.
    ![](./images/4-new-group-create-compare-pair-checkbox.png " ")
2. Click **Manual Mapping**.
3. Select a Source **Schema** and a Target **Schema** under **Datasource Information**.
    ![](./images/5-compare-pair-manual-mappng-select-tables.png " ")
4. Click **Generate Compare Pair** to add the compare pair to the preview list.
    ![](./images/6-generate-compare-pair-manual-mappng.png " ")
5. Go the **Preview** tab and click **Save** to save the generated compare pair. The control moves to the **Existing Compare Pairs** tab.
    ![](./images/7-compare-pair-manual-mapping-generated-saved-existingCPtab.png " ")
Similarly, you can create any compare pairs for other tables.

## **STEP 3:** Create Compare Pairs (on Pattern Mapping Tab)
Use the **Pattern Mapping** tab to map numerous source and target objects at once by using:

    * An exact name match (for example TAB1=TAB1).
    * A SQL percent (%) wildcard or an asterisk (*) wildcard to map differently named source and targets whose naming conventions support wildcarding.
To create compare pairs on the **Pattern Mapping** tab:
1. In the **Compare Pair Configuration** page, click **Pattern Mapping**.
2. Select a Source **Schema** and a Target **Schema** under **Datasource Information**.
3. Under **Pattern Compare Pair Mapping**, select a **Table Mapping Method**. You can select any of the following:
    * **Map Source and Target Tables Using Exact Names**: Let's select this option here:
        [](./images/9-pattern-mapping-pair-mapping-option1.png " ")
	  * **Map Source and Target Tables Using SQL % Wildcard Pattern. (Use only one % on each side.)**
        [](./images/8-pattern-mapping-pair-mapping-option2.png " ")
    * **Map Source and Target Tables Using GoldenGate * Wildcard Pattern. (Use only one * on each side.)**
        [](./images/10-pattern-mapping-pair-mapping-option3.png " ")
4. Click **Generate Mappings**. The control moves to the **Preview** tab.
5. Click **Save** save the generated compare pair. The control moves to the **Existing Compare Pairs** tab.
    [](./images/11-pattern-mapping-pair-saved-existing-compare-pairs.png " ")


## Want to Learn More?

* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Configuring Groups](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-70B42ABB-EA8E-4ADF-8414-7EA1752CA7E6)
* [Compare Pairs](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-055CE119-0307-4826-98C7-A51F53E28763)

## Acknowledgements

* **Author:**
    + Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Reviewed by:**
    + Avinash Yadagere, Principal Member Technical Staff, Oracle GoldenGate Development
    + Sukin Varghese, Senior Member of Technical staff, Database Test Dev/Tools/Platform Testing

* **Last Updated By/Date:** Anuradha Chepuri, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*. Please include your workshop name and lab name.  You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
