# Oracle Database 19c JSON Documents

## Introduction

This workshop aims to help you understanding JSON data and how you can use SQL and PL/SQL with JSON data stored in Oracle Database.  This lab takes approximately 20 minutes.

## About JSON in the Oracle Database

**JavaScript Object Notation (JSON)** is defined in standards ECMA-404 (JSON Data Interchange Format) and ECMA-262 (ECMAScript Language Specification, third edition). The JavaScript dialect of ECMAScript is a general programming language used widely in web browsers and web servers.  **Oracle Database** supports **JavaScript Object Notation (JSON)** data natively with relational database features, including transactions, indexing, declarative querying, and views.

Watch this video to learn more about JSON in the Oracle Database.

[](youtube:OXxA6SFqlJ4)


***Schemaless*** development based on persisting application data in the form of JSON documents lets you quickly react to changing application requirements. You can change and redeploy your application without needing to change the storage schemas it uses. SQL and relational databases provide flexible support for complex data analysis and reporting, as well as rock-solid data protection and access control. This is typically not the case for NoSQL databases, which have often been associated with schemaless development with JSON in the past. Oracle Database provides all of the benefits of SQL and relational databases to JSON data, which you store and manipulate in the same ways and with the same confidence as any other type of database data.


### Lab Prerequisites

This lab assumes you have completed the following labs:
* Lab: Login to Oracle Cloud
* Lab: Generate SSH Key
* Lab: Environment Setup
* Lab: Sample Schema Setup

### Lab User Schema

For this lab we will use the ***Order Entry (OE)*** sample schema that is provided with the Oracle Database installation. If you have completed the setup previously you will already have the ***OE*** schema installed.

## Step 1: Environment Preparation

Grant Required Privileges to the OE user

1. Connect to the **ORCLPDB** pluggable database, as SYSDBA.

  ````
  $ <copy>sqlplus sys/Ora_DB4U@localhost:1521/orclpdb as SYSDBA</copy>
  ````

2. Grant **OE** user some privileges required for the tasks we will execute in this lab.

  ````
  <copy>GRANT SELECT ON v_$session TO oe;
  GRANT SELECT ON v_$sql_plan_statistics_all TO oe;
  GRANT SELECT ON v_$sql_plan TO oe;
  GRANT SELECT ON v_$sql TO oe;
  GRANT ALTER SYSTEM TO oe;
  </copy>
  ````

*Note: The ***ALTER SYSTEM*** privilege is required to flush the Shared Pool in one exercise about performance.*

3. Create Network Access Control List as our database needs to connect to a web service, and retrieve information over HTTP, and this requires an ***Access Control List (ACL)***. This ACL can be created by a user with SYSDBA privileges, SYS in this case, from the Pluggable Database called **ORCLPDB**, by executing the following procedure.

  ````
  <copy>begin
    DBMS_NETWORK_ACL_ADMIN.append_host_ace (
      host       => 'api.geonames.org',
      ace        => xs$ace_type(privilege_list => xs$name_list('http','connect','resolve'),
                                principal_name => 'OE',
                                principal_type => xs_acl.ptype_db));
  end;
  /</copy>
  ````

  ![](./images/p_addACL.png " ")

4. Ensure the execution is successful.  SQL*Plus Formatting is suggested

3. Close the SYSDBA connection and connect as the **OE** user to pluggable database ORCLPDB. From this point, all tasks on the database side will be performed using the **OE** user. For SQL*Plus, it is also useful to format the output. Feel free to use your own formatting, or just run these formatting commands every time you connect.

  ````
  > <copy>conn oe/Ora_DB4U@localhost:1521/orclpdb</copy>
  ````

  ````
  <copy>set linesize 130
  set serveroutput on
  set pages 9999
  set long 90000
  column WORKSHOPNAME format a50
  column LOCATION format a20
  column COUNTRY format a8
  column GEONAMEID format a10
  column TITLE format a35
  column NAME format a32
  column REGION format a20
  column SUB_REGION format a22
  column REGION format a12
  </copy>
  ````

## Step 2:  Register for Geonames

