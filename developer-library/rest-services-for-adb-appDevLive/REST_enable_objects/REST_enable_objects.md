# Modern App Dev with Oracle REST Data Services - Loading Data and Creating Business Objects

## Introduction

In this lab you will use Database Actions to REST enable your function and a custom SQL Statement.

Estimated Lab Time: 10 minutes

#### About RESTful Web Services

Representational State Transfer (REST) is a style of software architecture for distributed hypermedia systems such as the World Wide Web. An API is described as RESTful when it conforms to the tenets of REST. Although a full discussion of REST is outside the scope of this document, a RESTful API has the following characteristics:

- Data is modeled as a set of resources. Resources are identified by URIs.
- A small, uniform set of operations are used to manipulate resources (for example, PUT, POST, GET, DELETE).
- A resource can have multiple representations (for example, a blog might have an HTML representation and an RSS representation).
- Services are stateless and since it is likely that the client will want to access related resources, these should be identified in the representation returned, typically by providing hypertext links.

#### RESTful Services Terminology

This section introduces some common terms that are used throughout this lab:

**RESTful service**: An HTTP web service that conforms to the tenets of the RESTful architectural style.

**Resource module**: An organizational unit that is used to group related resource templates.

**Resource template**: An individual RESTful service that is able to service requests for some set of URIs (Universal Resource Identifiers). The set of URIs is defined by the URI Pattern of the Resource Template

**URI pattern**: A pattern for the resource template. Can be either a route pattern or a URI template, although you are encouraged to use route patterns.

**Route pattern**: A pattern that focuses on decomposing the path portion of a URI into its component parts. For example, a pattern of /:object/:id? will match /emp/101 (matches a request for the item in the emp resource with id of 101) and will also match /emp/ (matches a request for the emp resource, because the :id parameter is annotated with the ? modifier, which indicates that the id parameter is optional).

**URI template**: A simple grammar that defines the specific patterns of URIs that a given resource template can handle. For example, the pattern employees/{id} will match any URI whose path begins with employees/, such as employees/2560.

**Resource handler**: Provides the logic required to service a specific HTTP method for a specific resource template. For example, the logic of the GET HTTP method for the preceding resource template might be:
    ```
    select empno, ename, dept from emp where empno = :id
    ```
**HTTP operation**: HTTP (HyperText Transport Protocol) defines standard methods that can be performed on resources: GET (retrieve the resource contents), POST (store a new resource), PUT (update an existing resource), and DELETE (remove a resource).


### Objectives

- Load a CSV of over 2 million rows into the CSV_DATA table
- Create PL/SQL business objects in the database

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- Completed the User Setups Lab
- Completed the Create and auto-REST enable a table lab
- Completed the Loading Data and Creating Business Objects Lab

## **STEP 2**: REST Enable a custom SQL Statement

**If this is your first time accessing the REST Workshop, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

1. Start by using the Database Actions Menu in the upper left of the page and select REST

    ![DB Actions Menus, choose REST](./images/rest-1.png)

2. Once on the REST page, use the upper tab bar to select **Modules**

    ![REST Tab Menu, choose Modules](./images/rest-2.png)

3. On the Modules page, left click the **+ Create Module** button in the upper right.

    ![Left click the + Create Modules button](./images/rest-2.png)

4. 







## Conclusion

In this lab, you loaded over two million rows into a table with curl and REST as well as added business logic to the database.

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - April 2021
- **Workshop Expiry Date** - April 2022