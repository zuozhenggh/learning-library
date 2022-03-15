# Working with JSON collections using the SODA (Simple Oracle Document Access) API

## Introduction

In this lab, we are going to download a standard MongoDB tool: __mongosh__ and use it to access Autonomous Database to create collections and documents.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

* Start up Cloud Shell
* Install __mongosh__ in Cloud Shell
* Attach __mongosh__ to your Autonomous JSON Database
* Create a collection
* Add some simple documents to that collection

### Prerequisites

* Have provisioned an Autonomous JSON Database instance and saved the URLs for Database API for MongoDB.

## Task 1: Start Cloud Shell

Cloud Shell is a Linux command prompt provided for your user. You can upload files to it and run commands from it.

1. Go to the main Oracle Cloud page (you may need to close the Service Console browser tab if you still have it open). Click on the square icon with ">" in it at the top right.

	![](./images/open-console.png)

2. The console will open at the bottom of your screen. It may take a minute or so to do so first time round. You should see a Linux command prompt. If you wish, you can expand the console window to fill your browser screen by clicking on the diagonal double-arrow. You can resize the font if needed using your browser's normal zoom operation (e.g. CMD-+ on a Mac)

	![](./images/cloud-shell.png)

## Task 2: Download and install mongosh

1. In a new browser tab, open the following link: https://www.mongodb.com/try/download/shell (note: this page belongs to MongoDB and may change - Oracle Corporation is not responsible for the page or any programns downloaded from it).

	In the Available Downloads box, leave the Version as it is and change Platform to __Linux Tarball 64-bit__. Click the __Copy Link__ button

	![](./images/mongo-download.png)

2. Go back to the cloud shell and type "wget" followed by the link you just copied

	![](./images/wget-mongosh.png)

3. This willl download a compressed tar file which you will need to unzip. Do that with "tar xvf" followed by the name of the downloaded file. In my case, this would be "tar xvf mongosh-1.2.3-linux-x64.tgz" but it may change with newer versions.

	![](./images/unzip.png)

4. Finally set the PATH variable so it includes the mongosh executable.

	The PATH variable must include the 'bin' directory, which you can see in the output from the unzip command. Don't forget to include the existing path at the end with :$PATH. In my case the command is as below, but the directory may change for newer versions of mongosh.

	```
	<copy>
	export PATH=mongosh-1.2.3-linux-x64/bin:$PATH
	</copy>
	```

	![](./images/save-path.png)

	Note: If you close and reopen the Cloud Shell you will need to repeat this step to set the PATH. To avoid that you can add the SET PATH 

## Task 4: Start Mongo Shell and create a collection

Mongo Shell is a command-line utility to interact with MongoDB databases (and, by extension, any other database which implements the MongoDB API). Other tools are available such as the graphical Compass tool, but we will stick with the command line to avoid complexities of installing a GUI-based tool.

1. Go back to where you saved the URLs for the Database API for MongoDB in the previous lab. Edit each URL, replacing *[user]* with *admin* (without the brackets) and *[user:password@]* with *admin:password@* where password is the password you provided earlier for the admin user for your database.

	For example, if your first URL is mongodb://[user:password@]myserver.oraclecloudapps.com:27017/[user]?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true and your admin password is "password1":

	You would modify it to read

	mongodb://admin:password1@myserver.oraclecloudapps.com:27017/admin?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true
 
2.  In the cloud shell, enter "mongosh" followed by the first modified URL in single quotes

	![](./images/id101.png)
	![](./images/id101-results.png)

3.	Find all DVDs:

	Running the query will displays two documents with format DVD.

	```
	<copy>
	{"format":"DVD"}
	</copy>
	```
	![](./images/dvd-results.png)

4.	Find all non-movies:

	This query displays the documents that are not of type - movies, which means just the document with id 103.

	```
	<copy>
	{"type":{"$ne":"movie"}}
	</copy>
	```
	![](./images/not-movies.png)

5.	Find documents whose condition value contains "new", which means just document (with id) 101.

	```
	<copy>
	{"condition":{"$like":"%new%"}}
	</copy>
	```
	![](./images/new.png)

6. Find bargains of all products costing 5 or less:

	This query displays the documents with ids 100, 102 and 103 as those documents have price less than 5.

	```
	<copy>
	{"price":{"$lte":5}}
	</copy>
	```
	![](./images/less5.png)

7. Tighten previous query to choose only movie documents:

	This query displays the documents whose ids are 100, 102 as those documents have price less than 5 and not the type - book.

	```
	<copy>
	{"$and":[{"price":{"$lte":5}}, {"type":"movie"}]}
	</copy>
	```
	![](./images/less5-movie.png)

## Task 4: JSON and Constraints

Some values need to be unique, so how do we enforce this?

1.	Insert a duplicate document for the id - 100:

	Click New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	The document is successfully inserted as duplicate id's are not prevented and JSON database is schemaless.

	```
	<copy>
	{
		"id": 100,
		"fruit": "banana"
	}
	</copy>
	```
	![](./images/step4.1.png)