For the purpose of this exercise we will use a web service, that returns information in JSON format, provided by GeoNames - [geonames.org](http://www.geonames.org/). GeoNames is licensed under a [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/). You are free to:

- Share — copy and redistribute the material in any medium or format;
- Adapt — remix, transform, and build upon the material for any purpose, even commercially.

1. Click '**login**' link on the upper right corner of GeoNames website, and create a new account. **Note:** When you create your GeoNames account you will receive an email to activate the account. 
   
2. Enable the account for web services on the account page [GeoNames Account Page](http://www.geonames.org/manageaccount)


## Step 3: Generate JSON Data

First step is to generate some JSON data into the database, or retrieve sample documents from a web service. Oracle Database supports *JavaScript Object Notation (JSON)* data natively with relational database features, including transactions, indexing, declarative querying, and views.

This lab covers the use of database languages and features to work with JSON data that is stored in Oracle Database. In particular, it covers how to use SQL and PL/SQL with JSON data.
1. Please make sure you activate your GeoNames account before continuing with the exercise.

2. Test the access to the external web service – in this case countryInfo web service from GeoNames. You have to replace **<GeoNames_username>** with the username of your account on GeoNames website.

  ````
  <copy>set serveroutput on</copy>
  ````

3.  Preview the sample output below.

  ![Geonames Sample Output](./images/p_GeoNameSampleOutput.png " ")

4. Please make sure you receive a similar output to the sample shown above.

## Step 4: Store Json Documents Into Oracle Database

2. Create a new table to store all JSON documents inside the pluggable database.

  ````
  <copy>CREATE TABLE MYJSON (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY (CACHE 5) PRIMARY KEY,
    doc CLOB CONSTRAINT valid_json CHECK (doc IS JSON));</copy>
  ````

3. Using JSON inside Oracle database is very flexible, and does not require a predefined data structure, or specific schema. You can store any JSON document in a relational table, like the one we just created, with any internal document structure. Here is another JSON document example, with a totally different structure than the one we have received from GeoNames, and we can store it in the same table.

  ````
  <copy>
  INSERT INTO MYJSON (doc) VALUES (
  '{
    "workshopName": "Database 19c New Features for Developers",
    "audienceType": "Partners Technical Staff",
    "location": {
      "company": "Oracle",
      "office": "Customer Visiting Center",
      "region": "EMEA"
    }
  }');
  </copy>
  ````

  ````
  <copy>commit;</copy>
  ````

4. Once stored, we can query these documents and retrieve the JSON values as traditional relational data.

  ````
  <copy>set pages 9999
  set long 90000
  SELECT j.doc FROM MYJSON j;
  </copy>
  ````

  ![](./images/p_jsonDoc_1.png " ")

## Step 5:  Single Dot Notation

Oracle database SQL engine allows you to use a **simple-dot-notation (SDN)** syntax on your JSON data. With other words, you can write SQL queries that contain something like ***TABLE_Alias.JSON_Column.JSON_Property.JSON_Property>*** which comes quite handy as the region attribute is an attribute of the nested object location within the JSON document. Remember, JSDN syntax is case sensitive.

The return value for a dot-notation query is always a string (data type VARCHAR2(4000)) representing JSON data. The content of the string depends on the targeted JSON data, as follows:
- If a single JSON value is targeted, then that value is the string content, whether it is a JSON scalar, object, or array.
- If multiple JSON values are targeted, then the string content is a JSON array whose elements are those values.

1.  Let's format your SQL query environment
  ````
  <copy>
  column WORKSHOPNAME format a50
  column LOCATION format a20
  </copy>
  ````

2.  Issue the query to choose the workshop name and region from the table you loaded earlier.
  ````
  > <copy>SELECT j.doc.workshopName, j.doc.location.region FROM MYJSON j;</copy>
  ````

  ![](./images/p_jsonDoc_2.png " ")

3. Test other queries and review the output.

## Step 6: Retrieve Sample Data

The objective for our lab is to retrieve information about castles in Europe, and use them as JSON documents in different scenarios. Imagine you are starting the development of a new mobile application that provides recommendations for tourists.  For convenience and comfort, we can encapsulate the communication with a web service into a function. This way, we don’t have to write all the code required for a simple request, which in most of the cases is even more complicated than our simple example here, because they require a more complex authentication.

*Note: Remember to replace <GeoNames_username>*

1.  Create a function to get country information

  ````
  <copy>create or replace function get_country_info (countryCode in VARCHAR2) return clob
    is
      t_http_req  utl_http.req;
      t_http_resp  utl_http.resp;
      t_response_text clob;
    begin   
      t_http_req:= utl_http.begin_request('http://api.geonames.org/countryInfoJSON?formatted=true' || '&' || 'country=' || countryCode || '&' || 'username=<GeoNames_username>' || '&' || 'style=full', 'GET', 'HTTP/1.1');
      t_http_resp:= utl_http.get_response(t_http_req);
      UTL_HTTP.read_text(t_http_resp, t_response_text);
      UTL_HTTP.end_response(t_http_resp);
      return t_response_text;
    end;
  /
  </copy>
  ````

2. The input of the function we just created is the ISO code of a country. Run this query to get information about Spain, for example.

  ````
  <copy>select get_country_info('ES') country_info from dual;</copy>
  ````

  ![](./images/p_jsonFunc_1.png " ")

3. Insert the JSON document retrieved from the web service into the JSON column of that same table, even though this JSON document has a totally different structure.

  ````
  <copy>insert into MYJSON (doc) values (get_country_info('ES'));</copy>
  ````

  ````
  <copy>commit;</copy>
  ````

4. Select the contents of that table, and notice we use the same column.

````
<copy>select * from MYJSON;</copy>
````

![](./images/p_jsonDoc_3.png " ")

5. Working with attributes, allows us to get the information we want from a specific document. We can assign default values for attributes that do not match, and treat the issue further from the application. The SQL/JSON function ***JSON_VALUE*** finds a specified scalar JSON value in JSON data and returns it as a SQL value.

  ````
  <copy>column GEONAMEID format a10
  column COUNTRY format a40
  </copy>
  ````

  ````
  > <copy>SELECT JSON_VALUE(doc, '$.geonames.geonameId' NULL ON ERROR) AS GeoNameID,
  JSON_VALUE(doc, '$.geonames.countryName' DEFAULT 'Not a country' ON ERROR) AS Country
  FROM MYJSON;</copy>
  ````

  ![](./images/p_jsonDoc_4.png " ")`

6. Or we can filter the results to receive only the documents that are useful for the query, using the SDN syntax.

  ````
  > <copy>select j.doc.geonames.geonameId GeoNameID, j.doc.geonames.countryName Country
      from MYJSON j where j.doc.geonames.isoAlpha3 IS NOT NULL;</copy>
  ````

  ![](./images/p_jsonDoc_5.png " ")

7. In both cases, we can see that Spain geonameId is 2510769. This value will be used in the following steps.

8. A new function is required to retrieve JSON documents with country regions information from GeoNames web service. This function requires the  **geonameId** of the country, and a style value used internally by GeoNames web service to specify the level of details.

*Note: Remember to replace <GeoNames_username>*

  ````
  <copy>create or replace function get_subdivision (geonameId in NUMBER, style in VARCHAR2) return clob
    is
      t_http_req  utl_http.req;
      t_http_resp  utl_http.resp;
      t_response_text clob;
    begin
      t_http_req:= utl_http.begin_request('http://api.geonames.org/childrenJSON?formatted=true' || '&' || 'geonameId=' || geonameId || '&' || 'username=<GeoNames_username>' || '&' || 'style=' || style, 'GET', 'HTTP/1.1');
      t_http_resp:= utl_http.get_response(t_http_req);
      UTL_HTTP.read_text(t_http_resp, t_response_text);
      UTL_HTTP.end_response(t_http_resp);
      return t_response_text;
    end;
  /
  </copy>
  ````

9. Test this function using the following inputs.

  ````
  > <copy>select get_subdivision(2510769, 'medium') regions_document from dual;</copy>
  ````

  ![](./images/p_jsonFunc_2.png " ")

10. If the test is successful, insert this new JSON document in the same table.

  ````
  > <copy>insert into MYJSON (doc) values (get_subdivision(2510769, 'medium'));</copy>
  ````

  ````
  <copy>commit;</copy>
  ````

11. The SQL/JSON function ***JSON_TABLE*** creates a relational view of JSON data. It maps the result of a JSON data evaluation into relational rows and columns. You can query the result returned by the function as a virtual relational table using SQL. The main purpose of ***JSON_TABLE*** is to create a row of relational data for each object inside a JSON array and output JSON values from within that object as individual SQL column values. Nested clause allows you to flatten JSON values in a nested JSON object or JSON array into individual columns in a single row along with JSON values from the parent object or array. You can use this clause recursively to project data from multiple layers of nested objects or arrays into a single row. This path expression is relative to the SQL/JSON row path expression specified in the ***JSON_TABLE*** function.

  ````
  <copy>column TITLE format a35
  column NAME format a32
  </copy>
  ````

  ````
  > <copy>SELECT jt.countryName Country, jt.fcode, convert(jt.toponymName,'WE8ISO8859P1','AL32UTF8') Title,
    convert(jt.name,'WE8ISO8859P1','AL32UTF8') Name, jt.geonameId GeoNameID FROM MYJSON,
    JSON_TABLE(DOC, '$' COLUMNS
      (NESTED PATH '$.geonames[*]'
        COLUMNS (countryName VARCHAR2(80) PATH '$.countryName',
                toponymName VARCHAR2(120) PATH '$.toponymName',
                geonameId VARCHAR2(20) PATH '$.geonameId',
                name VARCHAR2(80) PATH '$.name',
                fcode VARCHAR2(6) PATH '$.fcode')))
    AS jt  WHERE (fcode = 'ADM1');</copy>
  ````

  ![](./images/p_jsonDoc_6.png " ")

12. Having all regions from Spain, we can ask the GeoNames web service for more information about each region, for example Andalucia with **geonameId** 2593109.

  ````
  > <copy>SELECT get_subdivision(2593109, 'full') sub_regions FROM dual;</copy>
  ````

13. Our next goal is to get more details about each region, and for that we need the geonameId for each region. One option is to use ***JSON_TABLE*** to return only that column, or the following SDN syntax.

  ````
  > <copy>SELECT j.doc.geonames.geonameId FROM MYJSON j WHERE j.doc.geonames.fcode like '%ADM1%';</copy>
  ````

  ![](./images/p_jsonDoc_7.png " ")

The SDN syntax returns an array, not a relational view of JSON data in one column.

## Step 7: Performance Considerations

Using PL/SQL, we may treat and manipulate JSON arrays as strings, inside Oracle database, using standard functions and procedures.

### Consider Multiple Choices When Querying JSON Documents

16. There are performance considerations, for example when using regular expressions on strings, as in this example.

````
<copy>set timing on</copy>
````

````
> <copy>WITH DATA AS
    (SELECT substr(j.doc.geonames.geonameId, 2, length(j.doc.geonames.geonameId)-2) as GEONAMES
     FROM MYJSON j WHERE j.doc.geonames.fcode like '%ADM1%')
  SELECT trim(regexp_substr(geonames, '[^,]+', 1, LEVEL)) geonames
  FROM DATA
  CONNECT BY instr(geonames, ',', 1, LEVEL - 1) > 0;</copy>
````

![](./images/p_jsonDoc_8.png " ")

Take a note of the execution time, and compare it with the following code, that returns the same result, but faster.

````
> <copy>WITH ids ( GEONAMES, start_pos, end_pos ) AS
  ( SELECT GEONAMES, 1, INSTR( GEONAMES, ',' ) FROM
(SELECT substr(j.doc.geonames.geonameId, 2, length(j.doc.geonames.geonameId)-2) as GEONAMES FROM MYJSON j WHERE j.doc.geonames.fcode like '%ADM1%')
  UNION ALL
  SELECT GEONAMES,
    end_pos + 1,
    INSTR( GEONAMES, ',', end_pos + 1 )
  FROM ids
  WHERE end_pos > 0
  )
SELECT SUBSTR( GEONAMES, start_pos, DECODE( end_pos, 0, LENGTH( GEONAMES ) + 1, end_pos ) - start_pos ) AS geonameId
FROM ids;</copy>
````

The execution time difference is insignificant (00:00:00.02 compared to 00:00:00.00), however, for millions of transactions it may have to be considered. The point is coding with JSON objects is a matter of choice, and always there will be multiple options for reaching the same result, and we need to choose the most optimal one.

### Retrieve Sub-Regions Information In JSON Format

17. Using a cursor, and the query you like most, we can run a loop, to retrieve the sub-regions for every region in Spain. This procedure will store a JSON document in our table, with the sub-regions, for each region (19 documents).

````
<copy>declare
   cursor c1 is
	WITH ids ( GEONAMES, start_pos, end_pos ) AS
	  ( SELECT GEONAMES, 1, INSTR( GEONAMES, ',' ) FROM
	(SELECT substr(j.doc.geonames.geonameId, 2, length(j.doc.geonames.geonameId)-2) as GEONAMES
	 FROM MYJSON j WHERE j.doc.geonames.fcode like '%ADM1%')
	  UNION ALL
	  SELECT GEONAMES,
	    end_pos + 1,
	    INSTR( GEONAMES, ',', end_pos + 1 )
	  FROM ids
	  WHERE end_pos > 0
	  )
	SELECT SUBSTR(GEONAMES, start_pos, DECODE(end_pos, 0, LENGTH( GEONAMES ) + 1, end_pos) - start_pos) AS geonameId
	FROM ids;
begin
   FOR subregionID in c1
   LOOP
      insert into MYJSON (doc) values (get_subdivision(subregionID.geonameId, 'full'));
   END LOOP;
commit;
end;
/
</copy>
````

Query the regions and sub-regions stored in these 19 documents, retrieving them as relational data.

````
<copy>column COUNTRY format a8
column REGION format a20
</copy>
````

````
> <copy>SELECT jt.countryName Country,
       convert(jt.adminName1,'WE8ISO8859P1','AL32UTF8') Region,
       convert(jt.toponymName,'WE8ISO8859P1','AL32UTF8') Title,
       convert(jt.name,'WE8ISO8859P1','AL32UTF8') Name, jt.adminCode1, jt.adminCode2 FROM MYJSON,
JSON_TABLE(DOC, '$' COLUMNS
  (NESTED PATH '$.geonames[*]'
     COLUMNS (countryName VARCHAR2(80) PATH '$.countryName',
              adminName1 VARCHAR2(80) PATH '$.adminName1',
              toponymName VARCHAR2(120) PATH '$.toponymName',
              name VARCHAR2(80) PATH '$.name',
              adminCode1 VARCHAR(8) PATH '$.adminCode1',
              adminCode2 VARCHAR(8) PATH '$.adminCode2',
              fcode VARCHAR2(6) PATH '$.fcode')))
AS jt  WHERE (fcode = 'ADM2');</copy>
````

![](./images/p_jsonDoc_9.png " ")

Now we have the entire geographic division.

### Retrieve Castles Information In JSON Format

18. In order to retrieve information about castles from GeoNames web service, we have to create a new function. The input for this function is the ISO country code, the code of the region, and the code of the sub-region. The output is a JSON document with all castles in that sub-region.

>**Note**: Remember to replace ***<GeoNames_username>***

````
<copy>create or replace function get_castles (country in VARCHAR2, adminCode1 in VARCHAR2, adminCode2 in VARCHAR2) return clob   
  is
    t_http_req  utl_http.req;
    t_http_resp  utl_http.resp;
    t_response_text clob;
  begin
    t_http_req:= utl_http.begin_request('http://api.geonames.org/searchJSON?formatted=true' || '&' || 'featureCode=CSTL' || '&' || 'country=' || country || '&' || 'adminCode1=' || adminCode1 ||  '&' || 'adminCode2=' || adminCode2 || '&' || 'username=<GeoNames_username>' || '&' || 'style=full', 'GET', 'HTTP/1.1');
    t_http_resp:= utl_http.get_response(t_http_req);
    UTL_HTTP.read_text(t_http_resp, t_response_text);
    UTL_HTTP.end_response(t_http_resp);
    return t_response_text;
  end;
/
</copy>
````

19. Test get_castles function, using as input ***Valencia*** region (adminCode1 : 60), and ***Provincia de Alicante*** sub-region (adminCode2: A).

````
> <copy>select get_castles('ES', 60, 'A') castles_document from dual;</copy>
````

![](./images/p_jsonDoc_10.png " ")

20. Use this function in a loop to retrieve castles from all sub-regions, as shown in the following example, storing the JSON documents inside the same table.

````
<copy>column SUB_REGION format a20
column REGION format a12
</copy>
````

````
<copy>declare
   cursor c1 is
     SELECT jt.adminCode1, jt.adminCode2 FROM MYJSON,
     JSON_TABLE(DOC, '$' COLUMNS
       (NESTED PATH '$.geonames[*]'
          COLUMNS (adminCode1 VARCHAR(8) PATH '$.adminCode1',
                   adminCode2 VARCHAR(8) PATH '$.adminCode2',
                   fcode VARCHAR2(6) PATH '$.fcode')))
      AS jt  WHERE (fcode = 'ADM2');
begin
   FOR SubRegion in c1
   LOOP
      insert into MYJSON (doc) values (get_castles('ES', SubRegion.adminCode1, SubRegion.adminCode2));
   END LOOP;
commit;
end;
/
</copy>
````

![](./images/p_jsonFunc_3.png " ")

At this point we have enough JSON documents inside the database, and all the information to develop our application that provides information about medieval castles in Spain.

````
> <copy>SELECT jt.countryName Country,
       convert(jt.adminName1,'WE8ISO8859P1','AL32UTF8') Region,
       convert(jt.adminName2,'WE8ISO8859P1','AL32UTF8') Sub_Region,
       jt.fcode, convert(jt.toponymName,'WE8ISO8859P1','AL32UTF8') Title,
       convert(jt.name,'WE8ISO8859P1','AL32UTF8') Name FROM MYJSON,
JSON_TABLE(DOC, '$' COLUMNS
  (NESTED PATH '$.geonames[*]'
     COLUMNS (countryName VARCHAR2(80) PATH '$.countryName',
              adminName1 VARCHAR2(80) PATH '$.adminName1',
              adminName2 VARCHAR2(80) PATH '$.adminName2',
              toponymName VARCHAR2(120) PATH '$.toponymName',
              name VARCHAR2(80) PATH '$.name',
              adminCode1 VARCHAR(8) PATH '$.adminCode1',
              fcode VARCHAR2(6) PATH '$.fcode')))
AS jt  WHERE (fcode = 'CSTL');</copy>
````
![](./images/p_jsonDoc_11.png " ")

> This query should return 269 rows.


## Step 3: Syntax Simplifications

In Oracle Database 19c, there were some improvements in the simplicity of querying JSON documents using SQL. Other improvements were made as well in generating JSON documents on the fly from relational data.

## Query JSON Data

1. This is a basic example of generating JSON documents from a relational table, to be used in a web service. Through these web services, you can integrate heterogeneous applications within the enterprise, or expose business functions to third parties over the internet. All this can be done directly from the database, without any other components installed and configured.

### Query JSON Data Using Plane SQL

Let’s consider **ORDERS** table from OE schema.

````
<copy>column ORDER_DATE format a28</copy>
````

````
> <copy>desc ORDERS</copy>
````

````
> <copy>select * from ORDERS;</copy>
````

2. SQL/JSON function ***JSON_OBJECT*** constructs JSON objects from relational (SQL) data. Using this function on a relational table to generate JSON, prior to 19c, it was necessary to specify for each column an explicit field name–value pair.

````
> <copy>select JSON_OBJECT (
    key 'OrderID' value to_char(o.order_id) format JSON,
    key 'OrderDate' value to_char(o.order_date) format JSON ) "Orders"
  from ORDERS o;</copy>
````

This requires more time and code to be written.

### JSON Query Improvements In Oracle 19C

3. In Oracle 19c, function ***JSON_OBJECT*** can generate JSON objects receiving as argument just a relational column name, possibly preceded by a table name or alias, or a view name followed by a dot. For example ***TABLE.COLUMN***, or just ***COLUMN***.

````
> <copy>select JSON_OBJECT(order_id, order_date) from ORDERS;</copy>
````

4. Another improvement was made in generating JSON documents in 19c using wildcard. The argument in this case can be the table name or alias, or a view name, followed by a dot and an asterisk wildcard (.*), or just an asterisk wildcard like in the following example.

````
> <copy>SELECT JSON_OBJECT(*) FROM ORDERS;</copy>
````

In conclusion, in Oracle 19c we can say that ***JSON_OBJECT*** function follows what is allowed for column names and wildcards in a SQL SELECT query.

### Using Custom Types And Wildcard

There are some cases, exceptions, where wildcards are not accepted for tables with columns of certain custom data types, like our table **CUSTOMERS**, for example.

````
> <copy>desc CUSTOMERS</copy>  

 Name                      Null?    Type
 ------------------------- -------- ---------------------
 CUSTOMER_ID               NOT NULL NUMBER(6)
 CUST_FIRST_NAME           NOT NULL VARCHAR2(20)
 CUST_LAST_NAME            NOT NULL VARCHAR2(20)
 CUST_ADDRESS                       CUST_ADDRESS_TYP
 PHONE_NUMBERS                      PHONE_LIST_TYP
 NLS_LANGUAGE                       VARCHAR2(3)
 NLS_TERRITORY                      VARCHAR2(30)
 CREDIT_LIMIT                       NUMBER(9,2)
 CUST_EMAIL                         VARCHAR2(30)
 ACCOUNT_MGR_ID                     NUMBER(6)
 CUST_GEO_LOCATION                  MDSYS.SDO_GEOMETRY
 DATE_OF_BIRTH                      DATE
 MARITAL_STATUS                     VARCHAR2(20)
 GENDER                             VARCHAR2(1)
 INCOME_LEVEL                       VARCHAR2(20)
````

Asterisk wildcard is allowed in a normal SQL query.

````
> <copy>select * from CUSTOMERS;</copy>
````

But we receive an error if we try to use the asterisk wildcard with ***JSON_OBJECT*** function.

````
> <copy>select JSON_OBJECT(*) from CUSTOMERS;</copy>

ERROR at line 1:
ORA-40579: star expansion is not allowed
````

![](./images/p_synExp-1.png " ")

There is a solution for that.

### Workaround For Custom Types

The workaround for this issue is to create a view on the original table. This view will compile the custom data types and will use the result as standard data types.

````
> <copy>CREATE OR REPLACE VIEW view_cust AS SELECT * FROM customers;</copy>
````

````
> <copy>SELECT json_object(*) FROM view_cust;</copy>
````

In conclusion, instead of passing SQL expressions that are used to define individual JSON object members, you can pass a single instance of a user-defined SQL object type. This produces a JSON object whose field names are taken from the object attribute names and whose field values are taken from the object attribute values (to which JSON generation is applied recursively). Or use an asterisk (*) wildcard as a shortcut to explicitly specifying all of the columns of a given table or view to produce object members. The resulting object field names are the uppercase column names. You can use a wildcard with a table, a view, or a table alias.


## Step 4: Updating a JSON Document

You can now update a JSON document declaratively using the new SQL function **JSON_MERGEPATCH**. You can apply one or more changes to multiple documents by using a single statement. This feature improves the flexibility of JSON update operations.

## Updating Selected JSON Documents On The Fly

You can use ***JSON_MERGEPATCH*** in a SELECT list, to modify the selected documents. The modified documents can be returned or processed further.

### Retrieve A Specific Value From JSON Document

1. For example we can retrieve the entire JSON document containing the country description for Spain.

````
> <copy>select DOC from MYJSON j where j.doc.geonames.geonameId = '2510769';</copy>
````

![](./images/p_updateJsonDoc_1.png " ")

JSON Merge Patch acts a bit like a UNIX patch utility — you give it:
  * a source document to patch and
  * a patch document that specifies the changes to make, and it returns a copy of the source document updated (patched).
Here is a very simple example, changing one attribute in a two attributes JSON document.

````
> <copy>SELECT json_mergepatch('{"CountryName":"Spain", "Capital":"Madrid"}', '{"Capital":"Toledo"}' RETURNING CLOB PRETTY) Medieval FROM dual;</copy>
````
![](./images/p_updateJsonDoc_2.png " ")

However, you cannot use it to add, remove, or change array elements (except by explicitly replacing the whole array). For example, our documents received from GeoNames are all arrays.

The Country description for Spain has one field geonames that has an array value. This array has one element (geonames[0]), which is an object with 17 fields
- continent
- capital
- languages
- geonameId
- south
- isoAlpha3
- north
- fipsCode
- population
- east
- isoNumeric
- areaInSqKm
- countryCode
- west
- countryName
- continentName
- currencyCode

````
> <copy>SELECT j.doc.geonames[0] FROM MYJSON j where j.doc.geonames.geonameId = '2510769';</copy>
````

![](./images/p_updateJsonDoc_3.png " ")

Take a note of the capital attribute in that document — ***"capital":"Madrid"***. There is always a solution.

### Update A Specific Value From JSON Document

2. Change that attribute on the fly — ***"capital":"Toledo"***. We can print the same result in a pretty format, just to highlight it more.

````
> <copy>SELECT json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo"}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````

![](./images/p_updateJsonDoc_4.png " ")

3. Change two attributes in that JSON document. Remember, the return value for a dot-notation query is always a string, and we can work with strings. For example we can add the first part of it, before element geonames[0], and the last part, to convert this single element back into an array, and print the resulted array in a pretty format.

````
> <copy>SELECT json_mergepatch(j.doc, '{"geonames": [' || json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo", "countryName" : "Medieval Spain"}') || ']}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````
![](./images/p_updateJsonDoc_5.png " ")

4. Further, we can add the altered element with the updated values, as an additional JSON document, to the first element with the original value. For example, we can keep our original array elements, and add new ones with new values.

````
> <copy>SELECT json_mergepatch(j.doc, '{"geonames": [' || j.doc.geonames[0] || ',' || json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo", "countryName" : "Medieval Spain"}') || ']}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````
![](./images/p_updateJsonDoc_6.png " ")

In the end, everything is possible, there are no restrictions.

### Update JSON Document Using Selected Current Value

5. In the same way, we can use the altered array with ***JSON_MERGEPATCH*** function to insert, or update, a JSON document stored inside the database.

````
> <copy>INSERT INTO MYJSON (doc) SELECT json_mergepatch(j.doc, '{"geonames": [' || j.doc.geonames[0] || ',' || json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo", "countryName" : "Medieval Spain"}') || ']}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````

In this case, we insert a new document.

## Updating A JSON Column Using JSON Merge Patch

6. You can use ***JSON_MERGEPATCH*** in an UPDATE statement, to update the documents in a JSON column. We will use the very first JSON document in our table, the one about that Oracle Workshop.

````
> <copy>select DOC from MYJSON where ID = 1;</copy>
````
![](./images/p_updateJsonDoc_7.png " ")

This is a simple JSON document, with three fields. The third field is also a collection with three fields.

### Update Specific Element In A JSON Document

7. We can update the second field, using the plain UPDATE statement and ***JSON_MERGEPATCH*** function. When running the same SELECT statement, we notice that the document is not pretty-printed any more.

````
> <copy>update MYJSON set DOC = json_mergepatch(DOC, '{"audienceType": "Developers and DBAs"}') where ID = 1;</copy>
````

````
> <copy>select DOC from MYJSON where ID = 1;</copy>
````
![](./images/p_updateJsonDoc_8.png " ")

8. You can add the ***PRETTY*** clause to the UPDATE statement, and have more clarity when returning the document from our table.

````
> <copy>update MYJSON set DOC = json_mergepatch(DOC, '{"audienceType": "Developers and DBAs"}' RETURNING CLOB PRETTY) where ID = 1;</copy>
````

````
> <copy>select DOC from MYJSON where ID = 1;</copy>
````
![](./images/p_updateJsonDoc_9.png " ")

This one looks much nicer. Remember to commit changes if you want to keep them in the database.

````
<copy>commit;</copy>
````

Updating JSON documents inside the Oracle Database is that simple.

## Step 5: JSON Materialized View Support

Materialized views query rewriting has been enhanced so that queries with ***JSON_EXISTS***, ***JSON_VALUE*** and other functions can utilize a materialized view created over a query that contains a ***JSON_TABLE*** function.

This feature is particularly useful when the JSON documents in a table contain arrays. This type of materialized view provides fast performance for accessing data within those JSON arrays.

## Materialized View With Fast Refresh For Query Rewrite

As a performance enhancement in Oracle 19c, if you create a refresh-on-statement materialized view over json_table  and some other conditions apply then a query that matches the query defining the view can be rewritten to a materialized-view table access. You can use this feature instead of creating multiple functional indexes.

### Create A Materialized View

1. Create a materialized view that will help us retrieve information about the medieval castles, using the ***ON STATEMENT*** clause. The ***ENABLE QUERY REWRITE*** clause is not mandatory, the performance enhancements apply even if it’s not specified. Notice the error and null handling is specified explicitly for each column.

````
<copy>CREATE MATERIALIZED VIEW json_castles_mv
REFRESH FAST ON STATEMENT
ENABLE QUERY REWRITE
AS
SELECT j.id jsonID, jt.geonameId ID, jt.countryName Country,
       convert(jt.adminName1,'WE8ISO8859P1','AL32UTF8') Region,
       convert(jt.adminName2,'WE8ISO8859P1','AL32UTF8') Sub_Region,
       jt.fcode, convert(jt.toponymName,'WE8ISO8859P1','AL32UTF8') Title,
       convert(jt.name,'WE8ISO8859P1','AL32UTF8') Name FROM MYJSON j,
JSON_TABLE(DOC, '$' COLUMNS
 (NESTED PATH '$.geonames[*]'
  COLUMNS (countryName VARCHAR2(80) PATH '$.countryName' ERROR ON ERROR NULL ON EMPTY,
           adminName1 VARCHAR2(80) PATH '$.adminName1' ERROR ON ERROR NULL ON EMPTY,
           adminName2 VARCHAR2(80) PATH '$.adminName2' ERROR ON ERROR NULL ON EMPTY,
           toponymName VARCHAR2(120) PATH '$.toponymName' ERROR ON ERROR NULL ON EMPTY,
           name VARCHAR2(80) PATH '$.name' ERROR ON ERROR NULL ON EMPTY,
           adminCode1 VARCHAR(8) PATH '$.adminCode1' ERROR ON ERROR NULL ON EMPTY,
           fcode VARCHAR2(6) PATH '$.fcode' ERROR ON ERROR NULL ON EMPTY,
           geonameId VARCHAR2(10) PATH '$.geonameId' ERROR ON ERROR NULL ON EMPTY)))
AS jt;</copy>
````

2. Test the materialized view with the following query. Optionally, use set timing on when running this query, and the query we used to retrieve information about castles after we retrieved all required JSON documents from the GeoNames web service, and compare the results. The difference may look insignificant, because there are only 269 castles, but imagine that we could have millions of rows in one application, and thousands of concurrent users.

````
<copy>set timing on</copy>
````

````
> <copy>SELECT Country, Region, Sub_Region, Title, Name FROM json_castles_mv WHERE fcode = 'CSTL';</copy>
````

In the following Step we will get into more details about performance.

## Performance Boost

Significant performance gains can often be achieved using query rewrite and materialized views, and in this exercise we will examine how these performance gains can be achieved without the need to change the application.

### Check Query Rewrite Mechanism

3. We will use the following SELECT statement as an example. Run this query on the database. It returns the first castle in every sub-region, so it should list 45 castles.

````
<copy>column CODE format a4</copy>
````

````
> <copy>SELECT JSON_VALUE(doc, '$.geonames[0].fcode') Code,
       JSON_VALUE(doc, '$.geonames[0].countryName') Country,
       JSON_VALUE(doc, '$.geonames[0].adminName1') Region,
       JSON_VALUE(doc, '$.geonames[0].adminName2') Sub_Region,
       JSON_VALUE(doc, '$.geonames[0].toponymName') Title,
       JSON_VALUE(doc, '$.geonames[0].name') Name
from MYJSON
  where JSON_VALUE(doc, '$.geonames[0].fcode') = 'CSTL'
  order by Region, Sub_Region;</copy>
````
![](./images/p_mvSupp_1a.png " ")

![](./images/p_mvSupp_1b.png " ")

4. Flush the shared pool, flushing the cached execution plan and SQL Queries from memory.

````
> <copy>ALTER SYSTEM FLUSH SHARED_POOL;</copy>
````

5. Display the execution plan chosen by the Oracle optimizer for this statement.

````
> <copy>EXPLAIN PLAN for
  SELECT JSON_VALUE(doc, '$.geonames[0].fcode') Code,
         JSON_VALUE(doc, '$.geonames[0].countryName') Country,
         JSON_VALUE(doc, '$.geonames[0].adminName1') Region,
         JSON_VALUE(doc, '$.geonames[0].adminName2') Sub_Region,
         JSON_VALUE(doc, '$.geonames[0].toponymName') Title,
         JSON_VALUE(doc, '$.geonames[0].name') Name
  from MYJSON
  where JSON_VALUE(doc, '$.geonames[0].fcode') = 'CSTL'
  order by Region, Sub_Region;</copy>
````

The ***DBMS_XPLAN*** package provides an easy way to display the output of the ***EXPLAIN PLAN*** command in several, predefined formats. By default, the table function ***DISPLAY*** format and display the contents of a plan table.

We can see the dot notation calls get rewritten as a ***JSON_TABLE*** call, because we can see the ***JSONTABLE EVALUATION*** step in the plan (6), and we can see the data has been returned from the ***JSON_CASTLES_MV*** materialized view (4).

````
> <copy>SELECT * FROM table(DBMS_XPLAN.DISPLAY);</copy>

Plan hash value: 3162132558

---------------------------------------------------------------------------------------------------
| Id  | Operation		| Name		  | Rows  | Bytes |TempSpc| Cost (%CPU)| Time	  |
---------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	|		  |  5146 |	9M|	  |  3915   (1)| 00:00:01 |
|   1 |  SORT ORDER BY		|		  |  5146 |	9M|    13M|  3915   (1)| 00:00:01 |
|   2 |   NESTED LOOPS		|		  |  5146 |	9M|	  |  1726   (1)| 00:00:01 |
|*  3 |    HASH JOIN RIGHT SEMI |		  |    63 |   124K|	  |	7   (0)| 00:00:01 |
|*  4 |     MAT_VIEW ACCESS FULL| JSON_CASTLES_MV |   113 |   904 |	  |	4   (0)| 00:00:01 |
|   5 |     TABLE ACCESS FULL	| MYJSON	  |    75 |   147K|	  |	3   (0)| 00:00:01 |
|*  6 |    JSONTABLE EVALUATION |		  |	  |	  |	  |	       |	  |
---------------------------------------------------------------------------------------------------
````
![](./images/p_mvSupp_2.png " ")

If the query is too simple, there may not be a query rewrite, in this case it will not be eligible to be rewritten to use the materialized view.

## Step 6: JSON-Object Mapping

This feature enables the mapping of JSON data to and from user-defined SQL object types and collections. You can convert JSON data into an instance of a SQL object type using SQL/JSON function ***JSON_VALUE***. In the opposite direction, you can generate JSON data from an instance of a SQL object type using SQL/JSON function ***JSON_OBJECT*** or ***JSON_ARRAY***.

## Create Your Own JSON Structure

We will start with the second use case, generating JSON data using SQL/JSON function ***JSON_OBJECT***. You will use the relational data from the ***JSON_CASTLES_MV*** materialized view to generate JSON documents with a customized structure.

### Insert Castles Data Using A Custom JSON Structure

1. Use this statement to generate data representing a JSON document version of a materialized view relational record.

````
> <copy>SELECT JSON_OBJECT(
               'CastleID' : id,
               'Country' : country,
               'Region' : region,
               'Sub_Region' : sub_region,
               'Name' : '"' || title || '"'
             FORMAT JSON)
  FROM json_castles_mv WHERE fcode = 'CSTL';</copy>
````
![](./images/p_jsonObject_1.png " ")

2. Some client drivers (like SQL Developer, for example) might try to scan query text and identify bind variables before sending the query to the database. In some such cases a colon as name–value separator in ***JSON_OBJECT*** might be misinterpreted as introducing a bind variable. You can use keyword VALUE as the separator to avoid this problem ('Country ' VALUE country), or you can simply enclose the value part of the pair in parentheses: 'Country':(country). Here is the same SELECT statement, that can be executed successfully in SQL Developer.

````
> <copy>SELECT JSON_OBJECT(
               key 'CastleID' value id,
               key 'Country' value country,
               key 'Region' value region,
               key 'Sub_Region' value sub_region,
               key 'Name' value '"' || title || '"'
             FORMAT JSON)
  FROM json_castles_mv WHERE fcode = 'CSTL';</copy>
````

3. These JSON documents generated from the relational data, and having a completely personalized structure, can be inserted in our table.

````
> <copy>INSERT INTO MYJSON (doc)
  SELECT JSON_OBJECT(
               'CastleID' : id,
               'Country' : country,
               'Region' : region,
               'Sub_Region' : sub_region,
               'Name' : '"' || title || '"'
             FORMAT JSON)
  FROM json_castles_mv WHERE fcode = 'CSTL';</copy>
````

````
> <copy>COMMIT;</copy>
````
![](./images/p_jsonObject_2.png " ")

4. Run the following select to verify the inserted documents, and observe these are individual JSON objects, describing each medieval castle, from the 269 entries we have in this database.

````
> <copy>SELECT j.id, JSON_SERIALIZE(j.doc PRETTY) FROM myjson j WHERE j.doc."CastleID" is not null;</copy>
````

![](./images/p_jsonObject_3.png " ")

Observe the structure, and values, in these JSON documents. Note it is easier for our Tourist Recommendations application to list these castles for our end users.

## JSON To User-Defined Object Type Instance

Conversely, you can convert JSON documents to a user-defined object type.

### Create A New Type And Retrieve Data

5. We can create object types that may not match the JSON data in the table. One with all attributes, and another one with fewer attributes than the JSON data available in the database. Create a new type with all the attributes of our JSON documents.

````
> <copy>CREATE TYPE t_castle AS OBJECT (
  "CastleID"  NUMBER(10),
  "Country"  VARCHAR2(10),
  "Region"  VARCHAR2(120),
  "Sub_Region"  VARCHAR2(120),
  "Name"  VARCHAR2(120)
  );
/
</copy>
````

6. Now convert the JSON data to an instance of a SQL object type using the SQL/JSON function ***JSON_VALUE***. This can be done in just one query.

````
> <copy>SELECT JSON_VALUE(j.doc, '$' RETURNING t_castle) AS castle FROM myjson j WHERE j.doc."CastleID" is not null;</copy>
````
![](./images/p_jsonObject_4.png " ")

In Oracle Database 19c, the function ***JSON_VALUE*** also accepts an optional ***RETURNING*** clause, apart from the optional ERROR clause we tested already. In this case, the ***JSON_VALUE*** function uses the user-defined object type in the ***RETURNING*** clause, and returns the instantiated object type from a query, based on the data in the source JSON document.

### Use Multiple Types For Same Data

7. Create another object type that doesn’t match the JSON data in our documents. This object type gives a simplified version of the JSON structure, using only two attributes. Imagine we have a list of all medieval castles in our application, and we just want to display the names, using the ID as a reference. In this case don’t want to use memory for attributes that we don’t use, and a simpler object type would do the job.

````
> <copy>CREATE TYPE t_castle_short AS OBJECT (
  "CastleID"  NUMBER(10),
  "Name"  VARCHAR2(120)
  );
/
</copy>
````

8. Review the results of this query, compared with the previous one, and check the differences.

````
> <copy>SELECT JSON_VALUE(j.doc, '$' RETURNING t_castle_short) AS castle FROM myjson j WHERE j.doc."CastleID" is not null;</copy>
````
![](./images/p_jsonObject_5.png " ")

These custom object types can be used to optimize our applications, directly from the database layer.

### Create A Table With Columns Of Custom Type

9. Custom object types can be used also as for table columns. Create this new table, with one single column, of a custom type.

````
> <copy>CREATE TABLE mycastles ( castle t_castle );</copy>
````

10. Insert into the new table the information about our all 269 medieval castles.

````
> <copy>INSERT INTO mycastles
  SELECT JSON_VALUE(j.doc, '$' RETURNING t_castle) AS castle
  FROM myjson j WHERE j.doc."CastleID" is not null;</copy>
````

````
> <copy>COMMIT;</copy>
````

11. Select all 269 records from the new table, returned as user-defined SQL objects.

````
> <copy>SELECT * FROM mycastles;</copy>
````
![](./images/p_jsonObject_6.png " ")

Now we have just the castles in a new table, with the attributes we need in our application.

## User-Defined Object Type Instance To JSON

It would be equally easy to convert user-defined SQL object type instances into JSON documents.

### Convert To JSON A Custom Type

12. Using the ***JSON_OBJECT*** function, we can retrieve the JSON representation of this data, stored using the user-defined object types, from our new table.

````
> <copy>SELECT JSON_OBJECT(castle) AS castle FROM mycastles;</copy>
````
![](./images/p_jsonObject_7.png " ")

In this case our application uses JSON format, and you can make this conversion on the fly from the SELECT statement.

### Use Pretty Format

13. The pretty format may help you to better understand the output.

````
> <copy>SELECT JSON_SERIALIZE( JSON_OBJECT(castle) PRETTY) AS castle FROM mycastles;</copy>
````
![](./images/p_jsonObject_8.png " ")

This is a very simple example, and it is not totally necessary, but imagine you have JSON documents with hundreds of attributes.

### Group Custom Format Values In Array

14. The ***JSON_ARRAY*** function will also convert user-defined object type instances to JSON. In the following example we create a JSON array for each row, containing the castle ID number for reference, and the JSON representation of the castle row retrieved from the user-defined object type.

````
> <copy>SELECT JSON_ARRAY(c.castle."CastleID", castle) AS castle FROM mycastles c;</copy>
````
![](./images/p_jsonObject_9.png " ")

The output is a collection with two records, having a valid JSON structure.

### Use Pretty Format For Array

15. As before, the pretty format could be useful in understanding the output.

````
> <copy>SELECT JSON_SERIALIZE( JSON_ARRAY(c.castle."CastleID", castle) PRETTY) AS castle FROM mycastles c;</copy>
````
![](./images/p_jsonObject_10.png " ")

We hope you enjoyed this lab.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Troy Anthony, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
---
