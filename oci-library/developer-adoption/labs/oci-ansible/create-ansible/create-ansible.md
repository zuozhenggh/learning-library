# Oracle Cloud Infrastructure Ansible Collection

  ## Introduction
  
  [Oracle Cloud Infrastructure Ansible Collection](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/ansiblegetstarted.htm) provides an easy way to provision and manage resources in Oracle Cloud using Ansible. With the creation of Oracle Cloud Ansible Collection, we are providing two user benefits:
  
   **Faster Availability** - Oracle Cloud Ansible Modules will now be available to users at a faster pace on Ansible Galaxy. 
   
   **Wider Coverage** - Support for the majority of the Oracle Cloud services.

   Below is a collection ofi OCI Ansible collateral for your reference before we walk through a OCI Ansible tutorial.

   - [Ansible Galaxy Reference](https://galaxy.ansible.com/oracle/oci)

   -  [OCI Ansible Samples](https://github.com/oracle/oci-ansible-collection/tree/master/samples)

   - [OCI Ansible Solutions](https://github.com/oracle/oci-ansible-collection/tree/master/solutions)




In this tutorial, we’re going to use [OCI Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm) since Ansible comes pre-installed for your environment. We are  going to install the Oracle Cloud Infrastructure Ansible collection. You then will write a sample playbook that uses Ansible modules on OCI. 

### Pre-Requisites

* Need to be an OCI Tenancy Administrator

## Task 1: Install an OCI Ansible Collection using Cloud Shell

1. To start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon at the top right of the page.

![](./images/cloudshellopen.png " ")

    ![](./images/cloudshellsetup.png " ")

    ![](./images/cloudshell.png " ")
.

2. From the OCI Cloud Shell, install the OCI Ansible collection from Ansible Galaxy by using the following command:

```bash
$ ansible-galaxy collection install oracle.oci
```

   ![](./images/Ansible-Cloud-Shell1.png " ")



2. ***Stream Name:*** Required. Specify a friendly name for the stream. It does not have to be unique within the compartment, but it must be unique to the stream pool. The stream name cannot be changed. Avoid entering confidential information.

4. Compartment: Choose the compartment in which the stream will be created. FOr this lab, we will keep it in the root tenancy.

5. ***Stream Pool:*** Choose the stream pool that will contain your stream.

   a. If your chosen compartment has an existing stream pool, you can select it from the drop-down list or click Create new stream pool and configure the stream pool manually.

   b. **If no stream pool exists** in the chosen compartment, select Auto-create a default stream pool or click Create a new stream pool and configure the stream pool manually.

6. In the Define Stream Settings panel:

    a. ***Retention (in Hours):*** Enter the number of hours (from 24 to 168) to retain messages. The default value is 24.

    b. ***Number of Partitions:*** Enter the number of partitions for the stream. The maximum number is based on the limits for your tenancy.

7. Click ***Show Advanced Options*** to optionally define Tags: If you have permissions to create a resource, then you also have permissions to apply free-form tags to that resource. To apply a defined tag, you must have permissions to use the tag namespace. For more information about tagging, see Resource Tags. If you are not sure whether to apply tags, skip this option (you can apply tags later) or ask your administrator.

8. Click ***Create***.

![OCI Stream](./images/OCI-Stream4.png)


## Task 2: Write an Ansible playbook on OCI

1. Open the navigation menu and click ***Storage***. Under ***Object Storage***, click ***Buckets***.

2. Select a ***compartment*** from the ***Compartment list***  on the left side of the page. For this lab you will remain in the tenancy root compartment.

You will keep all of the defaults for the bucket creation.

3. Click ***Create Bucket***.

4. Enter a ***Bucket Name*** . For this lab we will name the bucket **streaming-archive-demo-0**.

   You will keep all of the defaults for the bucket creation.

5. Click ***Create*** . 

![OCI Stream](./images/OCI-Stream5.png)

 


```bash
$ echo -n "key1" | base64
a2V5MQ==
$ echo -n "key2" | base64
a2V5Mg==
$ echo -n '{"id":"0", "test": "message from CLI"}' | base64
eyJpZCI6IjAiLCAidGVzdCI6ICJtZXNzYWdlIGZyb20gQ0xJIn0=
```

3. You then plug these encoded values into your OCI CLI commands and published both messages. The ***Stream id*** and *** stream endpoint*** can be retrieved from your stream information.

```bash
// key1
oci streaming stream message put \
  --stream-id ocid1.stream.oc1.phx… \
  --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com \
  --messages "[{\"key\": \"a2V5MQ==\", \"value\": \"eyJpZCI6IjAiLCAidGVzdCI6ICJtZXNzYWdlIGZyb20gQ0xJIn0=\"}]"

// key2
oci streaming stream message put \
  --stream-id ocid1.stream.oc1.phx… \
  --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com \
  --messages "[{\"key\": \"a2V5Mg==\", \"value\": \"eyJpZCI6IjAiLCAidGVzdCI6ICJtZXNzYWdlIGZyb20gQ0xJIn0=\"}]"
  ```

