# Lab 1: Baggage Tracking Demo

## Introduction

This lab walks you through a live baggage tracking demo.   This application is running in all the OC1 regions.

![](images/demo-region.png)

We selected demo because it solves real world business problems.  Many of those are listed on the slide.

![](images/business-problem.png)

## The Serverless Logic Tier
The application behind the demo uses a three-tier architecture, representing the brains of the application. Integrating these components: an API Gateway, Streams, and Functions; in your logic tier can be revolutionary.  The features of these services allow you to build a serverless production application that is highly available, scalable, and secure. Your application can use thousands of servers, however, by leveraging this pattern you do not have to manage even a single one.

In addition, by using these managed services together you gain the following benefits:
*	No operating systems to choose, secure, patch, or manage.
*	No servers to size, monitor, or scale out.
*	No risk to your cost by over-provisioning.
*	No risk to your performance by under-provisioning.

Here is a diagram of architecture behind the demo.

![](images/arch-diagram.png)

Here is architecture diagram at the component level.

![](images/component-arch.png)


Estimated Lab Time: 7 minutes

### Objectives

Use your personal cellphone and connect to the live application.  

### Prerequisites

*  Connection to the internet
*  Personal cellphone



## Task 1: The "traveling user" problem!

This particular application came to the NoSQL team from Emirates airlines.  When we thought about this for a little bit, we realized that this was a perfect use case for NoSQL.  Many airlines, like United, Delta, American are now offering real time baggage tracking.  You have to install their application, and you get close to a real time feed of where your bag is at as it moves along its journey.  This is a really good example of companies offloading queries from the operational data store.   In the Emirates case, this data was already collected in their operational database and they didn’t want to put consumer level queries on that data store.   The second thing in this example is the involvement of an active/active configuration.  You write data locally in closest data center as that bag travels, but you want to read it from anywhere.  For the best latency, you want the RFID bag scans to be immediately written to the local data center and then let the system take care of propagating that data to the other data centers in an active/active set up.   If you took a trip from the US to Europe for example, the last thing you would want to do is force all the writes back to the US.   Hundreds of bags get scanned per flight segment and you need the best possible latency.   

What are some of the goals of this application:

    - Predictable low latency
    - Scalable to your user base
    - Highly available
    - Auto-expiry of the data - baggage location data has a limited lifespan
	- Offload consumer queries from operation data store



## Task 2: Grab your personal cell phone

In a browser window, enter ndcsdemo.com

 ![](images/ndcs-google.png)

Following that you will get the welcome screen for Blue Mist airways.

 ![](images/blue-mist.png)

 If you try this from your laptop instead of your cell phone, then you will get the employee portal which is a read only portal.  You can also play around with that.

## Task 3: Hit ‘Track Your Baggage’ button

Tap on the button.

![](images/blue-mist-track.png)

After doing so, you will get random baggage information for a traveler.  Scroll through the information.  In an application from a real airlines, a variety of different information can be displayed.   

![](images/ferry-trip.png)

## Task 3: Hit menu button on top right button

Tap on the 'hamburger' button on the top right, and then hit ‘Track Your Baggage’ again.  A new random traveler will be shown.


![](images/hamburger-menu.png)

![](images/track-bag.png)

## Task 4:  Explore the JSON data record

The data record is a JSON document with several nested arrays.  Oracle NoSQL makes it easy to handle nested arrays.

![](images/json-record.png)


## Task 5: Key takeaways

While this was a simple demo, it used many components that are available in OCI today.

	- Application is running live on all OCI regions
  - Application uses OCI Traffic Management for Geo-Steering to steer network requests to closest OCI region
	- OCI API gateway
  - UI development done with Visual Builder Cloud Service
	- Tomcat Server for REST calls
  - Data stored in Oracle NoSQL Cloud Service as JSON documents

  The benefits to customers are shown in this slide.

  ![](images/benefits.png)


## Learn More

* [About Oracle NoSQL Database Cloud Service](https://docs.oracle.com/pls/topic/lookup?ctx=cloud&id=CSNSD-GUID-88373C12-018E-4628-B241-2DFCB7B16DE8)
* [Oracle NoSQL Database Cloud Service page](https://cloud.oracle.com/en_US/nosql)
* [Java API Reference Guide](https://docs.oracle.com/en/cloud/paas/nosql-cloud/csnjv/index.html)
* [Node API Reference Guide](https://oracle.github.io/nosql-node-sdk/)
* [Python API Reference Guide](https://nosql-python-sdk.readthedocs.io/en/latest/index.html)


## Acknowledgements
* **Author** - Dario Vega, Product Manager, NoSQL Product Management and Michael Brey, Director, NoSQL Product Development
* **Contributors** - XXX, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Michael Brey, Director, NoSQL Product Development, September 2021
