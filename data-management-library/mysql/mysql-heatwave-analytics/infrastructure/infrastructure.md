# Lab 1: Infrastructure Configuration 

**Key Objectives:**
 
-	Create a Virtual Cloud Network and allow traffic through MySQL Database Service port
-	Create a compute instance as a bastion host
-	Connect to the bastion host, install MySQL Shell and download the workshop dataset

## **STEP 1**: Create a Virtual Cloud Network and allow traffic through MySQL Database Service port

### **Step 1.1:**
  Log-in to your OCI tenancy. Once you have logged-in, select _**Networking >> Virtual Cloud Networks**_ from the _**menu icon**_ on the top left corner

![](./images/HW1_vcn.png)

### **Step 1.2:**
 From the Compartment picker on the bottom left side, select your compartment from the list

![](./images/HW1b_vcn.png)

### **Step 1.3:** 
 To create a virtual cloud network, click on _**Start VCN Wizard**_ , 
  
![](./images/HW2_vcn.png)

### **Step 1.4:** 
 Select _**VCN with Internet Connectivity**_ and click _**Start VCN Wizard**_

![](./images/HW3_vcn.png)

### **Step 1.5:**
 Now you need to complete some information and set the configuration for the VCN. In the _**VCN NAME**_ field enter the value _**analytics_vcn_test**_ (or any name at your convenience), and make sure that the selected compartment is the right one. Leave all the rest as per default. Click next.

![](./images/HW4_vcn.png)

### **Step 1.6:** 
 Review and click _**Create**_

![](./images/HW5_vcn.png)

### **Step 1.7:** 
 Once the VCN will be created click _**View Virtual Cloud Network**_

![](./images/HW6_vcn.png)

### **Step 1.8:** 
 Click on the _**Public_Subnet-analytics_vcn_test**_ link. 

![](./images/HW7_vcn.png)

### **Step 1.9:** 
 Earlier we set up the subnet to use the VCN's default security list, that has default rules, which are designed to make it easy to get started with Oracle Cloud Infrastructure. 
 Now we will customize the default security list of the VCN to allow traffic through MySQL Database Service ports by clicking on  _**Default_Security_List_for_analytics_vcn_test**_

![](./images/HW8_vcn.png)

### **Step 1.10:** 
  Click on _**Add Ingress Rules**_

![](./images/HW9_vcn.png)

### **Step 1.11:**
 Add the necessary rule to the default security list to enable traffic through MySQL Database Service port. 

Insert the details as below:
Source CIDR  _**0.0.0.0/0**_,  port _**3306**_, description  _**MySQL Port**_.

At the end click the blue button _**Add Ingress Rules**_

![](./images/HW10_vcn.png)



## **STEP 2:** Create a compute instance as a bastion host


### **Step 2.1:**
- From the main menu on the top left corner select _**Compute >> Instances**_
  
![](./images/HW11_ci.png)

### **Step 2.2:** 
- In the compartment selector on the bottom left corner, select the same compartment where you created the VCN. Click on the _**Create Instance**_ blue button to create the compute instance.

![](./images/HW12_ci.png)

### **Step 2.3:** 
- In the _**Name**_ field, insert _**mysql-analytics-test-bridge**_ (or any other name at your convenience). This name will be used also as internal FQDN. 
The _**Placement and Hardware section**_ is the section where you can change Availability Domain, Fault Domain, Image to be used, and Shape of resources. For the scope of this workshop leave everything as default.

- In the Networking section, check that your previously created VCN is selected, and select your PUBLIC subnet (_**Public Subnet - analytics_vcn_test**_) from the dropdown menu.
  
![](./images/HW13_ci.png)


### **Step 2.4:** 
- Scroll down and MAKE SURE TO DOWNLOAD the proposed private key. 
You will use it to connect to the compute instance later on.
Once done, click _**Create**_

![](./images/HW15_ci.png)

### **Step 2.5:** 
- Once the compute instance will be up and running, you will see the square icon on the left turning green.
 However, you can proceed to the next lab until the provisioning is done.
  
