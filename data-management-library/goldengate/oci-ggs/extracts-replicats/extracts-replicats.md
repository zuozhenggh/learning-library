# Create and Run Extracts and Replicats

## Introduction

This lab walks you through the steps to create an Extract and a Replicat in the Oracle GoldenGate deployment console.

Estimated Lab Time: 10 minutes

### About Product/Technology
Extract definition

Replicat definition

### Objectives

In this lab, you will:
* Log in to the Oracle GoldenGate deployment console
* Create and run an Extract
* Create and run a Replicat

## **STEP 1**: Log in to the Oracle GoldenGate deployment console

1. Log in to Oracle Cloud Infrastructure and navigate to the GoldenGate service using the Console navigation menu.

2. From the list on the Deployments page, select a **GGSDeployment**.

3. On the Deployment Details page, click **Launch Console**.

    ![Click Launch Console](images/01-03-ggs-launchconsole.png)

4. On the OCI GoldenGate Deployment Console sign in page, enter **oggadmin** for User Name and **oggadmin-A1** for Password, and then click **Sign In**.

    ![OCI GoldenGate Deployment Console Sign In](images/01-04-ggs-console-signin.png)

## **STEP 2:** Create and Run an Extract

1. On the GoldenGate Deployment Console dashboard, click the plus (+) icon for Extracts.

    ![Click Add Extract](images/02-02-ggs-add-extract.png)

2. On the Add Extract page, select **Integrated Extract**, and then click **Next**.

3. For **Process Name**, enter UAEXT.

4. For **Trail Name**, enter E1.

    ![Add Extract - Basic Information](images/02-04-ggs-basic-info.png)

5. Under **Source Database Credential**, for **Credential Domain**, select **OracleGoldenGate**.

6. For **Credential Alias**, select the **SourceATP**.

    ![Add Extract - Source Database Credential](images/02-04-ggs-src-db-credential.png)

7. Under Managed Options, enable **Critical to deployment health**.

8. Click **Next**.

9. On the Parameter File page, in the text area, add a new line and the following text:

    ```
    <copy>Table SRC_UA_USER.*;</copy>
    ```

10. Click **Create**.

11. In the breadcrumb, click **Overview**.

12. In the UAEXT **Actions** menu, select **Start**.

    ![Start Extract](images/02-12-ggs-start-extract.png)

    The yellow exclamation point icon changes to a green checkmark.

    ![Extract started](images/02-ggs-extract-started.png)

## **STEP 3**: Create and Run the Replicat

1. On the GoldenGate Deployment Console dashboard, click the plus (+) icon for Replicats.

    ![Click Add Replicat](images/03-01-ggs-add-replicat.png)

2. On the Add Replicat page, select **Nonintegrated Replicat**, and then click **Next**.

3. On the Replicate Options page, for **Process Name**, enter **Rep**.

4. For **Trail Name**, enter E1.

5. Under **Target Database Credential**, from the **Credential Alias**  dropdown, select **TargetADW**.

    ![Add Replicat - Basic Information](images/03-05-ggs-replicat-basicInfo.png)

6. Under **Managed Options**, enable **Critical to deployment health**.

7. Click **Next**.

8. Click **Create**.

9. In the breadcrumb, click **Overview**.

    ![Click Overview](images/03-09-ggs-overview.png)

10. In the Rep Replicat **Actions** menu, select **Start**.

    ![Replicat Actions Menu - Start](images/03-10-ggs-start-replicat.png)

    The yellow exclamation point icon changes to a green checkmark.

In this lab, you created and ran an Extract and Replicat. You may now [proceed to the next lab](#next), to monitor these processes.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
