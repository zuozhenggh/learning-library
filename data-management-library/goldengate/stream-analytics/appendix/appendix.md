
# Appendix

## Introduction
This appendix is a sumplementary aid to the labs for OSA Workshop primarily for Lab 3 creating the **RetailPromotions** pipeline.  You can refer to this section of the workshop when performing the labs.  Not every screen shot has been captured in this appendix but you can look at the following image and verify the structure of your pipeline.  In that regard each stage that does have a screen shot has been labeled accordingly.


### About Product/Technology
Golden Gate Stream Analytics (OSA) is a tool designed to consume a stream of data from any source such as a database, GoldenGate, kafka, JMS, REST or even a file system.  Once the data is in OSA you can run analytics on live data in real time using transformation and action functionality of Spark and send the data downstream to any target of your choice.

### Objectives
- Provide screen shots for the labs
- Aid the user to reference screen shots while performing the labs

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

### Instructions
At each stage of the Lab 3 you can refer back to this appendix to compare your pipeline and screens with the screen shots provided here.  Each stage is marked with the name of the stage so that you can reference it while performing the task for that stage.


## GetCustomerDetails Stage
![](./images/orderstreamstage2.png)


![](./images/orderstreamstage3.png)


![](./images/getcustomerdetails2.png)


![](./images/getcustomerdetails3.png)


![](./images/getcustomerdetails4.png)


![](./images/getcustomerdetails5.png)


## GetLatLongFromZipCode Stage

![](./images/getlatlongfromzipCode.png)

## FilterCustomers Stage

![](./images/filtercustomers.png)


![](./images/geoFilterpattern.png)


![](./images/geofiltervisual.png)

## GetProductDetails Stage

![](./images/getproductdetails.png)


![](./images/getproductdetails2.png)


## SegmentCustomers Stage

![](./images/discountoffered.png)


![](./images/newaddedfields.png)


![](./images/goldcustomers.png)


## RealtimeRevenue Stage


![](./images/revenuebycustomersegment.png)


![](./images/rtrvenuesummaries.png)


![](./images/rtrvenuesummariesrename.png)


## GetCustomer Stage

![](./images/getcustomer.png)


## LikelyBuyersByTypeAndZip Stage

![](./images/likelybuyersbytypeandzip.png)


![](./images/likelybuyersbytypeandzipgroups.png)


![](./images/likelybuyersbytypeandzipvisual.png)



* [Oracle Stream Analytics](https://www.oracle.com/middleware/technologies)

## Acknowledgements

* **Author** - Hadi Javaherian, Solution Engineer
* **Contributors** - Shrinidhi Kulkarni, Solution Engineer
* **Last Updated By/Date** - Hadi Javaherian, Septembe 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
