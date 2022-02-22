# Setup the Environment

## Introduction

This lab walks you through the steps to prepare your OCI Environment to be able to carry all the next steps needed to create a function, create data pipelines, run OCI Language Service as well as visualize your data in OAC.

Estimated Time: 90 minutes

### Objectives

In this lab, you will:
* Set up Policies
* Create VCN with right access
* Create an API Gateway
* Confirm access to OCI Language Services


### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


## **Task 1**: Setup Policies

Talk to your Administrator and make sure you can: Create VCN Networks, Function, API Gateways, use AI Services (Language) and Data Integration.

1.	Open the Oracle Cloud Infrastructure Console navigation menu and click **Identity & Security**. Under **Identity**, click **Policies**

2.	Click **Create Policy**

3.	In the **Create Policy** panel, complete the following fields:
    * For **Name**, enter a name without any spaces. You can use alphanumeric characters, hyphens, periods, and underscores only.
    * For **Description**, enter a description to help other users know the purpose of this set of policies.
    * In **Policy Builder**, use the manual editor to add the following statements, then click **Create**.

4.	The following policies should be set:

    ```
    <copy>
    allow any-user to use ai-service-language-family in tenancy
    </copy>
    ```
    ```
    <copy>
    allow group <oac-developers> to manage dis-workspaces in compartment oac-compartment
    </copy>
    ```
    ```
    <copy>
    allow group <oac-developers> to manage dis-work-requests in compartment oac-compartment
    </copy>
    ```
    ```
    <copy>
    allow group <oac-developers> to use virtual-network-family in compartment oac-compartment
    </copy>
    ```
    ```
    <copy>
    allow group <oac-developers> to manage tag-namespaces in compartment oac-compartment
    </copy>
    ```
    ```
    <copy>
    allow service dataintegration to use virtual-network-family in compartment oac-compartment
    </copy>
    ```    
    ```
    <copy>
    allow group <oac-developers> to use object-family in compartment oac-compartment
    </copy>
    ```
    ```
    <copy>
    allow group <oac-developers> to use functions-family in compartment oac-compartment
    </copy>
    ```
    where **oac-developers** represents the name of your user group and **oac-compartment** represents the name of your compartment.

5.	Once you have created an API gateway (**Task 3** in the lab) and Functions (**Lab 2**), you will also need to set the following policies:

    ```
    <copy>allow any-user to use functions-family in compartment <functions-oac-compartment> where ALL {request.principal.type= 'ApiGateway', request.resource.compartment.id = '**api-gateway-compartment-OCID**'}</copy>
    ```
    where **functions-oac-compartment** is the name of your compartment and **compartment-OCID** is OCID # of the compartment.

6.	Once you have created a Data Integration workspace (**Lab 4**), you will also need to set the following policies:

    ```
    <copy>
    allow any-user to read buckets in compartment **oac-compartment** where ALL {request.principal.type = 'disworkspace', request.principal.id = ‘**data-integration-workspace-ocid**‘, request.operation = 'GetBucket'}
    </copy>
    ```
    ```
    <copy>
    allow any-user to manage objects in compartment **oac-compartment** where ALL {request.principal.type = 'disworkspace', request.principal.id = ‘**data-integration-workspace-ocid**‘}
    </copy>
    ```
    ```
    <copy>
    allow any-user to manage buckets in compartment **oac-compartment** where ALL {request.principal.type = 'disworkspace', request.principal.id = ‘**data-integration-workspace-ocid**‘, request.permission =   'PAR_MANAGE'}
    </copy>
    ```


## **Task 2**: Create VCN with the right access levels

We will create a virtual cloud network that will serve as the home for our serverless function and the API gateway we will create.

Create a VCN with Internet access.
1.	Open the navigation menu, click **Networking**, and then click **Virtual Cloud Networks**.

   ![Create VCN](./images/createvcn.png " ")

2.	Click the button **Start VCN Wizard**.
3.	Select **Create VCN with Internet Connectivity**
4.	Click **Start SVN Wizard**
5.	Enter a name for the VCN and click **Next**
6.	Click **Create**

Make sure your VCN can be accessed from the Internet.
The API Gateway communicates on port 443, which is not open by default. You must add a new stateful ingress rule for the public regional subnet to allow traffic on port 443.
1.	Open the navigation menu, click **Networking**, and then click **Virtual Cloud Networks**.
2.	Select the VCN you just created.
3.	Click the name of the public regional subnet.
4.	In the **Security Lists** section, select the Default Security List
5.	Click **Add Ingress Rules**
6.	Specify:
    * Source Type: CIDR
    * Source CIDR: 0.0.0.0/0
    * IP Protocol: TCP
    * Source Port Range: All
    * Destination Port Range: 443
   ![](./images/introduction.png " ")
7.	Click **Add Ingress Rules** to add the new rule to the default security list.
    See [Documentation](https://docs.oracle.com/en-us/iaas/Content/APIGateway/Tasks/apigatewaycreatingpolicies.htm) for more details.


## **Task 3**: Create an API Gateway

An API Gateway allows you to aggregate all the functions you created into a single end-point that can be consumed by your customers.

On the console, go to **Developer Services** and click **Gateways**, and then:

   ![Create Gateway](./images/createapigateway.png " ")

1.	Click **Create Gateway**
2.	Specify:
    * a name for the new gateway, such as lab1-gateway
    * the type of the new gateway as **Public**
    * the name of the compartment in which to create API Gateway resources
    * the name of the VCN to use with API Gateway (the one you just created)
    * the name of the regional subnet in the VCN, select the **Public subnet** you just modified.
3.	Click **Create Gateway**.

When the new API gateway has been created, it is shown as Active in the list on the Gateways page.
See [Documentantion](https://docs.oracle.com/en-us/iaas/Content/APIGateway/Tasks/apigatewaycreatinggateway.htm) for more details.


## **Task 4**: Confirm access to OCI Language Services
This step ensures you are able to access OCI Language Service.

Policy Pre-requisites
1.	Navigate to **Identity & Security**, and then select **Policies** item under Identity.
2.	Click **Create Policy**
3.	Create a new Policy with the following statement:
    ```
    <copy>
    allow any-user to use ai-service-language-family in tenancy
    </copy>
    ```

4.	Click **Create**

Get familiar with the Language AI Service
1.	On the console, navigate to **Analytics & AI** > **Language**

   ![Open AI Language](./images/openlanguageai.png " ")

2.	In the Pre-trained models section, you can enter any text to analyze (or just keep the text there)

   ![Open AI Language2](./images/openlanguageai2.png " ")

3.	OCI Language has several capabilities, including sentiment analysis and entity extraction.
    Make sure those capabilities are selected and click **Analyze**
4.	Inspect the results you get. If you cannot analyze the text, you may have to check that your policies are set correctly.

   ![Open AI Language3](./images/openlanguageai3.png " ")

5.	Click the **Show JSON** button on the output of the analysis so that you can see the schema of the JSON that you get by calling each of the capabilities.

We need to call the endpoint from Python code (or using some other SDK). In **Lab 2** we will write a couple of functions that will call OCI Language Service.

This concludes this lab. You may now **proceed to the next lab**.

## Learn More


## Acknowledgements
* **Author** - Chenai Jarimani, Cloud Architect, Cloud Engineering
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
