# Deploy Superset dashboard

## Introduction

**Oracle Container Engine for Kubernetes (OKE)** is an Oracle-managed container orchestration service that can reduce the time and cost to build modern cloud native applications. Unlike most other vendors, Oracle Cloud Infrastructure provides Container Engine for Kubernetes as a free service that runs on higher-performance, lower-cost compute shapes. 

In this lab, you will deploy a Superset package using Helm to **OKE**, and connect it to **MySQL**.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

* Install helm cli client and Superset repo for k8s package installation
* Deploy Superset package to the OKE cluster using helm cli client
* Use port-forward in oke-operator VM to route 8088 port traffic to superset service
* Change VCN security list to open 8088
* Define MySQL Database in Superset
* Test MySQL Database connection with SQL Editor in Superset
* Create a simple Dashboard

### Prerequisites

This lab assumes you have:

* An Oracle account
* You have enough privileges to use OCI
* Resources Ready : HOL-compartment, OKE cluster, MySQL Database Service

## Task 1: Verify OKE cluster

1. Click the **Hamburger Menu** ![](images/hamburger.png) in the upper left, navigate to **Developer Services** and select **Kubernetes Cluster (OKE)**

    ![Navigate to OKE](images/navigate-to-oke.png)

2. Select the Compartment (e.g. HOL-Compartment) that you provisioned the OKE cluster, and verify that the status of OKE cluster 'oke_cluster' is Active

    ![Locate OKE](images/locate-oke-instance.png)

3. Click 'oke_cluster' to view the status of the OKE cluster and the worker nodes in your OKE cluster. You will deploy a PHP application to this OKE cluster soon.

    ![Verify OKE](images/oke-worker-nodes.png)

## Task 2: Deploy Superset to OKE

1. Connect to the **oke-operator** compute instance using OCI Cloud Shell

2. Install helm cli client 'helm' to the operator VM and add superset repo.

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

3. Generate superset-custom-values.yaml (if needed, to update any specific variables) and Install superset package

    ```
    <copy>
    helm show values superset/superset  > superset-custom-values.yaml
    kubectl create ns superset
    helm upgrade --install --values superset-custom-values.yaml superset superset/superset -n superset
    </copy>
    ```

    ![Install superset ](images/superset-install.png)

4. Verify Superset deployment

    ```
    <copy>
    helm list -n superset
    kubectl get all -n superset
    </copy>
    ```

    ![Check resources in namespace superset ](images/superset-get-all.png)

5. Disable firewalld in oke-operator COMPUTE VM (make sure you are on oke-operator)

    ```
    <copy>
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
    </copy>
    ```

6. Start port-forward to service/superset.  If the testing finishes, press **CTRL-C** to terminate port-forward service.

    ```
    <copy>
    kubectl port-forward --address 0.0.0.0 8088:8088 service/superset -n superset
    </copy>
    ```
    > **Note** This is an alternative way to access OKE services via kubernetes port-forwarding function that is different from using ingress-controller

## Task 3: Edit VCN Security List

1. Select VCN **oke-vcn** from networking
    ![Choose oke-vnc VCN](images/VCN.png)

2. Click on the oke-operator subnet **operator-subnet-regional**
    ![operator subnet](images/VCN-subet.png)

3. Click on the security list of **operator-subnet-regional**
    ![security list](images/VCN-subnet-securitylist.png)

4. Add ingress rule to specify port 8088 and click "Add Ingress Rules" button
    ![Add Ingress Rule](images/VCN-AddIngressRule.png)

    ![Add Ingress Rule](images/VCN-AddIngressRule-8088.png)

    > **Note** In order to use kubernetes port-forwarding function, we need to allow ingress traffic to TCP port 8888 to oke-operator VM

## Task 4: Test Superset

1. Point your browser to http://&lt;public IP of oke-operator VM&gt;:8088. (Substitude **public IP of oke-operator VM** with the Public IP of **oke-operator** VM)

2. Login using user id and password of "admin/admin" and click "Sign In"
    ![Superset login](images/superset-login.png)

3. You will land on the default Superset **HOME** page
    ![Superset Home page](images/superset-home-page.png)

## Task 5: Connect Superset to MySQL

1. Login to OCI Console, select the **Hamburger Menu** ![](images/hamburger.png), type in **mysql** in the seach bar, select **DB System**

2. Click on the link "MySQLInstance" to check the details
    ![DB System](images/oci-mysql-dbsystem.png)

  Note down the IP Address for the DB System
    ![DB System](images/oci-mysql-dbsystem-ip.png)

4. Add MySQL Database Connection to Superset

5. Select "Connect Database" from "Data" menu item on "+" icon
    ![Connect Database Menu](images/superset-add-database-menu.png)

6. Choose "MySQL" for Database connection
    ![Connect MySQL database](images/superset-connect-mysql.png)

7. Fill in the details accordingly
    ![MySQL Details](images/superset-mysql-details.png)

8. Click "Finish" on successful connection to the MySQL Database Service
    ![Connect Success](images/superset-mysql-connect-success.png)

## Task 6: Execute SQL

1. Choose **SQL Editor** from SQL Lab menu
    ![SQL Editor menu](images/superset-sqllab-menu.png)
    ![SQL Editor menu](images/superset-sql-editor.png)

2. Select the relevant values in the list boxes
    ![SQL Editor test](images/superset-sql-editor-test.png)

  You may now **proceed to the next lab.**

## Acknowledgements

* **Author**
	* Ivan Ma, MySQL Solution Engineer, MySQL APAC
	* Ryan Kuan, MySQL Cloud Engineer, MySQL APAC
* **Contributors**
	* Perside Foster, MySQL Solution Engineering
	* Rayes Huang, OCI Solution Specialist, OCI APAC

* **Last Updated By/Date** - Ryan Kuan, March 2022






