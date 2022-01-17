


# Create an Oracle ERP Cloud Adapter Connection 
Before you can build an integration, you have to create the connections to the applications with which you want to share data. Follow these steps to create an ERP Cloud connection.

1. In the left navigation pane, click **Home** > **Integrations** > **Connections**.

2. Click **Create**.

3. In the *Create Connection - Select Adapter* dialog, select the **Oracle ERP Cloud** adapter to use for this connection. To find the adapter, enter `erp` in the search field. Click on the highlighted adapter and hit **Select**.
    ![](images/create-erp-connection01.png)

4. In the *Create Connection* dialog, enter the following information:

| **Field**        | **Value**          |       
| --- | ----------- |
| Name         | `ERP_LLDemo`       |
| Description  | `ERP Connection for Livelabs demo` |
|

Keep all other values as default.

5. In the *Oracle ERP Cloud Connection* dialog, enter the following information:

| **Field**  | **Values** |
|---|---|
|ERP Cloud Host | `your-host-name` |
|Security Policy | `Username Password Token`|
|Username | `<user>`|
|Password | `<password>`|
|

6. Click on **Test**, followed by **Save**. Exit the connection canvas by clicking the back button on the top left side of the screen.
