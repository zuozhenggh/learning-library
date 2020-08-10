# Oracle REST Data Services

## Introduction

This lab will show you how to create RESTful Services for JSON data.

## Before You Begin

**What Do You Need?**

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup
    
## Step 1: AutoREST Enable a Schema and its JSON Table

To enable AutoREST on a schema and a table, perform the following steps:
       
1. On the left-side, the Connections navigator is displayed. To make a new connection, click down arrow beside + sign and click New Connection
  
  ![](./images/ordsl1.png " ") 

2.	Enter **JSON** for **Connection Name, appjson** for **Username, Oracle_4U**for **Password** , 
&lt;**Instance _ip_address**&gt; for **Hostname**. Enter **JXLPDB** for **Service name** and **1521** for **Port**. Click **Test** to test the connection.

![](./images/ordsl2.png " ") 

3.	Once the connection test shows Status:success, click **connect** to create the connection.

4.	On the Connections navigator, connect to **appjson** schema by expanding it. Right click **JSON** and select **REST Services> Enable REST Services.**

![](./images/ordsl3.png " ") 

5.	The RESTful Services Wizard will appear. Enter the following and click **Next**.

![](./images/ordsl4.png " ") 


![](./images/ordsl5.png " ") 

6.	The RESTful Summary will appear. Click **Finish**.

![](./images/ordsl6.png " ") 

7.	The SQL is processed and success message appears. Click **OK**.

![](./images/ordsl7.png " ") 

8.	Now, to AutoREST Enable a table, expand Tables (Filtered) under JSON by clicking + beside it. Right click **PURCHASE_ORDER** and select **Enable REST Service.**

![](./images/ordsl8.png " ") 

9.	The RESTful Services Wizard will appear. Enter the following and click **Next**.

![](./images/ordsl9.png " ") 

![](./images/ordsl10.png " ") 

10.	This screen gives a summary of the selected operations. Click the SQL tab.

![](./images/ordsl11.png " ") 

11.	Here is the SQL to REST Enable the table. Click **Finish**.

![](./images/ordsl12.png " ") 

12.	The SQL is processed. Click **OK**.

![](./images/ordsl13.png " ") 

The **appjson** schema and the **Purchase_order** table are now REST enabled.

13.	Retrieve Purchase_order table data.  Open the browser and enter the following URL in the address bar: 

````
http://<instance_IP_address>:9090/ords/JXLPDB/appjson/purchase_order/
````
The URL corresponds to the following:

````
http://<HOST>:<PORT>/ords/<PDBNAME>/<SchemaAlias>/table/ 
````

![](./images/ordsl14.png " ") 

## Step 2: Define Resource Module, Resource Template

Perform the following steps to create your first RESTful Service

1. Expand Rest Data Services and right click **Modules** and select **New Module.**

![](./images/ordsl15.png " ") 

2. **The RESTful Services Wizard** appears which will assist you to define a resource module and a resource template. Enter the following values in the wizard and click **Next**.

  ````
  <copy>

Module Name: cnvg 	
URI Prefix: cnvg/ 	
Publish- Make this RESful Service available for use: (check) 
Pagination Size : 25 
Origins Allowed: (leave blank)

   
    </copy>
 ````

![](./images/ordsl16.png " ") 

3. The RESTful Services Wizard - Step 2 of 3 displays the Resource Template attributes. Enter the following values in the wizard.

 ````
    <copy>

URI Pattern: cnvg/:id 	
Priority : Low 
ETag : Secure Hash
    
    </copy>
 ````

![](./images/ordsl17.png " ") 

The resource template groups the resource handlers that consist of the HTTP operation method: GET, DELETE, POST and PUT. Only one resource handler per HTTP operation method type is allowed. For example, you cannot have two HTTP GET resource handlers for the same resource template. But you can have one GET and one PUT resource handlers.

4. The RESTful Services Wizard - Step 3 of 3 displays the RESTful Summary. Review the summary and click Finish to create your resource module and resource template.
  
