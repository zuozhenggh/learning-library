# Create RESTful Services for Spatial Data #

## Introduction ##

This lab will shows you to create RESTful Services for SPATIAL data

## Step 4: AutoREST Enable a Schema and its SPATIAL Table 

To enable AutoREST on a schema and a table, perform the following steps:

1. On the left-side, the Connections navigator is displayed. To make a new connection, click the down arrow beside + sign and click on **New Connection**.
   
 ![](./images/ordslab3.1.png " ")

2. Enter **SPATIAL** for **Connection Name**, **appspat** for **Username**, **Oracle\_4U** for **Password**,         &lt;Instance\_ip\_address&gt; for **Hostname**. Enter **SGRPDB** for **Service name** and **1521** for **Port**. Click **Test** to test the connection.

   
 ![](./images/ordslab3.2.png " ")

3. Once the test connection shows Status : **success**, click **connect** to create the connection.

4. On the Connections navigator, connect to **appspat** schema by expanding it.  
   Right click **SPATIAL** and select **REST Services** and then **Enable REST Services**

 ![](./images/ordslab3.3.png " ")

5. The RESTful Services Wizard will appear. Enter the following and click **Next**.  
   
   |    |   |   |  
   | -------- | -------- | -------- |  
   | Enable schema | Check | Specifies whether the object is available to the Auto Rest service or not |   
   | Schema alias | appspat | This gives the name that is used in the Auto Rest URL to access this object |  
   | Authorization required | Uncheck | When set, only authenticated users with the correct role may access this object |  

  ![](./images/ordslab3.4.png " ")
  
6. The RESTful Summary will appear. Click **Finish**.

![](./images/ordslab3.5.png " ")

7. The SQL is processed and success message appears. Click **OK**.

![](./images/ordslab3.6.png " ")

8. Now, to AutoREST Enable a table, expand Tables (Filtered) under SPATIAL by clicking + beside it. Right click **WAREHOUSES** and select **Enable REST Service**.

![](./images/ordslab3.7.png " ")

9.  The RESTful Services Wizard will appear. Enter the following and click **Next**.  
       
   |    |   |   |  
   | -------- | -------- | -------- |  
   | Enable object | Check | Specifies whether the object is available to the Auto Rest service or not  |   
   | Object alias | WAREHOUSES | This gives the name that is used in the Auto Rest URL to access this object |  
   | Authorization required | Uncheck | When set, only authenticated users with the correct role may access this object |  

  ![](./images/ordslab3.8.png " ")

10.	This screen gives a summary of the selected operations. Click the SQL tab.

![](./images/ordslab3.9.png " ")

11.	Here is the SQL to REST Enable the table. Click **Finish**.

![](./images/ordslab3.10.png " ")

12.	The SQL is processed. Click **OK**.  

![](./images/ordslab3.11.png " ")

The **appspat** schema and the **WAREHOUSES** table are now REST enabled.  

**Define Resource Module, Resource Template**

Please Refer **Lab-1 -> step-2** to create resource module and resource template. All those steps will be performed under the DB connection **Spatial**.

**Retrieve information from SPATIAL table using GET method **

13. In the RESTful Services navigator, the resource module **cnvg** contains the resource template **cnvg/:id**.  
  This template retrieves the  information from table WAREHOUSES based on the parameter id. Right click on template **cnvg/:id** then select **Add handler** and select **GET**.

![](./images/ordslab3.12.png " ")

14. On the Edit Resource handler, select source type as **Collection Query** and click on **Apply**.

![](./images/ordslab3.13.png " ")

15. The resource handler editor **GET cnvg/:id** is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:
     ````
    <copy>
    SELECT
   c.customer_id,
   c.cust_last_name,
   c.GENDER,
   w.warehouse_name
FROM warehouses w,
   customers c
WHERE w.WAREHOUSE_ID = :id
AND sdo_nn (c.cust_geo_location, w.wh_geo_location, 'sdo_num_res=5') = 'TRUE'

    </copy>
    ````

![](./images/ordslab3.14.png " ")

16. The Enter Binds dialog displays. Enter **2** for Value, and click **Apply**. 

![](./images/ordslab3.15.png " ")

17. The Query Result tab displays all the customers which are near to warehouse with id 2. Save the GET handler.

![](./images/ordslab3.16.png " ")

18. Let’s test the Restful Service. Open Postman.  
   Enter **http://&lt;Instance\_ip\_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/2** for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

![](./images/ordslab3.17.png " ")

19. Open the browser and test the following URL in the address bar:
   
      ````
    <copy>

   http://&lt;Instance_ip_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/2

    </copy>

    ````
![](./images/ordslab3.18.png " ")

