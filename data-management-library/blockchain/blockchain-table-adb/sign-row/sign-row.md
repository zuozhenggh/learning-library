# Work with Signatures for Blockchain Table

## Introduction

This lab walks you through the steps to generate your x509 keypair. Add your certificate to the certificates table, create a signature, update the row with the signature and finally verify the blockchain table.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

* Create certificate in a directory
* Generate your x509 keypair
* Add certificate to certificates table
* Generate row bytes to sign a row in blockchain table.
* Sign the row and verify the blockchain table

### Prerequisites

* Provisioned an Oracle Database 21c Instance
* Created a Blockchain tables and inserted data into it.

## **STEP 1:** Create a certificate directory

1.  Create a `CERT_DIR` certificate directory in the ATP.

	```
	<copy>
	CREATE DIRECTORY CERT_DIR AS 'CERT_DIR';
	</copy>
	```

	![](./images/cert-dir.png " ")

## **STEP 2:** Generate certificate

Let's connect to Oracle cloud shell to generate your x509 keypair.

1. Navigate back to the tab with Oracle Cloud console. Click on the cloud shell icon at the top right of the page to start the Oracle Cloud shell.

2. Create a folder `demo` and navigate into the folder.

	```
	<copy>
	cd ~
	mkdir demo
	cd demo
	</copy>
	```

3. Run the command to generate your x509 key pair - *user01.key*, *user01.pem*.

	Press enter after providing each detail - Country Name, State, Locality Name, Organization name, Common name, Email address.

	```
	<copy>
	openssl req -x509 -sha256 -nodes -newkey rsa:4096 -keyout user01.key -days 730 -out user01.pem
	</copy>
	```

4.	List the files and notice that your *user01.key*, *user01.pem* key pair is created.

	```
	<copy>ls</copy>
	```

	![](./images/pem.png " ")

## **STEP 3:** Add your certificate to the ATP instance

1. Copy and paste the below command in cloud shell. *Do not hit enter*. Replace the `<namespace>` with the namespace of your demo-bucket you copied earlier in lab 1 step 3 to upload the `user01.pem` key to object storage.

	```
	<copy>
	oci os object put -ns <namespace> -bn demo-bucket --file user01.pem
	</copy>
	```

	Your command should look like this

	```
	oci os object put -ns idytgywzwo9h -bn demo-bucket --file user01.pem
	```

2. Navigate to the tab with SQL Developer Web. Copy and paste the below procedure in the worksheet and replace the `<namespace>` in onject_uri with the namespace of your demo-bucket to download the `user01.pem` key from object storage to ATP using the `demotoken` credential.

	```
	<copy>
	BEGIN
	DBMS_CLOUD.GET_OBJECT(
		credential_name => 'demotoken',
		object_uri => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/<namespace>/b/demo-bucket/o/user01.pem',
		directory_name => 'CERT_DIR');
	END;
	/
	</copy>
	```

	You procedure should look like this

	```
	BEGIN
	DBMS_CLOUD.GET_OBJECT(
		credential_name => 'demotoken',
		object_uri => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/idytgywzwo9h/b/demo-bucket/o/user01.pem',
		directory_name => 'CERT_DIR');
	END;
	/
	```

3. List files in the `CERT_DIR` certificate directory and notice the `user01.pem` key is uploaded to ATP.

	```
	<copy>
	SELECT * FROM DBMS_CLOUD.LIST_FILES('CERT_DIR');
	</copy>
	```

4. Before you register your key to sign, you need to create a certificate. *Make sure to copy the **Certificate GUID** value as it is not shown again.*

	```
	<copy>
	DECLARE
  	  file BFILE;
  	  buffer BLOB;
  	  amount NUMBER := 32767;
  	  cert_guid RAW(16);
	BEGIN
  	  file := BFILENAME('CERT_DIR', 'user01.pem');
      DBMS_LOB.FILEOPEN(file);
	  DBMS_LOB.READ(file, amount, 1, buffer);
	  DBMS_LOB.FILECLOSE(file);
	  DBMS_USER_CERTS.ADD_CERTIFICATE(buffer, cert_guid);
	  DBMS_OUTPUT.PUT_LINE('Certificate GUID = ' || cert_guid);
	END;
	/
	</copy>
	```

	![](./images/add-cert.png " ")

