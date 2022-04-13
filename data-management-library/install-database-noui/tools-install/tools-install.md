# Install Tools and Services

## Introduction

In this lab, we will configure Install and configure SQL Developer to access CDB and PDB, Install the software like JDK, Python, NodeJS, and NPM

Estimated Time: 40 minutes

### Objectives
 
In this lab, you will:
* Download and Install JDK. 
* Download, Install and Configure SQL Developer
* Review Net Manager configuration
* Install developer tools such as Visual Code
* Install and Verify Node JS and Python

### Prerequisites 
This lab assumes you have:

* Access to noVNC Desktop environment 
  
## Task 1: Install JDK 

1. Download JDK, since we are using Oracle Linux x64 Compressed Archive
 
      ![Oracle Linux x64 Compressed Archive](images/download-jdk-compressed.png "Oracle Linux x64 Compressed Archive") 
 
2. Download JDK

      ![Download JDK](images/download-jdk.png "Download JDK") 

3. UnCompress the JDK file in Downloads folder

## Task 2: Install SQL Developer

1. Download SQL Developer for other platforms 

      ![Download SQL Developer](images/download-sqldeveloper-otherpf.png "Download SQL Developer") 

2. Accept License

      ![Download SQL Developer](images/download-sqldeveloper.png "Download SQL Developer") 

3. UnCompress the Downloaded SQLDeveloper file in Downloads folder
   
4. Set the Java Home  

      ```
      <copy>
            [orcl:oracle@x]$ vi /home/oracle/.sqldeveloper/21.4.3/product.conf
      </copy>
      ``` 
      add the following line depending upon the JDK uncompressed folder location
   
      ```
      <copy>
            SetJavaHome /home/oracle/Downloads/jdk1.8.0_321
      </copy>
      ``` 

      Launch SQL Developer with following command

      ```
      <copy>
            /home/oracle/Downloads/sqldeveloper/sqldeveloper.sh
      </copy>
      ``` 

5. Setup SQLDeveloper Launcher from Desktop

      Replace the command with absolute path to sqldeveloper.sh and the icon in sqldeveloper, *Trust* the Launcher if prompted

      ```
      <copy>
            /home/oracle/Downloads/sqldeveloper/sqldeveloper.sh
      </copy>
      ``` 

     ![SQL Developer launcher](images/sqldeveloper-launcher.png "SQL Developer launcher") 

## Task 3: Configure SQL Developer connection parameters

1. Configure connection parameters

      ![SQL Developer connection](images/sqldeveloper-connection.png "SQL Developer connection") 

      ![SQL Developer connection](images/sqldeveloper-connection-properties.png "SQL Developer connection") 

## Task 4: Connecting to Pluggable Database PDB1 and accessing HR Schema based tables

1. In the connection parameters of SQL Developer, change to orcl to the name of pluggable database in our case pdb1

      ![SQL Developer PDB connection](images/sqldev-pdb1.png "SQL Developer PDB connection") 

      Once connected run the following query to access HR Schema based employee table
  
      ```
      <copy>
      select * from HR.EMPLOYEES;
      </copy>
      ``` 

      ![HR Schema](images/hr-schema.png "HR Schema") 

## Task 4: Configuring Net Manager ( Optional )

1. You can also update the configurations through Net Manager 

      ```
      <copy>
      cd /u01/app/oracle/product/19c/db_1/bin
      netmgr
      </copy>
      ``` 

      ![Net manager service](images/netmgr-service.png "Net manager service") 

      ![Net manager listener](images/netmgr-listener.png "Net manager service") 

## Task 5: Install Visual Studio Code

1. Configure connection parameters

      ```
      <copy>
      # cd /etc/yum.repos.d
      sudo vi vscode.repo 
      </copy>
      ``` 

      ```
      <copy> 
      [vscode]
      name=vscode
      baseurl=https://packages.microsoft.com/yumrepos/vscode/
      enabled=1
      gpgcheck=1
      gpgkey=https://packages.microsoft.com/keys/microsoft.asc
      </copy>
      ``` 

      ```
      <copy> 
      sudo su
      yum install code 
      </copy>
      ``` 

      create Visual code launcher from Desktop 

      ![Visual studio code](images/vscode.png "Visual studio code") 

## Task 6: Install NodeJS

1. Configure connection parameters

      ```
      <copy>
      sudo yum install oracle-nodejs-release-el7
      sudo yum install nodejs
      sudo yum install npm
      </copy>
      ``` 

      Verify the installed node version

      ```
      <copy> 
      node -v
      v16.14.1
      npm -v
      8.5.0
      </copy>
      ``` 

## Task 7: Install Python3

1. Configure connection parameters

      ```
      <copy>
      sudo yum install -y python3
      </copy>
      ``` 

      Verify the output if Python 3 is already installed

      ```
      <copy> 
      Loaded plugins: langpacks, ulninfo
      Package python3-3.6.8-18.0.5.el7.x86_64 already installed and latest version
      Nothing to do
      </copy>
      ``` 
 
   You successfully made it to the end this lab. You may now  *proceed to the next lab* .  

## Learn More

* [Install Visual Code](https://blogs.oracle.com/wim/post/installing-visual-studio-code-on-oracle-linux-7) 
* [How do I start with Node.js](https://nodejs.org/en/docs/guides/getting-started-guide/) 
* [HR Schema](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/comsc/HR-sample-schema-table-descriptions.html) 

## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** - Kevin Lazarz, Senior Principal Product Manager, Database 
* **Last Updated By/Date** -  Madhusudhan Rao, April 2022 
