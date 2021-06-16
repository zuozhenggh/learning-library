# Put it all together in one single application [Work in progress]

## Introduction

TBD

![architecture diagram](./images/architecture-diagram.png)

Estimated Lab Time: TBD

### Objectives
* Download the code of the full Skillset Tracking application.
* Provision all the needed OCI resources to run the code.
* Learn how to connect the modules into one single application.

### Prerequisites
* An OCI Account.
* A tenancy where you can provision all the resources in the architecture diagram above.
* **Lab 3: Install and prepare prerequisites**.
* **Lab 4: Autonomous JSON Database & SODA Collections**.


## **Step 1:** Download the full Skillset Tracking application code
Before proceeding, you must first download the zip file with the code that can be found [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/FCkf-hjTxrlpKNHF9Y-Ofpfg35DTBsOQDalozYSjvK_JfH98sdytIR8ZgF0Cr5GN/n/c4u03/b/labfiles/o/SkillsetTrackerApplicationCode.zip). After downloading, you can unzip the archive.

In the _SkillsetTrackerApplicationCode_ directory you can find two folders:

* ***API*** - The code containing the APIs that make calls to the database for various operations. This is an extended version of the code you built in **Lab 6: Build NodeJS APIs to make calls to the database** and is needed for **Step 2** in this Lab.

* ***OJET*** - The code containing the interface of the Skillset Tracking application, built using OracleJET. This is an extended version of the application you built in **Lab 5: Build an OracleJET Web Application** and is needed for **Step 3** in this Lab.


## **Step 2:** Create NodeJS API instance and run the code

1. The first thing that you need to do is to go through the first step in **Lab 5: Build an OracleJET Web Application**, **Creating a Virtual Cloud Network**.

2. After your VCN is properly set up, you can proceed creating and configuring a new Linux Instance as described in **Lab 6: Build NodeJS APIs to make calls to the database** -> **Steps 1, 2, and 3**.

3. Now, before copying the code to the instance and running it, let's understand what all the files in this project are. Note that some of them were already explained in more detail in **Lab 6: Build NodeJS APIs to make calls to the database**.
    * **package.json** file - This file contains all the needed NodeJS packages that will be downloaded & installed by the ``npm install`` command.
    * **config** folder - The two files in the config folder are meant to set up the default configuration for the entire application.
        * **database.js** - Sets up the configuration for making the connection to the database. Here you can set up the database user and password, the connection string used, as well as the database name. Notice that the values for these variables are not hardcoded and they are read from the _.env_ file.
        * **web-server.js** - sets up the port on which the web server would run on. In this case, 8000, but any other port can be used.
    * **services** folder - In the services folder there are three files which will do most of the work in this project.
        * **web-server.js** - Has two main functions defined in it:
            - _initialize()_ – used to run the web server on the port that was set in the _config/web-server.js_ file. Here it’s also set up the path for the API calls to the database, so that all the paths will look similar.
            - _close()_ – used to close the web server.
        * **skills-jsondb.js** - Has 7 main functions as described below. This code is mainly using SODA for NodeJS functionalities for opening the document collections and for manipulating the data existing in these collections.
            - _initialize()_ – this function opens the connection to the database, as well as the document collections that currently exist in the database and are going to be used in the application.
            - _close()_ – function used to close the connection to the database.
            - _get()_ – this is the most used function in the entire application and it’s making a call to the database to get the data from the document collection, based on the two parameters: _qbe_ (the query condition, which is written and formatted according to the documentation for SODA calls for NodeJS; if this parameter is _null_, the function will retrieve all the data in the collection) and _coll_name_ (which represents the name of the collection for which the calls are made).
            - _getByQuery()_ – this function is making calls to get data from the database based on simple queries which are not using SODA calls (ex. simple ‘select’ statement queries).
            - _update()_ – this function is used to update (replace) an existing document in a collection with a new one by using SODA for NodeJS and based on an existing ID which is sent as a parameter of the function.
            - _create()_ – this function is used to create a new document in a collection.
            - _remove()_ – this function is used to remove an existing document from a collection, based on the unique ID sent as a parameter in the function.
        * **api_router.js** - Sets up the routes for making the calls to the database. Currently this project has 36 routes which are described in the table that can be found in the ***Annexes*** section of this Lab. In order to make it easier to build the query for making the SODA calls, there are several functions that will either dynamically build the query or filter the data further, according to the need for each call.
      * **app.js** file - All the code is tied up in _app.js_ which starts/stops the application. When starting the application, the first step is to open the connection to the database by calling the _database.initialize()_ function, then runs the web server by calling _webserver.initialize()_ function. When shutting down the application, the order is reversed: first the web server is closed and then the database connection.
      * **.env** file - Contains the details for connecting to the database: database user, password and connection string.
