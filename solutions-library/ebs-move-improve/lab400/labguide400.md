# Lab 400: Clone Your Oracle E-Business Suite Environment

## Introduction
Use the Cloning feature of Oracle E-Business Suite Cloud Manager to clone your Oracle E-Business Suite environment.

## Part 1. Access the Clone Environment Page
1. Navigate to the Cloud Manager Environments page.
2. For ebsholenv1, click Action and select Clone. Enter Details (see screenshot and points below)
![](./imgs/1.png "")

3. Enter the following values for the clone details:<br>
  * Environment Name: ebsholenv2
  * Source Apps Password: apps
  * Source WebLogic Server password: welcome1
4. Choose Load Balancer as a Service (LBaaS) by selecting the Deploy New Load Balancer check box.
5. Then, you must also select a shape in the Load Balancer Shape field. Select 100 mbps
6. Enter these values for the following Web Entry properties.
  * Protocol: https
  * Domain: example.com
  * Port: 443
  * Web Access IP/CIDR: 0.0.0.0/0
7. Click Submit.
8. You can check the status of the activity to clone the environment in the Activities page. The new environment is listed on the Environments page.

## Part 2. Configure Local Host Files for the Cloned Environment and Log in to Oracle E-Business Suite

1. In the Oracle Cloud Infrastructure console, find the IP address for the Oracle E-Business Suite web entry point by navigating to Networking > Load Balancers.

2. On the Load Balancers page, you will find a load balancer named ebsholenv2-lbaas. Obtain the public IP address of this load balancer and record in your ```Key-Data.txt``` file.

3. Edit the local hosts file on your laptop and add an entry. <br>
  a. For Windows users <br>
    i. Navigate to Notepad in your start menu. <br>
    ii. Hover over Notepad, right-click, and select the option “Run as Administrator.” <br>
    iii. In Notepad, navigate to File > Open. <br>
    iv. And browse to ```C:\\Windows\System32\drivers\etc.``` <br>
    v. Find the file ```hosts```. <br>
    ![](./imgs/2.png "")

    vi. In the hosts file, scroll down to the end of the content. <br>
    vii. Add the following entry to the very end of the file: ```<ip_address> ebsholenv1.example.com``` <br>
    viii. Save the file. <br><br>

  b.For Mac users <br>
    i. Open a Terminal Window. <br>
    ii. Enter the following command: ```sudo vi /etc/hosts``` <br>
    iii. Go to the last line and add the following entry: ```<ip_address> ebsholenv1.example.com``` <br>
    iv. save the file <br>

4. Log in to Oracle E-Business Suite:
  a. In your browser, navigate to the following URL: https://ebsholenv2.example.com /OA_HTML/AppsLocalLogin.jsp <br>
  b. When prompted, accept the warning concerning the certificate coming from an unauthorized certificate authority as we are using a self-signed certificate. (You will change the certificate with your own when executing this procedure outside of this hands-on lab.) <br>
  c. On this page, you will log in to Oracle E-Business Suite. <br>
  ![](./imgs/3.png "")
