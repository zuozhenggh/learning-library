# Implement Logging Analytics

## Introduction

This lab will setup OCI Logging Analytics Service and will walk you through the steps to Setup Logging Analytics, Install management agents for monitoring the instances setup in previous labs, set up the Logging Service to stream Network and Audit Flow logs using the Service Connector, visualize logs in the Log Explorer and finally create a dashboard for visualizing your data. You will create a Dashboard for Operations Analysts and EBS Application Analysts.

**Estimated Lab Time: 2 hours**

### About Logging Analytics

Oracle Cloud Infrastructure Logging Analytics is a machine learning-based cloud service that monitors, aggregates, indexes, and analyzes all log data from on-premises and multicloud environments. Enabling users to search, explore, and correlate this data to troubleshoot and resolve problems faster and derive insights to make better operational decisions.

### Objectives

**In this lab, you will:**
* Setup Logging Analytics Baseline (including policies, users, groups, and dynamic groups for using Logging Analytics Service)
* Pull data from Logging Entities: Servers, EBS Application and Database, Network and Audit Flow logs
* Visualize and Absorb this Data in the Logging Analytics User Interface

### Prerequisites

* An Oracle Cloud Environment
* EBS Cloud Manager, EBS 1-Click and Advanced Provisioned Instance, Network - All setup in previous labs

## **STEP 1**: Onboard Logging Analytics Service

In Step 1 of this lab we will Setup Logging Analytics Service

1. Enable Logging Analytics
    
    a. Navigate to Logging Analytics - Administration

    ![](./images/AdministrationPortal.png " ")

    b.Click the **Start Using Logging Analytics** (if this is not an option, it is already done)

    ![](./images/StartLogging.png " ")

    c. Click **Continue**

