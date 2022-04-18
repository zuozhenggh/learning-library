# ERP Cloud Adapter Connection configuration

## Introduction

This lab walks you through the steps to create Integration flow.

This Lab explores the use of Oracle Integration to subscribe to Oracle ERP Cloud Events and
push the relevant event information to downstream systems. As part of the lab you will build the following use case scenario:

1.  You create and activate an integration that subscribes to an ERP Cloud Purchase Order (PO) event

2.  You then create a PO in ERP Cloud and a PO event is triggered.
3. Your integration receives the PO event and pushes the data
    into a Visual Builder Web App

    The following diagram shows the runtime interaction between the systems involved in this use case:
      ![POEvent](images/PO-Real-Time-Sync.png)

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Understand different authentication schemes supported by ERP Cloud Adapter

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed.

##	Task	1: Create the PO Event Integration
1. In the left Navigation pane, click **Integrations** > **Integrations**.
2. On the Integrations page, click **Create**.
3. On the *Integration Style* dialog, select **App Driven Orchestration**, followed by **Select**
![Select Integration Style](images/select-integration-style.png)
4. In the *Create New Integration* dialog, enter the following information:

    | **Element**        | **Value**          |       
    | --- | ----------- |
    | Name         | `ERPPOEvent`       |
    | Description  | `ERP Event integration for LiveLabs demo` |


    Accept all other default values.

5. Click **Create**.

6. Click **Save** to apply changes.

## **Task 2:** Define ERP Purchase Order (PO) Event trigger
Add ERP PO Event trigger to the empty integration canvas.

1. Click the **+** sign below *START* in the integration canvas.

2. Select the configured ERP Cloud adapter. This invokes the Oracle ERP Cloud Endpoint Configuration Wizard.

3. On the Basic Info page, for *What do you want to call your endpoint?* element, enter `ERP_POEvent`.

4. Click **Next**.

5. On the Request page, select the following values:

    | **Element**        | **Value**          |       
    | --- | ----------- |
    | Define the purpose of the trigger         | **Receive Business Events raised within ERP Cloud**       |
    | Business Event for Subscription  | **Purchase Order Event** |
    | Filter Expr for Purchase Order Event | [see code snippet below] |
    |

    ```
    <copy>
    <xpathExpr xmlns:ns0="http://xmlns.oracle.com/apps/prc/po/editDocument/purchaseOrderServiceV2/" xmlns:ns2="http://xmlns.oracle.com/apps/prc/po/editDocument/purchaseOrderServiceV2/types/">$eventPayload/ns2:result/ns0:Value/ns0:PurchaseOrderLine/ns0:ItemDescription="Lan Cable"</xpathExpr></copy>
    ```

    > **Tip:** If you are working on a shared ERP Cloud environment, it is recommended to use a distinct value in the filter expression under **ItemDescription**. For example `Lan Cable <your-initials>`. The value you enter is case sensitive. Write down this value for later use.


    > **Note:** The filter is not required, however it does allow you to control which integration should be triggered. This is useful if there are multiple integrations subscribed to the PO Event in the same ERP Cloud environment. Without the filter expression, all integrations subscribed to the PO Event would get triggered whenever that specific event occurs.

6. Click **Next**.

7. On the Response page, for *Response Type* element, choose **None**. Click **Next**.

8. On the Summary page, click **Done**.

9. On the integration canvas, from the Layout list, choose **Horizontal**.

    ![Horizontal Flow layout](images/horizontal-flow-layout.png)


10. Click **Save** to persist changes.

## **Task 3:** Add the FTP Adapter as invoke activity
Add the FTP Adapter invoke to the integration canvas.
1. Hover you cursor over the arrow in the integration canvas to display the **+** sign. Click the **+** sign and select the FTP Connection created in previous labs.
This invokes the FTP adapter Configuration Wizard.
2. On the Basic Info page, select the following values:
  | **Element**        | **Value**          |       
  | --- | ----------- |
  | What do you want to call your endpoint? | `WritePO2FTP`       |

3. On the Operation page, select the following values:

    | **Element**        | **Value**          |       
    | --- | ----------- |
    | Select Operation | Write File  |
    | Output Directory | /home/users/subhani.italapuram@oracle.com/Output  |
    | File Name Pattern | PO%SEQ%.txt  |
3. On the Schema page, select the "Sample JSON document" from the drop down:
4. On the File Contents - Definition page, upload the file [Download the Purchase Order JSON](files/PurchaseOrder.json?download=1) and upload it here.


You may now **proceed to the next lab**.

## Learn More

* [Getting Started with Oracle Integration](https://docs.oracle.com/en/cloud/paas/integration-cloud)
* [Using the Oracle ERP Cloud Adapter with Oracle Integration](https://docs.oracle.com/en/cloud/paas/integration-cloud/erp-adapter)

## Acknowledgements

* **Author** - Subhani Italapuram, Product Management, Oracle Integration
* **Contributors** - Kishore Katta, Product Management, Oracle Integration
* **Last Updated By/Date** -
