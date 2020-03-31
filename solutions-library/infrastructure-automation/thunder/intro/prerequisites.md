# Prerequisites

## Introduction

Terraform and python are needed to run all of the components in this framework.
In addition to this, you will also need to generate an OCI API key, add it to your OCI user and prepare tenancy variables in the **provider.auto.tfvars** file.

### Installing Terraform

Go to [terraform.io](https://www.terraform.io/downloads.html) and download the proper package for your operating system and architecture. Terraform is distributed as a single binary. 
Install Terraform by unzipping it and moving it to a directory included in your system's PATH. You will need the latest version available.

### Installing Python

Go to [python.org](https://www.python.org/downloads/release/python-370/) and download the proper package for your operating system and architecture. Install python by following the setup instructions.

### Prepare Terraform Provider Values

In order to prepare provider.auto.tfvars file, you will need the following:
- Tenancy OCID
- User OCID
- Local Path to your private oci api key
- Fingerprint of your public oci api key
- Region



#### Getting the Tenancy and User OCIDs

You will have to login to the [console](https://console.us-ashburn-1.oraclecloud.com) using your credentials (tenancy name, user name and password). If you do not know those, you will have to contact a tenancy administrator.

In order to obtain the tenancy ocid, after logging in, from the menu, select Administration -> Tenancy Details. The tenancy OCID, will be found under Tenancy information and it will be similar to **ocid1.tenancy.oc1..aaa…**

In order to get the user ocid, after logging in, from the menu, select Identity -> Users. Find your user and click on it (you will need to have this page open for uploading the oci_api_public_key). From this page, you can get the user OCID which will be similar to **ocid1.user.oc1..aaaa…**



#### Creating the OCI API Key Pair and Upload it to your user page

Create an oci\_api\_key pair in order to authenticate to oci [api_key](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#How)

Create the .oci directory in the home of the current user

$ mkdir ~/.oci

Generate the oci api private key

$ openssl genrsa -out ~/.oci/oci\_api\_key.pem 2048

Make sure only the current user can access this key

$ chmod go-rwx ~/.oci/oci\_api\_key.pem

Generate the oci api public key from the private key

$ openssl rsa -pubout -in ~/.oci/oci\_api\_key.pem -out ~/.oci/oci\_api\_key\_public.pem

You will have to upload the public key to the oci console for your user (go to your user page -> API Keys -> Add Public Key and paste the contents in there) in order to be able to do make API calls.

After uploading the public key, you can see its fingerprint into the console. You will need that fingerprint for your provider.auto.tfvars file. 
You can also get the fingerprint from running the following command on your local workstation by using your newly generated oci api private key.

$ openssl rsa -pubout -outform DER -in ~/.oci/oci\_api\_key.pem | openssl md5 -c



#### Getting the Region

Even though, you may know your region name, you will needs its identifier for the provider.auto.tfvars file (for example, US East Ashburn has us-ashburn-1 as its identifier).

In order to obtain your region identifier, you will need to Navigate in the OCI Console to Administration -> Region Management

Select the region you are interested in, and save the region identifier.


#### Prepare the provider.auto.tfvars file

You will have to modify the **provider.auto.tfvars** file to reflect the values that you’ve captured. In the end, your file should look like this:

```
provider_oci = {
  tenancy       = "ocid1.tenancy.oc1.."
  user_id       = "ocid1.user.oc1.."
  fingerprint   = "45:87:.."
  key_file_path = "/root/.oci/oci_api_key.pem"
  region        = "us-ashburn-1"
}
```