2. (Optional) You can also use existing user groups. 
    
    Create Logging Analytics Group Logging Analytics Super Admins

    a. Navigate to Identity - Federation - OracleIdentityCloudService

    b. Click on the Url following **Oracle Identity Cloud Service Console**

    ![](./images/IDCSConsole.png " ")

      i. From the IDCS console go to Groups

      ii. Like in the first step of the EBS Lift and Shift Lab Click **+ Add**

      iii. Create a Group called `Logging-Analytics-SuperAdmins`

    ![](./images/addGroup.png " ")

      iv. Click **Next**

      v. Add your OCI Admin User that you are using to navigate OCI not your EBS Cloud Manager

    ![](./images/adduser.png " ")

      vi.  You can now close this page and go back to your OCI Console

    c. From the OCI Console Navigate to Identity - Groups

      i. Create a new OCI Group with the same name `Logging-Analytics-SuperAdmins`

      ii. Then Go to Identity - Federation - Group Mappings

      iii. Click **Add Mapping**

      iv. Associate the two `Logging-Analytics-SuperAdmins`

    ![](./images/map.png " ")

      v. Click **Add Mapping**

  3. Create Logging Analytics Dynamic Group: Management Agent Admins
    
    a. Now navigate to Identity - Dynamic Groups 

      i. Click **Create Dynamic Group**

      ii. Enter name: `ManagementAgentAdmins`

      iii. Add Description

      iv. Leave `MATCH ANY RULES DEFINED BELOW` checked

      v. Add the following rule:

        All {resource.type = 'managementagent', resource.compartment.id = '<Compartment OCID of ebshol_compartment>'}

      Note: Fill in the Compartment OCID with the OCID of the ebshol compartment.

    ![](./images/dynamicgroup.png " ")

      vi. Click **Create**
    
  4. Create Logging Analytics Policy

    a. Go to Identity - Policies

    b. **Make sure you change to the root compartment**

    c. Click **Create Policy**

      i. Enter name: `Logging-Analytics-Policy` and add description

      ii. In the policy builder click **Customize(Advanced)** 

      iii. Paste the following Policies into the Policy Builder as shown below

      To create policies for your administrator to use OCI Logging Analytics create the below

      ```
      <copy>
allow service loganalytics to READ loganalytics-features-family in tenancy
allow service loganalytics to read buckets in tenancy
allow service loganalytics to read objects in tenancy
allow service loganalytics to manage cloudevents-rules in tenancy
allow service loganalytics to inspect compartments in tenancy
allow service loganalytics to use tag-namespaces in tenancy where all {target.tag-namespace.name = /oracle-tags /}
allow group Administrators to MANAGE loganalytics-resources-family in tenancy
allow group Administrators to MANAGE management-dashboard-family in tenancy
allow dynamic-group ManagementAgentAdmins to MANAGE management-agents in tenancy
allow dynamic-group ManagementAgentAdmins to USE metrics in tenancy
allow dynamic-group ManagementAgentAdmins to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in tenancy
allow dynamic-group ManagementAgentAdmins to USE loganalytics-collection-warning in tenancy
allow service loganalytics to {VNIC_READ} in tenancy
      </copy>
      ```

      iv. If you want to use the Logging Analytics Super Admin Group use these policies:

      ```
      <copy>
allow service loganalytics to READ loganalytics-features-family in tenancy
allow service loganalytics to read buckets in tenancy
allow service loganalytics to read objects in tenancy
allow service loganalytics to manage cloudevents-rules in tenancy
allow service loganalytics to inspect compartments in tenancy
allow service loganalytics to use tag-namespaces in tenancy where all {target.tag-namespace.name = /oracle-tags /}
allow group Logging-Analytics-SuperAdmins to READ compartments in tenancy
allow group Logging-Analytics-SuperAdmins to MANAGE loganalytics-features-family in tenancy
allow group Logging-Analytics-SuperAdmins to MANAGE loganalytics-resources-family in tenancy
allow group Logging-Analytics-SuperAdmins to MANAGE management-dashboard-family in tenancy
allow group Logging-Analytics-SuperAdmins to READ metrics in tenancy
allow group Logging-Analytics-SuperAdmins to MANAGE management-agents in tenancy
allow group Logging-Analytics-SuperAdmins to MANAGE management-agent-install-keys in tenancy
allow group Logging-Analytics-SuperAdmins to READ users in tenancy
allow dynamic-group ManagementAgentAdmins to MANAGE management-agents in tenancy
allow dynamic-group ManagementAgentAdmins to USE metrics in tenancy
allow dynamic-group ManagementAgentAdmins to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in tenancy
allow dynamic-group ManagementAgentAdmins to USE loganalytics-collection-warning in tenancy
allow service loganalytics to {VNIC_READ} in tenancy
      </copy>
      ```

    ![](./images/policies.png " ")

  5. Last we will go to Logging Analytics - Administration - Log Groups

    a. Click **Create Log Group**

    b. For Name enter: `EBS_VCN_Logs` and a description

    c. Click **Create**

    d. Create another Log Group named `Audit_Logs`

    ![](./images/laloggroup.png " ")

    e. We will use these log groups when ingesting logs from a service connector in the next step.
    


## **STEP 2:** Ingest Logs into Logging Analytics

