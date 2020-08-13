# Create RESTful Services for XML data #

## Introduction

This lab will show you how to create RESTful Services for XML data.

## Before You Begin

**What Do You Need?**

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup
    

**AutoREST Enable a Schema and its XML Table**

To enable AutoREST on a schema and a table, perform the following steps:
1. On the left-side, the Connections navigator is displayed. To make a new connection, click down arrow beside + sign and click New Connection.
   
![](./images/ordslab2.1.png " ")

2. Enter **XML** for **Connection Name, appxml** for **Username, Oracle\_4U** for **Password, 
   &lt;Instance\_ip\_address&gt** for **Hostname**. Enter **JXLPDB** for **Service name** and **1521** for **Port**. Click **Test** to test the connection.

![](./images/ordslab2.2.png " ")

3. Once the connection test shows Status:success, click **connect** to create the connection.

4. On the Connections navigator, connect to **appxml** schema by expanding it. Right click **XML** and select **REST Services > Enable REST Services**.
![](./images/ordslab2.3.png " ")

5. The RESTful Services Wizard will appear. Enter the following and click **Next**.

    <table>
    <tr>
        <td>Enable schema</td>
        <td>Check</td>
        <td>Specifies whether the object is available to the Auto Rest service or not.</td>
    </tr>
    <tr>
        <td>Schema alias</td>
        <td>appxml</td>
        <td>This gives the name that is used in the Auto Rest URL to access this object.</td>
    </tr>
    <tr>
        <td>Authorization required</td>
        <td>Uncheck</td>
        <td>When set, only authenticated users with the correct role may access this object.</td>
    </tr>
    </table>



   ![](./images/ordslab2.4.png " ")

6. The RESTful Summary will appear. Click **Finish**.
![](./images/ordslab2.5.png " ")

7.	The SQL is processed and success message appears. Click **OK**.
![](./images/ordslab2.6.png " ")

8.	Now, to AutoREST Enable a table, expand Tables (Filtered) under XML by clicking + beside it. Right click **PURCHASEORDER** and select **Enable REST Service**.
![](./images/ordslab2.7.png " ")

9.	The RESTful Services Wizard will appear. Enter the following and click **Next**.

    <table>
    <tr>
        <td>Enable object</td>
        <td>Check</td>
        <td>Specifies whether the object is available to the Auto Rest service or not.</td>
    </tr>
    <tr>
        <td>Object alias</td>
        <td>PURCHASEORDER</td>
        <td>This gives the name that is used in the Auto Rest URL to access this object.</td>
    </tr>
    <tr>
        <td>Authorization required</td>
        <td>Uncheck</td>
        <td>When set, only authenticated users with the correct role may access this object.</td>
    </tr>
    </table>

    ![](./images/ordslab2.8.png " ")

10.	This screen gives a summary of the selected operations. Click the SQL tab.
![](./images/ordslab2.9.png " ")

11.	Here is the SQL to REST Enable the table. Click **Finish**.
![](./images/ordslab2.10.png " ")

12.	The SQL is processed. Click **OK**.
![](./images/ordslab2.11.png " ")

    The **appxml** schema and the **PURCHASEORDER** table are now REST enabled.
    ![](./images/ordslab2.12.png " ")

**Define Resource Module, Resource Template**

Refer **Lab-1-> step-2** to create resource module and resource template. All those steps will be performed under DB connection **XML**.

**Retrieve information from XML table using GET method**

13. In the RESTful Services navigator, the resource module cnvg contains the resource template cnvg/:id. This template will retrieves the  information from table PURCHASEORDER based on the parameter id. Right click on template  **cnvg/:id** then select **Add handler** and select **GET**.
   
   ![](./images/ordslab2_3.png " ")

14. On the Edit Resource handler, select source type as Collection Query and click on **Apply**.
![](./images/ordslab2.13.png " ")

