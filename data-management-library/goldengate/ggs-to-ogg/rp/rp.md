# Send the Trail File from Oracle GoldenGate to OCI GoldenGate

## Introduction

This lab walks you through the steps to create and run a Distribution Path on Oracle GoldenGate.

Estimated Lab Time: 10 minutes

### About Distribution Paths
A Receiver Path is a source-to-destination configuration that uses the Receiver Server.

### Objectives

In this lab, you will create and run a path on the Oracle GoldenGate Receiver Server to pull a Trail file from OCI GoldenGate.

## **STEP 1**: Add and Run an Extract in OCI GoldenGate

This Extract process captures data from the source database to send to OCI GoldenGate.

1.  On the GoldenGate Deployment Console Home page, click the plus (+) icon for Extracts.

    ![Click Add Extract](images/02-02-ggs-add-extract.png)

2.  On the Add Extract page, select **Integrated Extract**, and then click **Next**.

3.  For **Process Name**, enter UAEXT.

4.  For **Trail Name**, enter E1.

    ![Add Extract - Basic Information](images/02-04-ggs-basic-info.png)

5.  Under **Source Database Credential**, for **Credential Domain**, select **OracleGoldenGate**.

6.  For **Credential Alias**, select the **SourceATP**.

    ![Add Extract - Source Database Credential](images/02-04-ggs-src-db-credential.png)

7.  Under Managed Options, enable **Critical to deployment health**.

8.  Click **Next**.

9.  On the Parameter File page, in the text area, add a new line and the following text:

    ```
    <copy>Table SRC_OCIGGLL.*;</copy>
    ```

10. Click **Create**. You're returned to the OCI GoldenGate Deployment Console Home page.

11. In the UAEXT **Actions** menu, select **Start**. In the Confirm Action dialog, click **OK**.

    ![Start Extract](images/02-12-ggs-start-extract.png)

    The yellow exclamation point icon changes to a green checkmark.

    ![Extract started](images/02-ggs-extract-started.png)

    
## **STEP 2**: Create and Run a Receiver Path on Oracle GoldenGate

1.  Open the Oracle GoldenGate Marketplace Receiver Server in your web browser.

2.  Click **Add Path**.

3.  On the Add Path page, for **Path Name**, enter a name for this Path. For example, **GGStoOGG**.

4.  For **Description**, describe the purpose of this Path.

5.  Enable **Use Basic Authentication**.

6.  For **Source Host**, enter the OCI GoldenGate hostname in the following format: **&lt;domain&gt;.deployment.goldengate.us-&lt;region&gt;-1.oci.oraclecloud.com:443**. You can copy the host from the browser address bar of your OCI GoldenGate Deployment Console window.

7.  For **Source Trail Name**, enter the name of the OCI GoldenGate Trail file you're sending to Oracle GoldenGate.

8.  For **Source Deployment Name**, enter the your OCI GoldenGate Deployment name.

9.  For **Source Domain**, enter the domain name you created on Oracle GoldenGate. For example, **GGSNetwork**.

10. For **Source Alias**, enter the alias name you created on Oracle GoldenGate.

11. For **Target**, enter a two character name for the Trail file when it is received by Oracle GoldenGate.

12. Click **Create Path**.

13. Return to the Receiver Server Overview page, and then select **Start** from the Path's **Action** menu.

In this lab, you created and ran a Path on your on premise Oracle GoldenGate Receiver Server and pulled a Trail file from OCI GoldenGate to Oracle GoldenGate.

## **STEP 3**: Add and Run a Replicat

This Replicat process consumes the trail file sent from Oracle GoldenGate.

1.  Launch the Oracle GoldenGate Administration Server and log in.

2.  Click **Add Replicat** (plus icon).

    ![Click Add Replicat](images/03-01-ggs-add-replicat.png)

3.  On the Add Replicat page, select **Nonintegrated Replicat**, and then click **Next**.

4.  On the Replicate Options page, for **Process Name**, enter **Rep**.

5.  For **Credential Domain**, select **OCIGoldenGate**.

6.  For **Credential Alias**, select **TargetADW**.

7.  For **Trail Name**, enter R1.

8.  Under **Managed Options**, enable **Critical to deployment health**.

9.  Click **Next**.

10.  In the **Parameter File** text area, replace **MAP \*.\*, TARGET \*.\*;** with **MAP SRC\_OCIGGLL.\*, TARGET SRCMIRROR\_OCIGGLL.\*;**

11. Click **Create**.

12. In the Rep Replicat **Action** menu, select **Start**.

    ![Replicat Actions Menu - Start](images/03-10-ggs-start-replicat.png)

    The yellow exclamation point icon changes to a green checkmark.  

## Learn More

* [Create a Receiver Path](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/goldengate-deployment-console.html#GUID-F2366D03-55DE-4C90-91FA-7D66491BE1AE)


## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Werner He and Julien T, Database Product Management
* **Last Updated By/Date** - June 2021
