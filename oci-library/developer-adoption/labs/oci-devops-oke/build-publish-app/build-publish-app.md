# Build and Publish Application

## Introduction

In this lab exercise, you will turn into a Developer and be responsible for releasing a Cloud Native Microservice Java application. The application source code is hosted on `myapp` GitHub repository and you will use GitHub Actions and docker CLI to publish the Image to [Oracle Cloud Infrastructure Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm).

Oracle Cloud Infrastructure Registry (also known as Container Registry) is an Oracle-managed registry that enables you to simplify your development to production workflow. Container Registry makes it easy for you as a developer to store, share, and manage container images (such as Docker images). And the highly available and scalable architecture of Oracle Cloud Infrastructure ensures you can reliably deploy your applications. So you don't have to worry about operational issues, or scaling the underlying infrastructure.

You can use Container Registry as a private Docker registry for internal use, pushing and pulling Docker images to and from the Container Registry using the [Docker V2 API](https://docs.docker.com/registry/spec/api/) and the standard Docker command line interface (CLI). You can also use Container Registry as a public Docker registry, enabling any user with internet access and knowledge of the appropriate URL to pull images from public repositories in Container Registry.

Container Registry is an [Open Container Initiative](https://opencontainers.org/)-compliant registry. As a result, you can store container images (such as Docker images) that conform to Open Container Initiative specifications in Container Registry. You can also store manifest lists (sometimes known as multi-architecture images) to support multiple architectures (such as ARM and AMD64). And you can store Helm charts (for more information about the Helm feature that supports chart storage in Open Container Initiative-compliant registries, see [Registries](https://helm.sh/docs/topics/registries/) in the Helm documentation).




![Diagram](./images/developer-build-publish.png)

Estimated Lab time: 20 minutes

### Objectives

In this lab, you will:

* Create a CI Pipeline on GitHub to publish a Cloud Native Java Microservice
* Publish Java Microservice Container Image to OCI Registry.

### Prerequisites

* An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
* GitHub account


## **STEP 1**: Import oci-cloudnative git repository 

Oracle has published a [quickstart]( https://github.com/oracle-quickstart/oci-cloudnative.git) which contains a complete polyglot micro-services application built to showcase a cloud native approach to application development on Oracle Cloud Infrastructure. MuShop Complete uses a Kubernetes cluster, and can be deployed using the provided helm charts (preferred), or Kubernetes manifests. It is recommended to use an Oracle Container Engine for Kubernetes cluster, however other Kubernetes distributions will also work.

1. Open up a new browser tab and go to [GitHub](https://github.com).

1. On the top navigation bar, click on the plus sign and then  Import Repository.
![plus sign](./images/github-plus.png)
![import repository](./images/github-import-repo.png)

1. Enter the URL of the OCI Architecture DevOps repo: `https://github.com/oracle-quickstart/oci-cloudnative`


1. Enter a name for the new *myapp* repository. To better identify it, let's name it: `oci-cloud-native-mushop`. 

1. Set privacy settings to `Private` and then click on Begin import button in the bottom of the page to create a new repo.
![import project](./images/gh-import-mushop.png)
![import finished](./images/gh-import-mushop-finished.png)

1. Open up the new project on your browser.