![](./images/ordsl18.png " ") 

URI pattern cnvg/:id in the above template will retrieve the information based on the parameter id. To retrieve full table data, we will create another template with URI patter as cnvg/ in the next step.

5.  Right click on module cnvg and click on add template.

![](./images/ordsl19.png " ") 

6. Provide the URI patter as cnvg/ and click on **Next**

![](./images/ordsl20.png " ") 

7.  Review the summary and click on **Finish**.

![](./images/ordsl21.png " ") 

8. The SQL is processed. Click **OK** .
   
![](./images/ordsl22.png " ") 


## Step-3: Retrieve information from JSON table using GET method.

1.  In the RESTful Services navigator, the resource module cnvg contains the resource template cnvg/:id. This template will retrieves the  information from table purchase_order based on the parameter id. Right click on template  **cnvg/:id** then select **Add handler** and select **GET** 

![](./images/ordsl23.png " ") 

2. On the Edit Resource handler, select source type as Collection Query and click on **Apply**.

![](./images/ordsl24.png " ") 

3. The resource handler editor GET cnvg/:id is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:

````
    <copy>

Select * from purchase_order j where j.po_document.PONumber=:id
      
     </copy>
````

![](./images/ordsl25.png " ") 

4. The Enter Binds dialog displays. Enter **200** for Value, and click **Apply**. 
   
![](./images/ordsl26.png " ") 

5. The Query Result tab displays the information for PONumber, 200. Save the GET handler

![](./images/ordsl27.png " ") 

6. Let’s test the Restful Service. Open the Postman.
Enter
````
        <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/200

     </copy>
````
for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

![](./images/ordsl28.png " ") 

7. Open the browser and test the following URL in the address bar: 
````
    <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/200
      
      </copy>
````
![](./images/ordsl29.png " ") 

