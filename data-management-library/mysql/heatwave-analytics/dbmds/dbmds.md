# Lab 2: Create MySQL DB Service (MDS) with HeatWave 

## Introduction

In this lab we will create a MySQL DB system and add a heatewave cluster to it. The DB System and HeatWave cluster must use the same shape, the shape defines the number of CPU cores, the amount of RAM, and so on. The size of the HeatWave cluster needed depends on tables and columns required to load, and the compression achieved in memory for this data.

 By enabling HeatWave you will deploy a standalone DB System characterized by a HeatWave-compatible shape (MySQL.HeatWave.VM.Standard.E3) and 1TB of data storage that will accelerate processing of analytic queries. For more information, check **[HeatWave Documentation](https://docs.oracle.com/en-us/iaas/mysql-database/doc/heatwave1.html#GUID-9401C69A-B379-48EB-B96C-56462C23E4FD)**. 

Estimated Lab Time: 20 minutes

### Objectives

-  Create an Instance of MySQL DB Systems
-  Add HeatWave cluster to MySQL Database Service

### Prerequisites

  - All previous labs have been successfully completed.


## **Task 1:** Create an Instance of MySQL in the Cloud

### **Task 1.1:**
- From the main menu on the left select _**Databases >> DB Systems**_
  
![](./images/task1.1.png)

### **Task 1.2:**
- The previous Task will bring you to the DB System creation page. 
Look at the compartment selector on the left and check that you are using the same compartment used to create the VCN and the Compute Instance. Once done, click on _**Create MySQL DB System**_.

![](./images/task1.2.png)

### **Task 1.3:**
- Start creating the DB System. Cross check again the compartment and assign to the DB System the name _**mysql-analytics-test**_ and select the HeatWave box. This will allow to create a MySQL DB System which will be HeatWave-ready. Ignore other boxes.
  
![](./images/task1.3.png)

### **Task 1.4:**
- In the _**Create Administrator Credential**_ section enter the following information:
  
```
<copy>
username: admin
password: Oracle.123
</copy>
```
- In the _**Configure Networking**_ section make sure you select the same subnet which you have used to create the Compute Instance _**`Public-Subnet-analytics_vcn_test(Regional)`**_.

- Leave the default availability domain and proceed to the _**Configure Hardware**_ section.
 
  ![](./images/task1.4.png)

### **Task 1.5:**
- Confirm that in the _**Configure Hardware**_ section, the selected shape is **MySQL.HeatWave.VM.Standard.E3**, CPU Core Count: **16**, Memory Size: **512 GB**, Data Storage Size: **1024**.
In the _**Configure Backup**_ section leave the default backup window of **7** days.

![](./images/task1.5.png)

### **Task 1.6:**
- To select a Configuration, scroll down and click on _**Show Advanced Options**_. 
  
![](./images/task1.6.png)


- In the Configuration tab click on _**Select Configuration**_. 

![](./images/task1.6-1.png)

### **Task 1.7:**
- In the _**Browse All Configurations**_ window, select **MySQL.HeatWave.VM.Standard.E3.Standalone**, and click the button _**Select a Configuration**_. 

![](./images/task1.7.png)

- If everything is correct you should see something corresponding to the below:

![](./images/task1.7-1.png)

### **Task 1.8:**
- Go to the Networking tab, in the Hostname field enter _**mysql-analytics-test**_ (same as DB System Name). 
Check that port configuration corresponds to the following:

    - MySQL Port: **3306**
    - MySQL X Protocol Port: **33060**
      
Once done, click the _**Create**_ button.

![](./images/task1.8.png)


- The MySQL DB System will have _**CREATING**_ state (as per picture below). 
  
![](./images/task1.8-1.png)


## **Task 2:** Add HeatWave cluster to MySQL Database Service


### **Task 2.1:**
- We will need to wait for the DB System which you have just created until its status turns  _**Active**_, it would takes around 10 minutes.

 Once it is active you can take note of the _**Private IP Address**_ of the MySQL DB System which we will use later in the workshop.

![](./images/task2.1.png)

### **Task 2.2:**
- From the menu on the left bottom side select _**HeatWave**_, and click on the button _**Add HeatWave Cluster**_ located on the right.
  
![](./images/task2.2.png)

- Check that Shape looks as per picture below and that Node Count is set to 2, and then click the button _**Add HeatWave Cluster**_.

![](./images/task2.2-1.png)

### **Task 2.3:**
- You will be brought back to the main page where you can check for the creation status. After some seconds you should see the nodes in _**Creating**_ status.
  
![](./images/task2.3.png)

- After completion, the node status will switch to _**Active**_ status. The process will take some time to be completed. 


As a recap, in this lab we have created a MySQL DB System node includes a HeatWave plugin that is responsible for cluster management, query scheduling, and returning query results to the MySQL DB System. 
 
Well done, you can now proceed to the next lab!



## **Acknowledgements**
- **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Vittorio Cioe - MySQL Solution Engineer
- **Contributors** - Priscila Iruela - Technology Product Strategy Director, Victor Martin - Technology Product Strategy Manager 
- **Last Updated By/Date** -