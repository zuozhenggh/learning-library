# Build Integration with Oracle SOA

## Service Connectivity and Orchestration using Oracle SOA

## Overview

This lab walks you through in improving an order processing system to accommodate multichannel growth with online business partners. In addition, an aggressive store expansion is planned. Overlapping systems must be consolidated to provide better end-to-end visibility from order to fulfillment.


The order processing system must be accessible through multiple protocols, data formats, and client types, including mobile devices:

  * Business trends indicate that Company X, let's called it Avitek, must launch a mobile application soon and the new order processing service must support access through RESTful APIs.

  * In addition to the existing online direct store, Avitek plans to launch a service in which orders are received through a different channel (as batch comma-separated value (CSV) files over FTP or EDI via B2B Trading Partner. They must eventually be processed and fulfilled using the same new order provisioning infrastructure.


For large orders, a customer's credit history must be checked before sending the order for fulfillment. Otherwise, the order is rejected. Initially, credit is checked by internal departments, but later must be integrated with PayPal. Changing credit providers must not disrupt order processing operations.

The order processing system must provide direct integration with the packaging department to ship orders with preferred shipping providers based on the type of shipping service (2 day, 5-7 day shipping, and so on).

The bulk fulfillment process must run according to a predefined pick-up schedule.

Upon fulfillment processing and orders being sent to the packaging department, a message must be communicated to the customer (either bulk or on-demand).

## Lab Objectives

* Introducing to development tool, JDeveloper 12c on this workshop
* Build first SOA composite application using JDeveloper-SOA
* Design an improvement to existing integration with service orchestration
* Deploy composite application on the embedded SOA/Weblogic in JDeveloper


*{Note: For this lab, it assumes you have accessed to JDeveloper12c environment.}*

## Lab Modules

| # | Module | Est. Time |
| --- | --- | --- |
| 1 | [Introduction to SOA](1-introduction-to-soa.md) | 10 min |
| 2 | [Build composite integration to validate payment](2-build-composite-to-validate-payment.md) | 35 min |
| 3 | [Processing order using composite app](3-process-order-using-composite.md) | 45 min |
| 4 | [Add new channel for order](4-add-new-channel-for-ordering.md) | 45 min |
| 5 | [Pack and ship service composite app](5-pack-and-ship-service-composite.md) | 45 min |
| 6 | [Order fullfilment](6-order-fullfilment.md) | 25 min |
| 7 | [Summary and next step](7-summary-and-next-step.md) | 10 min |

***To log issues***, click here to go to the [github oracle repository](https://github.com/oracle/learning-library/issues/new) issue submission form.

## Navigating the Lab
To return to this page from anywhere within the lab click either Oracle Hands on Labs, or Home in the header.

![](images/0/new-lab-header.png)

Click the navigation menu icon, in the upper-left corner of the header, to see a list of modules in this lab. Click any of the list entries to navigate directly to that module.

When you're ready to proceed to module 1, please [click here to navigate to Module 1](1-introduction-to-soa.md)

![](images/0/new-lab-menu.png)

During the live lab, the tutorial pdf document can be found on the desktop of your OCI Linux instance.

![](images/2/soa-tutorialpdf.png)


[Click here](https://www.oracle.com/middleware/technologies/soasuite/12c-samples-tutorials-downloads.html) to download SOA suite tutorial. 

## Learn More - Useful Links

- SOA on   <a href= https://cloudmarketplace.oracle.com/marketplace/en_US/listing/74792101> Marketplace </a>
-   <a href= https://www.oracle.com/middleware/technologies/soasuite.html> SOA suite </a>
-   <a href= https://www.oracle.com/middleware/technologies/soasuite-learmore.html> Tutorials </a> 
-  <a href= https://docs.oracle.com/middleware/12211/soasuite/develop/SOASE.pdf> SOA Developer </a> 
- <a href= https://apex.oracle.com/community> Community </a>
- External Site + Slack   https://www.oracle.com/technetwork/middleware/weblogic/learnmore/reducing-middleware-costs-2327571.pdf