15. The resource handler editor GET cnvg/:id is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:

    ````
        <copy>
        SELECT t.object_value.getclobval() FROM   purchaseorder t
        WHERE  xmlexists('/PurchaseOrder[PONumber/text()=$PONumber]' passing object_value, 
        :id AS   "PONumber" )

        </copy>
    ````

    ![](./images/ords_lab2_3.png " ")

    
16. The Enter Binds dialog displays. Enter **200** for Value, and click **Apply**. 
![](./images/ordslab2.15.png " ")

17. The Query Result tab displays the information for PONumber, 200. Save the GET handler
![](./images/ordslab2.16.png " ")

18. Let’s test the Restful Service. Open the Postman.
Enter http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/200 for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.
![](./images/ordslab2.17.png " ")

19. Open the browser and test the following URL in the address bar: http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/200
![](./images/ordslab2.18.png " ")

20. Now will use other template cnvg/ which is there in the  the resource module cnvg This template will retrieve the  whole table information from PURCHASEORDER. Right click on template  **cnvg/** then select **Add handler** and select **GET**.
![](./images/ordslab2.19.png " ")

21. On the Edit Resource handler, select source type as Collection Query and click on **Apply**.
![](./images/ordslab2.20.png " ")

22. The resource handler editor GET cnvg is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:


    ````
        <copy>
        SELECT t.object_value.getclobval() FROM   purchaseorder t;
        </copy>
    ````

    ![](./images/ordslab2.21.png " ")

23.  The Query Result tab displays the information for the whole table.
![](./images/ordslab2.22.png " ")

24. Let’s test the Restful Service. Open the Postman.
Enter http://&lt;Instance_ip_address&gt:9090/ords/jxlpdb/appxml/cnvg/cnvg/ for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.
![](./images/ordslab2.23.png " ")

25. Open the browser and test the following URL in the address bar: http://&lt;Instance_ip_address&gt:9090/ords/jxlpdb/appxml/cnvg/cnvg/
![](./images/ordslab2.24.png " ")

**Insert data into XML table using POST method**
Perform the following steps to create a RESTful Service which inserts the  information into table PURCHASEORDER  using the HTTP Method POST.

26. Right click on template  **cnvg/** then select **Add handler** and select **POST**.
![](./images/ordslab2.25.png " ")

27. In the Mime Types, click the **+** icon to add a row to the Mime Types. Enter **application/XML** and click **Apply**.
![](./images/ordslab2.26.png " ")

28. In the RESTful Services navigator, the resource template cnvg/ contains the resource handler POST.
The resource handler editor POST cnvg/ is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the POST handler.
    
    ````
        <copy>
        declare
        aa varchar2(30000);
        BEGIN    
        aa:=UTL_RAW.CAST_TO_VARCHAR2(:body);
        insert into purchaseorder values (aa);
        commit;
        END;
        </copy>
    ````
![](./images/ordslab2.27.png " ")

29. Test the Restful Service. Provide following values in the Postman.
Enter http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/ for URL, and select POST for HTTP Method. For the **body** select **raw** and XML from dropdown, enter below PO document in the body section Then, click **Send** icon located next to the URL field on the top right side.

        
        <PurchaseOrder>
        <PONumber>10020</PONumber>
        <Reference>MSD-20200505</Reference>
        <Requestor>MS Dhoni</Requestor>
        <User> TGATES </User>
        <CostCenter>A50</CostCenter>
        <ShippingInstructions>
            <name>MS Dhoni</name>
            <Address>
            <street>200 Sporting Green</street>
            <city>South San Francisco</city>
            <state>CA</state>
            <zipCode>99236</zipCode>
            <country>United States of America</country>
            </Address>
            <Phone>
            <type>Office</type>
            <number>131-555-5589</number>
            </Phone>
        </ShippingInstructions>
        <LineItems>
            <ItemNumber>1</ItemNumber>
            <Part>
            <Description>Ivanhoe</Description>
            <UnitPrice>19.95</UnitPrice>
            <UPCCode>66479101648</UPCCode>
            </Part>
            <Quantity>2</Quantity>
        </LineItems>
        <LineItems>
            <ItemNumber>2</ItemNumber>
            <Part>
            <Description>Karaoke: Classic Country Hits Vol. 3 203</Description>
            <UnitPrice>19.95</UnitPrice>
            <UPCCode>13023003897</UPCCode>
            </Part>
            <Quantity>2</Quantity>
        </LineItems>
        <LineItems>
            <ItemNumber>3</ItemNumber>
            <Part>
            <Description>Urban Legend</Description>
            <UnitPrice>19.95</UnitPrice>
            <UPCCode>43396030916</UPCCode>
            </Part>
            <Quantity>9</Quantity>
        </LineItems>
        <Special_Instructions>COD</Special_Instructions>
        </PurchaseOrder>

 Once we get the Status:200 OK, POST is successfully done.
    ![](./images/ordslab2.28.png " ")

30. Open the browser and test the following URL in the address bar: 
http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/10020
![](./images/ordslab2.29.png " ")

**Update data in XML table using PUT method**
31. Right click on template  **cnvg/:id** then select **Add handler** and select **PUT**.
![](./images/ordslab2.30.png " ")

32. In the Mime Types, click the **+** icon to add a row to the Mime Types. Enter **application/XML** and click **Apply**.
![](./images/ordslab2.31.png " ")

33. In the RESTful Services navigator, the resource template cnvg/:id contains the resource handler PUT.
The resource handler editor POST cnvg/:id is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the PUT handler.

    ````
        <copy>
        BEGIN    
        UPDATE purchaseorder
        set object_value=updateXML(OBJECT_VALUE, '/PurchaseOrder/User/text()',:body )
        WHERE  xmlexists('/PurchaseOrder[PONumber/text()=$PONumber]' passing object_value, :id AS "PONumber" );
        commit;
        END;
        </copy>
    ````



     ![](./images/ordslab2.32.png " ")

34. Test the Restful Service. Provide following values in the Postman.  
Enter http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/10020
for URL, and select PUT for HTTP Method. For the **body** select **raw** and XML from dropdown, update Requester name as below in the body section Then, click Send icon located next to the URL field on the top right side.

    ````
        <copy>
        Dummy_user
        </copy>
    ````


    Once we get the Status:200 OK, PUT is successfully done.
    ![](./images/ordslab2.33.png " ")

35. Open the browser and test the following URL in the address bar. Check the requester name , it is changed to dummy_user.
http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/10020
![](./images/ordslab2.34.png " ")

**Delete data in XML table using DELETE method**

36.  In the RESTful Services navigator, right-click **cnvg/:id**, select **Add Handler** and then select **DELETE**.
![](./images/ordslab2.35.png " ")

37. Click **Apply**.
![](./images/ordslab2.36.png " ")

38. The resource handler editor DELETE cnvg/:id is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab and save it.

    ````
        <copy>
        BEGIN
        delete from purchaseorder
        WHERE  xmlexists('/PurchaseOrder[PONumber/text()=$PONumber]' passing object_value,
        :id AS "PONumber" );
        commit;
        </copy>
    ````
      ![](./images/ordslab2.37.png " ")

39. Test the Restful Service. Provide following values in the Postman.  
   
   Enter http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/10020
 for URL, and select DELETE for HTTP Method. Then, click Send icon located next to the URL field on the top right side.  

  Once we get the Status:200 OK, DELETE is successfully done.
  ![](./images/ordslab2.38.png " ")

40. Open the browser and test the following URL in the address bar.  
   Check for the PONumber 10020 and its deleted.
   http://&lt;Instance\_ip\_address&gt;:9090/ords/jxlpdb/appxml/cnvg/cnvg/10020
   ![](./images/ordslab2.39.png " ")


    
    


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya,         Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management
- **Expiration Date** - June 2021

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.