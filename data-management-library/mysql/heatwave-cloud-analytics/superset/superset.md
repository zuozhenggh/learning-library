
# Deploy Superset Dashboard for MySQL to OCI Kubernetes
## Introduction

**Oracle Container Engine for Kubernetes (OKE)** is an Oracle-managed container orchestration service that can reduce the time and cost to build modern cloud native applications. Unlike most other vendors, Oracle Cloud Infrastructure provides Container Engine for Kubernetes as a free service that runs on higher-performance, lower-cost compute shapes. 

In this lab, you will deploy a Superset package using Helm to **OKE**, and connect it to **MySQL**.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Install helm cli client and superset repo for k8s package installation
* Deploy a superset package to the OKE cluster using helm cli client
* Using port-forward in oke-operator VM to route 8088 port traffic to superset service
* Change VCN security list to open 8088 
* Define MySQL Database in Superset
* Test MySQL Database connection with SQL Editor in Superset
* Create a simple Dashboard

### Prerequisites

This lab assumes you have:
* An Oracle account
* You have enough privileges to use OCI
* All previous labs successfully completed
* Resources Ready : HOL-compartment, OKE cluster, MySQL Database Service 


## Task 1: Verify OKE cluster

1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services** and select **Kubernetes Cluster (OKE)**

![Navigate to OKE](images/navigate-to-oke.png)

2. Select the Compartment (e.g. HOL-Compartment) that you provisioned the OKE cluster, and verify that the status of OKE cluster 'oke_cluster' is Active

![Locate OKE](images/locate-oke-instance.png)

3. Click 'oke_cluster' to view the status of the OKE cluster and the worker nodes in your OKE cluster. You will deploy a PHP application to this OKE cluster soon.

![Verify OKE](images/oke-worker-nodes.png)

## Task 2: Connect to **oke-operator** compute instance

1. Connect to the **oke-operator** compute instance again using OCI Cloud Shell

## Task 3: Deploy Application to OKE

1. Install helm cli client 'helm' to the operator VM and add superset repo.

    ```
    <copy>
    curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 |bash -
    </copy>
    ```
    ![Install helm cli](images/helm-cli-install.png) 
    
    ```
    <copy>
    helm repo add superset https://apache.github.io/superset
    </copy>
    ```
    ![Add superset repo to helm ](images/helm-add-repo.png)

2. Generate superset-custom-values.yaml (if needed, to update any specific variables) and Install superset package.
    ```
    <copy>
    helm show values superset/superset  > superset-custom-values.yaml
    kubectl create ns superset
    helm upgrade --install --values superset-custom-values.yaml superset superset/superset -n superset
    </copy>
    ```
    ![Install superset ](images/superset-install.png)

3. Check deployment
    ```
    <copy>
    helm list -n superset
    kubectl get all -n superset
    </copy>
    ```
    ![Check resources in namespace superset ](images/superset-get-all.png)

3. Disable firewalld in oke-operator COMPUTE VM (make sure you are on oke-operator)
    ```
    <copy>
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
    </copy>
    ```

4. Start port-forward to service/superset.  If the testing finishes, press **CTRL-C** to terminate port-forward service.

    ```
    <copy>
    kubectl port-forward --address 0.0.0.0 8088:8088 service/superset -n superset
    </copy>
    ```


## Task 4 : Change VCN security list attached to oke-operator VM's subnet to open 8088 traffic

- Select VCN oke-vcn from networking
    ![Choose oke-vnc VCN](images/VCN.png)

- Click on the oke-operator subnet "operator-subnet-regional"
    ![operator subnet](images/VCN-subnet.png)

- Click on the security list on operator-subnet-regional
    ![security list](images/VCN-subnet-securitylist.png)

- Add ingress rule to define 8088 and Click "Add Ingress Rules" button
    ![Add Ingress Rule](images/VCN-AddIngressRule.png)

    ![Add Ingress Rule](images/VCN-AddIngressRule-8088.png)


## Task 5 : Test Superset (note: using http://[public IP of oke-operator VM]:8088)
- Open a browser and put in the URL : http://[public IP of oke-operator VM]:8088
    - login as admin / admin and click "Sign In"
    ![Superset login](images/superset-login.png)
    - You will be landing on superset **HOME** page
    ![Superset Home page](images/superset-home-page.png)

## Task 6 : Adding MySQL Database Service Connection to Superset
- Identify the MySQL DB System IP Address
    - Open New Browser page to OCI console
    - On hamburger menu, type mysql and choose DB System.  
    - Click on the link "MySQLInstance" to check the details
    ![DB System](images/oci-mysql-dbsystem.png)
    - Note down the IP Address for the DB System
    ![DB System](images/oci-mysql-dbsystem-ip.png)

- Add MySQL Database Connection to superset
    - Select "Connect Database" from "Data" menu item on "+" icon
    ![Connect Database Menu](images/superset-add-database-menu.png)
    - Choose "MySQL" for Database connection
    ![Connect MySQL database](images/superset-connect-mysql.png)
    - Fill in the Content accordingly.   
    ![MySQL Details](images/superset-mysql-details.png)
    - Click "Finish" on successful connection to the MySQL Database Service
    ![Connect Success](images/superset-mysql-connect-success.png)


## Task 7 : Testing SQL on SQL Editor from superset 
- Choose **SQL Editor** from SQL Lab menu
    ![SQL Editor menu](images/superset-sqllab-menu.png)
    ![SQL Editor menu](images/superset-sql-editor.png)

    - Select Database:"MySQL", Schema:"airportdb", Table Schema:"airline", the result is listed
    ![SQL Editor test](images/superset-sql-editor-test.png)


You may now **proceed to the next lab.**

## Acknowledgements
* **Author** 
      - Ivan Ma, MySQL Solution Engineer, MySQL APAC
      - Ryan Kuan, MySQL Cloud Engineer, MySQL APAC
* **Contributors** 
			 
* **Last Updated By/Date** - Ivan Ma, March, 2022







