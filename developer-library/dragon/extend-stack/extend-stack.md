# Extend your first React Web Application using the DRAGON Stack

## Introduction

In the previous lab, you've installed the DRAGON Stack manager, provisioned an Autonomous Database and created your very first application stack: a React frontend.

In this lab, you'll extend your application using DRAGON Stack **overrides**. Indeed, while you can create basic stacks, you can also extend them with existing code samples.
Let's see how this works!

Estimated Lab Time:  10 minutes

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **STEP 1**: Prepare your dragon.config file

This second lab, will contain some JSON data. These data will be loaded later into the `purchase_orders` collection.

Hence, in order to automate the loading process using DRAGON, you'll need to add inside your `dragon.config` configuration 
file another collection to the list of managed collections:
```
<copy>
database_collections=employees,purchase_orders
</copy>
```

## **STEP 2**: Override your existing React stack 

Overriding basic stacks is really easy, you'll need to position yourself inside the parent directory of your stack folder (default being: `frontend`) and run the following comand:
 ```
$ <copy>./dragon-linux-x86_64-2.1.1 -create-react-app#lab2</copy>
```

![Override the React frontend with the Lab2 using the DRAGON Stack manager](images/frontend-override.png)

### Details
Running this command will modify your `frontend` folder content by downloading all the required files for this Lab.  

In details, it will:
- download the purchase_orders.json file that contain the data set will work with
- download and overwrite the package.json file adding some new dependencies to display a nice looking React component: a Table
- download and overwrite the src/App.js file to add new code and display the JSON data (once loaded) inside a table
- download and overwrite the src/ORDS.js file to add a new function used to load (using pagination) the JSON data

## **STEP 3**: Run the provided commands to update the stack
Following the previous step, the DRAGON Stack manager advises for some commands to run. Basically, this consists of loading the JSON data:
```
$ <copy>./dragon-linux-x86_64-2.1.1 -loadjson</copy>
```
updating the Node.js dependencies:
```
$ <copy>npm install</copy>
```
and finally start the frontend:
```
$ <copy>npm start &</copy>
```

## Learn More

* [Oracle REST Data Services](https://www.oracle.com/database/technologies/appdev/rest.html)
* [DRAGON Project (GitHub)](https://bit.ly/DRAGONStack) and add a star :)

## Acknowledgements
* **Author** - Loic Lefevre, Principal Product Manager
* **Last Updated By/Date** - Loic Lefevre, Database Product Management, June 2021

![DRAGON Stack logo](./images/dragon-logo.png)

