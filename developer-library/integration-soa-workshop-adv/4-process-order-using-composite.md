# Module 4: Process Order Using composite

## Introduction
You will build the basis of the new order processing system for Avitek, referred to as ProcessOrder, starting on page 78 on the SOA suite tutorial.
Recall a few of the business requirements for Avitek ‘s new order processing system:
1. Many different types of clients will access it over different protocols and data formats, including mobile devices.
2. With a mobile app launch in progress, next year at the latest, the new order processing system must support access via RESTful API.
3. It must allow existing systems to place orders using xml files and CSV files. These should be processed and fulfilled using the same new order provisioning infrastructure.

To build new order processing composite application, you will use templates. This is a new feature in SOA Suite 12c that can be used in BPEL. As well as Service Bus application. Here are the steps needed for this module:
1. Open e2e-1201-servicebus application and import Pipeline template resources (new feature!).
2. Next steps:
   - Configure ProcessOrder Business Service.
   - Configure Pipeline and Proxy using Pipeline template.
   - Test your application end-to-end.

You will leverage the validatePayment service you built in previous module.
At the end of this module, your solution will look similar to the following process flow diagram:

![](images/3/Module3-SOA.png)


## **Design Process Order composite**
You will now create another SOA application that will accept new purchase orders, approve them and forward them to the fulfillment system. You will use a project template 

## **STEP 1**: Create a new project Process Order by importing a project template
## **STEP 2**: Add the payment validation service built previously 
## **STEP 3**: Update the order status in the database based on the outcome of the payment validation
## **STEP 4**: Use an inline BPEL subprocess 
The order status update will be converted to a BPEL subprocess to make it easily re-usable. Once completed, your composite will show as the following:

![](images/3/ProcessOrderComposite.png)

## **STEP 5**: Add an Order Number sensor to the Order Process composite app

### Details: ###
To complete step 1 to 5, please start <ins>**Chapter 3, page 80 to 116** </ins> of the [SOAsuite 12c tutorial.pdf](https://oradocs-prodapp.cec.ocp.oraclecloud.com/documents/fileview/D62E7C999F2BB9C78C4D8085F6EE42C20DD5FE8D98D7/_SOASuite12c_Tutorial.pdf) 

## **Register Process Order app on Service Bus** 
As you have completed and tested the Process Order composite, you will register it on Service Bus to make it available for external consumers. 
1. Service Bus will allow the Process Order composite to be made available over different protocols and data formats without disruption to the core business logic in the composite
2. Service Bus will also validate the Order data and report for auditing. For now, you will just create an HTTP / SOAP Proxy and Pipeline for Process Order. 
3. You can also add a File Proxy and Pipeline to allow orders to be processed from existing systems.

    ![](images/3/ProxyService.png)

## **STEP 6**: Open the existing service bus application and import the template resource

![](images/3/import-sb-resource0.png)

+ Right-click in the Application Navigator window and select Import...
+ 
+ ![](images/3/import-sb-resource1.png)
+ On the import dialog, select Service Bus resources
+ 
+ ![](images/3/import-sb-resource2.png)

## **STEP 7**: Register Process Order composite as a business service in the Service Bus

As in previous module, you will first register the composite on Service Bus by creating a Business Service. This time, rather than dragging and dropping from the Component Palette, you will create using a menu-based Insert on the External Services lane.

+ First, make sure your overview editor is active by double-clicking on the ProcessOrderSB icon on top or in the left-hand Application Navigator. The canvas will be blank.
+ Right click on the External Services lane of the overview editor

+ ![](images/3/import-sb-resource3.png)

+ Mouse-over Insert Transports and select HTTP.
+ ![](images/3/import-sb-resource4.png)
  

## **STEP 8**: Create a service bus pipeline with proxy using a pipeline template

instead of creating the Pipeline for ProcessOrder from scratch, you will leverage a Pipeline Template. The template encapsulates all the repetitive tasks common with building a Pipeline such as routing, data validation, reporting, error handling and alerting under error conditions.
+ First, make sure your overview editor is active by double-clicking on the ProcessOrderSB icon, on top center or in the left-hand Application Navigator.
+ Locate the Pipeline icon on the Component palette and drag onto the middle of your canvas.

+ ![](images/3/import-sb-resource5.png)

The Create Pipeline dialog will appear. This is the same dialog as you used to create your Pipeline in Chapter 2; however, this time you will select to Create the Pipeline from a Template.  

## **STEP 9**: Test end-to-end process - Proxy service, route to Business service

+ Click on the ProcessPS service on the left swim lane and select Run
+ ![](images/3/import-sb-resource9.png)

+ First, send in a good Order
+ - a. ~/e2e-1201-orderprocessing/sample_input/OrderSample.xml
+ Then send in and invalid order
+ - a. ~/e2e-1201-orderprocessing/sample_input/BadOrderSample.xml

### Details: ###
To complete step 6 to 7, please review on <ins> **chapter 3, page 117 to 137** </ins> of the [SOAsuite tutorial document](https://oradocs-prodapp.cec.ocp.oraclecloud.com/documents/fileview/D62E7C999F2BB9C78C4D8085F6EE42C20DD5FE8D98D7/_SOASuite12c_Tutorial.pdf)

## **Summary**
In this module, you've accomplished:
- Created Service Bus pipeline from an existing template.
- Providing Data validation, Routing and manage exception inside the pipeline
- Provided API for backend service from a service bus. This is exposed using Proxy Service within a Service Bus.
  

This completes Process order composite application. You may proceed to the next lab.

 <!-- [Click here to navigate to Module 4](4-add-new-channel-for-ordering.md) -->

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Adapted for Cloud by** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.