20. Now we will use other template **cnvg/** which is present in the resource module **cnvg**. This template will retrieve the whole table information from WAREHOUSES table. Right click on template  **cnvg/** then select **Add handler** and select **GET**.

![](./images/ordslab3.19.png " ")

21.  On the Edit Resource handler, select source type as Collection Query and click on **Apply**.

![](./images/ordslab3.20.png " ")

22. The resource handler editor **GET cnvg** is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:
     ````
    <copy>

   select * from warehouses;

    </copy>
    ````

![](./images/ordslab3.21.png " ")

23. The Query Result tab displays the information for the whole table.

![](./images/ordslab3.22.png " ")

24. Let’s test the Restful Service. Open the Postman.  
  Enter http://&lt;Instance\_ip\_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/ for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

![](./images/ordslab3.23.png " ")

25. Open the browser and test the following URL in the address bar:  
    
   ````
    <copy>

   http://&lt;Instance_ip_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/

    </copy>
    ````

![](./images/ordslab3.24.png " ")

**Insert data into SPATIAL table using POST method**

Perform the following steps to create a RESTful Service which inserts the  information into table WAREHOUSES using the HTTP Method POST.

26. Right click on template **cnvg/** then select **Add handler** and select **POST**.

![](./images/ordslab3.25.png " ")

27. In the Mime Types, click the + icon to add a row to the Mime Types. Enter **application/json** and click **Apply**.

![](./images/ordslab3.26.png " ")

28. In the RESTful Services navigator, the resource template **cnvg/** contains the resource handler POST.  
The resource handler editor **POST cnvg/** is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the POST handler.
     ````
      
      <copy>

   BEGIN
    INSERT INTO WAREHOUSES (
        WAREHOUSE_ID,
        WAREHOUSE_NAME,
        LOCATION_ID,
        WH_GEO_LOCATION
    ) VALUES (
        :WAREHOUSE_ID,
        :WAREHOUSE_NAME,
        :LOCATION_ID,
        MDSYS.SDO_GEOMETRY(2001, 4326, MDSYS.SDO_POINT_TYPE(:lon, :lat, NULL), NULL, NULL) 
        );
     commit;
END;


    </copy>
    ````
![](./images/ordslab3.27.png " ")

29. Test the Restful Service. Provide following values in the Postman.
Enter **http://&lt;Instance\_ip\_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/**
for URL, and select **POST** for HTTP Method.  
For the body select **raw** and **JSON** from dropdown, enter below warehouse entry in the body section.  
Then, click **Send** icon located next to the URL field on the top right side.
     ````
       
       <copy>

 {
       "WAREHOUSE_ID":"5",
        "WAREHOUSE_NAME":"p_warehouse",
        "LOCATION_ID":"1600",
        "lon": "-86.2508",
        "lat": "39.7927"
}

    </copy>
    ````
![](./images/ordslab3.28.png " ")

   Once we get the **Status:200 OK**, POST is successfully done.

30. Open the browser and test the following URL in the address bar. This will display results for all of the customers which are near to warehouse with id 5.
     ````
    <copy>

 http://&lt;Instance_ip_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/5

    </copy>
    ````
![](./images/ordslab3.29.png " ")


**Update data in SPATIAL table using PUT method**

31. Right click on template **cnvg/:id** then select **Add handler** and select **PUT**.

![](./images/ordslab3.30.png " ")

32. In the Mime Types, click the + icon to add a row to the Mime Types. Enter **application/json** and click **Apply**.

![](./images/ordslab3.31.png " ")

33. In the RESTful Services navigator, the resource template **cnvg/:id** contains the resource handler PUT.  
The resource handler editor **POST cnvg/:id** is displayed on the right-side.  
Enter the following PL/SQL code in the SQL Worksheet tab. **Save the code** in the PUT handler.
     ````
      
      <copy>

      BEGIN    
      UPDATE WAREHOUSES
      set WAREHOUSE_NAME= :WAREHOUSE_NAME 
      WHERE WAREHOUSE_ID= :id;
      commit;
      END;

    </copy>
    ````

![](./images/ordslab3.32.png " ")

34. Test the Restful Service. Provide following values in the Postman.  
Enter http://&lt;Instance\_ip\_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/5 for URL, and select **PUT** for HTTP Method.  
For the body select **raw** and **JSON** from dropdown, update warehouse name as below in the body section. Then, click **Send** icon located next to the URL field on the top right side.
     ````
       
       <copy>

      {
        "WAREHOUSE_NAME":"put_new__warehouse"
      }

    </copy>
    ````

   Once we get the **Status:200 OK**, PUT is successfully done.

![](./images/ordslab3.33.png " ")

35. Open the browser and test the following URL in the address bar. Check the warehouse name , it is changed to “put\_new\_warehouse"
     ````
    <copy>

      http://&lt;Instance_ip_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/5 

    </copy>
    ````
![](./images/ordslab3.34.png " ")


**Delete data in SPATIAL table using DELETE method**

36. In the RESTful Services navigator, right-click **cnvg/:id**, select **Add Handler** and then select **DELETE**.

![](./images/ordslab3.35.png " ")

37. Click **Apply**.

![](./images/ordslab3.36.png " ")

38. The resource handler editor **DELETE cnvg/:id** is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab and **save** it.
     ````
    <copy>

     BEGIN
     delete from WAREHOUSES
     WHERE WAREHOUSE_ID= :id;
     commit;
     END;
  
    </copy>
    ````

![](./images/ordslab3.37.png " ")

39. Test the Restful Service. Provide following values in the Postman.  

    Enter **http://&lt;Instance\_ip\_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/5** for URL, and select **DELETE** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

     Once we get the Status:200 OK, DELETE is successfully done.

![](./images/ordslab3.38.png " ")

40. Open the browser and test the following URL in the address bar. Check for the warehouse with id 5 and its deleted.
      ````
    <copy>

     http://&lt;Instance_ip_address&gt;:9090/ords/sgrpdb/appspat/cnvg/cnvg/5
  
    </copy>
    ````
![](./images/ordslab3.39.png " ")


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya,         Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management
- **Expiration Date** - June 2021

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.