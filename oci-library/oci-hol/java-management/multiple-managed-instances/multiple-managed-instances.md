# Set up multiple Managed Instances and Management Gateway

## Introduction
The Management Gateway provides a single point of communication between the Management Agents (or any other customer-side products) and the Oracle Cloud Infrastructure.

Using the Management Gateway as the single point for traffic to and from the Oracle Cloud Infrastructure means that the enterprise firewall only needs to allow HTTPS communication from the host where the Management Gateway resides. This scenario allows installing Management Agent on the remaining hosts which do not need to have direct access to the internet. Oracle recommends to configure the Management Gateway first and then the Management Agent on the other hosts.


  ![image of gateway concepts](/../images/gateway_concepts_diagram.png =400x*)
  
This lab walks you through the steps to install and configure Management Gateway on an on-premises host and have another on-premises host proxy through it to communicate with OCI network and JMS.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:

* Install and configure Management Gateway on an on-premises host
* Verify the installation of Management Gateway
* Install Management Agent on another on-premises host and configure it to communicate to OCI network through Management Gateway


### Prerequisites

* You have signed up for an account with Oracle Cloud Infrastructure and have received your sign-in credentials.
* You are using an Oracle Linux image on your on-premises host machine to install Management Gateway.
* You are using an Oracle Linux image or Windows OS on your another on-premises host machine to install Management Agent.
* Access to the cloud environment and resources configured in the previous labs
* The hosts, the one running Management Gateway and the one running Management Agent software, must be in same network.

## Task 1: Prepare gateway software and response file for Management Gateway installation

