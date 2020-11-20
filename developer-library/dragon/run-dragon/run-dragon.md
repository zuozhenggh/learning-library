# Download and run DRAGON

## Introduction

This lab walks you through the steps to download, install and run the DRAGON stack. <more>

Estimated Lab Time:  10 minutes

### About DRAGON
The DRAGON stack is designed to speed up you development of applications that leverage the power of Oracle Autonomous Database. In this short workshop, you'll download the stack and deploy the stack to Oracle Cloud.


### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account


## **STEP 1**: Download the DRAGON Stack

1. In Cloud Shell, change directories to your home directory:

    ```
    <copy>cd</copy>
    ```

2. Download the DRAGON stack and make it executable:
   *Note: see [the GitHub repo](https://github.com/loiclefevre/dragon) for the latest version.*

    ```
    <copy>wget https://github.com/loiclefevre/dragon/releases/download/v2.0.5/dragon-linux-x86_64-2.0.5</copy>
    ```

    ```
    <copy>chmod +x dragon-linux-*</copy>
    ```

3. Run the dragon command to generate SSH keys and display the config file:

    ```
    <copy>dragon-linux-x86_64-2.0.5 -config-template -create-keys</copy>
    DRAGON Stack manager v2.0.5

    > Command line parameters ................................................... ok
    Entering keys generation process...
    These keys (public and private) will be used for future connection to Oracle Cloud Infrastructure API endpoints.
    Please enter a passphrase: banana
    > Keys creation ..................................... ok [Upload the Public Key]
    Please upload this public key to your Oracle Cloud Infrastructure user's API Keys:

    -----BEGIN RSA PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsJthzZ9NzhJiFL/iC7nK
    bJlBQbTrsyDkc0zF0impJ5h9U/hCPopsKl53aBlaTTYjHnY73zaR/cJXbvsfbIJk
    v4USZpC/uhczo16BOtE3W+iQjoLgn8gsiFrcXvsb3G9h2avSa6eI1KifjJ7gqvEv
    SEb8t0ztMOkV3e3S5hrX57itipZZ0tPn//eBk8HpuHWV2wDoLtmzX2ZnIlu/niAO
    Fr7qTSvkVm28YEDAXEtQZ43C2wzImpacqiH37mK6fiK0Vunbx3D1bB+1a+dM6wVz
    09oXAIeD7lVROHpHHmqfb+AGbhEpsif005SE6mGgLxxSoRegWdVPKaLvZudpwlc8
    swIDAQAB
    -----END RSA PUBLIC KEY-----

    (instructions: https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#three)
    - public key saved in file: /home/tom_mcginn/dragon_ssh_key.pub
    - private key saved in file: /home/tom_mcginn/dragon_ssh_key

    Configuration template (save the content in a file named "dragon.config"):
    ...

     # Uncomment to ask for Bring Your Own Licenses model (doesn't work for Always Free and AJD)
    # database_license_type=byol

     # A list of coma separated JSON collection name(s) that you wish to get right after database creation
    # database_collections=

     # Path to a folder where data to load into collections can be found (default to current directory)
    data_path=.

    ```

4. Copy the public key (from the BEGIN RSA PUBLIC KEY to the end of END RSA PUBLIC KEY, including the dashes).

## **STEP 2:** Gather Data you need

1. From the OCI console, click the user icon (top right of your browser) and click **User Settings**. Click **API Keys** and **Add Public Key**.
   ![](./images/select-user.png " ")
   ![](./images/create-api-key.png " ")

2. Paste the content of public key you created and click **Add**. A new finger print will be generated.
   ![](./images/add-public-key.png " ")

  Make a note of the fingerprint for later.

  To see more information about generating the keys and finding your OCIDs, refer to [API Signing Key](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm).

3. On the User Details page, copy the user OCID and save it for later:

  ![](images/user-ocid.png)

4. Click on the user icon again and click **Tenancy: <tenancy-name>**, then copy and save the tenancy OCID for later:

  ![](images/tenancy-ocid.png)

5. From your compartment details page, copy the compartment OCID and save it for later.

  ![](images/compartment-details.png)

6. Look in the upper right of the Oracle Cloud Console to determine your region, then use [this reference](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm) to determine your region code. Save it for later.

## **STEP 3:** Create the dragon.config file

1. Create a `dragon.config` file using vi, nano or your favorite editor:

    ```
    <copy>nano dragon.config</copy>
    ```

2. Copy the following and paste it into the file, and add the values you collected earlier:

    ```
    <copy>
    [DEFAULT]
    user=<user ocid>
    fingerprint=<api key fingerprint>
    key_file=~/dragon_ssh_key
    tenancy=<tenancy ocid>
    compartment_id=<compartment ocid>
    region=<region code>
    auth_token=<authentication token>
    database_password=5uPeR_5tRoNg_PaSsWoRd
    database_collections=employees></copy>
    ```

    *Recommend we provide a sample JSON file for the collection*

## **STEP 4:** Deploy the DRAGON stack

1. Use the `-help` to see the parameters that DRAGON accepts:

    ```
    $ <copy>./dragon-linux-x86_64-2.0.5 -help</copy>
    DRAGON Stack manager v2.0.5

    > Command line parameters ................................................... ok
    Usage:
    -config-template                        displays a configuration file template
      -create-keys                          create the user's OCI API Key pair (use with -config-template)
    -profile <profile name>                 to choose the given profile name from dragon.config (default profile name: DEFAULT)
    -db <database name>                     to denote the database name to create or destroy
    -loadjson                               loads {JSON} data corresponding to collections (default: no data loaded)
                                             . use with configuration parameters database_collections and data_path
                                             . loading JSON data can be done during and/or after database provisioning
                                             . JSON file names must match <collection name>[_[0-9]+].json
    -create-react-app [name]                creates a React frontend (default name: frontend)
    -create-spring-boot-petclinic [name]    creates the Spring Boot Petclinic (default name: petclinic)
    -destroy                                to destroy the database
    -upgrade                                to download the latest version for your platform... (if available)

    Reporting issues:
    Please report any issue (bug, enhancement request, documentation needs...) at http://bit.ly/DragonStack in the "Issues" tab.
    $
    ```

2. Create a sample JSON file to load. Open the following file and paste the contents into it, and save the file:

    ```
    $ <copy>nano employees.json</copy>
    ```

    ```
    <copy>{"Employees":[{"userId":"rirani","jobTitleName":"Developer","firstName":"Romin","lastName":"Irani","preferredFullName":"Romin Irani","employeeCode":"E1","region":"CA","phoneNumber":"408-1234567","emailAddress":"romin.k.irani@gmail.com"},{"userId":"nirani","jobTitleName":"Developer","firstName":"Neil","lastName":"Irani","preferredFullName":"Neil Irani","employeeCode":"E2","region":"CA","phoneNumber":"408-1111111","emailAddress":"neilrirani@gmail.com"},{"userId":"thanks","jobTitleName":"Program Directory","firstName":"Tom","lastName":"Hanks","preferredFullName":"Tom Hanks","employeeCode":"E3","region":"CA","phoneNumber":"408-2222222","emailAddress":"tomhanks@gmail.com"}]}</copy>
    ```

    *Note: JSON files must be minified(no line breaks).*

3. Create the DRAGON stack with the employees collection:

    ```
    $ <copy>./dragon-linux-x86_64-2.0.5 -loadjson</copy>
    DRAGON Stack manager v2.0.5

    > Command line parameters ................................................... ok
    > Oracle Cloud Infrastructure configuration ................................. ok
    > Database creation ................................................. ok [1m 8s]
    > Database wallet download ..................................... ok [dragon.zip]
    > Database configuration .................................................... ok
    > Object storage configuration .............................................. ok
    > Data loading .............................................................. ok
    > Local configuration ....................................................... ok
    > Local configuration ....................................................... ok
    You can connect to your database using SQL Developer Web:
    - URL  : https://DEQ7GMUGY6X3FK1-DRAGON.adb.uk-london-1.oraclecloudapps.com/ords/dragon/sign-in/?username=DRAGON&r=_sdw%2F
    - login: dragon
    duration: 1m 48s
    ```

## **STEP 5:** Using DRAGON

1. Copy and paste the link into a browser and connect to SQL Developer Web:

  ![](images/connect-to-sql-dev-web.png)

2. Login, using the login name and password you created in the config file:

  ![](images/sql-dev-web-signin.png)

3. Click SQL Worksheet:

  ![](images/open-sql-worksheet.png)

4. Expand the two collections:

  ![](images/expand-collections.png)

5. In the worksheet, enter the following command to look at the contents of the employees collection (JSON), and click **Run Statement**:

  ```
  <copy>select json_query(json_document, '$' returning CLOB) from employees;</copy>
  ```

  ![](images/view-employees-collection-json.png)

6. Click in the query result to see the contents of the JSON document:

  ![](images/employees-values.png)

## **STEP 6:** Create the front end React application

1. In Cloud Shell, build the front-end:

    ```
    $ <copy>./dragon-linux-x86_64-2.0.5 -create-react-app</copy>
    DRAGON Stack manager v2.0.0

    > Command line parameters ................................................... ok
    > Oracle Cloud Infrastructure configuration ................................. ok
    > Local configuration ....................................................... ok
    > Stack creation .......................................... ok [React: frontend]
    Success! Created frontend at /home/tom_mcginn/frontend
    Inside that directory, you can run several commands:

      npm install
        Installs all the dependencies.

      npm start
        Starts the development server.

      npm run build
        Bundles the app into static files for production.

      npm test
        Starts the test runner.

      npm run eject
        Removes this tool and copies build dependencies, configuration files
        and scripts into the app directory. If you do this, you can’t go back!

    We suggest that you begin by typing:

      cd frontend
      npm install
      npm start

    Happy hacking!
    duration: 0.012s
    $
    ```

2. Build the front end using npm:

    ```
    <copy>cd frontend; npm install; npm start</copy>
    ```

    ![](images/frontend-installed.png)

3. When the build completes, install NGROK to access the local website (deployed on Cloud Shell):

    ```
    <copy>wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip; unzip ngrok-stable-linux-amd64.zip</copy>
    ```

4. Start ngrok and then access the website:

    ```
    <copy>npm start &</copy>
    ```

    ```
    <copy>./ngrok http 3000</copy>
    ```

    ![](images/ngrok.png)

5. Click in the interface to learn more about the DRAGON project, Reactjs, ORDS, or sign into the database on your ATP instance.

    ![](images/dragon-frontend.png)

    *maybe add more here?*

## **STEP 7:** Cleanup your environment

1. Quit ngrok by pressing `Ctrl-C`.

2. Change directories to home.

    ```
    $ <copy>cd</copy>
    ```

3. Destroy you DRAGON stack

    ```
    $ <copy>./dragon-linux-x86_64-2.0.0 -destroy</copy>
    ```

Congratulations! You have complete the workshop!

## Learn More

* [DRAGON Project (GitHub)](https://github.com/loiclefevre/dragon)
* [Oracle REST Data Services](https://www.oracle.com/database/technologies/appdev/rest.html)

## Acknowledgements
* **Author** - Loic Lefevre, Principal Product Manager
* **Last Updated By/Date** - Tom McGinn, Database Product Management, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
