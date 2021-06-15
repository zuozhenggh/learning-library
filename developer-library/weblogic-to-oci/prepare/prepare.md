# Prepare the Oracle Cloud Infrastructure Account

## Introduction

In this lab we will prepare the Oracle Cloud Infrastructure (OCI) environment to provision WebLogic Server for OCI from the Oracle Cloud Marketplace.

Estimated Lab Time: 5 minutes.

### Objectives

In this lab you will:

- Create a Vault.
- Create a Key.
- Create a Secret to hold the WebLogic Admin password.
- Copy the Secret OCID to use during the provisioning stage.

### Prerequisites

For this lab you will need an OCI account with a compartment created.

## **STEP 1:** Create a Vault

1. Go to **Security** and select **Vault**.

   ![](./images/prereq-vault1.png)

2. Make sure you are in the compartment where you want to deploy WebLogic.

3. Click **Create Vault**.

   ![](./images/prereq-vault2.png)

4. Name the vault `WebLogic Vault` or a name of your choosing. Make sure the `private` option is not selected and click **Create Vault**.

   ![](./images/prereq-vault3.png)

## **STEP 2:** Create a Key in the Vault

1. Once the vault is provisioned, select the vault.

   ![](./images/prereq-vault4.png)

2. Click **Create Key**.

   ![](./images/prereq-key1.png)

3. Name the key `WebLogicKey` or a name of your choosing and click **Create Key**.

   ![](./images/prereq-key2.png)

## **STEP 3:** Create a Secret for the WebLogic Admin Password

1. Once the key is provisioned, click **Secrets**.

   ![](./images/prereq-secret1.png)

2. Click **Create Secret**.

  ![](./images/prereq-secret2.png)

3. Name the **Secret** `WebLogicAdminPassword`, select the `WebLogicKey` that you created in **Create a key in the vault** as the **Encryption Key**, keep the default `plaintext` option and type `welcome1` or any WebLogic compliant password (at least 8 characters and 1 uppercase letter or number) in the **Secret Content** text field, and click **Create Secret**.

  ![](./images/prereq-secret3.png)

4. Click the `WebLogicAdminPassword` secret you just created and make a note of its **OCID**.

   ![](./images/prereq-secret4.png)

That is all that's needed to get started.


## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020
