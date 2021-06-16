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

1. The first thing that you need to do is to go through the second step in **Lab 5: Build an OracleJET Web Application**, **Creating a Linux Instance in OCI**.

2. After you created the instance, it's time to configure it as described in **Lab 5: Build an OracleJET Web Application** -> **Step 3**.

3. Now, before copying the code to the instance and running it, let's understand what all the files in this project are. Note that some of them were already explained earlier.
    * **package.json** file - This file contains all the needed NodeJS packages that will be downloaded & installed by the ``npm install`` command.
    * **config** folder - The two files in the config folder are meant to set up the default configuration for the entire application.
        * **authentication.js** - The authentication.js contains all the IDCS configuration using data stored in *.env* file, so that the user of the application can be successfully authenticated
        * **web-server.js** - The web-server.js sets up the port on which the web server would run on. In this case, 8000, but any other port can be used.
    * **scripts** folder appears automatically when you create a new OracleJET project.
    * **services** folder contains all the necessary authentication functions and also the initialization of the server, so that the application can run properly.
        * **authentication.js** - This file contains the user, login and logout routes and several functions that make possible the authentication part:
            - *user()* - function to check if the user is authenticated.
            - *login()* - function that makes the login action.
            - *callback()* - function for storing *id_token* in the session (server side) for logout purposes and adding a request header that is required by the IDCS strategy.
            - *logout()* - function that makes the logout action.
            - *ensureAuthenticated()* - created as middleware to check if the user is authenticated.
        * **web-server.js** - The web-server.js file has two main functions defined in it:
            - *initialize()* – used to run the web server on the port that was set in the config/web-server.js file. Here it’s also set up the path for the API calls to the database, so that all the paths will look similar.
            - *close()* – used to close the web server.
    * **staged-themes** and **web** folders appear automatically when you run ``ojet build`` command.
    * **src** - because Oracle JET applications are modular, it needs to be mentioned that a module consists of business logic defined in a JavaScript file and a view defined in an HTML file. By convention, the name of the JavaScript file is the same as the name of the HTML file. By default, the JavaScript side of a module is located in the *src/js/viewModels* folder, while its matching view is located in the *src/js/views* folder.
    Whenever you run ``ojet build`` or ``ojet serve``, the *src* folder is copied to the *web* folder mentioned earlier.
    If one developer wants to change something in the application, he should never change the files in the web folder, because they will automatically be overwritten whenever ojet build or ojet serve is run. Only change the files in the src folder.
    As mentioned before, all JavaScript files have the same name as their associated HTML files.
    * **src/js/viewModels** contains the JavaScript files (**about.js**, **skills.js**, **treemap.js**).
    * **src/js/views** contains the HTML files (**about.html**, **skills.html**, **treemap.html**).
    * **src/js/main.js** is the main entry point into the file, hooked into the index.html file via a script element.
    * **src/js/appController.js** represents the location for global variables, which is loaded into the application in the require block in the main.js file.
    * **src/index.html** is the main index file of the application, though note that ``ojet serve`` will load it from **web** folder, not the **src** folder.
    **src/data** contains two JSON files, one for storing multiple databases with different parameters (**db.json**) and one with navigation information (**nav.json**).
    * **app.js** file - All the code is tied up in app.js which starts / stops the application. When starting the application, the first step is to open the connection to the database by calling the database.initialize() function, then runs the web server by calling webserver.initialize() function. When shutting down the application, the order is reversed: first the web server is closed and then the database connection.
    * **.env** file - Contains the details regarding IDCS tenant, id and secret.

  ***Treemap Section***

  This section contains two treemap structures that can be seen in the Treemap entry of the application:
    * **Cloud Native Skills Treemap** which shows all the skills grouped by categories according to existing JSON file in the database;

    ![cloudnativeskills treemap](./images/cloudnativeskillstreemap.png)

    * **Management Treemap** which shows all the people grouped by manager name.

    ![management treemap](./images/managementtreemap.png)

    The *size* of the treemap boxes is represented by number of people with that skill and the *color* is represented by the average skill points.

    As you can see, the main two colors used for this treemap are *RED* (**highest average of skill points**) and *GREEN* (**lowest average of skill points**). But we took into consideration color blind people and also personal preferences, so the application has available a color palette from which the user can choose any combination he likes.

    ![colorpalette](./images/colorpalette.png)

    This color palette is defined like this in the code:

    ```
    /* CODE FOR COLOR PALETTE */
      self.setPalette = (colors) => {
        self.highPalette = colors.map((o) => {
          let c = o.color;
          if (typeof c === "string") {
            o.color = new Color(c);
          }
          return o;
        });
        self.lowPalette = colors.map((o) => {
          let c = o.color;
          if (typeof c === "string") {
            o.color = new Color(c);
          }
          return o;
        });
        ...
      ```

    You can **FILTER** both treemaps by *manager*, *skills category*, *development area* (primary/secondary), *skill*, and *minimum skill level*.

    ![cloudnativeskillstreemapfilter](./images/cloudnativeskillstreemapfilter.png)

    The filters are defined in the code like this:

    ```
    /* SKILL LEVELS LIST - FILTER */
     self.skillLevelSelectVal = ko.observable('1');
     var skillLevelList = rootModel.skillLevelList();
     self.skillLevelDP = new ArrayDataProvider(skillLevelList, { keyAttributes: 'value' });
    ```

    When you click on a box at your choice from one of the treemaps you will see details about the people that have a certain skill if you choose **Cloud Native Skills Treemap** or engineer details and Edit form if you choose the **Management Treemap**.

  ***Skills Section***

  This entry in the application represents the page where the user can find all the engineers with their skill points taking into consideration their role.

    ![skills entry](./images/skills.png)

  If the role was mentioned, a user can have three different roles:

  **ADMIN**
    - VIEW Cloud Native Skills Treemap;
    -	VIEW Details Table from Treemap;
    -	VIEW, EDIT, DETELE Management Treemap + Edit Form;
    -	VIEW, INSERT, EDIT, DELETE Skills Entry;
    -	VIEW About Entry.

  **MANAGER**
    -	VIEW Cloud Native Skills Treemap;
    -	VIEW Details Table from Treemap;
    -	VIEW, EDIT, DETELE ONLY HIS PEOPLE - Management Treemap + Edit Form;
    -	VIEW, INSERT, EDIT, DELETE ONLY HIS PEOPLE - Skills Entry;
    -	VIEW About Entry.

  **USER**
    -	VIEW Cloud Native Skills Treemap;
    -	VIEW Details Table from Treemap;
    -	VIEW, INSERT, EDIT ONLY ITS OWN SKILLS - Skills Entry;
    -	VIEW About Entry.

  In order to explain the code part for this entry, the ADMIN role will be taken into consideration.

  The **ADMIN** user can see and do everything (**use and apply all filters**, **add**, **edit**, **delete**, **view** engineers, **view table** and **click on specific engineer**).
  All these elements can be found in the *skills.js* file for the JavaScript part and also in the skills.html for the HTML part.
  For example, filters are defined like this in *skills.js* file:

  ```
  let mgrList = rootModel.managerListFilter();
  self.mgrSelected = ko.observable('All');
  self.mgrDP = new ArrayDataProvider(mgrList, { keyAttributes: 'value' });
  var managersList = rootModel.managerList();
  managerDP = new ArrayDataProvider(managersList, { keyAttributes: 'value' });
  ```

  And they are mentioned in the *skills.html* file like this:

  ```
  <oj-select-single id="selectMgr" label-hint="Manager" style="max-width:10em" data="[[mgrDP]]"
          value="{{mgrSelected}}" on-value-changed="[[filterTable]]">
          </oj-select-single>
  ```

  If you click on a specific engineer you can *VIEW* his details and you can *EDIT* or *DELETE* his data if you have **ADMIN** role.

  ![clickontable](./images/clickontable.png)

  This window is done based on a popup mechanism defined like this in the code:

  ```
  /* CODE FOR POPUP WITH FORM */
      self.formAnimationListener = function (event) {
         ...
      };
      self.formOpenListener = function () {
        if (self.selectedNodesEmployee().length != 0) {
         ...
      };
      self.formCancelListener = function () {
        var popup = document.getElementById('form-popup');
        popup.close();
         ...
      };
  /* END OF CODE FOR POPUP WITH FORM */
  ```

  The **CREATE**, **EDIT**, **DELETE** buttons call specific functions defined in code. *POST* method is called for both *create* and *update* and *DELETE* method is called for *delete* functionality. Here is an example:

  ```
  $.ajax({
      url: createURL,
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(json_var),
      success: function (data) {
          window.location.reload();
          },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
      alert("Action failed! Please check that there isn't another person added with this EMAIL address. If you believe this is not the case, please contact the ADMIN of the application!");
            }
    });
  ...
  ```

  ***About Section***

  This section contains **about.js** and **about.html** files that contain all the elements that build the final result as a table which provides information about skill points and their meaning.

  ![about entry](./images/about.png)

  4. Open the _OJET_ project folder in _Visual Studio Code_ (or any other editor of your choice) and let's configure the code to run properly. Open the _.env_ file and replace _IDCS\_CLIENT\_TENANT_, _IDCS\_CLIENT\_ID_, and _IDCS\_CLIENT\_SECRET_ with your own IDCS details.

  ```
  IDCS_CLIENT_TENANT=IDCS_CLIENT_TENANT
  IDCS_CLIENT_ID=IDCS_CLIENT_ID
  IDCS_CLIENT_SECRET=IDCS_CLIENT_SECRET
  ```

  In the same manner, complete the **src/data/db.json** file with your *NAME*, *DESCRIPTION*, *IP*, *PORT* according to your database type (OracleDB, NoSQL, MySQL and others).

  ```
  [   {
      "name": "adb",
      "description": "Autonomous JSON Database",
      "ip": "<your_ip>",
      "port": "<your_port>"
      },
      {
      "name": "mysqldb",
      "description": "MySQL Database",
      "ip": "<your_ip>",
      "port": "<your_port>"
      }
]
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

  You should now be able to see the application running in browser at **http://your\_instance\_public\_ip:8000/**.

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
