# Install Oracle Cloud Infrastructure Ansible Collection and write a Playbook

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

   ## Task 2: Write a sample Ansible playbook 

   After your installation is complete, you can write a sample playbook that uses Ansible modules. Following is an example playbook (named list_buckets.yaml) that uses the oci_object_storage_bucket_facts module to fetch facts pertaining to the buckets in your compartment.

    
    ```yaml
$ ---
- name : List summary of existing buckets in OCI object storage
  collections:
    - oracle.oci
  connection: local
  hosts: localhost
  tasks:
    - name: List bucket facts
      oci_object_storage_bucket_facts:
         namespace_name: '<yournamespace>'
         compartment_id: '<yourcompartmentocid>'
      register: result
    - name: Dump result
      debug: 
        msg: '{{result}}'
 ```  






