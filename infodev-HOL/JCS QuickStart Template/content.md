# Getting Started with Oracle Java Cloud Service by Using a QuickStart Template
## Before You Begin

This tutorial shows you how to create an Oracle Java Cloud Service instance and supporting database by using a QuickStart template. This tutorial takes approximately 10 minutes to complete. The typical wait time to provision your new instance is 30 to 60 minutes.

### Background
With Oracle Java Cloud Service, you can quickly create and manage a Java Platform, Enterprise Edition (Java EE) application environment in the cloud, without installing and configuring any software yourself. The environment is based on Oracle WebLogic Server and Oracle Database.

### What Do You Need?
To get started, you need valid credentials for an Oracle Cloud account that has an active subscription to Oracle Java Cloud Service. See [How to Begin with Oracle Java Cloud Service Subscriptions](http://www.oracle.com/pls/topic/lookup?ctx=cloud&id=JSCUG-GUID-8408EA3E-8058-470A-A414-DB9A840320D4).

## Access the Service Console

Follow these steps to create an ASP.NET Core Web Project in Visual Studio.

1. Sign in to [Oracle Cloud](https://cloud.oracle.com/en_US/sign-in).

2. On the Dashboard, click **Create Instance**.

    ![](images/dashboard-create.png "Dashboard Create")

3. Below **Featured Services**, next to **Java**, click **Create**.

   ![](images/dashboard-create-java.png "Dashboard Create Java Featured Services")

   If the QuickStart feature is not available in your account, follow this tutorial instead: [Creating a Custom Oracle Java Cloud Service Instance](https://apexapps.oracle.com/pls/apex/f?p=44785:112:0:::112:P112_CONTENT_ID:10021).

## Create a QuickStart Instance

1. Enter an **Instance Name**. For this tutorial, enter `MyJCS`.

   ![](images/quick-start-name.png "QuickStarts")

2. Below one of the available templates, click **Create**:
   * Simple Java Web App (2 OCPUs)
   * Multi-Tier Java EE App with High Availability (5 OCPUs)
   * Highly Available Java EE App with Caching (6 OCPUs)

   For help choosing a template, see the documentation.

3. Click **Download**. Save the archive file to your machine. It contains:
   * The username and password that you use to administer Oracle WebLogic Server

   * The system password that you use to administer Oracle Database

   * SSH keys that you use to access the VMs that host your service instances

4. Click **Create**. The Cloud Stack Console is displayed.

## Monitor the Instance Creation

1. Verify that the status of your **MyJCSQS** cloud stack is `Waiting or Creating Service`. A cloud stack is a group of Oracle Cloud resources that are created as a single unit.

   ![](images/stack-in-progress.png "Stacks")

2. Click the stack name, **MyJCSQS**.

3. Periodically, click **Refresh** ![Refresh icon](images/refresh.png) on the right side of the page until the status of the MyJCS instance is no longer `Waiting or Creating Service`.

   ![](images/stack-details-completed.png "MyJCS")

4. Click **MyJCS** to view and manage your new Oracle Java Cloud Service instance.

  **Tip:** To return to the cloud stack at a later time, click the **Dashboard** menu ![Dashboard Menu Icon](images\dashboard-menu.png), and then select **Cloud Stack**.

## Want to Learn More?

* [Product tour video](https://apexapps.oracle.com/pls/apex/f?p=44785:265:0::::P265_CONTENT_ID:10027)
* [QuickStart documentation](http://www.oracle.com/pls/topic/lookup?ctx=cloud&id=JSCUG-GUID-CE7CA098-F8D4-4BE2-AC7B-3D2D3AECD68D)
* [Tutorial: Deploy an application](http://apexapps.oracle.com/pls/apex/f?p=44785:112:0:::112:P112_CONTENT_ID:10014)
* [Tutorial: Create a custom service instance](http://apexapps.oracle.com/pls/apex/f?p=44785:112:0:::112:P112_CONTENT_ID:10021)
* [More tutorials](http://www.oracle.com/pls/topic/lookup?ctx=cloud&id=jcstutorials)