5. To verify the certificate is created, view **CERTIFICATE_GUID** value by selecting all the columns from `USER_CERTIFICATES` table ordered by user\_name.

	```
	<copy>
	SELECT * FROM USER_CERTIFICATES ORDER BY user_name;
	</copy>
	```

	![](./images/select.png " ")

## **STEP 4**: Generate row bytes to sign a row in the blockchain table

1. Query the Blockchain table and make note of the `ORABCTAB_INST_ID$`, `ORABCTAB_CHAIN_ID$` and `ORABCTAB_SEQ_NUM$` column values for the row you want to sign.

	In this example, we will be signing the row with ORABCTAB\_INST\_ID$ - 1, ORABCTAB\_CHAIN\_ID$ - 17 and ORABCTAB\_SEQ\_NUM$ - 1.

	```
	<copy>
	select bank, deposit_date, deposit_amount, ORABCTAB_INST_ID$,
	ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$,
	ORABCTAB_CREATION_TIME$, ORABCTAB_USER_NUMBER$,
	ORABCTAB_HASH$, ORABCTAB_SIGNATURE$, ORABCTAB_SIGNATURE_ALG$,
	ORABCTAB_SIGNATURE_CERT$ from bank_ledger;
	</copy>
	```

2. To sign the row we need the bytes of the row that writes to a file. Replace the existing `ORABCTAB_INST_ID$`, `ORABCTAB_CHAIN_ID$` and `ORABCTAB_SEQ_NUM$` value `1` with the values you just noted and run the command to get the bytes for the row and write to a file called `row_data`.

	```
	<copy>
	DECLARE
		row_data BLOB;
		buffer RAW(4000);
		inst_id BINARY_INTEGER;
		chain_id BINARY_INTEGER;
		sequence_no BINARY_INTEGER;
		row_len BINARY_INTEGER;
		l_output utl_file.file_type;
	BEGIN
		SELECT ORABCTAB_INST_ID$, ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$ INTO inst_id, chain_id, sequence_no FROM bank_ledger WHERE ORABCTAB_INST_ID$=1 and ORABCTAB_CHAIN_ID$=1 and ORABCTAB_SEQ_NUM$=1;
		DBMS_BLOCKCHAIN_TABLE.GET_BYTES_FOR_ROW_SIGNATURE('DEMOUSER','bank_ledger',inst_id, chain_id, sequence_no, 1, row_data);
		row_len := DBMS_LOB.GETLENGTH(row_data);
		DBMS_LOB.READ(row_data, row_len, 1, buffer);
		l_output := utl_file.fopen('CERT_DIR', 'row_data', 'WB', 32767);
		utl_file.put_raw(l_output,buffer, TRUE);
	END;
	/
	</copy>
	```

	![](./images/row-byte.png " ")

3. Notice the `row_data` file is created in the `CERT_DIR` directory.

	```
	<copy>
	SELECT * FROM DBMS_CLOUD.LIST_FILES('CERT_DIR');
	</copy>
	```

	![](./images/row-byte-created.png " ")

4. Let's put the `row_data` file in object storage. Replace the `<namespace>` with you demo-bucket namespace and upload the `row_data` to object storage from ATP using the `atp1` credential created.

	```
	<copy>
	BEGIN
	DBMS_CLOUD.PUT_OBJECT (
		credential_name      => 'demotoken',		
		object_uri           => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/<namespace>/b/demo-bucket/o/',		
		directory_name       => 'CERT_DIR',
		file_name            => 'row_data');	
	END;
	/
	</copy>
	```

5. Navigate to the tab with `demo` directory in Oracle cloud shell and run the below command to download the `row_data` object from `demo-bucket` from Object Storage.

	```
	<copy>
	oci os object get -bn demo-bucket --name row_data --file row_data
	</copy>
	```

6.	List the files and notice that your `row_data` file is downloaded to your demo directory.

	```
	<copy>
	ls
	</copy>
	```

7. Run the below command to generate the `row1.sha256` for the `row_data` file.

	```
	<copy>
	openssl dgst -sha256 -sign user01.key -out row1.sha256 row_data
	</copy>
	```

8. List the file and to see that the `row1.sha256` file is created.

	```
	<copy>
	ls
	</copy>
	```

	![](./images/row-sha-created.png " ")

