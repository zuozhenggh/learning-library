# Deploy Ingress Controller to OCI Kubernetes

## Introduction

**Oracle Container Engine for Kubernetes (OKE)** is an Oracle-managed container orchestration service that can reduce the time and cost to build modern cloud native applications. Unlike most other vendors, Oracle Cloud Infrastructure provides Container Engine for Kubernetes as a free service that runs on higher-performance, lower-cost compute shapes. 

In this lab, you will deploy a Ingress controller on **OKE**.  This provides public IP access to internal service (as similar to load balancer).  Each of the following labs defines ingress resource with different port number which associates to the application service.

Please do remember to add security list to public subnet to allow All protocol from All source IP address in this demo.   Or you can add your notebook public IP address as source so that your IP is registered in VCN to allow all TCP traffic in/out your services.

Estimated Time: 5 minutes

### Objectives

In this lab, you will:
* Deploy ingress controller
* Deploy hello world service for testing
* Define security list in VCN for public subnet
* Test browser access to hello world thru ingress resource

### Prerequisites

This lab assumes you have:
* An Oracle account
* You have enough privileges to use OCI
* All previous labs successfully completed
* Resources Ready : HOL-compartment, OKE cluster


## Task 1: Verify OKE cluster

1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services** and select **Kubernetes Cluster (OKE)**

![Navigate to OKE](images/navigate-to-oke.png)

2. Select the Compartment (e.g. HOL-Compartment) that you provisioned the OKE cluster, and verify that the status of OKE cluster 'oke_cluster' is Active

![Locate OKE](images/locate-oke-instance.png)

3. Click 'oke_cluster' to view the status of the OKE cluster and the worker nodes in your OKE cluster. You will deploy a PHP application to this OKE cluster soon.

![Verify OKE](images/oke-worker-nodes.png)

## Task 2: Connect to **oke-operator** compute instance

1. Connect to the **oke-operator** compute instance again using OCI Cloud Shell

## Task 3: Deploy Ingress Controller to OKE

2. Download yaml deployment file to **OKE**

```
<copy>
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/cloud/deploy.yaml
</copy>
```


3. Check the status of deployed namespace and service

	```
	<copy>
	kubectl get all -n ingress-nginx
	kubectl get service -n ingress-nginx --watch
	</copy>
	```

Once you have the External IP provisioned, you can execute CTL+C to kill the command



## Task 4: Deploy hello world application and Test with Ingress resource

### Creating namespace helloworld
```
kubectl create ns helloworld
```

### Deploying hello world app to namespace helloworld
```
<copy>
cat <<EOF | kubectl apply -n helloworld -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: docker-hello-world
  labels:
    app: docker-hello-world
spec:
  selector:
    matchLabels:
      app: docker-hello-world
  replicas: 3
  template:
    metadata:
      labels:
        app: docker-hello-world
    spec:
      containers:
      - name: docker-hello-world
        image: scottsbaldwin/docker-hello-world:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: docker-hello-world-svc
spec:
  selector:
    app: docker-hello-world
  ports:
    - port: 8088
      targetPort: 80
  type: ClusterIP

EOF
</copy>
```

### Deploy Ingress Resource 'helloworld-ing' to namespace helloworld

```
cat <<EOF | kubectl apply -n helloworld -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: helloworld-ing
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/default-backend: docker-hello-world-svc
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths: 
      - path: /helloworld
        pathType: Prefix
        backend:
          service:
            name: docker-hello-world-svc
            port:
              number: 8088
EOF
```

### Check the Public IP and resource agin
- Based on the output and note down the public IP from the service.  
- The Ingress Resource helloworld-ing may get empty Public IP at the beginning.  After a while, the publc IP will be associated.


```
kubectl get svc -n ingress-nginx
kubectl get ing -n helloworld
```




### Open a browser and access your hello world application using the external IP address. (e.g. http://xxx.xxx.xxx.xxx:/helloworld). 


You may now **proceed to the next lab.**

## Acknowledgements
* **Author** 
			 - Ivan Ma, MySQL Solution Engineer, MySQL APAC
			 - Ryan Kuan, Cloud Engineer, MySQL APAC
* **Contributors** 

* **Last Updated By/Date** - Ivan Ma, March, 2022