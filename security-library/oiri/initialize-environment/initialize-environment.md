# Initialize the workshop environment

## Introduction

In this lab we will review and startup all components required to successfully run this workshop.

*Estimated Lab Time*:

### Objectives

In this lab, you will:
* Launch the workshop instance
* Start the OIG Database
* Create and Initialize Kubernetes nodes
* Start the OIG 12c domain. Analyze the different roles and entitlements created in OIG

### Prerequisites

* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported
* SSH Private Key to access the host via SSH

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***


## **STEP 1:** Launch the workshop instance

1. Launch a browser window to the following URL to access the instance

    ```
    <copy>http://[your instance public-ip address]:6080/index.html?password=LiveLabs.Rocks_99&resize=remote&autoconnect=true/</copy>
    ```

    ![](images/1-no-vnc.png)

    ![](images/2-no-vnc.png)

## **STEP 2:** Initialize the Kubernetes cluster and the pod network add-on

1. Open a terminal session as opc user (default)

    ```
    <copy>sudo swapoff -a</copy>
    ```
    ```
    <copy>sudo setenforce 0</copy>
    ```
    ```
    <copy>sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux</copy>
    ```

2. Deploy and initialize the pod network and make sure that the pod network does not overlap with any of the host networks

    ```
    <copy>sudo kubeadm init --pod-network-cidr=10.244.0.0/16</copy>
    ```

3. Enable kubectl to work with non-root users

    ```
    <copy>sudo cp -i /etc/kubernetes/admin.conf /home/oracle/.kube/config</copy>
    ```
    ```
    <copy>sudo chown oracle:oinstall /home/oracle/.kube/config</copy>
    ```

4. Launch another terminal session as *oracle* user and schedule Pods on the control-plane node

    ```
    <copy>sudo su - oracle</copy>
    ```
    ```
    <copy>kubectl taint nodes --all node-role.kubernetes.io/master-</copy>
    ```

5. List all pods in all namespaces

    ```
    <copy>kubectl get pods --all-namespaces</copy>
    ```

6. Update the resources in the cluster and make sure all pods are in the “Running” state

    ```
    <copy>kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml</copy>
    ```
    Wait for 1-2 minutes and list all the pods and make sure they are in the *Running* state

    ```
    <copy>kubectl get pods --all-namespaces</copy>
    ```

    ![](images/3-pods.png)

## **STEP 3:** Start the Oracle Identity Governance (OIG) Database and Instance

1. Start the OIG Database

    ```
    <copy>source ~/.bash_profile</copy>
    ```
    ```
    <copy>lsnrctl start</copy>
    ```
    ```
    <copy>sqlplus / as sysdba</copy>
    ```
    ```
    <copy>startup</copy>
    ```
    ```
    <copy>exit</copy>
    ```
    ```
    <copy>lsnrctl status</copy>
    ```

    ![](images/4-db-start.png)

2. Start the Node Manager

    ```
    <copy>cd /u01/oracle/config/domains/oig_domain/bin/</copy>
    ```
    ```
    <copy>nohup ./startNodeManager.sh &</copy>
    ```

    ![](images/5-node-manager.png)

3. Start the Weblogic Admin Server

    ```
    <copy>nohup ./startWebLogic.sh &</copy>
    ```

    ![](images/6-weblogic.png)

4. Open a browser window and Click on the bookmark *Weblogic Admin Console* to access the Weblogic console

    ![](images/7-weblogic-console.png)

5. Sign in to the console with the weblogic credentials

    ```
    Username:<copy>weblogic</copy>
    ```
    ```
    Password:<copy>Welcome1</copy>
    ```

    ![](images/8-weblogic-login.png)

6. Start SOA,OIM servers. On the Weblogic console, Click on *Servers* under *Environment*. Under Summary of servers, click on *Control*

    ![](images/9-servers.png)

    Select SOA and OIG server and click on *Start*

    ![](images/10-servers.png)
    ![](images/11-servers.png)


7. Open another browser tab and Click on the bookmark *OIG Identity Console*. Login to the Identity console using the following credentials:

    ```
    Username: <copy>xelsysadm</copy>
    ```
    ```
    Password: <copy>Welcome1</copy>
    ```

    ![](images/12-oig.png)

    ![](images/13-oig.png)

8. Click on *Manage* on the top right corner. Then, click on *Users* and notice that about 1000 test users have been created with respective roles and entitlements. Also notice that the users are provisioned to the "Document Access" account.

    ![](images/14-oig.png)

    ![](images/15-oig.png)

    ![](images/16-oig.png)

    ![](images/17-oig.png)


9. Now click on *Home*. Then, click on *Roles and Access policies* and select *Roles*. Notice that the OIRI role engineer role is created. The role *OrclOIRIRoleEngineer* is created and assigned to the application user so that the user can login to the OIRI application. In this example, this role is assigned to the *xelsysadm* user.

    ![](images/18-oig.png)

    ![](images/19-oig.png)

    ![](images/20-oig.png)

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Keerti R, Brijith TG, Anuj Tripathi, NATD Solution Engineering
* **Contributors** -  Keerti R, Brijith TG, Anuj Tripathi
* **Last Updated By/Date** - Keerti R, NATD Solution Engineering, June 2021