In this Step we will Ingest Flow Logs and Install Management Agents to our instances

  1. Setup Logging to Ingest Audit and Network Logs

    a. Navigate to Logging - Log Groups from the OCI Console (verify you are in your ebshol_compartment)

      i. Click Create Log Group

      ii. Name it `EBS_VCN_Logs` and add a description

    ![](./images/loggroup.png " ")

      iii. Click **Create**

    b. Now navigate to Logging - Logs

      i. Click **Enable Service Log**

      ii. For service select: `Virtural Cloud Network (subnets)`

      iii. Resource select a subnet

      iv. Log Category: `Flow Logs(All records)`

      v. Log Name: `<subnetprefix>_subnetwork_logs`

      vi. Click Advanced and verify the log is being added to your `EBS_VCN_Logs`

      vii. You can change your log retention as well. For now leave as Default

    ![](./images/enable1.png " ")
    
    ![](./images/enable2.png " ")

    c. Repeat Step B for the rest of your subnets

    d. Once complete your Logs should look like this:

    ![](./images/subnetlogs.png " ")

  2. Create Service Connectors for Audit and Network Logs
    
    a. Now navigate to Logging - Service Connectors

      i. Click **Create Connector**

      ii. For name Enter: `EBS_VCN_Flow_Service_Connector` and add a description

      iii. For Source select **Logging** and Target select **Logging Analytics**

      iv. Under **Configure source connection** for **Log Group** select `EBS_VCN_Logs` and for **Logs** select one of your subnet logs.

      v. Click **+ Another Log** and add each of your subnet logs for this log group 

      vi. Once you have added all your subnet logs scroll to **Configure target connection**

      vii. Make sure the Compartment is our `ebshol_compartment` and Log Group `EBS_VCN_Logs` that we created in part 5) of Step 1

      viii. An ask to `Create default policy allowing this service connector to write to Logging Analytics in compartment ebshol_compartment.` will show, click **Create** and then **Create** again.

      ![](./images/createpolicyservice.png " ")
    
    b. Click **Create Connector** again

      i. For name Enter: `Audit_Flow_Service_Connector` and add a description

      ii. For Source select **Logging** and Target select **Logging Analytics**

      iii. Under **Configure source connection** for **Log Group** select `_Audit_` and for **Logs** leave empty.

      iv. Make sure the Compartment is our `ebshol_compartment` and Log Group `Audit_Logs` that we created in part 5) of Step 1

      v. An ask to `Create default policy allowing this service connector to write to Logging Analytics in compartment ebshol_compartment.` will show, click **Create** and then **Create** again.

      ![](./images/createpolicyservice.png " ")

    c. You can now go to Logging Analytics - Administration

        You will now see entities have been automatically created.

        You can also go to Logging Analytics - Log Explorer and should see a pie with data similar to what is shown below
      
      ![](./images/firstlogexview.png " ")

  3. Now we will walk through installing management agents on our hosts. Because we are using linux servers in this lab we will stick to steps for those servers. For further documentation on installing agents and specifically on Windows servers refer to [Install Management Agents Documentation](https://docs.oracle.com/en-us/iaas/management-agents/doc/install-management-agent-chapter.html#GUID-5F2A1CEF-1185-469C-AF2E-8A94BC95DC35)

    a. In the OCI Console navigate to Management Agents - Downloads and Keys

    b. Click and download **Agent for LINUX** 

    c. Click **Create Key** below 
  
      i. Name the key `ebs_agent_key`

      ii. Select our `ebshol_compartment`

      iii. Click **Create**

      iv. on the right click the three dots in the row of our agent key we just created.

      v. Click `Download Key to File`

    ![](./images/keydownload.png " ")

      vi. Once you have Downloaded the key file, we need to edit it

      vii. open the `ebs_agent_key.txt` file

      Add agent name
        - AgentDisplayName

      Add Password
        - CredentialWalletPassword

      Uncomment the Service Plugins
        - Service.plugin.dbaas.download=true
        - Service.plugin.dbaas.download=true

    ![](./images/editkey.png " ")

    d. We now need to copy our `oracle.mgmt_agent.rpm` and `ebs_agent_key.txt` to our Cloud Manager Instance.

    e. Verify an SSH connection to our `ebshol_ebscm` instance

      i. Navigate to Compute and find your `ebshol_ebscm` and note the Public IP

      ii. From your terminal SSH to the Cloud Manager

      ```
      ssh opc@<public_ip_of_cloud_manager>
      ```

      iii. After verifying you can connect via ssh exit

    ![](./images/sshverify.png " ")

    f. Secure Copy your management agent and .txt file to cloud manager

      ``` 
      scp ~/Downloads/oracle.mgmt_agent.rpm opc@<public_ip_of_cloud_manager>:~ 
      ```

      ```
      scp ~/Downloads/ebs_agent_key.txt opc@<public_ip_of_cloud_manager>:/tmp
      ```

      ```
      ssh opc@<public_ip_of_cloud_manager>
      ```

      i. Type ls to verify your .txt and .rpm file are in your home directory

    g. Install Java
  
      ```
      <copy>
      sudo yum install java
      </copy>
      ```

    h. Edit permissions on the `ebs_agent_key.txt` file

      ```
      <copy>
      cd /tmp
      sudo chmod 755 ebs_agent_key.txt
      </copy>
      ```

    i. Go back to home directory and run management agent

      ```
      <copy>
      cd ~
      sudo rpm -ivh oracle.mgmt_agent.rpm
      </copy>
      ```

    Note: If successful your terminal should see this response ending with Agent install successful

    ![](./images/installsuccess.png " ")

    j. Setup and the management agent with info from Install Key

      ```
      <copy>
      sudo /opt/oracle/mgmt_agent/agent_inst/bin/setup.sh opts=/tmp/ebs_agent_key.txt
      </copy>
      ```

    ![](./images/startagent.png " ")

    k. Now to install our agent on the other instances built with our cloud manager we will move the `ebs_agent_key.txt` and oracle mgmt agent to our Oracle Home Directory

      ```
      <copy>
      sudo mv /tmp/ebs_agent_key.txt /u01/install/APPS
      sudo mv oracle.mgmt_agent.rpm /u01/install/APPS
      sudo su - oracle
      </copy>
      ```

    l. From the Oracle user on the cloud manager you can connect to your other instances using ssh. Now scp your management agent and key file to each of the other instances via their private IP address.

      ```
      scp oracle.mgmt_agent.rpm opc@<privateIPofebsinstance>:~
      scp ebs_agent_key.txt opc@<privateIPofebsinstance>:/tmp
      ssh opc@<privateIPofebsinstance>
      ```

    m. Go to the /tmp folder and using vi, edit the `ebs_agent_key.txt` file and change the name to refer to the server. We will use the same .txt file. 
  
    n. Once you edited the `ebs_agent_key.txt` file you can repeat the steps for install starting from `g.` to `j.` on each instance you want to monitor then exit to repeat. 

    Note: You can also follow the recommended procedure of deleting your key file from your instance one the agent has been installed and is configured properly 
    
      ```
      $ rm /tmp/ebs_agent_key.txt
      ```

  **Note:** If you have other instances not created with the cloud manager follow the same steps to add the agent and key file to those instances and install.

## **STEP 3:** Create Entities Log Groups and associate Log Sources

Now that we have our agents installed and our flow logs going to logging analytics we will now create entities and associate these entities with log sources

**Here you can create Entities and Log Sources for the entities that you want to monitor. We recommend you start with one Entity to understand the flow and then repeat the rest**

  1. Create Entities

  **Note:** Our entities for our flow logs are automatically setup. In this step we will focus on our Entities and Log Sources from the agents installs. 

    a. We will create an entity for host logs and ebs logs for each of the agent installations. As you did in the previous step repeat the following steps for each of the servers you installed a management agent.

    ![](./images/adminscreen.png " ")

    b. Navigate to Logging Analytics - Administration and click on **Entities**

    c. From here you can see the Entities that already have been created. Click **Create Entity**

    ![](./images/entities.png " ")

    (example is for our first EBS Cloud Manager agent)

      i. For host logs: 

        - Create an Entity with Entity Type: `Host(Linux)`
        - Name: EBS CM Host
        - Management Agent: ebscmagent
      Click **Create**

    ![](./images/createcmhost.png " ")

      ii. For ebs concurrent processing logs:

        - Create an Entity with Entity Type: EBS Concurrent Processing Node
        - Name: EBS CM CPN
        - Management Agent: ebscmagent
        - Properties
          omc_ebs_applcsf: /u01/install/APPS/fs_ne/inst/ebsdb_apps/
          omc_ebs_appllog: /logs/appl/conc/log

    ![](./images/createcpn.png " ")

  2. Create Host Log Group and EBS CPN Log Group

    a. Navigate to Logging Analytics - Administration - Log Groups

    b. Click **Create Log Group**

      Name it `Host Log Group` and click **Create**

      Repeat and name the other group `EBS CPN Log Group`

    ![](./images/loggroups.png " ")

  3. Associate Log sources
  
    Now that you have your entities go to Logging Analytics - Administration - Sources

    For Host Logs:

    a. Type in `linux` in the search bar on the right
    
    ![](./images/linuxsearch.png " ")

    b. Click on `Linux Secure Logs`

    c. Click Add

    d. Click the box in the left to associate for all your Host Entities

    e. Select `Host Log Group` Click Save and Deploy

    ![](./images/associatesources.png " ")

    f. Repeat for the following Log Sources: Linux Syslog Logs, Linux YUM Logs, Linux Audit logs, Linux Cron Logs, Ksplice Logs

    For EBS logs:

    a. Type in `ebs` in the search bar

    ![](./images/ebssearch.png " ")

    b. Click on `EBS Concurrent Manager Logs`

    c. Click Add

    d. Click the box in the left to associate for all your EBS CPN entities

    e. Select `CPN Log Group` Click Save and Deploy

    ![](./images/associatecpnsource.png " ")

    f. Repeat for the following Log Sources: EBS Concurrent Request Logs, EBS Conflict Resolution Manager Log, EBS Internal Concurrent Manager log, EBS Transaction Manager Logs

  4. Now that you have completed these steps you can go to the Log Explorer and view flow logs, ebs logs, host logs, and audit logs. In the next step we will create visualizations and dashboards based off this data.

  Note: If you have other logs you are looking to ingest find the respective log source and entity type and location of the log source and you can create the entity and the associate the respective log source with this same process.

## **STEP 4:** Visualize Data in Log Explorer and Create Dashboards

In this Step we will familiarize ourselves with the visualization tool `Log Explorer` and build dashboard.

Navigate to Logging Analytics - Log Explorer

The corresponding query will be shown captioned below each image

Your screen will look similar to this, with a pie chart showing an overview of the different logs that you have ingested. Likely your VCN Flow Logs will dominate your pie chart.

  ![](./images/piechart.png " ")

  1. The Log explorer is broken down into four main sections. 

    a. The first being the Query Search. You can filter through and analyze your logs based off of regex that define your search. As you change your fields and visualizations you will see these changes in the graph and the query search bar. If you ever want to return to the initial dashboard go to **Actions** and click **Create New**

    ![](./images/piechart1.png " ")

    ```* | stats count as logrecords by 'Log Source' | sort -logrecords```

    b. The second being the Fields panel on the left. Here you can choose what fields you want to use for grouping, filtering, and exploring your log data. You can drag your fields into the visualization panel or click on the three dots to the right of the field name to filter or pin the field.

    ![](./images/fields.png " ")

    ```* | stats count as logrecords by 'Log Source' | sort -logrecords```

    c. The third is the Visualizations panel that you can select what kind of graph you would like to use for your widget as well as drag and drop fields into the proper axis.

    **Click the cluster visualization to see how this will change your widget**

    ![](./images/visualizations.png " ")

    ```* | cluster```

    d. Lastly the main part of the log explorer is where you can see the data in a visual. These are called widgets. 

  2. Once you have used the log explorer and have created a widget you like you can then create a dashboard

    a. From the log explorer go to Actions in the top right and Click **Save As**

    b. Provide  a Search Name: `logs cluster` and Description

    c. Select Add to a dashboard

    d. Select New Dashboard

    e. make sure the compartment being used is our ebshol_compartment 

    f. Give the Dashboard a name: `EBS Dashboard` and Description

    ![](./images/savesearch.png " ")

    g. Click **Save**

  3. Now Navigate to Logging Analytics - Dashboards

    a. You will see your EBS Dashboard. Click into it

    b. You will now see your visualization as the lone widget. Click **Edit** on the far right

    c. From the edit you can add additional widgets as well as change the size of your widget.

    ![](./images/editdash.png " ")

    d. As you create more widgets based off of queries or built using the fields and visualization panels you can add them from the right side by dragging the widget into the dashboard and placing as you see fit. Allowing you to customize your dashboard to your preference.

  4. To complete this lab please navigate back to the log explorer.

  5. Analyze your VCN Flow Logs
  
  We will now walk through a flow to understand our logs and create some common widgets. Corresponding query will be shown captioned below each image

    a. First lets look at the logs we have ingested based on Entity Type

    b. Remove the `Log Source` from Group by and drag `Entity` from the fields panel

    c. Hit Apply

    d. You now have a widget showing your logs by Entity 

    ![](./images/logsbyentity.png " ")

    ```* | stats count as logrecords by Entity | sort -logrecords```

    e. This isn't too readable so lets change the visualization type.

    f. click the down arrow next to `Pie` and select the `Histogram` or `TreeMap` to see breakdowns of this data in different graphs.

    ![](./images/histogram.png " ")

    ```* | timestats count as logrecords by Entity | sort -logrecords```

    ![](./images/treemap.png " ")

    ```* | stats count as logrecords by Entity | sort -logrecords```

    g. Lets look at the histogram: ```* | timestats count as logrecords by Entity | sort -logrecords```

    ![](./images/histogram.png " ")

    h. Let's drill deeper.

      i. Select Entity Type in the fields panel and select `OCI VCN Virtual Network Interface Card`

    ![](./images/vcnhistogram.png " ")

    ```'Entity Type' = 'OCI VCN Virtual Network Interface Card' | timestats count as logrecords by Entity | sort -logrecords```

      ii. We see about the same graph as before as most of our logs are Network Flow logs right now. 

      iii. Now select `ebsadvancedapp01`

      iv. Now we see the logs strictly for ebsadvancedapp01 subnet.

      ![](./images/ebsadvancedapp01.png " ")

      ```Entity = ebsadvancedapp01 | timestats count as logrecords by Entity | sort -logrecords```

      v. Lets scroll down and expand one of the logs. By clicking the arrow next to Log Source in the Original Log Content. You can now see the values that have been parsed from your logs.

      vi. You can expand this at the bottom right of this entry.

    ![](./images/expandlogcontent.png " ")

      vii. Now if you click on the value shown by Source IP you will now filter your logs that have this source IP.

    i. Now go to the top clear your query and just type `reject` to find all the logs with a rejection on your network.

    ![](./images/reject.png " ")

    ```reject | timestats count```
    
    **Note: You can type `failed` or `error` instead of `reject` to see if there are any logs of this type that show up.**

    j. Now you can play in the log explorer and become more familiar with the tool

## **STEP 5:** Example Queries

  1. Sample Audit Queries

    a. 'Log Source' = 'OCI Audit Logs' and Status not in ('null') | link Status, 'User Name', Event, Method | stats unique('User Name'), unique(Status), unique(Method), unique(Event), unique(Method) | classify topcount = 300 'Group Duration', Status

    ![](./images/ocianomalus.png " ")

    - Name: OCI Audit Anomalus Status Calls

    b. ‘Log Source’ = ‘OCI Audit Logs’ and ‘Availability Domain’ != ‘null’ and Method != ‘null’ | stats count(Method) by Method, ‘Availability Domain’

    c. 'Log Source' = 'OCI Audit Logs' and Event != 'null' and Method != 'null' | stats count by Event | sort -Count

    d. 'Log Source' = 'OCI Audit Logs' and 'OCI Resource Name' not in ('null') and Method != 'null' | stats count(Method) by Method, 'OCI Resource Name'

    e. ‘Log Source’ = ‘OCI Audit Logs’ and ‘User Name’ != ‘null’ | timestats count as logrecords by ‘User Name’ | sort -logrecords

    f. 'Log Source' = 'OCI Audit Logs' and Event != 'null' and Method != 'null' | stats count(Method) by Method, 'User Name'

    g. ‘Log Source’ = ‘OCI Audit Logs’ and ‘User Name’ not in (‘null’, cloudguard) and ‘OCI Resource Name’ != null | stats count by ‘User Name’, ‘OCI Resource Name’

  2. Sample VCN Queries

    a. ‘Entity Type’ = ‘OCI VCN Virtual Network Interface Card’ and ‘Log Source’ = ‘OCI VCN Flow Unified Schema Logs’ | stats count by Entity

    b. ‘Entity Type’ = ‘OCI VCN Virtual Network Interface Card’ and ‘Log Source’ = ‘OCI VCN Flow Unified Schema Logs’ | eval vol = ‘Content Size Out’ / (1024 * 1024) | stats sum(vol) as ‘Egress (Mb)’ by ‘OCI Subnet OCID’

    c. 'Entity Type' = 'OCI VCN Virtual Network Interface Card' and 'Log Source' = 'OCI VCN Flow Unified Schema Logs' | timestats count by 'OCI Subnet OCID'

    d. ‘Entity Type’ = ‘OCI VCN Virtual Network Interface Card’ and ‘Log Source’ = ‘OCI VCN Flow Unified Schema Logs’ | stats count as logrecords by Entity

    e. 'Entity Type' = 'OCI VCN Virtual Network Interface Card' and 'Log Source' = 'OCI VCN Flow Unified Schema Logs' | timestats avg('Packets In') by 'OCI Subnet OCID'

    f. ‘Entity Type’ = ‘OCI VCN Virtual Network Interface Card’ and ‘Log Source’ = ‘OCI VCN Flow Unified Schema Logs’ | eval vol = ‘Content Size Out’ / (1024 * 1024) | timestats perhour(‘Packets In’) as ‘Packet Rate (per hr)’ by ‘OCI Subnet OCID’

  3. Sample Instance Queries

    a. ‘Log Source’ = ‘Linux Secure Logs’ and Service = sudo | stats count by ‘User Name (Originating)’

    b. ‘Entity Type’ = ‘Host (Linux)’ and (‘invalid user’ or ‘user unknown’) | stats count”

    c. ‘Entity Type’ = ‘Host (Linux)’ and ‘User Name’ != null and ‘User Authentication Method’ = publickey | timestats count by Entity

    d. ‘Entity Type’ = ‘Host (Linux)’ | stats count as ‘Log Entries’ by ‘Log Source’ | top limit = 10 ‘Log Entries’

    e. ‘Entity Type’ = ‘Host (Linux)’ and ‘User Name’ != null and ‘Host IP Address (Client)’ != null | stats count by ‘Host IP Address (Client)’, ‘User Name’

    f. ‘Entity Type’ = ‘Host (Linux)’ | stats count as ‘Log Entries’ by Service | top limit = 10 ‘Log Entries’

    g. ‘Entity Type’ = ‘Host (Linux)’ and not (‘invalid user’ or ‘user unknown’) | stats count

  You can now go to your dashboard and add these widgets to your EBS Dashboard

  Another option is to create a Networking/Security Dashboard with your networking queries in addition to your ebs dashboard where you can filter your EBS/host log metrics in the EBS Dashboard and Network and Audit information in the Networking/Security Dashboard. You can add this dashboard by clicking Create Dashboard, naming it and saving.

This will now complete the Logging Analytics portion of this lab.

For more information on how to create widgets to understand your data refer to [visualize data using charts and controls](https://docs.oracle.com/en-us/iaas/logging-analytics/doc/visualize-data-using-charts-and-controls.html#GUID-93988D5B-9717-4F63-8362-16B08BC3E020)

## Acknowledgements
* **Author** - Quintin Hill, Cloud Engineering, Packaged Applications
* **Contributors** -  Kumar Varun, Logging Analytics Product Management
* **Contributors** -  Kaylien Phan, Cloud Engineering, Packaged Applications
* **Contributors** -  Chris Wegenek, Cloud Engineering, Packaged Applications
* **Last Updated By/Date** - Quintin Hill, Cloud Engineering, Feb 5 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
