# Deploy MuShop Application

## Introduction

There are three options to deploying MuShop, they range from manual (docker) to automated (Helm).  

Designing in microservices offers excellent separation concerns and provides developer independence.  While these benefits are clear, they can often introduce some complexity for development enviornment.  Services support configurations that offer flexibility, when necessary, and establish parity as much as possible.  It is important to use the same tools for devleopment all the way to production.

![](images/mushop-deployment.png)

Estimated Lab Time: n minutes

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab:  Setup SSH Keys

## **STEP 1**: Obtain Oracle Cloud Information

1.  Create a txt file with the following values.  This step will walk you through how to obtain this information.
region:       # Region where resources will be provisioned. (ex: us-phoenix-1)
tenancy:      # Tenancy OCID value
user:         # API User OCID value
compartment:  # Compartment OCID value
key:          # Private API Key file path (ex: /Users/jdoe/.oci/oci_key.pem)
fingerprint:  # Public API Key fingerprint (ex: 43:65:2c...)

## **STEP 2**: Obtain Mushop source code

1.  Open up Cloud Shell and clone the github repo.

    ````
    git clone https://github.com/oracle-quickstart/oci-cloudnative.git mushop
    ````
2.  Change to the mushop directory
    ````
    cd mushop
    ````
    ![](images/mushop-code.png)

3.  Verify CLI is configured correctly by executing a command to list the Cloud Object Storage namespace
    ````
    oci os ns get
    ```` 
3.  Verify CLI is configured correctly by executing a command to list the Cloud Object Storage namespace
    ````
    oci ce cluster create-kubeconfig \
    --cluster-id ocid1.cluster.oc1.iad.aaaaaaaaabbbbbbbbdddddddd...xxx \
    --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0    
    ```` 
3.  Use kubectl to check the configuration
    ```` 
    kubectl config current-context
    # cluster-c4daylfgvrg
    ```` 
3.  Set the default kubectl namespace to skip adding --namespace <name> to every command.  You can replace *mushop* with *your name*
    ```` 
    kubectl create namespace mushop 
    kubectl config set-context \
    --current --namespace=mushop
    ```` 

    *TIP:* use kubens to switch namespace easily & often from the command line 

## **STEP 3**: OKE Cluster Setup
MuShop provides an umbrella helm chart called setup, which includes several recommended installations on the cluster. These installations represent common 3rd party services, which integrate with Oracle Cloud Infrastructure or enable certain application features.
Chart 	Purpose 	Option
[Prometheus](https://github.com/helm/charts/blob/master/stable/prometheus/README.md) 	Service metrics aggregation 	prometheus.enabled
[Grafana](https://github.com/helm/charts/blob/master/stable/grafana/README.md) 	Infrastructure/service visualization dashboards 	grafana.enabled
[Metrics Server](https://github.com/helm/charts/blob/master/stable/metrics-server/README.md) 	Support for Horizontal Pod Autoscaling 	metrics-server.enabled
[Ingress Nginx](https://kubernetes.github.io/ingress-nginx/) 	Ingress controller and public Load Balancer 	ingress-nginx.enabled
[Service Catalog](https://github.com/kubernetes-sigs/service-catalog/blob/master/charts/catalog/README.md) 	Service Catalog chart utilized by Oracle Service Broker 	catalog.enabled
1.  Check kubectl context.
    ```` 
    kubectl config current-context
    ```` 
1.  Create a namespace for MuShop utilities: 
    ```` 
    kubectl create namespace mushop-utilities
    ```` 
1.  Install cluster dependencies using helm: 
    ```` 
    helm dependency update deploy/complete/helm-chart/setup
    ```` 

## **STEP 4**: Hostname Ingress and Deploy with Helm

Part of the cluster setup includes the installation of an nginx ingress controller. This resource exposes an OCI load balancer, with a public ip address mapped to the OKE cluster.

By default, the mushop helm chart creates an Ingress resource, routing ALL traffic on that ip address to the svc/edge component. This is OK for simple scenarios, however it may be desired to differentiate ingress traffic, using host names on the same ip address. (for example multiple applications on the cluster) 

Configure the mushop helm chart ingress values in cases where traffic must be differentiated from one service to another: 
1.   Locate the EXTERNAL-IP assigned to the ingress controller: 

    ```` 
    kubectl get svc \
    mushop-utils-ingress-nginx-controller \
    --namespace mushop-utilities    
    ```` 
    Remembering that helm provides a way of packaging and deploying configurable charts, next we will deploy the application in "mock mode" where cloud services are mocked, yet the application is fully functional 

1.   Deploy the application in "mock mode" where cloud services are mocked, yet the application is fully functional 

    ```` 
    helm install mushop deploy/complete/helm-chart/mushop --set global.mock.service="all"
    ```` 
    *or*
    ```` 
    helm install mushop deploy/complete/helm-chart/mushop --set global.mock.service="all" --set ingress.hosts[0]="yourname.example.com"
    ```` 
1.  Please be patient. It may take a few moments to download all the application images. 
    ```` 
    kubectl get pod --watch
    ```` 
2.  After inspecting the resources created with helm install, launch the application in your browser. https://localhost

3.  Find the EXTERNAL-IP assigned to the ingress controller.  Open the IP address in your browser 
    ```` 
    kubectl get svc mushop-utils-ingress-nginx-controller --namespace mushop-utilities    
    ```` 
4.  Alternatively with kubectl configured on localhost.  Proxy to the MuShop app on http://localhost:8000 (or a port of your choice).  *NOTE:* For shared clusters, and host-based ingress, use the hostname you setup earlier. 
    ```` 
    kubectl port-forward svc/edge 8000:80
    ```` 

## **STEP 5**: Under the Hood
1.  To get a beter look at all the installed Kubernetes manifests by using the template command.
    ```` 
    mkdir ./out
    helm template mushop deploy/complete/helm-chart/mushop --set global.mock.service="all" --output-dir ./out
    ```` 
2.  Explore the files, and see each output. 

## **STEP 6**: Clean Up
1.  To get a beter look at all the installed Kubernetes manifests by using the template command.
    ```` 
    helm list
    ```` 
2.  Delete the mushop release
    ```` 
    helm delete mushop
    ````   


You may now *proceed to the next lab*.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
