# Register a Target Database with Private IP Address

## Introduction
Oracle Data Safe can connect to an Oracle Cloud database that has a public or private IP address on a virtual cloud network (VCN) in Oracle Cloud Infrastructure (OCI). This workshop describes the difference between public and private endpoints and explains the network connection between Oracle Data Safe and the databases. It also walks you through the steps of creating a private endpoint and registering a Exadata Cloud DB system with Oracle Data Safe when the DB system has a private IP address.

## **Step 1:** Create a Private Endpoint

If your DB system has a private IP address, you need to create a private endpoint for it prior to registering it with Oracle Data Safe. You can create private endpoints on the Data Safe page in OCI. Be sure to create the private endpoint in the same tenancy and VCN as your database. The private IP address does not need to be on the same subnet as your database, although, it does need to be on a subnet that can communicate with the database. You can create a maximum of one private endpoint per VCN.

1. From your database's Console in OCI, obtain the name of the virtual cloud network (VCN) on which your database resides. You can find the name on the DB System Information tab.

    ![](./images/dbsystem-info.png " ")

2. From the navigation menu in OCI, select **DataSafe**. The **Data Safe** page is displayed.

    ![](./images/login.png " ")

3. On the left click **Private Endpoint**. The **Private Endpoint** is displayed.

    ![](./images/private-endpoint.png " ")

4. Click **Create Private Endpoint**. The **Create Private Endpoint** page is displayed.

    ![](./images/create-pe.png " ")

5. In the **Name** field, enter the name of your private endpoint.

6. Select the compartment in which you want to store the private endpoint.

7.  Scroll down to the **Private Endpoint Information** section.

8. From the **VIRTUAL CLOUD NETWORK** drop-down list,select your database's VCN. If needed, click **CHANGE COMPARTMENT** and select the compartment that stores your VCN. You can select a different VCN than your database's VCN if VCN peering is set up between your database's VCN and the VCN that you select here.

9. From the SUBNET drop-down list, select a subnet within the selected VCN. If needed, click **CHANGE COMPARTMENT** and select the compartment that stores the subnet that you want to use. The subnet can be in a different compartment than the VCN. The subnet that you select needs to have access to the database's subnet.

10. (Optional) In the **PRIVATE IP** field, specify a private IP address. If you do not specify a private IP address, OCI automatically generates one for you in the selected subnet.

11. (Optional)Select a network security group. The following screenshot shows you an example configuration for a private endpoint:

    ![](./images/private-endpoint-details.png " ")

12. Click **Create Private Endpoint.**
A private endpoint is provisioned in the customer VCN (the VCN that you selected). The following screenshot shows you the private endpoint listed on the **Private Endpoints** page.

    ![](./images/private-endpoint-view.png " ")

## **Step 2:** Update the Related Security List and Network Security Group

After creating the private endpoint and before registering the DB system with Oracle Data Safe, you need to update the related security list and network security group (if implemented) for your database VCN to allow traffic from the private endpoint IP address to the DB system. This step is required so that Oracle Data Safe can connect to your DB system. The following diagram illustrates an example of how to configure a security list.

1. **Ingress for the database:** The database (on port 1521) can receive incoming traffic from the private endpoint's private IP address (from any port).

    ![](./images/private-ip-nsg.png " ")

2. **Egress for the private endpoint:** The private endpoint (from any port) can send requests to the database IP address (on port 1521).

    ![](./images/private-ip-nsg2.png " ")

## **Step 3:** Register a ExaCS DB using a Private IP

You can manually register DB systems (with public or private IP addresses) with Oracle Data Safe in the Oracle Data Safe Console. When you register a DB system with a private IP address, you are required to select a private endpoint and enter the database's private IP address and Oracle Cloud Identifier (OCID).

1. From the database's Console in OCI, obtain the private IP address for the database. For an Exadata DB system, Oracle recommends that you use one of the scan IP addresses. You can find a scan IP address under Network on the DB System Information tab, as shown below.

    ![](./images/exacs-scan-ip.png " ")

2. Sign in to the Oracle Data Safe Console.

3. Click the **Targets** tab.

4. Click **Register.** The **Register Target** dialog box is displayed.

    ![](./images/register-target.png " ")

5. Specify a name for your target database.

6. For **Target Type**, select **Oracle Database**.

7. (Optional) Enter a description for your target database.

8. Select the resource group to which you want your target database to belong. Alternatively, you can specify a new resource group.

9. For **Database with PrivateIP**, select **Yes**.

10. For **Private Endpoint**, select the name of the private endpoint that you created for your target database.

11. In the **OCID** field, enter the Oracle Cloud Identifier of your database system. You cannot use the OCID of the database or PDB.

12. For the connection type, select **TCP** or **TLS**. The default selection is TCP.

13. In the **Hostname/IP Address** field, enter the private IP address for your database. For an Exadata DB system, Oracle recommends that you enter one of the private scan IP addresses. Alternatively, you can enter the private floating IP address of any one of the database nodes.

14. Enter the port number for the database.

15. Enter the long version of the database service name for the target database; for example, **abc_prod.subnetad3.tttvcn.companyvcn.com**. For Virtual Machine, Bare Metal, and Exadata DB systems, you can find the service name by running the following statement when connected to the PDB via SQL Plus:

    ```
    <copy>select sys_context('userenv','service_name') from dual;</copy>
    ```

16. Enter the database username and password that you created on the target database specifically for Oracle Data Safe. If you created the user on the target database without quotation marks, you must enter the user name in uppercase here. For example, if the user name on the target database is called test, then you must enter TEST.
You cannot specify database roles, such as SYSDBA or SYSKM, and you cannot specify SYS as the user.

17. (Optional)To verify that Oracle Data Safe can successfully connect to the target database, click Test Connection.

18. Before you register the target, click **Download Privilege Script** and save the dscs_privileges.sql script to your computer. You need to run this script on your database after you are done with registration.

19. Click **Register Target**. You cannot register the target database if the connection test fails or if the target database does not exist.

    ![](./images/target-details.png " ")

20. Grant privileges to the database user that you created for Data Safe using the privilege script you downloaded. See [Grant Roles to the Oracle Data Safe Service Account on a DB System](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/grant-roles-oracle-data-safe-service-account-db-system.html).

You may proceed to the next lab.

## Acknowledgements

- **Author** - Tejus Subrahmanya, Phani Turlapati, Abdul Rafae, Sathis Muniyasamy, Sravya Ganugapati, Padma Natarajan, Aubrey Patsika, Jacob Harless
- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
