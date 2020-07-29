# Integration using Oracle SOA suite Hands-On Lab

## Building Application connectivity and Service orchestration with Oracle SOA Suite

## Overview

This lab walks you through in improving an order processing system to accommodate multichannel growth with online business partners. In addition, an aggressive store expansion is planned. Overlapping systems must be consolidated to provide better end-to-end visibility from order to fulfillment.


The order processing system must be accessible through multiple protocols, data formats, and client types, including mobile devices:

    - Business trends indicate that Company X must launch a mobile application soon and the new order processing service must support access through RESTful APIs.

    - In addition to the existing online direct store, Company X plans to launch a service in which orders are received through a different channel (as batch comma-separated value (CSV) files over FTP or EDI format via EDI Trading Partner). They must eventually be processed and fulfilled using the same new order provisioning infrastructure.


For large orders, a customer's credit history must be checked before sending the order for fulfillment. Otherwise, the order is rejected. Initially, credit is checked by internal departments, but later must be integrated with PayPal. Changing credit providers must not disrupt order processing operations.

The order processing system must provide direct integration with the packaging department to ship orders with preferred shipping providers based on the type of shipping service (2 day, 5-7 day shipping, and so on).

The bulk fulfillment process must run according to a predefined pick-up schedule.

Upon fulfillment processing and orders being sent to the packaging department, a message must be communicated to the customer (either bulk or on-demand).

## Lab Objectives

* Obtain a free development environment
* Build your first app using JDeveloper
* Improve and design service orchestration
* Link pages

*{Note: This lab assumes you have accessed to JDeveloper12c environment.}*

## Lab Modules

| # | Module | Est. Time |
| --- | --- | --- |
| 1 | [Introduction to SOA](1-Introduction-to-SOA.md) | 5 min |
| 2 | [Build Composite to validate payment](2-Build-composite-to-validate-payment.md) | 25 min |
| 3 | [Processing Order using composite](3-Process-order-using-composite.md) | 20 min |
| 4 | [Add new chnanel for Order](4-Add-new-channel-for-ordering.md) | 20 min |
| 5 | [Pack and ship service composite](5-Pack-and-Ship-Service-composite.md) | 20 min |
| 6 | [Order Fullfilment](6-Order-Fullfilment.md) | 15 min |
| 7 | [Summary and next step](7-Summary-and-next-step.md) | 10 min |

***To log issues***, click here to go to the [github oracle repository](https://github.com/oracle/learning-library/issues/new) issue submission form.

## Navigating in the Lab
To return to this page from anywhere within the lab click either Oracle Hands on Labs, or Home in the header.

![](images/0/lab-header.png)

Click the navigation menu icon, in the upper-left corner of the header, to see a list of modules in this lab. Click any of the list entries to navigate directly to that module.

![](images/0/lab-menu.png)

## Downloads

[Click here](spreadsheet-app.sql) to download the completed application. 

## Learn More - *Useful Links*

- SOA on Marketplace   https://cloudmarketplace.oracle.com/marketplace/en_US/listing/74792101
- SOA suite   https://www.oracle.com/middleware/technologies/soasuite.html
- Tutorials   https://www.oracle.com/middleware/technologies/soasuite-learmore.html and
-- https://docs.oracle.com/middleware/12211/soasuite/develop/SOASE.pdf
- Community   https://apex.oracle.com/community
- External Site + Slack   https://www.oracle.com/technetwork/middleware/weblogic/learnmore/reducing-middleware-costs-2327571.pdf

