# Introduction

## What is Ansible

**Ansible** is an open-source IT automation platform that makes your applications and systems easier to deploy and maintain. Ansible handles configuration management, application deployment, cloud provisioning, ad-hoc task execution, network automation and multi-node orchestration in a language that approaches plain English, using SSH - with no agents to install on remote systems.Ansible proposal is to be the easiest IT automation system to use, ever. Some design principles:Easy to setup, with a minimal learning curveManage remote systems very quickly and in parallel; agentless, leveraging SSHDescribe infrastructure in a language that is both machine and human friendlyFocus on security and easy auditability/review/rewriting of content


## Why Ansible

### Cpnfiguration Management

-Centralizing configuration file management

-Write state description of servers (playbooks)

-Human/Machine-readable format

***Example***

-Configuration files contain the expected value, expected permissions

-Ensure services are running

### Application Deployment

-Generate, package source code, binaries, static assets

-Copy then to servers

-Start-up services

***Example***

-Build Container Images

-Build VM Images

-Build K8s Operator (Ansible Operators)


### Orchestration

-Orchestrate deployments

-Multiple remote servers and ensure things happen in a specific order

-Rolling update

***Example***

-Bring up a database before the web server

-Take a web server out of the Load Balancer one at a time to upgrade without downtime (rolling update)


## Ansible Use Cases 

### Provisioning

-On-premise
  -Bare Metal
  -Virtual Machines
  -Hypervisors
  
-Cloud Infrastructure
  -PublicPrivateNetwork DevicesStorageExampleOCI Virtual Cloud Network, Load Balancer, OKE, VirtualBox, GlusterFS, Firewalls



### Ansible Architecture




***Elastic and scalable platform***

Data engineers can easily set up and operate big data pipelines. Oracle handles all infrastructure and platform management for event streaming, including provisioning, scaling, and security patching.

 ***Deploy streaming apps at scale***

With the help of consumer groups, Streaming can provide state management for thousands of consumers. This helps developers easily build applications at scale.

***Oracle Cloud Infrastructure integrations***

Native integrations with Oracle Cloud Infrastructure services include Object Storage for long-term storage, Monitoring for observability, Resource Manager for deploying at scale, and Tagging for easier cost tracking/account management.

***Kafka Connect Harness***

The Kafka Connect Harness provides out-of-the-box integrations with hundreds of data sources and sinks, including GoldenGate, Integration Cloud, Database, and compatible third-party offerings.

![Serverless Infrastrucuture](./images/OCI-Stream1.png)



### Open standards-based


***Open source Apache Kafka-compatible***

Run open source software as an Oracle-managed service. Streaming’s Kafka compatibility significantly reduces vendor lock-in and helps customers easily adopt hybrid and multicloud architectures.

***Choice of APIs***

Developers have the flexibility of using either Apache Kafka APIs or Oracle Cloud’s native Streaming APIs, which are available in SDKs such as Python, Java, Typescript, and Go.

***Easy transition for Kafka implementations***

Customers with existing Kafka implementations, whether deployed on-premises or on other clouds, can easily migrate to Streaming by changing a few configuration parameters.


![Open Standard](./images/OCI-Stream2.png)




### Security and reliability


***Encryption and privacy***

For security, the service provides data encryption both in transit and at rest. Streaming is integrated with Identity and Access Management (IAM) for fine-grained access control, as well as Private Endpointsand Vault (KMS) for data privacy.

***Fault tolerance and SLAs***

The service uses synchronous data replication across geographically distributed Availability Domains for fault tolerance and durability. Streaming is backed by a 99.95% service availability SLA. Oracle will provide credits for any breaches of this SLA.

***Consistent performance***

Streaming provides tenancy-level data isolation and eliminates “noisy neighbor” performance issues, irrespective of scale and usage.


![Security and Reliability](./images/OCI-Stream3.png)



### Industry-leading pricing


***Pay-as-you-use***

Customers pay only for what they use, making the service attractive for workloads with large spikes in usage.

***Simple pricing model***

Customers pay only for throughput and storage, with no upfront costs or early termination penalties.

***Zero-cost data movement***

Unlike other public cloud providers, Oracle does not charge any additional fees for data movement from Streaming to other Oracle Cloud Infrastructure services.



## Acknowledgements

* **Author** - Rishi Johari, Lucas Gomes
* **Last Updated By/Date** - Rishi Johari, September, 2021
