# Send the Trail File from Oracle GoldenGate to OCI GoldenGate

## Introduction

This lab walks you through the steps to create and run a Distribution Path on Oracle GoldenGate.

Estimated Lab Time: 10 minutes

### About Distribution Paths
A Distribution Path is a source-to-destination configuration that uses the Distribution Server.

### Objectives

In this lab, you will create and run a path on the Distribution Server to send a Trail file from Oracle GoldenGate to OCI GoldenGate.

## **STEP 1**: Create and Run a Distribution Path

1. Open the Oracle GoldenGate Distribution Server in your web browser.

2. Click **Add Path**.

3. Complete the field as follows:

   * For **Path Name**, enter a name for this Path. For example, **OGGtoGGS**.
   * For **Description**, describe the purpose of this Path.
   * Enable **Reverse Proxy enabled?**.
   * Enable **Use Basic Authentication**.
   * For **Source Trail File**, enter the name of the OGG Trail file you're sending to OCI GoldenGate.
   * For **Target Host**, enter the OCI GoldenGate hostname in the following format: **<domain>.deployment.goldengate.us-<region>-1.oci.oraclecloud.com:443**. You can copy the host from the browser address bar of your OCI GoldenGate Deployment Console window.
   * For **Target Trail Name**, enter a two character name for the Trail file when it is received by OCI GoldenGate.
   * For **Target Deployment Name**, enter the your OCI GoldenGate Deployment name.
   * For **Target Domain**, enter the domain name you created on Oracle GoldenGate. For example, GGSNetwork.
   * For **Target Alias**, enter the alias name you created on Oracle GoldenGate.

4. Click **Create**.

5. Return to the Distribution Server Overview page, and then select **Start** from the Path's **Action** menu.

In this lab, you created and ran a Path on your on premise Oracle GoldenGate Distribution Server and sent a trail file from Oracle GoldenGate to OCI GoldenGate.


## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Werner He, Database Product Management
* **Last Updated By/Date** - March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