8.	Now will use other template **cnvg/** which is there in the  the resource module cnvg This template will retrieve the  whole table information from purchase_order. Right click on template  cnvg/ then select **Add handler** and select **GET**.

![](./images/ordsl30.png " ") 

9. On the Edit Resource handler, select source type as Collection Query and click on **Apply**.

![](./images/ordsl31.png " ") 

10. The resource handler editor GET cnvg is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:

````
    <copy>
Select * from purchase_order j;
    
    </copy>
````
![](./images/ordsl32.png " ")

11. The Query Result tab displays the information for the whole table

![](./images/ordsl33.png " ")

12.Let’s test the Restful Service. Open the Postman.
Enter
````
    <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/
    
    </copy>
````
for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

![](./images/ordsl34.png " ")

13. Open the browser and test the following URL in the address bar: 
````
    <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/
   
    </copy>
````

![](./images/ordsl35.png " ")


## Step-4: Insert data into JSON table using POST method

Perform the following steps to create a RESTful Service which inserts the  information into table purchase_order  using the HTTP Method POST.

1.Right click on template  **cnvg/** then select **Add handler** and select **POST**.

![](./images/ordsl36.png " ")

2. In the Mime Types, click the **+** icon to add a row to the Mime Types. Enter **application/json** and click **Apply**.

![](./images/ordsl37.png " ")

 
3. In the RESTful Services navigator, the resource template cnvg/ contains the resource handler POST.
The resource handler editor POST cnvg/ is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the POST handler.
````
<copy>
BEGIN
insert into purchase_order (id,DATE_LOADED,po_document) values(SYS_GUID(),to_date('21-JUNE-2020'),:body);
     commit;
END;
</copy>
````

![](./images/ordsl38.png " ")

4.	Test the Restful Service. Provide following values in the Postman.
Enter
````
<copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/  
</copy>
````
for URL, and select POST for HTTP Method. For the **body** select **raw** and **JSON** from dropdown, enter below PO document in the body section Then, click Send icon located next to the URL field on the top right side.

````
<copy>
{"PONumber"             : 10020,
      "Reference"            : "SBELL-20141017",
      "Requestor"            : "Sarah Bell",
      "User"                 : "SBELL",
      "CostCenter"           : "A50",
      "ShippingInstructions" : {"name"    : "Sarah Bell",
                  "Address" : {"street"  : "200 Sporting Green",
                              "city"    : "South San Francisco",
                              "state"   : "CA",
                              "zipCode" : 99236,
                        "country" : "United States of America"},
                        "Phone"   : "983-555-6509"},
      "Special Instructions" : "Courier",
      "LineItems"            : [{"ItemNumber" : 1,
             "Part"       : {"Description" : "Making the Grade",
                             "UnitPrice"   : 20,
                             "UPCCode"     : 27616867759},
             "Quantity"   : 8.0},
                              {"ItemNumber" : 2,
             "Part"       : {"Description" : "Nixon",
                                "UnitPrice"   : 19.95,
                                "UPCCode"     : 717951002396},
                                 "Quantity"   : 5},
                                {"ItemNumber" : 3,
          "Part"       : {"Description" : "Eric Clapton: Best Of 1981-1999",
                               "UnitPrice"   : 19.95,
                               "UPCCode"     : 75993851120},
                                 "Quantity"   : 5.0}
                                ]}
</copy>
````

Once we get the Status:200 OK, POST is successfully done.

![](./images/ordsl39.png " ")

5.	Open the browser and test the following URL in the address bar: 

````
<copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020
</copy>
````

![](./images/ordsl40.png " ")

## Step-5: Update data in JSON table using PUT method.

1.Right click on template  **cnvg/:id** then select **Add handler** and select **PUT**.

![](./images/ordsl41.png " ")

2. In the Mime Types, click the **+** icon to add a row to the Mime Types. Enter **application/json** and click **Apply**.

![](./images/ordsl42.png " ")

3.  In the RESTful Services navigator, the resource template cnvg/:id contains the resource handler PUT.
The resource handler editor POST cnvg/:id is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the PUT handler.

````
<copy>
BEGIN
update purchase_order j
set    PO_DOCUMENT = json_mergepatch ( 
         PO_DOCUMENT,
         :body
       )
where  j.po_document.PONumber=:id;
     commit;
END;
</copy>
````

![](./images/ordsl43.png " ")

4.	Test the Restful Service. Provide following values in the Postman.

Enter
````

http://<instance_IP_address>:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020

````
for URL, and select PUT for HTTP Method. For the **body** select **raw** and JSON from dropdown, update Requester name as below in the body section Then, click Send icon located next to the URL field on the top right side.

````
{"Requestor":"Dummy_user"}
````

Once we get the Status:200 OK, PUT is successfully done.

![](./images/ordsl44.png " ")

5.	Open the browser and test the following URL in the address bar. Check the requester name , it is changed to dummy_user.

````
<copy>
http://&lt;Instance_ip_address&gt:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020
</copy>
````

![](./images/ordsl45.png " ")

## Step-6: Delete data in JSON table using DELETE method.

1.  In the RESTful Services navigator, right-click **cnvg/:id,** select **Add Handler** and then select **DELETE**.

![](./images/ordsl46.png " ")

2. Click **Apply**.
   
![](./images/ordsl47.png " ")

3. The resource handler editor DELETE cnvg/:id is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab and save it.

````
<copy>
BEGIN
delete from purchase_order j
where  j.po_document.PONumber=:id;
     commit;
END;
</copy>
````
![](./images/ordsl48.png " ")

4. Test the Restful Service. Provide following values in the Postman.

Enter
````

http://<instance_IP_address>:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020

````
for URL, and select DELETE for HTTP Method. Then, click Send icon located next to the URL field on the top right side.

Once we get the Status:200 OK, DELETE is successfully done.

![](./images/ordsl49.png " ")

5.	Open the browser and test the following URL in the address bar. Check for the PONumber 10020 and its deleted.

````
<copy>
http://&lt;Instance_ip_address&gt:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020
</copy>
````
![](./images/ordsl50.png " ")


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
      
 