4. Open the _API_ project folder in _Visual Studio Code_ (or any other editor of your choice) and let's configure the code to run properly. Open the _.env_ file and replace _DB\_USER_, _DB\_PASSWORD_, and _DB\_CONNECTION\_STRING_ with your own connection details.

```
NODE_ORACLEDB_USER=DB_USER
NODE_ORACLEDB_PASSWORD=DB_PASSWORD
NODE_ORACLEDB_CONNECTIONSTRING=DB_CONNECTION_STRING
```

5. In order to run the code, you need to upload it to the instance. You can use the following commands (run in from you laptop, not on the instance).

  **Note**: Before copying the code from your local machine to the instance, delete the _node\_modules_ folder so that the process will take less time.

* On the instance:
```
<copy>
cd /home/opc
mkdir SkillsetTracking
</copy>
```
To save output of the **npm** command into a _log_ file, you can create a new log folder.
```
<copy>
cd /home/opc/SkillsetTracking
mkdir log
</copy>
```
* On your local machine:
```
<copy>
cd <project_folder_path>
rm node_modules
scp -r * opc@<your_instance_public_ip>:/home/opc/SkillsetTracking/
scp -r .env opc@<your_instance_public_ip>:/home/opc/SkillsetTracking/
</copy>
```

After you uploaded the code on the instance, you need to run the ``npm install`` command in the application folder. Then you can either run it manually with ``node app.js``, but the application will stop running when you close the SSH connection, or you can add it as a **crontab job**. Use the following commands to add it as a **crontab job**.
```
<copy>
sudo crontab -e
</copy>
```
Press ***insert*** to enter the _edit_ mode and paste the following. In this way, you will save the output of the ``node app.js`` command into _skillset\_log.log_ file.
```
<copy>
@reboot node /home/opc/SkillsetTracker/app.js >> /home/opc/SkillsetTracker/log/skillset_log.log 2>&1
</copy>
```
Press ***Esc***, then ***:wq***. After the crontab is saved, reboot the instance.
```
<copy>
sudo reboot
</copy>
```

You should now be able to see the application running in browser at **http://your\_instance\_public\_ip:8000/** or run an API at **http://your\_instance\_public\_ip:8000/api/skillset**.  

## **Step 3:** Create OracleJET instance and run the code
- sa isi instanta si sa puna codul pe ea ca in lab 6
- sa updateze .env si fisierul cu ip-ul de db (+ explicatia pt dan cu valoare default - adb)
- explicare treemap-uri (ce arata fiecare, culoarea era ceva si marimea era altceva + cine ce vede)
- explicare filtre treemap
- paleta culori
- pagina skills - descriere tabel, butonul de adaugare si functionalitatea de edit/delete (cine ce vede) + filtre
- about


## **Step 4:** Deploy the NodeJS API code in OKE
- prepare code as in lab 8
- how to replace API ip in OJET with cluster ip
- replace IP in ODA

## **Step 5:** Integrate your application with ODA
In order to integrate your application with **Oracle Digital Assistant**, you would need to follow all the steps described in **Lab 6: Build NodeJS APIs to make calls to the database**, considering the fact that at **Step 4** -> **point 6** you would need to either use the Public IP of the NodeJS Instance from **Step 2** of this Lab, or the External IP from **Step 4** in this Lab.

## Annexes

TBD - API list table here?

## Acknowledgements

**Authors/Contributors** - Giurgiteanu Maria Alexandra, Gheorghe Teodora Sabina
