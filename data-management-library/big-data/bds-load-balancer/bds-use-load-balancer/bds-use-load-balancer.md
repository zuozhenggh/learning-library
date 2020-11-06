#  Use a Load Balancer to Access Services on a Big Data Service Cluster

## Introduction

In this lab, you'll create a load balancer for your Big Data Service highly-available (HA) cluster. You'll configure the load balancer to function as a front end for connecting to Cloudera Manager, Hue, and Big Data Studio on the cluster.

You'll implement end-to-end Secure Sockets Layer (SSL) encryption for the load balancer by using self-signed SSL certificates that are included with the cluster.

### Objectives

In this lab, you will:

* Create an Oracle Cloud Infrastructure load balancer as a front end for your HA cluster.

* Use the load balancer to access Cloudera Manager, Hue, and Oracle Data Studio on the cluster.

### What Do You Need?

If you're new to Big Data Cloud Service, the fastest way to set up the environment you need to complete this lab is to complete the [Getting Started with Oracle Big Data Service (HA)](https://oracle.github.io/learning-library/data-management-library/big-data/bds/workshops/freetier/?lab=introduction-oracle-big-data-service) workshop.

Specifically, you need the following:

* A highly available (HA) Oracle Big Data Service cluster running in a Virtual Cloud Network (VCN) with an internet gateway and a public regional subnet (for a public load balancer).

