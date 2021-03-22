# Prerequisites 

## Introduction

In this step, we will show you how to prepare your work environment in Oracle Cloud Infrastructure. We will use cloud-shell as our terminal which is console based, web terminal built in OCI console. It is good to use this terminal, in case you are behind corporate VPN, in case you don't have stable network connection.
To use the Cloud Shell machine, your tenancy administrator must grant the required IAM (Identity and Access Management) policy.

*Estimated lab time*: 10 minutes

### Assumptions

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor, or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the resources available  to provision what mentioned in Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.
* Your cloud account user must have required IAM (Identity and Access Management) policy or admin user.
* Successfully logged in to your cloud tenancy, if not please [login](https://www.oracle.com/cloud/sign-in.html) to your cloud account.

### Objectives

-   Create SSH keys in cloud-shell environment
-   Configure API keys for your cloud user
-	Modify bash profile to interact with terraform 

## **Step 1**: Login to Oracle Cloud Infrastructure 

1. Let's prepare our work directory. We will use Cloud Shell in OCI web console, which is simple and sophisticated cloud terminal for the most of your need. It is located right top corner of OCI web console

	![](/images/0.Prep_0.PNG)

## **Step 2**: Generate SSH keys 

1. Once cloud shell environment is ready, issue below commands, it will create a ssh key files and api signing keys:

	```
	ssh-keygen -t rsa -N "" -b 2048 -f ~/.ssh/oci
	openssl genrsa -out ~/.ssh/oci_api_key.pem 2048
	openssl rsa -pubout -in ~/.ssh/oci_api_key.pem -out ~/.ssh/oci_api_key_public.pem
	openssl rsa -pubout -outform DER -in ~/.ssh/oci_api_key.pem | openssl md5 -c | awk '{print $2}' > ~/.ssh/oci_api_key.fingerprint
	```

2. Copy your public pem file content:

	```
	cat ~/.ssh/oci_api_key_public.pem
	```

	![](/images/0.Prep_1.PNG)

## **Step 3**: Add public API keys to your user

1. Click on right top corner of your OCI web console, and click on your **profile**. Then navigate to **API Keys** from left pane and click on **Add API Key** button. A small pop-up will appear and you need to choose "Paste Public Key" radiobutton. Paste your **copied public pem key** there and click on **Add** button.

	![](/images/0.Prep_2.PNG)

2. A small confirmation will show after you added an API key. **Copy** those values and open a notepad and keep them for a moment. We will modify them.

	![](/images/0.Prep_3.PNG)

## **Step 4**: Modify bash profile in your cloud shell

1. In your notepad, modify following lines:

	```
	<copy>
	export TF_VAR_compartment_ocid="your-tenancy-value-goes-here"
	export TF_VAR_fingerprint="your-fingerprint-value-goes-here"
	export TF_VAR_private_key_path="~/.ssh/oci_api_key.pem"
	export TF_VAR_region="your-region-value-goes-here"
	export TF_VAR_tenancy_ocid="your-tenancy-value-goes-here"
	export TF_VAR_user_ocid="your-user-value-goes-here"
	</copy>
	```
	_**NOTE:** if you are an experienced OCI user, I'd highly suggest you to use your own compartment to isolate all resources. To do so, provide your compartment OCID in `TF_VAR_compartment_ocid`. If you are new to OCI cloud, just enter your Tenancy value as compartment OCID._

2. After you modified above using your values, we need to add these lines to your ".bash_profile". Go to cloud-shell terminal and issue:

	```
	vi ~/.bash_profile
	```

	_**NOTE:** Editing a file uses **vi** editor, if you never used it before here is little instruction. When you issue **`vi .bash_profile`** it will open a file. You have to press **i** key to enable editing, then "shift+insert" to paste from clipboard. When you are done editing press **:wq** keys then hit enter for save & quit._

	![](/images/0.Prep_4.PNG)

3. Once you've set these values **exit** from cloud-shell terminal by clicking on exit "X" button on right top corner, then again re-open cloud-shell terminal.

	![](/images/0.Prep_0.PNG)

Now your terminal knows your parameters and you'll not get any error in the next lab. **REMEMBER**, you must close cloud-shell and re-open!
You've done with prerequisites.

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - Bilegt Bat-Ochir 3/22/2021