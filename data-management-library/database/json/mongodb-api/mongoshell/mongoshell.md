# Using Mongo Shell with Autonomous Database

## Introduction

In this lab, we are going to connect to the Autonomous Database we provisioned in Lab 2, from the MongoDB shell tool that we installed into our Compute node in Lab 1.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

* Start up Cloud Shell
* Connect to our Compute Node
* Attach __mongosh__ to your Autonomous JSON Database
* Create a collection
* Add some simple documents to that collection

### Prerequisites

* Have provisioned an Autonomous JSON Database instance and saved the URLs for Database API for MongoDB.
* Have provisioned a Compute Node and installed the MongoDB Shell

You will need the following information, saved from previous labs:

* The URLs for the MongoDB API
* The IP address of your Compute Node

## Task 1: Start Cloud Shell

Cloud Shell is a Linux command prompt provided for your user. You can upload files to it and run commands from it.

1. Go to the main Oracle Cloud page (you may need to close any Service Console or Database Actions tabs that you have open). Click on the square icon with ">" in it at the top right.

	![](./images/open-console.png)

2. The console will open at the bottom of your screen. You should see a Linux command prompt. If you wish, you can expand the console window to fill your browser screen by clicking on the diagonal double-arrow. You can resize the font if needed using your browser's normal zoom operation (e.g. CMD-+ on a Mac)

	![](./images/cloud-shell.png)

## Task 2: Connect to your Compute Node

1. The key file should be in your current directory.

    As before, we will use ssh to connect to our Compute Node. We will need to know the name of the ssh file we just uploaded, and the IP address of the 
    Compute Node that we saved earlier. Run the following command, altering the file name and IP address (shown as 11.22.33.44) as necessary. 
    "opc" is the pre-installed username for the node and should not be changed. You may find that the necessary 'ssh' command is saved in your command history, accessed by the up-arrow key. 

    ```
    <copy>
    ssh -i ssh-key-YYYY-MM-DD.key opc@11.22.33.44
    </copy>
    ```

## Task 3: Edit the connection URL and use it to connect MongoDB shell to Autonomous Database

**NOTE** Maybe this could be two tasks - the title is too long as it is!

1. Find the URL you saved earlier and edit it in a text editor

	* Change the [user:password@] to admin:YourPassword@ at the start of the URL. Substitute the password you chose earlier for the YourPassword.
	* Change the [user] string in the middle to admin

   	For example, let's say your password is "Password123", and your original connection string is mongodb://[user:password@]MACHINE-JSONDB.oraclecloudapps.com:27017/[user]?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true

	You would change it to 

	```
	<copy>
	mongodb://admin:Password123@MACHINE-JSONDB.oraclecloudapps.com:27017/admin?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true
    </copy>
	```

	Make sure you've changed both strings, and have not left any square brackets in there.

	**IMPORTANT NOTE:** if your password contains any special characters in the set / : ? # [ ] @, you will need to escape them as follows:

	* /	  %25
	* :	  %3A
	* #	  %23
	* [	  %5B
	* ]   %5D
	* @	  %40

	So if your password was **P@ssword#123** you would encode it as **P%40ssword%23123**.

2. In the ssh shell prompt, enter "mongosh" followed by a space followed the first edited URL (the one with 27017 in it) in **single-quotes**.

	![](./images/mongosh-login.png)

	If all goes well you will see an "admin>" prompt. If not, check your URL carefully:

	* Is it enclosed in single quotes?
	* Is your password correct, with any special characters quoted as above?
	* Did you leave any [ square brackets ] in the URL where they should have been removed?
	* Do you have the : sign between the user and password, and the @ sign after the password? 
	* Is the whole commamd on a single line with no line breaks?

## Task 4: Create, populate and search a collection

You should now be in Mongo Shell. This is a command-line utility to interact with MongoDB databases (and, by extension, any other database which implements the MongoDB API). Other tools are available such as the graphical Compass tool, but we will stick with the command line to avoid complexities of installing a GUI-based tool.

1.  Create a collection.

	Copy the following into mongosh and press the enter key.

	```
	<copy>
	db.createCollection('emp')
    </copy>
	```
    ![](./images/create-collection.png)

	That will have created a new document collection called "emp". If you wish, you can type "show collections" to confirm it has been created.

2.	Add some employee documents to the collection.

	Copy the following into mongosh:

	```
	<copy>
	db.emp.insertOne(
  		{ "name":"Blake", "job": "Intern", "salary":30000 }
	)
	</copy>
	```

	That created a single employee record documemt. Now we'll create another two. Notice that the second one has an email address, which the first doesn't. With JSON we can change the schema at will.

	```
	<copy>
	db.emp.insertOne(
		{ "name":"Smith", "job": "Programmer", "salary": 60000, "email" : "smith@example.com" }
	)
	</copy>
	```

	```
	<copy>
	db.emp.insertOne(
		{ "name":"Miller", "job": "Programmer", "salary": 70000 }
	)	
	</copy>
	```
3.	Do some searches against the data we just inserted

	Queries in MongoDB (and most JSON databases) use '**Query By Example**' or **QBE**. For a simple QBE, you provide a JSON document fragment, and the system returns all documents that contain that fragment. For example:

	```
	<copy>
 	db.emp.find({"name":"Miller"})
	</copy>
	```

	will return all documents which have a name field of "Miller". Try it now.

	A more advanced QBE will use special match operators. For example, **$gt** means "greater than". So:

	```
	<copy>
	db.emp.find({"salary":{"$gt":50000}}) 
	<copy>
	```

	will find all documents where the salary field is numeric, and contains a value greater than 50,000.

    ![QBE to find salary greater than 50000](./images/find-salary.png)

**Note** the LiveLab basically follows my Blog from this point on: (https://blogs.oracle.com/database/post/mongodb-api)[https://blogs.oracle.com/database/post/mongodb-api].  The next lab should be Database Actions where we view the data we have created in JSON, and then SQL.

After that, we can consider adding a more advanced section where we load some significant amount of data using mongoimport, and do some more advanced queries, including graphs.

## Acknowledgements

- **Author** - Roger Ford, Principal Product Manager
- **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
- **Last Updated By/Date** - Anoosha Pilli, Brianna Ambler, June 2021
