# Python SODA Micro-service with Autonomous Database for JSON

## Introduction

SODA for Python is a Python API that implements Simple Oracle Document Access (SODA). It is part of the Oracle Python driver, cx_Oracle — no additional installation is needed.

You can use SODA for Python to perform create, read (retrieve), update, and delete (CRUD) operations on documents of any kind, and you can use it to query JSON documents.

SODA is a set of NoSQL-style APIs that let you create and store collections of documents (in particular JSON) in Oracle Database, retrieve them, and query them, without needing to know Structured Query Language (SQL) or how the documents are stored in the database.

Estimated Lab Time: 1 hour 40 minutes

### Objectives
In this lab, you will:
* Create development environment on Oracle Cloud Infrastructure
* Deploy a document store with one collection on Oracle Autonomous Database for JSON
* Develop a simple Python web service to manage JSON documents via REST calls

### Prerequisites
* An Oracle Free Tier, Always Free, or Paid Oracle Cloud Account
* Putty and PuttyGen tools for Windows laptops


## Task 1: Create Virtual Cloud Network (VCN)

1. Login to Oracle cloud console: [cloud.oracle.com](https://cloud.oracle.com/)

    - Cloud Account Name: oci-tenant
    - User Name: oci-username
    - Password: oci-password

    >**Note** : Use Root Compartment, oci-tenant(root), to create all resources for this workshop.

2. Click on main menu ≡, then Networking > **Virtual Cloud Networks**. Select your Region and Compartment assigned by the instructor. 

3. Click **Start VCN Wizard**.

4. Select **VCN with Internet Connectivity**. Start VCN Wizard.

    - VCN Name: DEVCN

5. Click Next and Create.

6. Click DEVCN for details. 

7. Click **Public Subnet-DEVCN**. Click **Default Security List for DEVCN**. Click **Add Ingress Rules**.

    - CIDR Block: 0.0.0.0/0
    - Destination Port Range: 5000
    - Description: Python Flask

8. Click **+ Another Ingress Rule**.

    - CIDR Block: 0.0.0.0/0
    - Destination Port Range: 6080
    - Description: noVNC

9. Click **+ Another Ingress Rule**.

    - CIDR Block: 0.0.0.0/0
    - Destination Port Range: 80
    - Description: HTTP

10. Click **Add Ingress Rules**.


## Task 2: Provision Compute Node for development

1. Click on main menu ≡, then Compute > **Instances**. Click **Create Instance**.

    - Name: DEVM
    - Image and shape: click **edit**.
    - Change Image: **Oracle Autonomous Linux 7.9**
    - Shape: VM.Standard.E2.1.Micro (Always Free-eligible)
    - Download the private and public keys: **Save Private Key**, Save Public Key.

2. Click **Create**. Wait for Compute Instance to finish provisioning, and have status Available. On the Instance Details page, copy Public IP Address in your notes.

3. Connect to the Compute node using SSH. (Mac/Linux only)

    ````
    ssh -C -i ssh-key-YYYY-MM-DD.key opc@[DEVM public-ip address]
    ````

4. Connect to the Compute node using **Putty**. (Windows only)

    ![](./images/putty1.png "")

5. Use **PuttyGen** from your computer to convert the private key file you saved on your computer to Putty `.ppk` format. Click on Conversions > Import Key. Open the private key. Click on Save Private Key and Yes to save **without a passphrase**. Use the same name for the new `.ppk` key file, add only the extension `.ppk`. Use the `ssh-key-YYYY-MM-DD.ppk` private key to connect. (Windows only)

    ![](./images/putty2.png "")

7. Go back to Session, give it a name, and save it. When asked if you trust this host, click **Yes**.

    ![](./images/putty3.png "")


## Task 3: Configure Compute Node for development

Developers usually need a graphical user interface, and this can be achieved using a Remote Desktop connection. Copy and paste these blocks of commands into your SSH connection, and hit **Enter** after each one.

1. Create oracle user.

    ````
    <copy>
    sudo groupadd oinstall
    sudo groupadd dba
    sudo groupadd oper
    sudo useradd -g oinstall -G dba,oper oracle
    </copy>
    ````

2. Use the substitute user command to start a session as **root** user.

    ````
    <copy>
    sudo su - || (sudo sed -i -e 's|root:x:0:0:root:/root:.*$|root:x:0:0:root:/root:/bin/bash|g' /etc/passwd && sudo su -)
    </copy>
    ````

3. Install Oracle Instant Client. 

    ````
    <copy>
    yum -y install gnome* --exclude=gnome-session-wayland-session
    yum -y install oracle-release-el7
    yum-config-manager --enable ol7_developer_EPEL
    yum -y install oracle-instantclient19.13-basic.x86_64 oracle-instantclient19.13-devel.x86_64 oracle-instantclient19.13-jdbc.x86_64 oracle-instantclient19.13-odbc.x86_64 oracle-instantclient19.13-sqlplus.x86_64 oracle-instantclient19.13-tools.x86_64
    firewall-cmd --permanent --add-port=5000/tcp
    firewall-cmd --reload
    </copy>
    ````

4. Install the remote desktop tools, type **oracle** when asked.

    ````
    <copy>
    cd /tmp
    rm -rf ll-setup
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/Nx05fQvoLmaWOPXEMT_atsi0G7Y2lHAlI7W0k5fEijsa-36DcucQwPUn6xR2OIH8/n/natdsecurity/b/misc/o/setup-novnc-livelabs.zip -O setup-novnc-livelabs.zip
    unzip -o  setup-novnc-livelabs.zip -d ll-setup
    cd ll-setup/
    chmod +x *.sh .*.sh
    ./setup-novnc-livelabs.sh
    </copy>
    ````

5. These commands will take 50 minutes to execute. Continue with the next Task.


## Task 4: Provision Oracle Autonomous JSON Database (AJD)

1. Click on main menu ≡, then Oracle Database > **Autonomous JSON Database**. **Create Autonomous Database**.

    - Display name: AJDEV
    - Database name: AJDEV
    - Choose a workload type: JSON
    - Choose a deployment type: Shared Infrastructure
    - Always Free: Show only Always Free configuration options
    - Choose database version: 19c
    - OCPU count: 1
    - Storage (TB): 1

2. Under Create administrator credentials:

    - Password: DBlearnPTS#22_

3. Under Choose network access:

    - Access Type: Secure access from everywhere

4. Click **Create Autonomous Database**. Wait for Lifecycle State to become Available.

5. On Tools tab, under Oracle Application Express, click **Open APEX**. On Administration Services login page, use password for ADMIN.

    - Password: DBlearnPTS#22_

6. Click **Create Workspace**.

    - Database User: DEMO
    - Password: DBlearnPTS#22_
    - Workspace Name: DEMO

7. Click AD icon on upper right corner, **Sign out**. Click **Return to Sign In Page**.

    - Workspace: demo
    - Username: demo
    - Pasword: DBlearnPTS#22_

8. Click **Sign In**. Oracle APEX uses low-code development to let you build data-driven apps quickly without having to learn complex web technologies. This also gives you access to Oracle REST Data Services, that allows developers to readily expose and/or consume RESTful Web Services by defining REST end points.

9. On Oracle Cloud Infrastructure Console, click **Database Actions** next to the big green box.

10. Click Development > SQL (first button), and run the following code:

    ````
    BEGIN 
       ords_admin.enable_schema (
          p_enabled => TRUE,
          p_schema => 'DEMO',
          p_url_mapping_type => 'BASE_PATH',
          p_url_mapping_pattern => 'demo',
          p_auto_rest_auth => NULL
       ) ;
      commit ;
    END ; 
    /
    ````

    >**Note** : For all code you run in SQL Developer Web, make sure you receive a success message:

    ````
    PL/SQL procedure successfully completed.
    ````

11. Grant **SODA_APP** to DEMO user. This role provides privileges to use the SODA APIs, in particular, to create, drop, and list document collections.

    ````
    GRANT SODA_APP TO demo;
    ````

12. Click **ADMIN** upper right corner, and **Sign Out**. 

13. Click **Sign In**. Login using DEMO user credentials.

    - Username: demo
    - Password: DBlearnPTS#22_

14. Click Development > JSON (under first button), and follow the tips. This is the interface you will use to manage your JSON collections in this document store.

## Task 5: Back to Compute Node SSH connection

1. Wait until all commands finished, there is a 'Completed!' success message at the end. Exit root user session. 

    ````
    <copy>
    exit
    </copy>
    ````

2. Use your laptop web browser to open the URL returned by the script, replacing **[DEVM public-ip address]** with the actual values.

    http://[DEVM public-ip address]/livelabs/vnc.html?password=LiveLabs.Rocks_99&resize=scale&quality=9&autoconnect=true&reconnect=true

3. Follow the wizard to complete your remote desktop environment. 

    - Language: English. Next
    - Select Keyboard. Next
    - Set Location Services Off. Next
    - Skip Online Accounts settings.
    - Start Using Oracle Linux Server.
    - Close Getting Started dialog.

4. Check if your keyboard works. If you need to select another keyboard layout, click the **On-Off** button in the upper right corner, and **Settings** button. You will find the options under Region & Language.

5. Click Applications > Favorites > Firefox to launch the web browser on the DEVM Compute Node remote desktop. Navigate to cloud.orale.com, and login to Oracle cloud console using your Cloud Account Name, User Name, and Password.

6. Click on main menu ≡, then Oracle Database > **Autonomous JSON Database**. Click **AJDEV**.

7. Next to the big green box, click DB Connection > Download wallet.

    - Password: DBlearnPTS#22_
    - Click Download > Save file.

8. Open another tab in Firefox on remote desktop, and navigate to **bit.ly**. Use the lab guide to copy and paste commands on the DEVM Compute Node remote desktop.

9. Click Applications > System Tools > Terminal on the DEVM Compute Node remote desktop. Run the following commands. Use Shift+Ctrl+V to paste the block in Terminal, and hit **Enter** after it.

    ````
    <copy>
    unzip Downloads/Wallet_AJDEV.zip -d Wallet_AJDEV
    sed -i 's/?\/network\/admin/\${TNS_ADMIN}/g' Wallet_AJDEV/sqlnet.ora
    export TNS_ADMIN=/home/oracle/Wallet_AJDEV
    export LD_LIBRARY_PATH=/usr/lib/oracle/19.13/client64/lib
    export PATH=$PATH:/usr/lib/oracle/19.13/client64/bin/
    </copy>
    ````


## Task 6: Develop micro-service with SODA for Python

Use SODA for Python on Oracle Autonomous JSON Database to develop a micro-service application that will allow you to insert and retrieve JSON documents using REST calls.

1. Create a new folder under `/home/oracle` as the location of the Python application. Create a Python virtual environment for development, and activate it.

    ````
    <copy>
    mkdir python-simple-project
    cd python-simple-project
    pip3 install --user virtualenv
    virtualenv .
    . bin/activate
    </copy>
    ````

2. Use the **gEdit** text editor on Remote Desktop to create a file with the required libraries for the application.

    ````
    <copy>
    gedit requirements.pip
    </copy>
    ````

3. Add the following lines in requirements.pip, click Save, and close the editor.

    ````
    <copy>
    Flask
    dnspython
    cx_Oracle
    pymongo
    </copy>
    ````

4. Use **pip** package installer for Python 3 to install the required libraries specified in the requirements.pip file.

    ````
    <copy>
    pip3 install -r requirements.pip
    </copy>
    ````

5. Use the **gEdit** text editor on Remote Desktop to create a file the Python application code.

    ````
    <copy>
    gedit simple-app.py
    </copy>
    ````

6. Paste the following code in simple-app.py file. Verify all connection variables are correct. Click Save, and close the editor.

    ````
    <copy>
    # import required modules
    import json
    import cx_Oracle
    from flask import Flask
    from flask import request
    app = Flask(__name__)
    
    # set Oracle connection variables
    o_usr = "demo"
    o_pwd = "DBlearnPTS#22_"
    o_srv = "ajdev_tp"
    
    # create Oracle AJD connection, and set collection used by application
    conn_string = o_usr + '/' + o_pwd + '@' + o_srv
    connection = cx_Oracle.connect(conn_string)
    connection.autocommit = True
    soda = connection.getSodaDatabase()
    ocollection = soda.createCollection("SimpleCollection")
    
    # function used to insert JSON documents in Oracle
    @app.route("/oracle/", methods=['POST'])
    def insert_orcl_doc():
        req_data = request.get_json()
        ocollection.insertOne(req_data)
        return ('', 204)
    
    # function used to retrieve JSON documents from Oracle
    @app.route('/oracle/')
    def get_orcl_doc():
        documents = ocollection.find().getDocuments()
        response = []
        for document in documents:
            content = document.getContent()
            content['key'] = str(document.key)
            response.append(content)
        return json.dumps(response)
    
    # main program module
    if __name__ == '__main__':
        app.run(host= '0.0.0.0')
    </copy>
    ````

7. Run simple-app application. 

    ````
    <copy>
    python3 simple-app.py
    </copy>
    ````

8. If you followed the steps correctly, you should see this output in the terminal. Leave this Terminal window like this in order to keep the micro-service running on port 5000.

    ````
    * Serving Flask app "simple-app" (lazy loading)
    * Environment: production
      WARNING: This is a development server. Do not use it in a production deployment.
      Use a production WSGI server instead.
    * Debug mode: off
    * Running on http://X.X.X.X:5000/ (Press CTRL+C to quit)
    ````

9. Use Terminal main menu to click File > New Tab, to open a new tab. Use the new tab to perform two POST request with CURL client.

    ````
    <copy>
    curl --request POST \
      --url http://localhost:5000/oracle/ \
      --header 'content-type: application/json' \
      --data '{
     "company":"Company One",
     "address": {
         "street": "22 Rue du Grenier Saint-Lazare",
         "city": "Paris",
         "country": "France"
     },
     "industry":"Financial Services",
     "employees":54234
    }'
    </copy>
    ````
    
