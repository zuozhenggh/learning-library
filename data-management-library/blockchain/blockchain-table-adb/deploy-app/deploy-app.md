# Install Node.js in Compute Instance and Deploy the Application

## Introduction

In this lab, let's install Node.js in the compute instance, deploy the application and sign a row in the database from the cloud shell.

### Objectives

In this lab, you will:

- Install Node.js in the compute instance
- Open Firewall for Ports
- Download and deploy the application

### Prerequisites

- Have successfully completed all the previous labs
<!---
## **STEP 1**: Connect to your Compute Instance

There are multiple ways to connect to your cloud instance. Choose the way to connect to your cloud instance that matches the SSH Key you generated.  *(i.e If you created your SSH Keys in cloud shell, choose cloud shell)*

- Oracle Cloud Shell
- MAC or Windows CYCGWIN Emulator
- Windows Using Putty

### Oracle Cloud Shell

1. To re-start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.  *Note: Make sure you are in the region you were assigned*

    ![](./images/cloudshell.png " ")

2.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
3.  On the instance homepage, find the Public IP address for your instance.

    ![](./images/linux-compute-step3-11.png " ")
4.  Enter the command below to login to your instance.    
    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````

    *Note: The angle brackets <> should not appear in your code.*
    ![](./images/linux-compute-step3-12.png " ")
5.  When prompted, answer **yes** to continue connecting.
6.  Continue to STEP 5 on the left hand menu.

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP address for your instance.

3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/cloudshellssh.png " ")

    ![](./images/cloudshelllogin.png " ")

    *Note: The angle brackets <> should not appear in your code.*

4.  After successfully logging in, proceed to STEP 5.

### Windows using Putty

1.  Open up putty and create a new connection.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/ssh-first-time.png " ")

    *Note: The angle brackets <> should not appear in your code.*

2.  Enter a name for the session and click **Save**.

    ![](./images/putty-setup.png " ")

3. Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4. Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5. Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![](./images/putty-auth.png " ")

6. The file path for the SSH private key file now displays in the Private key file for authentication field.

7. Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session STEP.

8. Click Open to begin your session with the instance.

Congratulations!  You now have a fully functional Linux instance running on Oracle Cloud Compute.
--->
## **STEP 1:** Install Node.js in the Compute Instance

Now that the virtual machine is provisioned, let us see how to  install Node.js for the Node.js application to interact with the Autonomous database rest end points.

1. Navigate back to the tab with Oracle Cloud console. If you are logged out of cloud shell, click on the cloud shell icon at the top right of the page to start the Oracle Cloud shell and SSH into the instance.

2.  To install Node.js we need to have oracle-release-el7 repo added to the virtual machine as sudo.

    ```
    <copy>
    sudo yum install -y oracle-nodejs-release-el7 oracle-release-el7
    </copy>
    ```

3. Run this command to install Node.js to set up the run time environment. Type `y` when prompted.

    ```
    <copy>
    sudo yum install nodejs
    </copy>
    ```

## **STEP 2:** Open Firewall for Ports

To connect to the Autonomous Database instance from the virtual machine we need to open firewall ports. Oracle linux compute instance internal firewall do not have any port enabled by default. We need to enable a port.

1. Run this sudo command to permanently add port 8080 under the public zone.

    ```
    <copy>
    sudo firewall-cmd --permanent --zone=public --add-port=8080-8080/tcp
    </copy>
    ```

2.  Reload the firewall to make sure if the port is added.

    ```
    <copy>
    sudo firewall-cmd --reload
    </copy>
    ```

3.  List all the ports to see that port 8080 is available. If it displays 8080/tcp means that the virtual machine firewall that comes by default with Oracle linux has enabled the 8080 port on TCP protocol.

    ```
    <copy>
    sudo firewall-cmd --permanent --zone=public --list-ports
    </copy>
    ```

## **STEP 3:** Deploy the Application

In the Oracle Linux virtual machine, as we the Node.js running, the ports are enabled, let's download and deploy the application.

<!---
3. Download the Node.js application

    ```
    <copy>
    wget 
    </copy>
    ```

4.  Unzip the Node.js application.
--->
1.  Navigate to nodejs folder.

    ```
    <copy>
    cd nodejs
    </copy>
    ```

2.  Open the index.js file in an editor of your choice.

    ```
    <copy>
    vi index.js
    </copy>
    ```

3.  If you are using vi editor hit the letter `i` to edit and replace the line 12 apex\_server database URl with your autonomous database URL and line 45 existing cert\_guid value that you noted in previous labs.

    In this lab, the autonomous database URL saved is `` and the cert_guid is `` . The apex_server value is replaced with `` and the cert_guid is replaced with ``.

4.  Once you have updated the values, save and quit the edit mode. If you are using vi editor press `Esc` and type `:wq` to save and exit the edit mode.

5. Duplicate the browser tab with cloud shell window and SSH into the compute instance.

6.  Navigate to the nodejs folder and run the command to deploy the application. Once we run the `node bin/www` command the Node.js application will be running and will be listening on port 8080.

    ```
    <copy>
    cd nodejs
    node bin/www
    </copy>
    ```

    If the cursor is idle which means the nodejs application is running.

## **STEP 5:** Sign the row

1. Navigate back to the previous cloud shell window that does not have the Node.js application running.

2. Replace the number 1 for the instanceId, chainId and seqId and update with your noted with instanceId, chainId and seqId values in the below command and hit enter.

    ```
    curl --location --request POST 'http://localhost:8080/transactions/row' --header 'Content-Type: application/json' --data '{"instanceId":1,"chainId":1,"seqId":1}'
    ```

    After replacing the instanceId, chainId and seqId values in the command, it should look like this:

    ```
    curl --location --request POST 'http://localhost:8080/transactions/row' --header 'Content-Type: application/json' --data '{"instanceId":1,"chainId":1,"seqId":1}'
    ```

3. Notice JSON message with status 200 and message displayed is `Signature has been added to the row successfully` which means that the row how has been signed successfully.

4. To verify, navigate back to the tab with Blockchain APEX application with the List of Transactions and refresh the tab. Notice that the row with the values Instance ID - , Chain ID - and Seq ID - `IS Signed` column should display a green tick from which indicates that the row is signed successfully.

## Acknowledgements

* **Author** - Salim Hlayel, Mark Rakhmilevich, Anoosha Pilli
* **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
* **Last Updated By/Date** - Anoosha Pilli, July 2021