9. Now let's upload the `row1.sha256` file to object storage. Copy and paste this command in cloud shell and replace the `<namespace>` with the namespace of your `demo-bucket` to upload the `row1.sha256` to object storage.

	```
	<copy>
	oci os object put -ns <namespace> -bn demo-bucket --file row1.sha256
	</copy>
	```

10. Navigate back to the tab with SQL Developer web. Copy and paste the below code snippet and replace the `<namespace>` in object_uri with the namespace of your `demo-bucket` to download the `row1.sha256` from object storage to ATP using the `demotoken` credential created.

	```
	<copy>
	BEGIN
	DBMS_CLOUD.GET_OBJECT(
		credential_name => 'demotoken',
		object_uri => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/<namespace>/b/demo-bucket/o/row1.sha256',
		directory_name => 'CERT_DIR');
	END;
	/
	</copy>
	```

9. List the files in `CERT_DIR` directory and notice that `row1.sha256` is downloaded to ATP from object storage.

	```
	<copy>
	SELECT * FROM DBMS_CLOUD.LIST_FILES('CERT_DIR');
	</copy>
	```

## **STEP 5:** Sign the row and verify the row with signature

1. Now let's sign the row. Replace the `<B6622BA923717399E0530400000AA85A>` value with your **CERTIFICATE\_GUID** value you saved earlier. Update `ORABCTAB_INST_ID$`, `ORABCTAB_CHAIN_ID$` and `ORABCTAB_SEQ_NUM$` value `1` with the values for which you generated the row bytes and run the script.

	```
	<copy>
	DECLARE
    	file BFILE;
    	amount NUMBER := 32767;
        	signature RAW(32767);
        	cert_guid RAW (16) := HEXTORAW('B759871FE24EE279E0533D11000AE5DC');
    	inst_id binary_integer;
    	chain_id binary_integer;
    	sequence_no binary_integer;
	BEGIN
    	SELECT ORABCTAB_INST_ID$, ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$ INTO inst_id, chain_id, sequence_no FROM bank_ledger WHERE ORABCTAB_INST_ID$=1 and ORABCTAB_CHAIN_ID$=1 and ORABCTAB_SEQ_NUM$=1;
    	file := bfilename('CERT_DIR', 'row1.sha256');
    	DBMS_LOB.FILEOPEN(file);
    	dbms_lob.READ(file, amount, 1, signature);
    	dbms_lob.FILECLOSE(file);
    	DBMS_BLOCKCHAIN_TABLE.SIGN_ROW('DEMOUSER','bank_ledger', inst_id, chain_id, sequence_no, NULL, signature, cert_guid, DBMS_BLOCKCHAIN_TABLE.SIGN_ALGO_RSA_SHA2_256);
	END;
	/
	</copy>
	```

	![](./images/sign.png " ")

2. Update `ORABCTAB_INST_ID$`, `ORABCTAB_CHAIN_ID$` and `ORABCTAB_SEQ_NUM$` value `1` with the values for which you created the signature and query all the columns from the `bank_ledger` blockchain table and notice the signature is updated for the row.

	```
	<copy>
	select bank, deposit_date, deposit_amount, ORABCTAB_INST_ID$,
	ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$,
	ORABCTAB_CREATION_TIME$, ORABCTAB_USER_NUMBER$,
	ORABCTAB_HASH$, ORABCTAB_SIGNATURE$, ORABCTAB_SIGNATURE_ALG$,
	ORABCTAB_SIGNATURE_CERT$ from bank_ledger where ORABCTAB_INST_ID$=1 and ORABCTAB_CHAIN_ID$=1 and ORABCTAB_SEQ_NUM$=1;
	</copy>
	```

	![](./images/check.png " ")

3. Verify the rows with signature.

	```
	<copy>
	DECLARE
        verify_rows NUMBER;
        instance_id NUMBER;
	BEGIN
        FOR instance_id IN 1 .. 4 LOOP
            DBMS_BLOCKCHAIN_TABLE.VERIFY_ROWS('DEMOUSER','BANK_LEDGER', NULL, NULL, instance_id, NULL, verify_rows, true);
            DBMS_OUTPUT.PUT_LINE('Number of rows verified in instance Id '|| instance_id || ' = '|| verify_rows);
        END LOOP;
	END;
	/
	</copy>
	```

	![](./images/verify-rows.png " ")


You may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** - Rayes Huang, Mark Rakhmilevich, Anoosha Pilli
* **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
* **Last Updated By/Date** - Anoosha Pilli, April 2021