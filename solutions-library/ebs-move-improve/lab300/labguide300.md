# Lab 300: Provision Your Oracle E-Business Suite Environment

## Introduction
In this 45 mins lab, we will use the One-Click Provisioning feature of Oracle E-Business Suite Cloud Manager to provision an Oracle E-Business Suite environment.

## Part 1. Log in to EBS Cloud Manager
1. Navigate to your Oracle E-Business Suite Cloud Manager application using the Login URL recorded in your Key-Data.txt file.
2. Log in with your Oracle Identity Cloud Service credentials.

![](./imgs/1.png "")

## Part 2. Provision an Environment Using One-Click Provisioning
1. On the Oracle E-Business Suite Cloud Manager Environments page, click Provision Environment and select One-Click.

2. Enter and select the following details for your new environment.
 - Environment Name: ebsholenv1
 -  Purpose: Vision Demo Install
 - EBS Version: 12.2.9
 - DB Version: 12.1.0.2

3. Click Submit

4. Demo 1: Lift and Shift Part 1
As you wait for the provisioning process to complete, your instructor will demo the first part of the lift and shift process.
After the demonstration and provisioning on your machine is successful, you will proceed to next section

You can check the status of the activity to provision the environment in the Activities page. The provisioning process will take approximately 20-25 minutes.

## Part 3. Enable and Set Oracle E-Business Suite Account Passwords

1. SSH to the newly created environment by following the instructions under “Administrator Access” in section “Access Your Oracle E-Business Suite Environment” in the Oracle by Example tutorial: [Performing Post-Provisioning and Post-Cloning Tasks for Oracle E-Business Suite on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/post_provisioning_tasks_for_ebs_on_oci/110_post_prov_cm_oci.html)

## Part 4. Configure Local Hosts File and Log in to Oracle E-Business Suite

1. In the Oracle Cloud Infrastructure console, find the IP address for the Oracle E-Business Suite web entry point by navigating to Networking > Load Balancers.

2. On the Load Balancers page, you will find a load balancer named ebsholenv1-lbaas. Obtain the public IP address of this load balancer and record this in your Key-Data.txt file.

![](./imgs/2.png "")

3. Edit the local hosts file on your laptop and add an entry.<br>
  a. *For Windows Users*<br>
    i. Navigate to Notepad in your start menu. <br>
    ii. Hover over Notepad, right-click, and select the option “Run as Administrator.” <br>
    iii. In Notepad, navigate to File > Open. <br>
    iv. Browse to C:\\Windows\System32\drivers\etc <br>
    v. Find the file hosts <br>
    ![](./imgs/3.png "")

    vi. In the hosts file, scroll down to the end of the content. <br>
    vii. Add the following entry to the very end of the file: ```<ip_address> ebsholenv1.example.com``` <br>
    viii. Save the file. <br>
  b. *For Mac Users* <br>
    i. Open a Terminal Window. <br>
    ii. Enter the following command: ```sudo vi /etc/hosts``` <br>
    iii. Go to the last line and add the following entry: ```<ip_address> ebsholenv1.example.com``` <br>
    iv. Save the file. <br>

4. Log in to Oracle E-Business Suite: <br>
  a. In your browser, navigate to the following URL: ```https://ebsholenv1.example.com/OA_HTML/AppsLocalLogin.jsp``` <br>
  b. When prompted, accept the warning concerning the certificate coming from an unauthorized certificate authority as we are using a self-signed certificate. (You will change the certificate with your own when executing this procedure outside of this hands-on lab.) <br>
  c. On this page, you will log in to Oracle E-Business Suite.
  ![](./imgs/4.png "")
