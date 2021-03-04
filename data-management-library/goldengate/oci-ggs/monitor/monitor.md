# Monitor Extracts and Replicats

## Introduction

This lab walks you through the steps to monitor the Extract and Replicat processes that were created and run in the previous lab.

Estimated Lab Time: 2 minutes

### About Performance Monitoring
Monitoring the performance of your GoldenGate instance ensures that your data replication processes are running smoothly and efficiently. You can monitor performance in both the GoldenGate deployment console as well as in the Oracle Cloud Infrastructure Console on the Deployment Details page.

### Objectives

In this lab, you will:
* View charts and statistics using the Performance Metrics Server in the GoldenGate deployment console
* Use Metrics on the Deployment Details page in the Oracle Cloud Infrastructure Console to determine overall instance health and utilization.

### Prerequisites

In order to complete this lab, you should have completed the preceding lab and have both an Extract and Replicat running.

## **STEP 1**: Using the Performance Metrics Server

1. In the GoldenGate deployment console, click **Performance Metrics Server**.

   Note: You can also view performance details for the Administration, Distribution, and Receiver Servers, as well as any processes created.

2. Select **UAEXT** to view its performance details.

3. Click **Database Statistics**.

   Here, you can view the real time database statistics, such as Inserts, Updates, Deletes, and so on.

4. Repeat steps 1-3 to view a snapshot of the Replicat's (named **Rep** in our lab) Database Statistics.

## **STEP 2:** Viewing GoldenGate Metrics in the OCI Console

1. On the OCI GoldenGate Deployments page, select **GGSDeployment**.

2. On the GGSDeployment Details page, scroll down to the **Metrics** section.

3. Review the **DeploymentInboundLag** and **DeploymentOutboundLag** charts.

4. Refresh your view after 5 minutes to see updated metrics.

In this lab, you learned to monitor performance in the OCI GoldenGate Deployment Console and in the OCI Console.

## Learn More

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
