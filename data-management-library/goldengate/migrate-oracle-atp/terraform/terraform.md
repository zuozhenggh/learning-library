# Lab 1 

## Introduction

In this step, we will show you how to prepare your work environment in Oracle Cloud Infrastructure. We will use cloud-shell which is a web-based terminal built into OCI console. To use the Cloud Shell machine, your tenancy administrator must grant your the required IAM (Identity and Access Management) policy.

This first lab is very important and where we will create all of our resources:

- Virtual Cloud Network
- Source Oracle database
- Target Autonomous database
- Goldengate database registrations
- Goldengate deployment

*Estimated lab time*: 15 minutes

### Objectives

-   Create SSH keys in a cloud-shell environment
-   Configure API keys for your cloud user
-	Modify bash profile to interact with terraform 
-   Prepare our work environment and create our lab resources using a Terraform script.

If you are running this lab in your existing tenancy, **make sure** you have the following compute quotas and resources available to use:

1. ATP for Target database - 1 OCPU, 1 TB storage
2. Virtual Machine for Source Database - VM.StandardE2.1

For a technical overview of this lab step, please watch the following video:

### Prerequisites

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the resources available to provision what is listed in the Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.
* Your cloud account user must have the required IAM (Identity and Access Management) policy or admin user.
* Successfully logged in to your cloud tenancy, if not please [login](https://www.oracle.com/cloud/sign-in.html) to your cloud account.

## **Step 1**: Open Cloud-Shell

1. Let's prepare our work directory. We will use Cloud Shell, it is located at the top right corner of the OCI web console

	![](/images/0.Prep_0.PNG)

## **Step 2**: Generate SSH keys 

1. Once the cloud shell environment is ready, issue the below 4 lines of commands. This will create the ssh key files and the api signing keys:

	```
	<copy>
	ssh-keygen -t rsa -N "" -b 2048 -f ~/.ssh/oci
	openssl genrsa -out ~/.ssh/oci_api_key.pem 2048
	openssl rsa -pubout -in ~/.ssh/oci_api_key.pem -out ~/.ssh/oci_api_key_public.pem
	openssl rsa -pubout -outform DER -in ~/.ssh/oci_api_key.pem | openssl md5 -c | awk '{print $2}' > ~/.ssh/oci_api_key.fingerprint
	</copy>
	```

2. Copy your public _**pem**_ file content:

	```
	<copy>
	cat ~/.ssh/oci_api_key_public.pem
	</copy>
	```

	![](/images/0.Prep_1.PNG)

## **Step 3**: Add Public API keys

1. Click on the top right corner of your OCI web console and click on your **profile**. Then navigate to the **API Keys** from the left pane and click on the **Add API Key** button. A small pop-up will appear and you need to choose the "Paste Public Key" radio button. Paste your **copied public pem key** there and click on the **Add** button.

	![](/images/0.Prep_2.PNG)

2. A small confirmation will show after you added an API key. **Copy** these values and open a notepad to keep these for a later use.

	![](/images/0.Prep_3.PNG)

## **Optional Step**: Modify Bash Profile (OPTIONAL)

1. This step is **not needed** if you are running this lab from OCI **cloud-shell**, you can skip to **Step 5**. However will require this step when you run workshop from your local machine. In your notepad, copy the below lines and add related values from previous step. For example: `export TF_VAR_user_ocid="ocid1.user.oc1..."`

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
	_**NOTE:** if you are an experienced OCI user, I'd highly suggest you use your own compartment to isolate all resources. To do so, provide your compartment OCID in `TF_VAR_compartment_ocid`. If you are new to OCI cloud, just enter your Tenancy value as compartment OCID._

2. After you modified the above using your values, we now need to add these lines to your ".bash_profile". In the cloud-shell terminal issue below:

	```
	<copy>
	vi ~/.bash_profile
	</copy>
	```

	_**NOTE:** Editing a file uses **vi** editor, if you never used it before here is a tip. When you issue **`vi .bash_profile`** it will open a file. You have to press **i** key to enable editing, then "shift+insert" to paste from clipboard. When you are done editing press **esc** button and press **:wq** keys then hit enter for save & quit._

	![](/images/0.Prep_4.PNG)

3. Once you've set these values, **exit** from the cloud-shell terminal by clicking on exit "X" button on top right corner, then re-open the cloud-shell terminal to continue.

	![](/images/0.Prep_0.PNG)

Now your terminal knows your parameters and you'll not get any error in the next lab. **REMEMBER**, you must close the cloud-shell and re-open it!
You've now completed the prerequisites.

## **Step 4**: Clone Lab Repository

1. Let's begin our lab. First, we'll make a copy of the lab repository and go to the cloned directory. In your cloud-shell web terminal, issue the below commands.

	```
	<copy>
	git clone https://github.com/hol-workshop/migrate_to_atp.git

	cd migrate_to_atp
	</copy>
	```

	![](/images/1.Git.PNG)

## **Step 5**: Create Terraform Variables

1. Now we need to edit a file to help terraform understand your environment. Enter the below command in your current working `migrate_to_atp` directory:

	```
	<copy>
    vi terraform.tfvars
	</copy>
	```

	_**NOTE:** This will create a new file, you have to press **i** key to enable editing, then "shift+insert" to paste copied parameter. When you are done editing press **esc** button and press **:wq** keys, then hit enter for save & quit.*_

2.  Let's add the following parameters in your notepad and modify them using your previous notes:

	```
	<copy>
	tenancy_ocid = "your_tenancy_value_here"
	region = "your-region-value here"
	compartment_ocid = "your-tenancy-value_here"
	</copy>
	```

## **Step 6**: Terraforming

1. It is now time to initialize terraform. Run the below command to download necessary terraform files from the OCI provider.

	```
	<copy>
	terraform init
	</copy>
	```

2. Plan and apply steps should not ask for any input from you. If it asks you to provide, for example; _**`compartment_ocid`**_ , then check previous steps.

	```
	<copy>
	terraform plan

	terraform apply --auto-approve
	</copy>
	```
	After you ran the apply command, terraform will start installation of several virtual machines and an autonomous database. Be patient, it will approximately take 6 to 15 minutes. During terraform script, if you see an error **Service limits exceeded** in output, please visit the Appendix section for instructions to correct the issue.
	
3. Make a copy of your output results in your notepad for later use.

	![](/images/1.git_1.PNG)


**This concludes this lab. You may now [proceed to the next lab](#next).**

## **Appendix**: Troubleshooting

###	Issue #1 Service Limits Exceeded
	
If you see **Service Limits Exceeded** issues when running _**terraform apply**_ command, follow the steps below to resolve them.
When creating a stack, you must have the available quotas for your tenancy and your compartment. 

Depending on the quota limit you have in your tenancy you can choose from any VM Standard Compute shapes, AMD shapes or Flex Shapes. 

This lab uses the following compute types but not limited to:

- Virtual Machine for Source Database - **VM.StandardE2.1**

#### Fix for Issue #1

1. Click on the Hamburger menu, go to **Governance** -> **Limits, Quotas and Usage**
2. Select Compute
3. Click Scope to change Availability Domain
4. Look for "Standard2 based VM" and "Standard.E2 based VM", then check **Available** column numbers and sum  them up. All you need to have is at least **3** or more. If you have found correct available capacity, please go to OCI cloud-shell.
5. Go  work directory `migrate_oracle_atp` folder in your cloud-shell and modify variables file with: **`vi vars.tf`**

	![](/images/fix_1.png)

6. Fix above accordingly to your **Available** resources.
7. Go to **Step 5: Terraform**, and continue from substep **2**.
	
However, if you are unable to resolve it using above fix, please skip to the **Need Help** section to submit your issue via our support forum.

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - 
* **Last Updated By/Date** - Bilegt Bat-Ochir 9/1/2021