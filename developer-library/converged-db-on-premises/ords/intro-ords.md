# Workshop Introduction and Overview 

## Introduction to ORDS

ORDS is a Java application that enables developers with SQL and database skills to develop REST APIs for the Oracle Database, the Oracle Database 12c JSON Document store, and the Oracle NoSQL Database. Any application developer can use these APIs from any language environment, without installing and maintaining client drivers, in the same way they access other external services using the most widely used API technology: REST. 

For more info see this blog post - https://www.oracle.com/tools/technologies/faq-rest-data-services.html

![](./images/ords1.png " ") 

## Install ORDS using SQL Developer

Oracle REST Data Services (ORDS) is bundled with SQL Developer. You can use SQL Developer to install the ORDS version that is bundled in SQL Developer or a standalone version.

As part of this lab , ORDS is pre-installed and ready for use.

## About RESTful Services 

Representational State Transfer (REST) is a style of software architecture for distributed hypermedia systems such as the World Wide Web. A service is described as RESTful when it conforms to the tenets of REST.  RESTful Service has the following characteristics: 

•	Data is modeled as a set of resources. Resources are identified by URIs. 

•	A small, uniform set of operations are used to manipulate resources (for example, GET, POST, PUT, DELETE). 

•	A resource can have multiple representations (for example, a blog might have a HTML representation and a RSS representation). 

•	Services are stateless and since it is likely that the client will want to access related resources, these should be identified in the representation returned, typically by providing hypertext links. 


## RESTful Services Terminology 

Common terms that are used throughout this lab: 

- **RESTful Service** : An HTTP web service that conforms to the tenets of the RESTful Architectural Style, as described in "About RESTful Services" above. 

- **Resource Module** : An organizational unit that is used to group related Resource Templates together. 

- **Resource Template** : An individual RESTful ervice that is able to service requests for some set of URIs (Universal Resource Identifiers). The set of URIs is defined by the URI Template of the Resource Template.

- **Route Patterns**: A simple grammar that defines the particular patterns of URIs that a given Resource Template can handle. For example, the pattern, employees/, will match any URI whose path begins with employees/. 

Example: http://localhost:8888/ords/hr/demo/employees/ 

- **Resource Handler** : Provides the logic required to service a particular HTTP method, for a specific Resource Template. For example the logic of the GET HTTP method for the above Resource Template might be:

select empno, ename, dept from emp where empno = :id

**HTTP Operation**: HTTP (HyperText Transport Protocol) defines a number of standard methods that can be performed on resources:

-	**GET** : Retrieve the resource contents. 
-	**POST** : Store a new resource.
-	**PUT** : Update an existing resource. 
-	**DELETE** : Remove a resource. 

## Step-1: Start ORDS in standalone mode

1. To start ORDS in standalone mode, go to 
   
   Tools-> Rest Data Services->Run
2. Select ORDS file as –"/u01/app/oracle/product/19c/db_1/ords/ords.war"
  
3.	Then provide ORDS config file location as – “/u01/app/oracle/product/19c/db_1/ords/config”

4.	Click on **Next**.
  
    ![](./images/ords_lab1_snap1.png " ") 

5.	Checkbox the option “Run in Standalone mode when installation completes” and enter Http Port: **9090**.
  
   ![](./images/ords_lab1_snap2.png " ") 

6.	Click on **Next**. 

7.	On ORDS installation summary page , click on **Finish**.

    ![](./images/ords_lab1_snap3.png " ") 

8.	Below snippet shows the log that ORDS is started.

    ![](./images/ords_lab1_snap4.png " ") 

## Step-2: Check if ORDS is connecting through the browser

Open the browser and enter the following URI in the address bar:

````
<copy>
http://&lt;Instance_ip_address&gt:9090/ords/
</copy>
````

If you see **ORACLE REST DATA SERVICES 404 Not Found**, it means that **ORDS** is connected. 

   ![](./images/ords_lab1_snap5.png " ")

## ORDS Video
  
  [](youtube:rvxTbTuUm5k)
  

## Want to learn more
- [ORDS](https://www.oracle.com/in/database/technologies/appdev/rest.html)

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
      

