# Module 3: Process Order Using composite

In this module, starting page 78 on the SOA suite tutorial, you will build the basis of the new order processing system for Avitek, referred to as ProcessOrder.
Recall a few of the business requirements for Avitek ‘s new order processing system:
1. Many different types of clients will access it over different protocols and data formats, including mobile devices.
2. With a mobile app launch in progress, next year at the latest, the new order processing system must support access via RESTful API.
3. It must allow existing systems to place orders using xml files and CSV files. These should be processed and fulfilled using the same new order provisioning infrastructure.

In this module, you will see templates, a new feature in SOA Suite, at work in BPEL as well as Service
Bus. You will leverage the validatePayment service you built in Chapter 2.
At the end of this module, your solution will look similar to the following process flow diagram:


![](images/3/Module3-SOA.png)


### **Part 1**: Build Process Order Composite

You will now create another SOA application that will accept new purchase orders, approve them and forward them to the fulfillment system. You will use a project template to implement the basic order processing scenario, add a call to the payment validation service built in chapter 2 and update the order status in the database based on the outcome of the payment validation.
The order status update will be converted to a BPEL subprocess to make it easily re-usable. Once completed, your composite will look like this:


![](images/3/ProcessOrderComposite.png)


To complete part 1, the details start in <ins> **Chapter 3, page 80 to 116** of the tutorial </ins>

 ### **Part 2**: Register Process Order on Service Bus 

As you have completed and tested the Process Order composite, you will register it on Service Bus to make it available for external consumers. Service Bus will allow the Process Order composite to be made available over different protocols and data formats without disruption to the core business logic in the composite. Service Bus will also validate the Order data and report for auditing.
For now, you will just create an HTTP / SOAP Proxy and Pipeline for Process Order. You can also add a File Proxy and Pipeline to allow orders to be processed from existing systems.

![](images/3/ProxyService.png)

# High Level Steps #

1. Open e2e-1201-servicebus application and import Pipeline template resources (new feature!).
2. Configure ProcessOrder Business Service.
3. Configure Pipeline and Proxy using Pipeline template.
4. Test your application end-to-end.

To complete part 2, please start on <ins> **chapter 3, page 117 to 137** </ins> in the SOA suite Tutorial.pdf document


### **Summary** ###

In module 3, you've accomplished:
- Created Service Bus pipeline from an existing template.
- Providing Data validatio, Routing and manage exception inside the pipeline
- Provided API for backend service from a service bus. This is exposed using Proxy Service within a Service Bus.
  

This completes Module 3.  [Click here to navigate to Module 4](4-add-new-channel-for-ordering.md)