* Security rules that allow incoming traffic to the ports where services run in the cluster: Cloudera Manager (port 7183), Hue (port 8889), and Big Data Studio (port 30000). See [Define Security Rules](https://docs.oracle.com/en/cloud/paas/big-data-service/user/define-security-rules.html#GUID-42EDCC75-D170-489E-B42F-334267CE6C92) in *Using Big Data Service*.

* Admin access to manage load balancers. For examples, see "Let network admins manage load balancers" in Common Policies in the Oracle Cloud Infrastructure documentation.

<!-- * IAM policy granting access to Cloud Shell

  allow group <GROUP-NAME> to use cloud-shell in tenancy
{Do  I need to have a section on setting the environment?} -->

* A Secure Shell (SSH) key pair. The key pair must include the private key that was associated with the cluster when it was create. In the steps below, the sample key pair files are named `my-ssh-key` (the private key) and `my-ssh-key.pub` (the public key used when the cluster was created).

* Access to the cluster file system (via SSH).

  You must be able to connect to nodes on your cluster to download self-signed SSL certificates that are stored on the cluster. To do this, prior to creating a load balancer, you must set up your environment to allow that access. For example you can use Oracle FastConnect or Oracle IpSec VPN, you can set up a bastion host, or you can map private IPs to public IP addresses. See Establish Connections to Nodes with Private IP Addresses.

* A list of the private IP addresses of the nodes where the services run on your cluster. In an HA cluster, the services run on the following nodes:

    * Cloudera Manager runs on the first utility node.

    * Hue and Big Data Studio run on the second utility node.

   In the steps below, the sample IP addresses are `10.2.0.101` (first utility node) and `10.2.0.102` (second utility node).

## **STEP 1:** Copy SSL Certificates from the Cluster

In this step, you'll obtain the self-signed SSL certificates that were automatically created with your cluster. You'll copy the contents of these files from the first and second utility nodes of your HA cluster.

In this step, you'll copy the following certificate and key from the _first_ utility node:

  * `/opt/cloudera/security/x509/`_&lt;first\_util\_node\_certificate&gt;_`.pem`

  * `/opt/cloudera/security/x509/node.hue.key`

...and you'll copy the following certificate and key from the _second_ utility node:

  * `/opt/cloudera/security/x509/`_&lt;second\_util\_node\_certificate&gt;_`.pem`

  * `/opt/cloudera/security/x509/node.hue.key`

You can save them as individual local files or you can save the contents of them in a file. The following procedure shows you one way to save the contents in a file. You'll later paste the contents of that file into fields in the Cloud Console.


The following steps assume you're running a recent version of Windows on a local machine. Windows includes an implementation of Secure Shell (SSH) and a command line shell called PowerShell, which you'll use below.

1. Create a text file with a name like `certs.txt` and enter four headings:

         "First Utility Node Certificate"

         "Second Utility Node Certificate"

         "First Utility Node Key"

         "Second Utility Node Key"

     For convenience, you'll use this file to store the certificate and key values that you'll need later when creating the load balancer.

1. On the Windows taskbar, right-click the **Windows** icon and select **Windows PowerShell**.

2. Use the `cd` command to change directory to the location of your SSH files, and use `ls` to display the files:

    ```
    PS C:\Users\DEV\> cd .ssh
    PS C:\Users\DEV\.ssh> ls

      Directory: C:\Users\DEV\.ssh

    Mode            LastWriteTime    Length Name
    ----            -------------    ------ ----
    -a----   12/12/2019  12:13 PM    1823 my-ssh-key
    -a----   12/12/2019  12:13 PM    392 my-ssh-key.pub
    ```

3. Use `ssh` to connect to the first node of your cluster:

    ```
    PS C:\Users\DEV\.ssh> ssh -i <private-ssh-key-file> opc@<first-utility-node-ip>
    ```

    For example:

    ```
    PS C:\Users\DEV\.ssh> ssh -i my-ssh-key opc@10.2.0.101
    [opc@myclustun0-0 ~]$
    ```

4. Change to the directory containing the SSL certificates and then list the directory to see its contents:

    ```
    [opc@myclustun0 ~]$ cd /opt/cloudera/security/x509/
    [opc@myclustun0 x509]$ ls
    agents.pem
    hostname.key
    hostname.pem
    hue.pem
    node_myclustmn0.sub12345678901.myclustevcn.oraclevcn.com.pem
    node_myclustmn1.sub12345678901.myclustevcn.oraclevcn.com.pem
    node_myclustun0.sub12345678901.myclustevcn.oraclevcn.com.pem
    node_myclustun1.sub12345678901.myclustevcn.oraclevcn.com.pem
    node_myclustwn0.sub12345678901.myclustevcn.oraclevcn.com.pem
    node_myclustwn1.sub12345678901.myclustevcn.oraclevcn.com.pem
    node_myclustwn2.sub12345678901.myclustevcn.oraclevcn.com.pem
    node.cert
    node.hue.key
    node.key
    ssl.cacerts.pem
    ssl.private.key
    ```

  The files with the `.pem` extension are the self-signed SSL certificates for all the nodes of the cluster. They are in Privacy Enhanced Mail (PEM) format. The `node.hue.key` file is the key for this first utility node.

6. Find the PEM file that includes the name of the first utility node, for example, `node_myclustun0.sub12345678901.myclustevcn.oraclevcn.com.pem`.

  (The first part of the name,
 `node_myclustun0...`, refers to the first utility node (`un0`) of the cluster named `mycluster`.)

 Use the `cat` command to display the contents:

    ```
    [opc@myclustun0 x509]$ cat node_myclustun0.sub12345678901.myclustevcn.oraclevcn.com.pem`
    -----BEGIN CERTIFICATE-----
    MIIDjTCCAnWgAwIBAgIEEZ+ZgDANBgkqhkiG9w0BAQsFADB3MQkwBwYDVQQGEwAx
    CTAHBgNVBAgTADEJMAcGA1UEBxMAMQkwBwYDVQQKEwAxCTAHBgNVBAsTADE+MDwG
    A1UEAxM1YmdlbGVybm1uMC0wLnN1YjA2MTgxOTE2NTQwLmJnZWxlcm50dmNuLm9y
    YWNsZXZjbi5jb20wHhcNMjAwOTAwb2teS5mMNpp/iZCrsLel7fI7TQyZe1R2aOD
    i7tFAcHLHipNVCV0HdSXI1GJbFt0oyNVt8+4gWwNOqAYUtNmlXJhSVc710x79+P8
    2P+VD4uomgIwvwTtYzSqeeqtu3+68pk3Nd1NvipNBLi083zC7EQ5cLDLyiE0LTf2
    J0LTvRSj7oOkR1FjKtD3ZU4sR7RmC0U87I1by9eaqITFbHYcGeRdzK1jgxDB9c0U
    YWNsZXZjbi5jb20wHhcNMjAwOTA...
    ...==
      -----END CERTIFICATE-----
    ```

6. Copy the entire contents of the file from the beginning of "``-----BEGIN CERTIFICATE-----``" to the end of "``-----END CERTIFICATE-----``" (without any added spaces or lines) and paste the contents under "First Utility Node Certificate" in your `certs.txt` file.

7. Find the PEM file that includes the name of the second utility node, for example, `node_myclustun1.sub12345678901.myclustevcn.oraclevcn.com.pem`. The first part of the name,
 `node_myclustun1...`, refers to the second utility node (`un1`) of the cluster named `mycluster`.

  Display the contents by using the `cat` command, as described above, and copy the contents into the `certs.txt` file under "Second Utility Node Certificate."

 8. Display the contents of the `node.hue.key` file, copy the entire contents from "-----BEGIN RSA PRIVATE KEY-----" to the end of "-----END RSA PRIVATE KEY-----" and paste them under "First Utility Node Key" in your `certs.txt` file:

    ```
      "First Utility Node Certificate"

      -----BEGIN CERTIFICATE-----
      MIIDjTCCAnWgAwIBAgIEEZ+ZgDANBgkqhkiG9w0BAQsFADB3MQkwBwYDVQQGEwAx
      CTAHBgNVBAgTADEJMAcGA1UEBxMAMQkwBwYDVQQKEwAxCTAHBgNVBAsTADE+MDwG
      A1UEAxM1YmdlbGVybm1uMC0wLnN1YjA2MTgxOTE2NTQwLmJnZWxlcm50dmNuLm9y
      YWNsZXZjbi5jb20wHhcNMjAwOTAwb2teS5mMNpp/iZCrsLel7fI7TQyZe1R2aOD
      i7tFAcHLHipNVCV0HdSXI1GJbFt0oyNVt8+4gWwNOqAYUtNmlXJhSVc710x79+P8
      2P+VD4uomgIwvwTtYzSqeeqtu3+68pk3Nd1NvipNBLi083zC7EQ5cLDLyiE0LTf2
      J0LTvRSj7oOkR1FjKtD3ZU4sR7RmC0U87I1by9eaqITFbHYcGeRdzK1jgxDB9c0U
      YWNsZXZjbi5jb20wHhcNMjAwOTA...
      ...==
      -----END CERTIFICATE-----

      "Second Utility Node Certificate"

      "First Utility Node Key"

      "Second Utility Node Key"
      ```


## **STEP 2:** Create the Load Balancer

1. In the Oracle Cloud Console, open the navigation menu navigation menu. Under Core Infrastructure, point to Networking, and then click Load Balancers.

2. On the **Load Balancers in *&lt;compartment&gt;* Compartment** page, under Compartment in the panel on the left, select the compartment where you want to create the load balancer. Then click Create Load Balancer.

3. On the **Add Details** page of the Create Load Balancer wizard, enter the following information:

     * **Load Balancer Name:** Enter a name to identify the load balancer.

     * **Choose Visibility Type:** Click **Public** to create a load balancer that will be accessible from the public internet.

      You could choose instead to select **Private** to create a load balancer that will be accessible only from your private network, but for simplicity these instructions describe how to create a public load balancer.

     * **Choose Total Bandwidth:** Select **Small**.

     * **Virtual Cloud Networking in <compartment>:** Click the **Select a virtual cloud network** list and select the VCN where your cluster is running. If the network is in a different compartment, click **Change Compartment** and select the compartment from the list.

     * **Subnet in <compartment>:** Click the **Select a subnet list** and select a public subnet in your VCN to use for the load balancer. (A public subnet is required for a public load balancer.) If the subnet is in a different compartment, click **Change Compartment** and select the compartment from the list.

     * **Use Network Security Groups to Control Traffic:** Leave this box unchecked.

4. Click **Next**.

5.  On the **Choose Backends** page of the wizard, enter the following information to create a backend set (with health policy) for Cloudera Manager:

    * **Specify a Load Balancing Policy:** Accept the default **Weighted Round Robin**.

    * **Select Backend Servers:** Skip this option. You'll add a backend server later.

    * **Specify Health Check Policy:** Enter the following for the health check policy for this Cloudera Manager backend set:

        * **Protocol:** Select **HTTP**.

        * **Port:** Enter **7183**, which is the port on which Cloudera Manager listens.

        * **URL Path (URI):** Keep the default forward slash (**/**).

        * **Use SSL:** Leave this box unchecked. You'll configure SSL for this backend set later.

6. Click **Next**.

    * On the **Configure Listener** page, enter the following information:

        * **Listener Name:** Enter a name for the listener, for example **`cm-listener`**.

        * **Specify the type of traffic your listener handles:** Select **HTTP**. You'll change this to HTTPS later.

        * **Specify the Port Your Listener Monitors for Ingress Traffic**: Enter **7183**.

    * Click **Submit**. When the large load balancer status icon load balancer status icon at the top of the **Load Balancer Details** page is green, you can continue with the steps below. It may take a few minutes to create the load balancer.

## **STEP 3:** Create Certificate Bundles

In this step, you'll save your SSL files as bundles, which you'll use later to configure SSL for backend sets and listeners.  


**RETURN HERE**

## **STEP 4:** Configure the Backend Set for Cloudera Manager

1. On the left side of the **Certificates** page, under **Resources**, click **Backend Sets**. The backend set you created in **STEP 2: Create the Load Balancer** is displayed in the **Backend Sets** table, with a name like **`bs_lb_<date-timestamp>`** for example, **bs\_lb\_2020-0928-1136**.

2. Click the **Action menu** at the end of the row containing this backend set, and select **Edit**.

3. Enter the following information.

    * **Name:** Read only. This name was created for you by the wizard.

    * **Traffic Distribution Policy:** Accept the default **Weighted Round Robin**.

    * **Use SSL:** Select this box, then, under **Certificate Name**, select **node0-self-signed-cert**. This is the bundle containing the self-signed SSL certificate for the first utility node of a the cluster.

    * **Verify Peer Certificate:** Check this box.

    * **Verify Depth:** Set to **1**.

    * **Session Persistence:** Accept the default **Disable Session Persistence**.

4. Click **Update Backend Set**, and then click **Close** in the **Work Request Submitted** dialog box. When complete, a cipher suite name is added to the **Cipher Suite** field for the backend set. It may take a few moments.

## **STEP 5:** Create a Backend Set for Hue

1. Remain on the **Backed Sets** page and click **Create Backend Set** again. On the **Create Backend Set** page, enter the following information.

    * **Name:** Enter a name, for example, **`hue-backend-set`**.

    * **Traffic Distribution Policy:** Accept the default **Weighted Round Robin**.

    * **Use SSL:** Select this box. Then, under **Certificate Name**, select  **node1-self-signed-cert**. This is the bundle containing the self-signed SSL certificate for the second utility node of the cluster.

    * **Verify Peer Certificate:** Check this box.

    * **Verify Depth:** Set to **1**.

    * **Session Persistence:** Accept the default **Disable Session Persistence**.

    * **Health Check:** Enter the following information:

        * **Protocol:** Select **TCP**.

        * **Port:** Enter **`8889`**, which is the port on which Hue listens.

2. Click **Create Backend Set**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the backend set to be added to the **Backend Sets** table.

## **STEP 6:** Create a Backend Set for Big Data Studio

1. Remain on the **Backend Sets** page and click **Create Backend Set** again. On the **Create Backend Sets** page, enter the following information.

    * **Name:** Enter a name, for example, **`data-studio-backend-set`**.

    * **Traffic Distribution Policy:** Accept the default **Weighted Round Robin**.

    * **Use SSL:** Select this box, then, under **Certificate Name**, select the **node1-self-signed-cert** certificate bundle. This is the bundle containing the self-signed SSL certificate for the second utility node of the cluster.

    * **Verify Peer Certificate:** Check this box.

    * **Verify Depth:** Set to **1**.

    * **Session Persistence:** Accept the default **Disable Session Persistence**.

    * **Health Check:** Enter the following information:

        * **Protocol:** Select **HTTP**.

        * **Port:** Enter **`30000`**, which is the port on which Big Data Studio listens.

        * **URL Path (URI)**: Enter a forward slash (**/**).

2. Click **Create Backend Set**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the backend set to be added to the **Backend Sets** table.

## **STEP 7:** Add a Backend Server for Cloudera Manager

1. Remain on the **Backend Sets** page. In the **Backend Sets** table, click the name of the backend set for Cloudera Manager, for example **bs\_lb\_2020-0928-1136**. (Remember, the wizard assigned this name to the first backend set.)

2. On the left side of the **Backend Set Details** page, under **Resources**, click **Backends**. Then click **Add Backends**.

3. On the **Add Backends** page, select **IP Addresses** at the top of the page, and enter the following information:

    * **IP Address**: Enter the private IP address of the first utility node of your cluster, for example `10.2.0.101`.

      * **Port:** Enter **`7183`**, which is the port on which Cloudera Manager listens.

      * **Weight:** Accept the default value **1**.

4. Click **Add**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the backend server to be added to the **Backends** table.

## **STEP 8:** Add a Backend Server for Hue

1. Click **Backend Sets** in the breadcrumbs at the top of the page to return to the **Backend Sets** page. In the **Backend Sets** table, click the name of the backend set you created for Hue, for example **hue-backend-set**.

2. On the left side of the **Backend Set Details** page, under **Resources**, click **Backends**. Then click **Add Backends**.

3. On the **Add Backends** page, select **IP Addresses** at the top of the page, and enter the following information:

    * **IP Address:** Enter the private IP address of the second utility node, for example **`10.2.0.102`**.

    * **Port:** Enter **`8889`**, which is the port on which Hue listens.

    * **Weight:** Accept the default value **1**.

4. Click **Add**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the backend server to be added to the **Backends** table.

## **STEP 9:** Add a Backend Server for Big Data Studio

1. Click **Backend Sets** in the breadcrumbs at the top of the page to return to the **Backend Sets** page. In the **Backend Sets** table, click the name of the backend set you created for Big Data Studio, for example **data-studio-backend-set**.

2. On the left side of the **Backend Set Details** page, under **Resources**, click **Backends**. Then click **Add Backends**.

3. On the **Add Backends** page, select **IP Addresses** at the top of the page, and enter the following information:

    * **IP Address:** Enter the private IP address of the second utility node, for example `10.2.0.102`.

    * **Port:** Enter **`30000`**, for the port where Big Data Studio listens.

    * **Weight:** Accept the default value **1**.

4. Click **Add**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the backend server to be added to the **Backends** table.

## **STEP 10:** Configure the Listener for Cloudera Manager

1. Click **Load Balancer Details** in the breadcrumbs at the top of the page. On the left side of the **Load Balancer Details** page, under **Resources**, click **Listeners**. Notice that the **Listeners** table includes the listener you created for Cloudera Manager in **STEP 2: Create the Load Balancer**, for example, **cm-listener**.

2. Click the **Action** menu at the end of the row containing the listener, and select **Edit**.

3. On the **Edit Listener** page, enter the following information:

    * **Name:** Read only.

    * **Protocol:** Select **HTTP**.

    * **Port:** Enter **`7183`**, which is the port on which Cloudera Manager listens.

    * **Use SSL:** Select this box. Then, under **Certificate Name**, select the certificate bundle **node0-self-signed-cert**. This is the bundle containing the self-signed SSL certificate for the first utility node of the cluster.

    * **Verify Peer Certificate:** Leave this box unchecked.

    * **Backend Set:** From the list, select the backend set you created for Cloudera Manager in **STEP 2: Create the Load Balancer**, for example, **bs\_lb\_2020-0928-1136**. (Remember, the wizard assigned this name when you created it.)

4. Click **Create Listener**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the listener to be added to the **Listeners** table.

## **STEP 11:** Create a Listener for Hue

1. Click **Backend Sets** in the breadcrumbs at the top of the page to return to the **Backend Sets** page.

2. On the left side of the page, under **Resources**, click **Listeners**.

3. Click **Create Listener**.

4. On the **Create Listener** page, enter the following information:

    * **Name:** Enter a name for the listener, for example, hue-listener.

    * **Protocol:** Select **HTTP**.

    * **Port:** Enter **`8889`**, which is the port on which Hue listens.

    * **Use SSL:** Select this box. Then, under **Certificate Name**, select the **node1-self-signed-cert** certificate bundle. This is the bundle containing the self-signed SSL certificate for the second utility node of the cluster.

    * **Verify Peer Certificate:** Leave this box unchecked.

    * **Backend Set:** From the list, select the backend set you created for Hue in **STEP 5: Create a Backend Set for Hue**, for example, **hue-backend-set**.

5. Click **Create Listener**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the listener to be added to the Listeners table.

## **STEP 12:** Create a Listener for Big Data Studio

1. Remain on the **Listeners** page. Click **Create Listener** again.

2. On the **Create Listener** page, enter the following information:

    * **Name:** Enter a name for the listener, for example, **data-studio-listener**.

    * **Protocol:** Select **HTTP**.

    * **Port:** Enter **30000**, which is the port on which Big Data Studio listens.

    * **Use SSL:** Select this box, then, under **Certificate Name**, select the **node1-self-signed-cert** certificate bundle. This is the bundle containing the self-signed SSL certificate for the second utility node of a the cluster.

    * **Verify Peer Certificate:** Leave this box unchecked.

    * **Backend Set:** From the list, select the backend set you created for Big Data Studio in **STEP 6: Create a Backend Set for Big Data Studio**, for example, **data-studio-backend-set**.

      ![](./images/create-load-bal-win2.png " ")


3. Click **Create Listener**, and then click **Close** in the **Work Request Submitted** dialog box. It may take a few moments for the listener to be added to the **Listeners** table.

## **STEP 13:** Access the Cluster

It may take a few minutes for the backend sets and listeners to be ready to receive requests. On the left side of the page, under **Resources**, click **Backend Sets**. In the **Backend Sets** table, check the status in the **Health** column. When the status for all the backend sets are **OK**, you can use the load balancer.

**Tip:** If it's taking a long time for the health check, consider shortening the interval. Click the **Action** menu at the end of the row containing a backend set, and select **Update Heath Check**. Change **Interval in Ms** to **1000** (the minimum interval) and **Timeout in Ms** to **500**. Repeat for each backend set. You can change the settings later if you want the health checks to be performed less often.

To open the services included in this load balancer:

1. Find the IP address or the hostname used for your load balancer.

      * IP address:

        The IP address is listed in the Load Balancer Information panel at the top of the load balancer pages in the console.

      * DNS hostname:

          After the load balancer is created and it's been given an IP address, you or another administrator must add a DNS entry to your DNS name servers, to resolve your desired hostname (for example, bds-frontend.mycompany.com) to the public IP address of the load balancer. Then, the services registered in the load balancer will be accessible by using that hostname, for example, `bds-frontend.mycompany.com:7183` for Cloudera Manager.

          For information about using DNS in Oracle Cloud Infrastructure, see [Overview of the DNS Service](https://docs.cloud.oracle.com/en-us/iaas/Content/DNS/Concepts/dnszonemanagement.htm) in the Oracle Cloud Infrastructure documentation.

2. In a web browser, enter the address as follows:

  * To use the load balancer's IP address: `https://`*`<load-balancer-ip>`*:*`<port>`*

  * To use the load balancer's hostname in a domain: `https://`*`<hostname>`*:*`<port>`*

  That is, for Cloudera Manager:

      * `https://`*`<load-balancer-ip>`*`:7183`
      * `https://`*`<hostname>`*`:7183`

    For Hue:
      * `https://`*`<load-balancer-ip>`*`:8889`
      * `https://`*`<hostname>`*`:8889`

    For Big Data Studio:
      * `https://`*`<load-balancer-ip>`*`:30000`
      * `https://`*`<hostname>`*`:30000`






<!--
reserved text

To view your reserved public IP address in the console, click the Navigation menu and navigate to **Core Infrastructure > Networking > Public IPs**. The  reserved public IP address is displayed in the **Reserved Public IPs** list.
-->




**This concludes this lab. Please proceed to the next lab in the Contents menu.**

## Want to Learn More?

* [Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/)


## Acknowledgements


* **Last Updated Date:** November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
