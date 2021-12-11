# B2B Trading Partner Manager

## Introduction

This lab walks you through the steps to work with Trading Partner Manager

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will learn:
* Define Host profile and identifiers
* Create Trading Partners
* Add Transports
*	Create Agreements based on the direction of message processing

### Prerequisites

This lab assumes you have:
* All previous labs successfully completed


## Task 1: Define Host Profile and Identifiers

1. Host trading partner concepts are provided. See **Host Company** in [Getting Started with B2B in Oracle Integration](../workshops/freetier/?lab=gettingStartedB2B)

*	Define Identifiers in the Host Profile
*	Create the Host Profile

**Define Identifiers in the Host Profile**

| Identifier Type | Purpose |
| --- | --- |
| EDI Interchange ID	 |Mandatory for all EDI data formats. This identifier is used as the Interchange Sender ID field of the interchange envelope (ISA segment for X12 and UNB segment for EDIFACT).For an outbound message, this value is inserted as the Interchange Sender ID. For an inbound message, this identifier (from the host profile) is not used.|
| EDI Interchange ID Qualifier |Mandatory for X12 and optional for EDIFACT.This identifier is used as the Interchange Sender ID Qualifier field of the interchange envelope of the EDI payload. It's a code to indicate the category of the value specified in the EDI Interchange ID (for example, DUNS number, IATA number, and so on).For an outbound message, this value is inserted as the Interchange Sender ID Qualifier. For an inbound message, the value (from the host profile) is not used.|
|EDI Group ID	|Mandatory for X12 and optional for EDIFACT.For an outbound X12 message, this value is inserted in the GS segment as the Application Sender's Code.For an inbound message, the value from the host profile is not used.|

**Create the Host Profile**

1.	In the left navigation pane, click **Menu > B2B > Host Profile**
2.	In the Host Company Name field, enter your company name
		<copy>Acme</copy>
		The name is currently only for reference and not used elsewhere.
3.	Select a host identifier or, if none are defined, click **Add** icon. You add identifiers to the host profile on behalf of your company.

Note: This is typically a one-time activity that you perform before adding your first trading partner. Host identifiers define your company when acting as the host interacting with other trading partners. They identify and validate the source of the document when sent by the host. Identifiers defined here are used in two places:
*	Transports
*	Outbound agreements

4.	Select a host identifier name and specify a value as per the table below.
| Identifier Type | Value |
| --- | --- |
| EDI Interchange ID	 |ACMEOICB2B|
| EDI Interchange ID Qualifier |ZZ|
|EDI Group ID	|Acme|
|EDI Group ID Qualifier|01|

5.	Click **Save**.

Note: If you change the host identifier value used in a deployed agreement, the changes only take effect after you explicitly redeploy the agreement between the host and the trading partner


## Task 2: Create Trading Partners

You can create and manage trading partners. A trading partner is the external business entity with which your company interacts to send or receive business documents, such as orders and invoices, in electronic form.

Trading partner concepts are provided. Refer [Getting Started with B2B in Oracle Integration](../workshops/freetier/?lab=gettingStartedB2B) Lab.

1.	In the left navigation pane, click **Menu > B2B > Trading Partners**
2.	Click **Create**. Enter the trading partner name as **Dell Inc** and an optional description. The Identifier field is automatically populated with the name you enter. The values for both must be unique. And click **Create**.

**Select Contact**

You can add ways to contact the trading partner, such as their name, email, phone number, or short message service (SMS) number. The Contact Type and Value fields are both free text fields. This enables you to enter custom text. Use this information to contact individuals offline, as needed. The Contacts field is currently provided only for reference and is not used in B2B for Oracle Integration

1.	Click **Contact** tab. Select Contact Type as **Email**. Enter your email id under Value column and click on **Save**
![](images/tpm-tp-contact-1.png)

**Define B2B Identifiers**

You collect identifying information from your external trading partner and enter it on their behalf in the B2B Identifiers section. This is very similar, in concept, to the identifiers specified under B2B > Host Profile > Identifiers. In a message exchange, the host's identifiers and trading partner's identifiers are used in the role of a sender or receiver, depending on the message direction.

Understand the identifiers and Create values for each of the required identifiers.

1. Click on **B2B Identifiers** tab. Select the below Identifiers and Values and click on **+** Icon to create multiple identifiers and click on **Save**

