# Workshop Introduction and Overview

## Introduction to Oracle Node.js 

Node.js is an open-source and cross-platform JavaScript runtime environment. It runs the V8 JavaScript engine, outside of the browser. This allows Node.js to be very performant.

A Node.js app is run in a single process, without creating a new thread for every request. Node.js provides a set of asynchronous I/O primitives in its standard library that prevent JavaScript code from blocking and generally, libraries in Node.js are written using non-blocking paradigms, making blocking behavior the exception rather than the norm. 

When Node.js needs to perform an I/O operation, like reading from the network, accessing a database or the filesystem, instead of blocking the thread and wasting CPU cycles waiting, Node.js will resume the operations when the response comes back.

**Why Node.js?**

  Node.js uses asynchronous programming!
-	A common task for a web server can be to open a file on the server and return the content to the client.
-	how Node.js handles a file request:
	     Sends the task to the computer's file system.
         Ready to handle the next request.
         When the file system has opened and read the file, the server returns the content to the client.
         
-	Node.js eliminates the waiting, and simply continues with the next request.
-	Node.js runs single-threaded, non-blocking, asynchronously programming, which is very memory efficient.

**What Can Node.js Do?**
-	Node.js can generate dynamic page content
-	Node.js can create, open, read, write, delete, and close files on the server
-	Node.js can collect form data
-	Node.js can add, delete, modify data in your database

**Download Node.js**

   The official Node.js website has installation instructions for Node.js: https://nodejs.org

**A Vast Number of Libraries**
   Npm with its simple structure helped the ecosystem of Node.js proliferate, and now the npm registry hosts over 1,000,000 open source packages you can freely use.

 **Watch the video below for an overview of Oracle Node.js**

  
 [](youtube:zQtRwTOwisI)

## Product Pages

- [Node-js Link](https//nodejs.org/en/)
- [Node-js for oracle Linux](https//yum.oracle.com/oracle-linux-nodejs.html)
  
- [Node-js Driver](https//oracle.github.io/node-oracledb/)
- [Oracle Instant Client](https//www.oracle.com/in/database/technologies/instant-client/downloads.html)
- [Docker](https//www.docker.com/)
- [Oracle Database 19c](https//www.oracle.com/database/)

- [Postman](https//www.postman.com/)

- [I have a Freetier or Oracle Cloud account](https://oracle.github.io/learning-library/data-management-library/database/multitenant/freetier/index.html)
- [I have an account from Livelabs](https://oracle.github.io/learning-library/data-management-library/database/multitenant/livelabs/index.html)


## Get an Oracle Cloud Trial Account for Free!
If you don't have an Oracle Cloud account then you can quickly and easily sign up for a free trial account that provides:
-	$300 of freee credits good for up to 3500 hours of Oracle Cloud usage
-	Credits can be used on all eligible Cloud Platform and Infrastructure services for the next 30 days
-	Your credit card will only be used for verification purposes and will not be charged unless you 'Upgrade to Paid' in My Services

Click here to request your trial account: [https://www.oracle.com/cloud/free](https://www.oracle.com/cloud/free)

 

## Acknowledgements

- **Authors/Contributors** - Arvind Bhope,Venkata Bandaru,Ashish Kumar,Priya Dhuriya , Maniselvan K.

- **Last Updated By/Date** - Laxmi A, kanika Sharma May 2020

- **Workshop Expiration Date**


### Issues?
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.


