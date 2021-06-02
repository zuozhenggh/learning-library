
    ![](images/NFWhiteBG.jpg)

# Introduction 

## About this Workshop

In this workshop, you will [required explanation of what you will do in the labs in the workshop]

Estimated Lab Time: ??? minutes
    
## About NetFoundry    
NetFoundry helps you spin up automated, zero trust, network-as-code connections between Oracle Cloud and any other location without waiting for infrastructure, MPLS, or VPNs. This gives the business unprecedented speed, agility, and security with a cloud-based Total Cost of Ownership (TCO) built on the principles of Gen 2 Cloud (elastic, autonomous and secure by design).

With increased focus on zero trust architecture, Oracle partners with NetFoundry to help transform your network and set the foundation for your long-term work from anywhere and zero trust networking strategy. To understand NetFoundry’s implementation of the zero trust access from the NIST 800-207 standard, refer to this [whitepaper](https://netfoundry.io/resources/netfoundry-and-nist-white-paper/).

As the incredible events of 2020 continue into 2021, NetFoundry continues to innovate for the Enterprise of the future with enhancements to our Work from Home platform and develop innovative solutions for connecting to Oracle Cloud Infrastructure (OCI). Your employees gain seamless connectivity to applications from anywhere, while advancing your overall security posture. Embed security and performance into your company’s core business applications. Policy-based access controls and micro-segmentation enable you to proactively manage all user connections, ensuring that employees, partners, and contractors can only access resources they’re entitled to and nothing else.

Because NetFoundry is offered as a service, organizations can realize the agility and flexibility benefits of zero trust networking access in a fraction of the time and cost of implementing traditional VPNs or SD-WAN solutions. Ultimately, NetFoundry can transform your networking infrastructure and accelerate employee productivity in the next phase. The NetFoundry software is staged within the OCI Marketplace for easy deployment within any customer OCI region.

## Software Components

Building the NetFoundry SDN framework consists of 7 major elements:

1. **Organization** - Platform customer/partner URL for organizational platform access - https://company.nfconsole.io.

2. **Network** - Dedicated Cloud based controller. Overlay only, not concerned with BGP, IP addressing and route peering.

3. **Edge Router Policy** - Transit policy providing access across the fabric. e.g. Which Hosted Edge routers to be used and which endpoints can transit these Hosted Edge Routers.

4. **Endpoints**

    1. **Hosted Edge Routers** - NetFoundry managed Global Fabric for middle mile transit. Deployed from the NetFoundry console. Automatically registered.

    2. **Customer Hosted Edge Routers** - implemented for application termination. Deployed from Cloud Marketplace. Registered by customer manually or through instance deployment script.

    3. Endpoints for Windows, MAC, Linux or Mobile for application access or termination or both.

5. **Attributes** - Method to group Endpoints, Edge Routers and Services. e.g. "@myendpoint" implies only that endpoint. "#it-admin" may imply a grouping of multiple IT admin endpoints. Same for services. e.g. @webserver1 & @webserver2 could be grouped into #webservers to ease administration for AppWAN membership.

6. **Services** - IP/Hostname for applications residing in the VCN/VNET/VPC/VLAN.

7. **AppWAN** - Policies for providing Services to Endpoints.  

Diagram below for logical reference:

    ![](images/diag1.png)



## Learn More

    For more information refer to the following [Oracle NetFoundry blog](https://blogs.oracle.com/cloud-infrastructure/zero-trust-network-access-with-netfoundry).
    
 

## Acknowledgements

* **Author** - person, Title
* **Contributors** -  person, Title
* **Last Updated By/Date** - person, Title,  June 2021