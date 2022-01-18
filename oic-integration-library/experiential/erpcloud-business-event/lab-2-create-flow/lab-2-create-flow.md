# Create the Purchase Order Event Integration flow

## Introduction
This demo lab will walk you through the steps to create an end-to-end flow of the ERP Purchase Order Event integration.

### Objectives
You will demo the following:
- Initiate an App Driven integration flow
- Define ERP Purchase Order (PO) Event trigger
- Add the Create PO activity
- Define the Tracking Fields
- Activate the integration


## Task 1: Initiate an App Driven integration flow
We will start by creating a new integration and adding some basic info.

1. In the left Navigation pane, and click **Integrations** > **Integrations**.
2. On the Integrations page, click **Create**. 
3. On the *Integration Style* dialog, select **App Driven Orchestration**, followed by **Select**. 

    ![Select Integration Style](images/create-app-integration01.png)

4. In the *Create New Integration* dialog, enter the following information:

    | **Field**        | **Value**          |       
    | --- | ----------- |
    | Name         | `LLERPEventDemo`       |
    | Description  | `ERP Event integration for Livelabs demo` |
    |

    Accept all other default values. 

5. Click **Create**. 


## Task 2: Define ERP Purchase Order (PO) Event trigger
Add ERP PO Event trigger to the empty integration canvas.

1. Click the **+** sign below *START* in the integration canvas.

2. Select the configured ERP Cloud adapter. This invokes the Oracle ERP Cloud Endpoint Configuration Wizard.

3. In the *What do you want to call your endpoint?* field, enter `ERP_POEvent`. 

4. On the Request page, select the following values:

    | **Field**        | **Value**          |       
    | --- | ----------- |
    | Define the purpose of the trigger         | **Receive Business Events raised within ERP Cloud**       |
    | Business Event for Subscription  | **Purchase Order Event** |
    | Filter Expr for Purchase Order Event | `<xpathExpr xmlns:ns0="http://xmlns.oracle.com/apps/prc/po/editDocument/purchaseOrderServiceV2/" xmlns:ns2="http://xmlns.oracle.com/apps/prc/po/editDocument/purchaseOrderServiceV2/types/">$eventPayload/ns2:result/ns0:Value/ns0:PurchaseOrderLine/ns0:ItemDescription=`**"LL demo"**`</xpathExpr>` |
    |

    You can use a custom filter expression by inserting a different value under **ItemDescription**. The value you enter is case sensitive. 

    ![](images/create-app-integration03.png)

5. Click **Next**.

6. On the Response page, for *Response Type*, choose **None**.


## Task 3:


