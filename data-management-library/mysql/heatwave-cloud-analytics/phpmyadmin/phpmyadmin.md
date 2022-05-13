# Deploy phpMyAdmin

## Introduction

In this lab, we will deploy a very popular open-source tool, <a href="https://www.phpmyadmin.net/", target="\_blank">phpMyAdmin</a> to OKE to manage MySQL HeatWave

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

* Create a Kubernetes namespace for phpMyAdmin
* Deploy phpMyAdmin to OKE
* Manage MySQL using phpMyAdmin

### Prerequisites (Optional)

* You have an Oracle account
* You have enough privileges to use OCI
* OCI Resource required: HOL-compartment, OKE Cluster, MySQL HeatWave

## Task 1: Verify OKE cluster

1. Click the **Hamburger Menu** ![](images/hamburger.png) in the upper left, navigate to **Developer Services** and select **Kubernetes Cluster (OKE)**

    ![Navigate to OKE](images/navigate-to-oke.png)

2. Select the Compartment (e.g. HOL-Compartment) that you provisioned the OKE cluster, and verify the status of **oke_cluster** is **Active**

    ![Verify OKE](images/click-cluster.png)

## Task 2: Deploy phpMyAdmin to OKE

1. Connect to the **oke-operator** compute instance using OCI Cloud Shell

  ![Connect to VM](images/connect-to-vm.png)

2. Create a phpmyadmin namespace in OKE

```
 <copy>
 kubectl create ns phpmyadmin
 </copy>
 ```

3. Install the helm client

	**Note** Skip this step if you have installed helm client

```
<copy>
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 |bash -
</copy>
```

4. Install phpmyadmin repository using helm

```
<copy>
helm repo add bitnami https://charts.bitnami.com/bitnami
</copy>
```

```
<copy>
helm install myrelease bitnami/phpmyadmin --namespace phpmyadmin
</copy>
```

5. Create the phpmyadmin ingress service

```
<copy>
cat <<EOF | kubectl -n phpmyadmin apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: phpmyadmin-ing
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
    nginx.ingress.kubernetes.io/app-root: /phpmyadmin/
    nginx.ingress.kubernetes.io/configuration-snippet: |
      rewrite ^/themes/(.*)$ /phpmyadmin/themes/$1 redirect;
      rewrite ^/index.php(.*)$ /phpmyadmin/index.php$1 redirect;
      rewrite ^/config/(.*)$ /phpmyadmin/config/$1 redirect;
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
        - path: /phpmyadmin(/|$)(.*)
          pathType: Prefix
          backend:
            service:
              name: myrelease-phpmyadmin
              port:
                number: 80
        - path: /index.php(.*)
          pathType: Prefix
          backend:
            service:
              name: myrelease-phpmyadmin
              port:
                number: 80
EOF
</copy>
```

6. Find out the public IP of OKE Ingress Controller

```
 <copy>
 kubectl get all -n ingress-nginx
 </copy>
```

  ![Ingress IP](images/ingress.png)

7. Access the deployed phpMyAdmin application using your browser, http:://&lt;OKE&#95;INGRESS&#95;PUBLIC&#95;IP&gt;/phpmyadmin

	![PhpMyAdmin](images/phpmyadmin.png)

## Acknowledgements

* **Author**
	* Ivan Ma, MySQL Solutions Engineer, MySQL Asia Pacific
	* Ryan Kuan, MySQL Cloud Engineer, MySQL Asia Pacific
* **Contributors**
	* Perside Foster, MySQL Solution Engineering North America
	* Rayes Huang, OCI Solution Specialist, OCI Asia Pacific

* **Last Updated By/Date** - Ryan Kuan, May 2022
