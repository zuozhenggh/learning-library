# Deploy Zeppelin notebook

## Introduction

In this lab, we will deploy the popular <a href="https://zeppelin.apache.org/" target="\_blank">**Apache Zeppelin**</a> notebook to OKE and to create a simple notebook to MySQL HeatWave

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Create a kubernetes namespace for Zeppelin
* Deploy Zeppelin to OKE
* Run interactive analytics using PhpMyAdmin on MySQL HeatWave

### Prerequisites (Optional)

* You have an Oracle account
* You have enough privileges to use OCI
* You have one Compute instance having <a href="https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-install.html" target="\_blank">**MySQL Shell**</a> installed on it
* All previous labs successfully completed

## Task 1: Access OKE cluster

1. Click the **Hamburger Menu** ![](images/hamburger.png) in the upper left, navigate to **Developer Services** and select **Kubernetes Cluster (OKE)**

    ![Navigate to OKE](images/navigate-to-oke.png)

2. Select the Compartment (e.g. HOL-Compartment) that you provisioned the OKE cluster, and verify that the status of OKE cluster 'oke_cluster' is Active

    ![Locate OKE](images/locate-oke-instance.png)

3. Click 'oke_cluster' to view the status of the OKE cluster and the worker nodes in your OKE cluster

    ![Verify OKE](images/oke-worker-nodes.png)

1. Log in to **OCI** and select **Developer Services**, and **Kubernetes Clusters (OKE)** to access to your OKE cluster created

    ![OKE](images/oke-cluster.png)

2. Click on the **oke-cluster**

    ![oke cluster](images/click-cluster.png)

3. Click on the **Access Cluster** 

    ![oke cluster detail](images/click-cluster.png)

4. Click on the **Access Cluster** to look for the kubectl script to access the cluster

    ![Access Cluster](images/access-cluster.png)

5. Copy the kubectl script

    ![kubectl script](images/copy-kubectl-script.png)

6. On OCI Console, clik on the cloud shell to launch cloud shell

    ![Cloud Shell](images/cloud-shell.png)

## Task 2: Deploy Zeppelin to OKE

1. Download the zeppelin yaml scripts

```
<copy>
wget https://raw.githubusercontent.com/kuanrcl/learning-library/master/data-management-library/mysql/heatwave-cloud-analytics/zeppelin/zeppelin-server.yml
</copy>
```
```
<copy>
wget https://raw.githubusercontent.com/kuanrcl/learning-library/master/data-management-library/mysql/heatwave-cloud-analytics/zeppelin/zeppelin-ing.yml
</copy>
```

2. Execute the kubectl commands to create a namespace

```
<copy>
kubectl create namespace zeppelin
</copy>
```

3. Deploy Zeppelin

```
<copy>
kubectl apply -f zeppelin-server.yaml -n zeppelin
</copy>
```
```
<copy>
kubectl apply -f zeppelin-ing.yaml -n zeppelin
</copy>
```

4. Find out the public IP of OKE Ingress Controller

```
<copy>
kubectl get all -n ingress-nginx
</copy>
```
   ![Ingress IP](images/ingress.png)

5. Access the deployed Zeppelin application. Point your browser to **http://<PUBLIC_IP_ADDRESS>/zeppelin**

    ![Zeppelin](images/zeppelin.png)


Task 3: Connect to MySQL HeatWave

1. Create a JDBC interpreter for MySQL HeatWave in Zeppelin. 

    ![Interpreter](images/interpreter.png)

2. Click on **Create** to create a new JDBC driver for MySQL HeatWave. Fill up the details as indicated in the diagram
Replace the private ip address of your MySQL instance in the **JDBC URL**

    ![MySQL JDBC](images/mysql-jdbc.png)

3. Scroll to the bottom of the page and specify the MySQL JDBC driver, **mysql:mysql-connector-java:8.0.28**

    ![MySQL JDBC Driver](images/mysql-jdbc-driver.png)

4. Create a new notebook to start connecting to MySQL HeatWave. Specify the name of the notebook, for example, **airportdb**, and select **mysql** as the JDBC interpreter, click on **Create**

    ![New Notebook](images/new-notebook.png)

5. You can now start working with MySQL HeatWave!
    
	![Interactive Query](images/notebook-query.png)

You may now **proceed to the next lab.**

## Acknowledgements
* **Author** 
			 - Ivan Ma, MySQL Solutions Engineer, MySQL JAPAC, Ryan Kuan, MySQL Cloud Engineer, MySQL APAC
* **Contributors** 
			 - Perside Foster, MySQL Solution Engineering 
* **Last Updated By/Date** - Ryan Kuan, March 2021