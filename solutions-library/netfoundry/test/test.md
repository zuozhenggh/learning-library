
* **Organization** - Platform customer/partner URL for organizational platform access - https://company.nfconsole.io.

* **Network** - Dedicated Cloud based controller. Overlay only, not concerned with BGP, IP addressing and route peering.

* **Edge Router Policy** - Transit policy providing access across the fabric. e.g. Which Hosted Edge routers to be used and which endpoints can transit these Hosted Edge Routers.

* **Endpoints**

    - **Hosted Edge Routers** - NetFoundry managed Global Fabric for middle mile transit. Deployed from the NetFoundry console. Automatically registered.

    - **Customer Hosted Edge Routers** - implemented for application termination. Deployed from Cloud Marketplace. Registered by customer manually or through instance deployment script.

    - Endpoints for Windows, MAC, Linux or Mobile for application access or termination or both.

* **Attributes** - Method to group Endpoints, Edge Routers and Services. e.g. "@myendpoint" implies only that endpoint. "#it-admin" may imply a grouping of multiple IT admin endpoints. Same for services. e.g. @webserver1 & @webserver2 could be grouped into #webservers to ease administration for AppWAN membership.

* **Services** - IP/Hostname for applications residing in the VCN/VNET/VPC/VLAN.

* **AppWAN** - Policies for providing Services to Endpoints.  