1. Sign in to the Oracle Cloud Console as an administrator using the credentials provided by Oracle, as described in [Signing into the Console](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
&nbsp;

2. Open navigation menu, click **Observability & Management**, and then click **Downloads and Keys** under **Management Agent**.  

  ![image of navigating to Management Agent page, Download and Keys section](/../images/navigate-to-management-agent.png)
  

  The Software Download pane will display at the top of the page.

  ![image of Software download pan view](/../images/software-download-pane-view.png)

3. The Software Download pane lists all the software available to download for the Management Agent and Management Gateway. Select the operating system that the Management Gateway will be installed on from the Download column. In this case, click on **Gateway for LINUX (X84_64)** link to download the Management Gateway software file.
  ![image of downloading management gateway software](/../images/download-gateway-software.png)

4. Alternatively, you can run the following command to download **Management Gateway software for Linux**. This is useful if you want to avoid user interface.
    ```
    <copy>
    curl -o oracle.mgmt-gateway.rpm https://objectstorage.us-ashburn-1.oraclecloud.com/n/idtskf8cjzhp/b/installer/o/Linux-x86_64/latest/oracle.mgmt_gateway.rpm
    </copy>
    ```    

5. On the same **Downloads and Keys** page, click on **Create key** to create a new **Install key**. An install key is issued against your identity domain and validates the authenticity of the installation. 
  ![image of clicking on create install key button](/../images/create-install-key.png)

6. Enter the required details in Create Key window and click **Create** button.

  ![image of entering details for Install key](/../images/create-install-key-popup.png)

7. On the Install Keys pane select the newly created Install Key. Then on the right side of the selected key, click the action menu and select **Download Key to File** option. 
  ![image of download key to file option](/../images/download-key-to-file-option.png)

8. Create a response file using downloaded Install key. To do that open the downloaded Install key file in a text editor.

    ```
    <copy>
    sudo nano <install key name>
    </copy>
    ```   
  Customize following parameters:
    * AgentDisplayName: Add a display name for management agent 
    * GatewayPort: 4479
    * Remove the parameters starting with Service.plugin.* parameter. These parameters are agent-specific and are only used for agent installations. 

  Final response file may look like this.
  ![image of final response file](/../images/terminal-edit-install-key.png)

9. Save the response file with .rsp extension and move it to /tmp directory. Moving the response file to /tmp directory helps to associate correct permissions to response file.
    ```
    <copy>
    sudo mv <install-key-file-name> /tmp/gateway.rsp
    </copy>
    ```   


## Task 2: Install Management Gateway
1. Open the terminal. 

2. Navigate to the directory where you have downloaded the management gateway RPM file and run the following command to install the RPM file: 

    ```
    <copy>
    sudo rpm -ivh <rpm_file_name.rpm>
    </copy>
    ```   

  The output will look similar to the following:
    ```
      Preparing...        ################################# [100%]
  Checking pre-requisites
      Checking if any previous gateway service exists        
  Checking if OS has systemd or initd
      Checking available disk space for gateway install
      Checking if /opt/oracle/mgmt_agent directory exists
      Checking if 'mgmt_agent' user exists
      Checking Java version
              JAVA_HOME is not set or not readable to root
              Trying default path /usr/bin/java
              Java version: 1.8.0_282 found at /usr/bin/java
      Checking gateway version
  Updating /  installing...
    1:oracle.mgmt_gateway-<VERSION>################################# [100%]

  Executing install
          Unpacking software zip
          Copying files to destination dir (/opt/oracle/mgmt_agent)
          Initializing software from template
          Checking if JavaScript engine is available to use
          Creating 'mgmt_gateway' daemon        
          Gateway Install Logs: /opt/oracle/mgmt_agent/installer-logs/installer.log.0

          Setup gateway using input response file (run as any user with 'sudo' privileges)
          Usage:
                  sudo /opt/oracle/mgmt_agent/agent_inst/bin/setupGateway.sh opts=[FULL_PATH_TO_INPUT.RSP]

          Gateway install successful
      ```   

3. Configure the management gateway by running the setupGateway.sh script using a response file. In this case, full path to response file should be `/tmp/gateway.rsp`.

    ```
    <copy>
    sudo /opt/oracle/mgmt_agent/agent_inst/bin/setupGateway.sh opts=<full_path_of_response_file>
    </copy>
    ```  


    The output will look similar to the following: 

    ```
    <copy>
sudo /opt/oracle/mgmt_agent/agent_inst/bin/setupGateway.sh opts=<user_home_directory>/gateway.rsp

Executing configure
       Parsing input response file
       Validating install key
       Generating communication wallet
       Generating security artifacts
       Registering Management Gateway
               Found service plugin(s): [GatewayProxy]

Starting gateway...
Gateway started successfully

Starting plugin deployment for: [GatewayProxy]
Deploying service plugin(s)......Done.
        GatewayProxy : Successfully deployed external plugin

Gateway setup completed and the gateway is running.
In the future gateway can be started by directly running: sudo systemctl start mgmt_gateway

Please make sure that you delete <user_home_directory>/gateway.rsp or store it in secure location.

Creating Wallets
Wallets created successfully
Waiting for Gateway to start...
Gateway Proxy started successfully
    </copy>
    ``` 

4.  Delete the gateway.rsp file after successful configuration.

    ```
    <copy>
    sudo rm /tmp/gateway.rsp
    </copy>
    ```  

5. As we set the Proxy port to 4479. Open this port on the host firewall by configuring the firewall. 

    ```
    <copy>
    sudo firewall-cmd --zone=public --permanent --add-port=4479/tcp

    sudo firewall-cmd --reload
    </copy>
    ```  

6. Take note of IP address of the machine by running following command.
    ```
    <copy>
    ifconfig
    </copy>
    ```  

    This IP address will be used as value for `ProxyHost` in Management Agent response file in Task 4.
  
## Task 3: Verify the Management Gateway Installation 

### Using OCI Console:

1. Open navigation menu, click **Observability & Management**, and then click **Agents** under **Management Agent**.  

  ![image of navigating to Management Agent page, Agents section](/../images/navigate-to-agents-page.png)

2. Select the correct compartment from left hand side panel. In this case it is `Fleet_Compartment`. You should be able to see newly created Management gateway in the **Agents and Gateways** list.

  ![image of verification on running Management Gateway](/../images/view-management-gateway.png)

### Using Command Line Interface on Linux:


1. Login to the host using a user with sudo privileges.

2. Run the following command to check Management Gateway service status:

    For Oracle Linux 6: 
     ```
    <copy>
   sudo /sbin/initctl status mgmt_gateway
    </copy>
    ```  
    

    For Oracle Linux 7: 
     ```
    <copy>
   sudo systemctl status mgmt_gateway
    </copy>
    ```
    

    For more details, check log file: 
    
     ```
    <copy>
     cat /opt/oracle/mgmt_agent/plugins/GatewayProxy/stateDir/log/mgmt_gateway.log
    </copy>
    ```



## Task 4:  Prepare agent software and response file for Management Agent installation

1. A fleet, `fleet_1`, has been setup during [Lab 2](?lab=setup-a-fleet) and you should have access to the downloaded install key file.

2. Start another on-premises host and connect it to the same on-premises network as the Management Gateway.

3. Create an `input.rsp` response file on your host. This will be used by the Management Agent installation script to read the agent parameters specific to your environment.



   Copy and paste the contents of the response file downloaded in [Lab 2](?lab=setup-a-fleet) into the editor, and enter values for following parameters:
    * AgentDisplayName: Any display name for the agent
    * ProxyHost: The IP address of host that is running Management Gateway
    * ProxyPort: 4479

    If you are using Linux OS then save the response file at `/tmp/input.rsp`. For windows OS you can save input.rsp file anywhere.

4. The response file is now ready. You can follow the instructions given in [Lab 5](?lab=set-up-of-management-agent-linux) to Install Management Agent on Linux OS and [Lab 6](?lab=set-up-of-management-agent-windows) to Install Management Agent on Windows OS, depending on you premises host.

  You must perform the below given tasks following the labs:
    * Install Management Agent according to the Operating System.
    * Configure the Management Agent using the response file created in Step 3.
    * Verify Management Agent installation using OCI Console.
    * Configure Java Usage Tracker.
    * Check that Management agent is tagged with fleet OCID
    * Run Java application.

5. Once you have finished installing Management Agent according to above mentioned labs and ran the `HelloWorld` java application. You should be able to see Managed Instance, Java Runtime and Application on Fleet page in 5-10 minutes.


## Task 5: Verify detection of Java applications and runtimes
1. In the Oracle Cloud Console, open the navigation menu, click **Observability & Management**, and then click on **Fleets** under **Java Management**.

  ![image of console navigation to java management](/../images/console-navigation-jms.png)

2. Select the compartment that the fleet is in and click the fleet.

3. Click **Java Runtimes** under **Resources**. If tagging, installation of management agents and coomunication between Management Gateway and Management Agent is successful, Java Runtimes will be indicated on the Fleet Main Page after 5 minutes.

  You should see only one Java Runtime. This corresponds to the Java 8 installation from [Lab 3](?lab=deploy-a-java-application).

  ![image of runtimes after successful installation](/../images/successful-installation.png)

4. Click **Applications** under **Resources**. You should now see two applications. The first is from the javac compiler command and the second is from the HelloWorld application.

  ![image of applications after successful installation](/../images/successful-installation-applications.png)




You may now **proceed to the next lab.**

## Troubleshoot Management Gateway Issues

**For Task 1 Step 4**

* To download the Management Gateway software from a different commercial region, edit the above download URL and replace it with the corresponding region's Object Storage API end point. For details, see [Object Storage Service API](https://docs.oracle.com/iaas/api/#/en/objectstorage/20160918/). 


## Learn More

* Use the [Troubleshooting](https://docs.oracle.com/en-us/iaas/management-agents/doc/troubleshoot-management-gateway-installation-issues.html) chapter for explanations on how to diagnose and resolve common problems encountered when installing or using Management Gateway.

* If the problem still persists or if the problem you are facing is not listed, please refer to the [Getting Help and Contacting Support](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/contactingsupport.htm) section or you may open a a support service request using the **Help** menu in the OCI console.

## Acknowledgements

* **Author** - Bhuvesh Kumar, Java Management Service
* **Last Updated By** - Bhuvesh Kumar, June 2022
