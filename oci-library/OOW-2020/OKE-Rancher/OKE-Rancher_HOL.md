# Oracle Container Engine and Rancher 

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create VCN](#sign-in-to-oci-console-and-create-vcn)

[Create ssh keys two compute instances and configure routing](#create-ssh-keys-two-compute-instances-and-configure-routing)

[ssh to compute instance and test VCN peering](#ssh-to-compute-instance-and-test-vcn-peering)

[Testing Console Connection to the compute instance](#testing-console-connection-to-the-compute-instance)

[Delete the resources](#delete-the-resources)


## Overview


**Some Key points;**



>- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them
>
>- OCI UI is being updated frequently thus some screenshots in the instructions might be different than actual UI
>
>- Do NOT use compartment name and other data from screen shots.
>
>- Login credentials are provided later in the guide (scroll down). Every User MUST keep these 
credentials handy.

Replace the below credentials with your own (seek instructors for assistance)

**Tenant Name** = _TENANTXX_
**User Name** = _USERXX_  
**Password** = _PASSWORDXX_  
**Compartment Name** = _COMPARTMENTXX_  

## Sign in to OCI Console and create VCN

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="media/01-lab-login.png" alt="image-alt-text">

*************
2. From the OCI Services menu, Click **Virtual Cloud Network**.  
   Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Create Virtual Cloud Network**

<img src="media/02-lab-vcn.png" alt="image-alt-text">

>**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

3. Click **VCN with Internet Connectivity** and click **Start Workflow**
   
4. Fill out the dialog box:

   - **VCN NAME**: Provide a name
   - **COMPARTMENT**: Ensure your compartment is selected
   - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
   - **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
   - **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)  
- Click **Next**

5. Verify all the information and  Click **Create**

6. This will create a VCN with followig components.

_**VCN**, **Public subnet**, **Private subnet**, **Internet gateway (IG)**, **NAT gateway (NAT)**, **Service gateway (SG)**_

7. Click **View Virtual Cloud Network** to display your VCN details.

8. We need to open the ports 80 and 443 to provide http/https access to the Rancher console.  
   Click Network Security Groups and then **Create Network Security Group**
   
<img src="media/03-lab-nsg.png" alt="image-alt-text">

9. Fill out the dialog box:
    - **NAME**: Provide a name
    - **COMPARTMENT**: Ensure your compartment is selected
- Click **Next**

10. Add the below rule:  

    - **STATELESS**: Make sure the flag is un-checked
    - **DIRECTION**: Ingress
    - **SOURCE TYPE**: CIDR
    - **SOURCE**: 0.0.0.0/0
    - **IP PROTOCOL**: TCP
    - **SOURCE PORT RANGE**: ALL
    - **DESTINATION PORT RANGE**: 80  
  
  - Click **+ Another Rule** to add a new rule. Fill out the dialog box:  
  
    - **STATELESS**: Make sure the flag is un-checked
    - **DIRECTION**: Ingress
    - **SOURCE TYPE**: CIDR
    - **SOURCE**: 0.0.0.0/0
    - **IP PROTOCOL**: TCP
    - **SOURCE PORT RANGE**: ALL
    - **DESTINATION PORT RANGE**: 443  

## Configure Rancher instance

We are going to create a compute instance to run Rancher

1. From OCI services menu, Click **Instances** under **Compute** 

2. Click **Create Instance**. Fill out the dialog box:

- **Name your instance**: Enter a name 
- **Choose an operating system or image source**: Select CentOS 7
- **Availability Domain**: Select availability domain
- **Instance Type**: Select Virtual Machine 
- **Instance Shape**: Select VM shape 

**Under Configure Networking**
- **Virtual cloud network compartment**: Select your compartment
- **Virtual cloud network**: Choose the VCN 
- **Subnet Compartment:** Choose your compartment. 
- **Subnet:** Choose the Public Subnet under **Public Subnets** 
- **Use network security groups to control traffic** : Leave un-checked
- **Assign a public IP address**: Check this option

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

- **Boot Volume:** Leave the default
- **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.

9. Click  **Show Advanced Options**

**Under Management**

- **User Data**: Choose '*Paste cloud-init script*' and paste the below script. Cloud-init script will be executed at the first boot only to configure the instance. 

```
#cloud-config
packages:
- httpd
- stress

runcmd:
- [sh, -c, echo "<html>Web Server IP `hostname --ip-address`</html>" > /var/www/html/index.html]
- [firewall-offline-cmd, --add-port=80/tcp]
- [systemctl, start, httpd]
- [systemctl, restart, firewalld]
```

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_013.PNG" alt="cloud-init setup">

10. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2 OR choose a different AD

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

11. Wait for Instance to be in **Running** state. 

12. Click Instance name and then select **Create Instance Configuration** from the Action menu.  
Fill out the dialog box:

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_001.PNG" alt="image-alt-text">


- **CREATE IN COMPARTMENT**: Choose your compartment
- **INSTANCE CONFIGURATION NAME** : Provide a name

13. Click **Create Instance Configuration**

14. In the Instance Configuration page, Click **Create Instance Pool**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_002.PNG" alt="image-alt-text">

15.  Click **Create Instance Pool**. A new dialog box will appear. This is used to create initial configuration of the instance pool such as how many compute instance to create initially, VCN, and Availability domain the instance pool should be created in. Fill out the dialog box:


- **CREATE IN COMPARTMENT**: Choose your compartment
- **INSTANCE POOL NAME**: Provide a suitable name
- **NUMBER OF INSTANCES**: 0 

(This is the number of computes that should be launched when the pool is created. We will start with no compute)


- **INSTANCE CONFIGURATION COMPARTMENT** : Provide your compartment

(This is the compartment where instance configuration will be placed and can only be used in this specific compartment)


- **INSTANCE CONFIGURATION**: Choose the instance configuration created earlier

(Any computes launched in this pool will inherit shape, image and ssh keys of the compute whose instance configuration we are using)

- **ATTACH A LOAD BALANCER**: Select this option.

- **LOAD BALANCER COMPARTMENT**: Choose your compartment

- **LOAD BALANCER**: Choose the Load Balancer created earlier

- **BACKEND SET**: Choose the first backend set

- **PORT**: 80

- **VNIC**: Leave the default


- **AVAILABILITY DOMAIN**: Choose the AD you want to places instances (you can choose first AD if in Multi AD region)
- **VIRTUAL CLOUD NETWORK COMPARTMENT**: Choose VCN's compartment
- **VIRTUAL CLOUD NETWORK**: Choose your VCN
- **SUBNET COMPARTMENT**: Choose your compartment

- **SUBNET**: Choose the Public Subnet  

**NOTE: Below step of adding second AD only applies if you are working in Multi AD Region. This step should be skipped for Single AD Region.**

16. Click **+ Additional Selection** and select a different availability domain for the instance pool. Then, specify the VCN details for the second availability domain.

**We configured instances to be deployed in two different Avaialability domain though they can be deployed in the same Availability domain as long as service limits allow it.**

**For this lab use two different availability domains**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_003.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_003-1.PNG" alt="image-alt-text">

17. Click **Create Instance Pool**. Wait for Instance Pool to be in **RUNNING** state (turns green)

18. From the instance pool details page, Click **Actions** and choose **Create Auto Scaling Configuration**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_004.PNG" alt="image-alt-text">

19. Fill out the dialog box:


- **COMPARTMENT**: Choose your compartment
- **AUTOSCALING CONFIGURATION NAME** : Provide a name
- **INSTANCE POOL** : This should show your instance pool name created earlier
- **COOLDOWN IN SECONDS** : 300 (This is he minimum period of time between scaling actions.)
- **AUTOSCALING POLICY NAME** : Provide a name
- **PERFORMANCE METRIC** : CPU Utilization (This is the Metric to use for triggering scaling actions.)
- **MINIMUM NUMBER OF INSTANCES** : 1 (this is the minimum number of instances that the pool will always have)
- **MAXIMUM NUMBER OF INSTANCES** : 2 (this is the maximum number of instances that the pool will always have)
- **INITIAL NUMBER OF INSTANCES** : 1 (this is how many instances will be created in the instance pool initially)
- **SCALE-OUT OPERATOR** : Greater than (>)
- **THRESHOLD PERCENTAGE** : 10
- **NUMBER OF INSTANCES TO ADD** : 1
- **SCALE-IN OPERATOR** : Less than (<)
- **THRESHOLD PERCENTAGE** : 5
- **NUMBER OF INSTANCES TO REMOVE**  : 1

**Leave other fields as is**

20. Click **Create**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_005.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_006.PNG" alt="image-alt-text">

**We have now created a auto scaling policy that will start with creating 1 compute instance in the designated pool. Once the CPU utilization is determined to be above 10% for at least 300 seconds another compute instance will be launched automatically. Once the CPU utilization is determined to be less than 5% for 300 seconds, one compute instance will be removed. At all times there will be at least 1 compute instance in the pool**

**Original image can be deleted as it's not part of the pool**

## Test the setup

1. Click **Instance Pools** under **Compute** and then your pool name. You should see a Compute instance created. Click the Compute Instance name.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_007.PNG" alt="image-alt-text">

2. Note down the Public and Private IP of compute instance from the details page (Under **Primary VNIC Information** section). 

3. Open a web browser and enter load balancer's public IP address. You should see the message: `Web Server IP: <instance private IP>`

4. Switch to git bash window, if the ssh session to compute instance is still open then exit out of the session (quit command). 

5. Ensure you are in /C/Users/PhotonUser/.ssh directory.

6. Enter **ls** and verify id_rsa file exists

7. Enter command 
```
ssh -i id_rsa_user opc@<PUBLIC_IP_OF_COMPUTE>
```

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command

8. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
9. Now start CPU stress, Enter command:

```
sudo stress --cpu 4 --timeout 350
```

**Spawn 4 workers spinning on sqrt() with a timeout of 350 seconds.**

10. Switch back to OCI console and navigate to Instance pool details page. Click your instance name and scroll down to **Metric** screen, you should see CPU spiking up after a minute or so.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_009.PNG" alt="image-alt-text">

11. Navigate to your Instance Pool details page. In about 3-4 minutes (time configured when we created auto scale configuration), status of Pool should change to **Scaling** and a second compute instance should launch.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_010.PNG" alt="image-alt-text">

**This is since our criteria of CPU utilization > 10 was met**

12. When the second instance is up and running and the instance pool status is  'Running', switch to the web browser and refresh the page multiple times and observe the load balancer balancing traffic between the two web servers.

13. Switch back to git bash window and if the stress tool is still running, Prees Ctrl + C to stop the script.

14. Switch back to OCI console window and navigate to your compute instance details page. Verify CPU utilization goes down after a minute.

15. Navigate to Instanse pool details page and after 3-4 minute Instance pool status will change to **Scaling** . Additional compute instance will be deleted. 

**This is because our criteria of CPU utilization < 5 is met**

## Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**

3. Locate first compute instance, Click Action icon and then **Terminat** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

5. In OCI console window from Instance Pool Details page, Click **Terminate** under **Action**. Provide Instance Pool name in the pop up dialog box and Click **Terminate**. This will delete the pool along with the compute instance and auto scale configuration.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_011.PNG" alt="image-alt-text">


6. Navigate to **Instance Configurations** Under **Compute**. For your Instance Configuration, Click **Delete** under the three Vertical dots.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Auto_Scaling/img/Auto_Scaling_012.PNG" alt="image-alt-text">

7. Navigate to **AutoScaling Configurations** Under **Compute**. For your Instance Configuration, Click **Delete**

8. From OCI services menu Click **Load Balancers** under Networking, locate your Load Balancer and Click Terminate under the three Vertical dots.

9. From OCI services menu Click **Virtual Cloud Networks** under Networking, Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">

***Congratulations! You have successfully completed the lab.***