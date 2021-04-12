# Introduction

## Deploying Nextcloud on OCI Arm A1 compute platform

This tutorial walks you through how to get started with Nextcloud on the OCI Arm A1 compute platform. 

Nextcloud is a suite of file hosting and collaboration tools. While functionally similar to Dropbox, Google Drive or Office365, Nextcloud is free and open-source and can be self hosted on any cloud infrastructure platform. Nextcloud can be accessed over the web interface or iOS and Android apps for devices that can keep your photos and documents automatically synced with your Nextcloud server on OCI. OCI Arm A1 provides a robust and efficient platform for hosting your own private file hosting and collaboration cloud. 

Additonally, you will use the new set of tools such as [Podman](podman.io) that are part of the container tools package in Oracle Linux 8.

Estimated time: 45 minutes

### Objectives

In this lab, you will:

* Create an OCI Arm A1 compute instance 
* Prepare the compute instance for deploying containerized applicaions
* Deploy Nextcloud as a set of containers.
* Connect the application and setup file sync.
* Clean up the deployments

### Prerequisites

1. An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
1. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
1. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
1. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
1. Basic conceptual knowledge of containers and [Podman](https://podman.io/)

You may now [proceed to the next lab](#next).

## Learn More

* [Cloud Native on OCI using MuShop sample](https://oracle-quickstart.github.io/oci-cloudnative/)
* [Reference Architecture: Deploy a microservices-based application in Kubernetes](https://docs.oracle.com/en/solutions/cloud-native-ecommerce/index.html#GUID-CB180453-1F32-4465-8F27-EA7300ECF771)
* [Overview of Functions](https://docs.cloud.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)

## Acknowledgements

* **Author** - Jeevan Joseph
* **Contributors** -  Orlando Gentil, Jeevan Joseph
* **Last Updated By/Date** - Jeevan Joseph, April 2021