2. Use QBE:

	Copy and paste the following query in the worksheet and click **Run Query**.

	The result now shows two documents with id 100.

	```
	<copy>
	{"id":100}
	</copy>
	```

	![](./images/id100-2.png)

	Let's delete the {id:100, fruit:banana} last inserted document by clicking on the trash bin button.

	![](./images/delete_document.png)

	It is likely we are looking up products by their id. Let's a create an index that gives fast access to 'id'. Make sure id is unique and numeric.

	Now we use a field 'id' in the JSON document to identify the product. The value could also be a SKU (barcode) or some catalog number. Obviously, every product needs an id and we want this to be a unique numeric value across all documents in the collection. Also, we want to be able to quickly find a product using the id value. So, let's create a unique index that solves all requirements (unique, numeric, present).

3.	Let's navigate to SQL Developer Web. Click the navigation menu on the top left and select **SQL** under Development.

	![](./images/sql-dw.png)

4. Copy and paste the query below in the worksheet and click Run query button to creates a unique index that solves all requirements (unique, numeric, present).

	```
	<copy>
	create unique index product_id_idx on products (JSON_VALUE(json_document, '$.id.number()' ERROR ON ERROR));
	</copy>
	```
	![](./images/index.png)

	JSON_Value is a SQL/JSON function that extracts one value from the JSON data that is specified by a JSON Path Expression - in this case we extract the 'id' and convert the selected value to a SQL number. Here, *$.id.number()* is a standard, SQL/JSON path expression. You'll learn more about SQJ/JSON functions later in this lab.

	*Learn more -* [SQL/JSON Path Expressions](https://docs.oracle.com/en/database/oracle/oracle-database/21/adjsn/json-path-expressions.html#GUID-2DC05D71-3D62-4A14-855F-76E054032494)

5.	Once the product\_id\_idx is created, navigate back to JSON workshop. Click the navigation menu on the top left and select **JSON** under Development.

	![](./images/json-nav.png)

6.	Try to insert some documents that do not have an id or a non-numeric id:

	Click New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	Although the "id" is unique the insert fails throws the error "Unable to add new JSON document" because the value is not a number. The same happens if the id is missing or already in use. Try it!

	```
	<copy>
	{"id":"xxx","title":"Top Gun"}
	</copy>
	```
	![](./images/create-error.png)
	![](./images/error.png)

7.  While we're at it lets add more 'checks' - we call them 'constraints'. Navigate back to the SQL Developer Web. Click the navigation menu on the top left and select **SQL** under Development.

	![](./images/nav.png)

8. Check constraint to make sure every product has a title of string data type and price >=0. Add a constraint to make sure that every item has at least a title and the price. We want the price to be a non-negative number and title to be a string.

	Copy and paste the query below in the worksheet and click Run query button to run the SQL query to alter products table and add constraints.

	```
	<copy>
	alter table products add constraint required_fields check (JSON_EXISTS(json_document, '$?(@.title.type() == "string" && @.price.number() > 0)'));
	</copy>
	```
	![](./images/sql-query.png)

	JSON_Exists is a SQL/JSON function that checks that a SQL/JSON path expression selects at least one value in the JSON data. The selected value(s) are not extracted – only their existence is checked. Here, *$?(@.title.type() == "string" && @.price.number() > 0)* i a standard, SQL/JSON path expressions. You'll learn more about SQJ/JSON functions later in this lab.

9. Once the *products* table is altered, navigate back to JSON workshop. Click the navigation menu on the top left and select **JSON** under Development.

	![](./images/nav2-json.png)

10. Validate that the following documents cannot get inserted as fields are missing or of wrong type.

	Click New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	Throws the error "Unable to add new JSON document" since the following document has missing fields while trying to insert.

	```
	<copy>
	{"id":"200","title":"Top Gun"}
	</copy>
	```
	![](./images/tester.png)
	![](./images/error2.png)

11. The following document now satisfies all the constraints: the "id" is a unique number, the title is a string, and the price is a positive number.

	```
	<copy>
	{
		"id": 200,
		"title": "Top Gun",
		"category": "VHS",
		"condition": "like new",
		"price": 8,
		"starring": [
			"Tom Cruise",
			"Kelly McGillis",
			"Anthony Edwards",
			"Val Kilmer"
		],
		"year": 1986,
		"decade": "80s"
	}
	</copy>
	```

You may now proceed to the next lab.

## Learn More

* [Creating B-Tree Indexes for JSON_VALUE](https://docs.oracle.com/en/database/oracle/oracle-database/21/adjsn/indexes-for-json-data.html#GUID-FEE83855-780A-424B-9916-B899BFF2077B)

## Acknowledgements

- **Author** - Beda Hammerschmidt, Architect
- **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
- **Last Updated By/Date** - Anoosha Pilli, Brianna Ambler, June 2021