10. Make sure you hit **Enter** after each one.

    ````
    <copy>
    curl --request POST \
      --url http://localhost:5000/oracle/ \
      --header 'content-type: application/json' \
      --data '{
     "company":"Company Two",
     "address": {
         "street": "Calle Extramuros 74",
         "city": "Madrid",
         "country": "Spain"
     },
     "industry":"Retail",
     "employees":12345
    }'
    </copy>
    ````
    
11. Use the web browser on your laptop to navigate to your micro-service to list JSON documents inserted into Oracle Autonomous Database.

    http://[DEVM public-ip address]:5000/oracle/

12. Insert two more documents into Oracle Autonomous Database using REST calls to the micro-service. Hit **Enter** after this block.

    ````
    <copy>
    curl --request POST \
      --url http://localhost:5000/oracle/ \
      --header 'content-type: application/json' \
      --data '{
     "company":"Company Three",
     "address": {
         "street": "3A Evergreen St, Ballyphehane",
         "city": "Cork",
         "country": "Ireland"
     },
     "industry":"Manufacturing",
     "employees":98765
    }'
    curl --request POST \
      --url http://localhost:5000/oracle/ \
      --header 'content-type: application/json' \
      --data '{
     "company":"Company Four",
     "address": {
         "street": "aleje Mikołaja Kopernika 32",
         "city": "Piotrków Trybunalski",
         "country": "Poland"
     },
     "industry":"Manufacturing",
     "employees":44444
    }'
    </copy>
    ````

13. Refresh the web browser on your laptop to list all JSON documents inserted.

    http://[DEVM public-ip address]:5000/oracle/

14. Go to the first Terminal window where the micro-service is running on port 5000, and hit CTRL+C to stop it.

    ````
    <copy>
    CTRL+C
    </copy>
    ````


## Acknowledgements
* **Author** - Valentin Leonard Tabacaru, Database Product Management
* **Contributors** - Priscila Iruela, Technology Product Strategy Director
* **Last Updated By/Date** - Valentin Leonard Tabacaru, March 2022

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