![](./images/HW16_ci.png)


## **STEP 3:** Connect to the bastion host, install MySQL Shell and download the workshop dataset

### **Step 3.1:**
- From the main menu on the left go to _**Compute >> Instances**_
 Click on the instance you have previously created and take note of the _**Public IP Address**_.

![](./images/HW16_ci4.png)

### **Step 3.2:**
- In order to connect to the bastion host, we will use the cloud shell, a small linux terminal embedded in the OCI interface.
To access cloud shell, click on the shell icon next to the name of the OCI region, on the top right corner of the page

![](./images/cloud-shell-1.png)

### **Step 3.3:**
- Once the cloud shell is opened, you will see the command line as per picture below:
  
![](./images/cloud-shell-2.png)

### **Step 3.4**
- We suggest to increase the font size, as per picture below:
  
![](./images/cloud-shell-3.png)

### **Step 3.5:**
- On the top left corner of the cloud shell there are Minimize, Maximize and Close buttons. If you Maximize the cloud shell it will take the size of the entire page. Remember to Restore the size or Minimize prior of changing page in the OCI interface.

![](./images/cloud-shell-4.png)

### **Step 3.6:**
- Drag and drop the previously saved private key into the cloud shell. Get the file name with the command _**ll**_ 
  
![](./images/cloud-shell-5.png)

### **Step 3.7:**
- In order to establish an ssh connection with the bastion host using the Public IP, execute the following commands:
```
chmod 600 <private-key-file-name>.key
ssh -i <private-key-file-name>.key opc@<compute_instance_public_ip>
```

If prompted to accept the finger print, type _**yes**_ and hit enter, then you will get a Warning.

_**Warning: Permanently added '130.******' (ECDSA) to the list of known hosts.**_

Now that you have connected to the instance you can proceed to the next step.

### **Step 3.8:**
- From the established ssh connection, install MySQL Shell and MySQL client executing the following commands and the expected outputput should be as following:
  
```
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
```
![](./images/cloud-shell-6.png)
```
sudo yum localinstall mysql80-community-release-el7-3.noarch.rpm
```
![](./images/cloud-shell-7.png)

_**when prompted a warning about the public key type "y"**_

```
sudo yum install mysql-shell  
```
![](./images/cloud-shell-8.png)

_**when prompted a warning about the public key type "y"**_

```
sudo yum install mysql-community-client
```

![](./images/cloud-shell-9.png)

_**when prompted a warning about the public key type "y"**_


### **Step 3.9:**
- Launch MySQL Shell executing the following command:
```
mysqlsh
```
When you see the MySQL Shell colorful prompt, exit with the following command:
```
\q
```

### **Step 3.10:**
- Download and unzip the workshop material using the following commands:
```
cd /home/opc
```

```
wget https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/wRGvQM7cJAXu6_YoMIfzLeWQnnw5zUXlSOynelMlADOFfQI3t1ugdRB7U8fFnFHG/n/odca/b/MySQL_Data/o/heatwave_workshop.zip
```

![](./images/cloud-shell-10.png)

```
unzip heatwave_workshop.zip
```

![](./images/cloud-shell-11.png)


After it is done extracting the files you can move to the next step and test it

### **Step 3.11:**
- Verify the extracted material executing _**ll**_ command.
Among the output, you should see the following file names:

_**tpch_dump**_

_**tpch_offload.sql**_

_**tpch_queries_mysql.sql**_

_**tpch_queries_rapid.sql**_

![](./images/cloud-shell-12.png)


## Conclusion

In this Lab we created the VCN and added the additional Ingress rules to the Security list, and created a compute instance that serves as a bastion host and launched the cloud shell to import the private keys to connect to the compute instance; we also installed MySQL Shell and MySQL client; finally we downloaded and unzipped the dataset that will be used later on for benchmark analysis.

Now you can proceed to the next lab!

 **[Home](../README.md)** | **[Go to Lab 2 >>](/Lab2/README.md)**
