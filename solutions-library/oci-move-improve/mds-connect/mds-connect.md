# Connecting your application with MDS (MySQL Database Cloud Service) on OCI

## Introduction
This lab walks you through the steps on how to create MDS instance on OCI and how to migrate your database from your OSCommerce App MySQL to MDS on OCI. The lab will also focus on how to connect your OSCommerce application with MDS.

Estimated Lab Time: 1 hour

### Objectives
* Create a MDS (MySQL Database Cloud Service)
* Migrate OSCommerce MySQL Database to MDS
* Connect your OSCommerce App with MDS

## **Step 1:** Create MDS Instance on OCI
1. Please login to OCI Console and click MySQL > DB Systems. And click Create MySQL DB System.

    ![](./images/1.png "")

2. Please provide name for MySQL instance. Select your compartment, Availability Domain and shape. And click Next.

    ![](./images/2.png "")

3. Now enter the credentials for MDS Instance. Please select the same VCN and public subnet we created in previous lab. And click Next.

    ![](./images/3.png "")

4. Once complete, Please click create button. This will take few minutes to spin up the MDS Instance on OCI.

    ![](./images/4.png "")

## **Step 2:** Migrating Database to MDS

1. Please ssh in your primary instance. Run the following command in the terminal.

    ```
    <copy>
    mkdir mysql
    cd mkdir
    </copy>
    ```

2. Use below command to extract oscommerce database from OSCommerce MySQL instance using mysql client.

    ```
    <copy>
    mysqldump -u root oscommerce > data-dump.sql
    </copy>
    ```
    ![](./images/5.png "")

3. Use below command to connect with MDS instance using mysql client. You would need to enter IP address of MDS, username and password created in previous step.

    ```
    <copy>
    mysql -h <MDS_IP_address> -u admin -p
    </copy>
    ```
    ![](./images/6.png "")


4. Run the following command in the terminal. This will create oscommerce database and upload the dump to MDS Instance. Using show tables, please check if you are able to see all tables of oscommerce database.

    ```
    <copy>
    mysql> create database oscommerce;
    mysql> use oscommerce;
    mysql> source data-dump.sql;
    mysql> show tables;
    </copy>
    ```

    ![](./images/7.png "")

5. Run below command to exit from MDS. And then proceed to next step.

    ```
    <copy>
    mysql> exit;
    </copy>
    ```

## **Step 3:** Connecting your OSCommerce App with MDS

1. Please download the oscommerce App code to your laptop and move the zip contents to your primary instance using FileZilla tool. You can download filezilla from [here](https://filezilla-project.org/)
OSCommerce Web Application - [Link](https://objectstorage.us-ashburn-1.oraclecloud.com/p/YWohpF3cmZuDi2LWL056VHnNvlNTu37JaGMhM8oqenS_95gf2WBWfUCylfFY2jI_/n/orasenatdpltintegration03/b/workshop/o/oscommerce.zip)

Configure FileZilla connection to connect to your primary instance as below. And drag and drop oscommerce.zip file to the primary instance.
    ![](./images/8.png "")

    ![](./images/9.png "")

3. Run this command to delete old oscommerce application code and replace with the recent code.
    ```
    <copy>
    cd /var/www/

    </copy>
    ```

4. After running the command you will also be asked to answer prompts within the terminal window. Enter the following below where the password is the one you just set:
    ```
    Enter current password for root (enter for none): Type Root Password

    Change The Root Password? **N**

    Remove Anonymous Users? **Y**

    Disallow Root Login Remotely? **Y**

    Remove test database and access to it? **Y**

    Reload Privilege Tables now? **Y**
    ```


## Learn More
* To learn about connecting to MDS on OCI [link](https://docs.oracle.com/en-us/iaas/mysql-database/doc/connecting-db-system.html)
* To learn about MySQL Shell [link](https://dev.mysql.com/doc/mysql-shell/8.0/en/)

## Acknowledgements
* **Author** - Rajsagar Rawool
* **Adapted for Cloud by** -  Rajsagar Rawool
* **Last Updated By/Date** - Rajsagar Rawool, January 2021


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