| Identifier Type | Purpose | Value |
| --- | --- | --- |
| EDI Interchange ID | Mandatory for all EDI data formats. This identifier is used as either the Interchange Sender or Receiver ID field of the interchange envelope. For an outbound message, this value is inserted as the Interchange Receiver ID. <ul><li>For an inbound message, this identifier is used as the Interchange Sender ID to identity a trading partner as a sender of a message</li><li>For an inbound message, this identifier is used as the Interchange Sender ID to identity a trading partner as a sender of a message.</li></ul> | Dell Inc.  |
|EDI Interchange ID Qualifier	|Mandatory for X12 and optional for EDIFACT. It is a code to indicate the category of the value specified in the EDI Interchange ID (for example, DUNS number, IATA number, and so on). For an outbound message, this value is inserted as the Interchange Receiver ID Qualifier.|ZZ|
|EDI Group ID	|This is mandatory for X12 and optional for EDIFACT. <ul><li>For an outbound X12 message, this value is inserted in the GS segment as the Application Receiver's Code</li><li>For an inbound message, this value is used only in case the EDI Interchange ID, on its own, is not enough to uniquely identify a trading partner</li></ul>|Dell Inc.|
|EDI Group ID Qualifier |It is a code to indicate the category of the value specified in the EDI Group ID (for example, DUNS number, IATA number, and so on).Only used for an outbound message, to insert as EDI Group ID Qualifier, if specified|01|
|Application Partner ID|Optionally used as an alternate way to specify which trading partner to which to route an outbound message.|Dell Inc.|

![](images/tpm-tp-B2BIdentifiers-1.png)
**Define Transports**

A transport maps to a technical communication protocol. In most cases, you add one transport per trading partner to receive or send messages from the partner.

Each transport is listed with its name, direction and type, status, and last updated time. The direction is an indicator of whether it is configured to receive (down arrow), send (up arrow), or both. Status can be:
<ul>
<li>Not deployed</li>
<li>Deploying</li>
<li>Deployed</li>
<li>Failed</li>
</ul>

1.	Click **Transports & Agreements** tab. In the Transports section, click **+** to add a new Transport. Enter the details as per the below and click on **Save**.
Note: . The AS2 and FTP transport protocols are currently supported

| Field                         | Description                 |
|------------------------------|------------------------------|
| Name                         | FTP                          |
| Type                         | FTP                          |
| Trading Partner's Connection | FTP Connection (File Server). Refer [Setup FTP Connection](../workshops/freetier/?lab=setup#Task4:CreatingConnectionwithFileServer)  |
| Output Directory             | /B2BWorkshop/B2BTPDELLOut    |
| Output File Name             | Order-%SEQ%.edi              |
| Integration Name Prefix      | Dell                       	|

Click **Add**

**B2B Integrations**

Two integrations are created automatically under the covers when a transport is created. These integrations are the heart of the transport for its runtime functioning. The two integrations actually process the runtime messages that pass through the transport.
    <ul><li>B2B integration for receiving messages (Dell FTP Receive)</li>
		<li>B2B integration for sending messages (Dell FTP Send)</li></ul>

Click the **Action** menu on a row to view available actions. Select **Deploy**

![](images\tpm-tp-Transport-1.png)

Navigate to the **Integrations** page and note that both Integrations created and Status is **Active**

![](images\tpm-tp-Transport-2.png)

## Task 3: Create Agreements
This section describes about creating and managing agreements. You define one or more agreements for a B2B trading partner with an intent to send or receive only certain types of business documents to or from that trading partner.

Detailed agreement concepts are provided. See **Agreements** in [Getting Started with B2B in Oracle Integration](../workshops/freetier/?lab=gettingStartedB2B)

In the left navigation pane, click **Menu > B2B > Trading Partners**

**Define Outbound Agreement**

1.	Click **Transports & Agreements**
2.	In the **Outbound Agreements** section, click **Add (+)** icon to add a new agreement.

Enter the details as per below
| Field                              | Value                       |
|------------------------------------|-----------------------------|
| Name                               | OutAgreement                |
| Select a Document                  | PurchaseOrder4010Document   |
| Select Trading Partner Identifiers | <ul><li>Application Partner ID</li><li>EDI Group ID Qualifier</li><li>EDI Group ID</li><li>EDI Interchange ID Qualifier</li><li>EDI Interchange ID</li></ul>                            |
| Select Host Identifiers            |<ul><li>EDI Interchange ID </li><li>EDI Interchange ID Qualifier</li><li>EDI Group ID Qualifier</li><li>EDI Group ID</li></ul>                             |
| Select a Transport                 | FTP                         |
| Configure Agreement Settings       | Select "Enable Validations" |
| Configure Agreement Settings       | Uncheck "Functional Ack Required" |

![](images/tpm-tp-Agreement-Out-1.png)

3.	Click **Add**
4.	From the **Action** menu, select **Deploy**

> **Note** : Deploy Transport and Transport agreements. You can deploy in any sequence and if you modify anything, you can just deploy the corresponding section. For example, if you modify outbound transport agreement then you can deploy(or redeploy) only outbound transport agreement


You may now [proceed to the next lab](#next).

## Learn More

* [B2B for Oracle Integation in Trading Partner Mode](https://docs.oracle.com/en/cloud/paas/integration-cloud/integration-b2b/b2b-oracle-integration-intrading-partner-mode.html)


## Acknowledgements
* **Author** - Kishore Katta, Technical Director, Oracle Integration Product Management
* **Contributors** -  Subhani Italapuram, Oracle Integration Product Management
* **Last Updated By/Date** -
