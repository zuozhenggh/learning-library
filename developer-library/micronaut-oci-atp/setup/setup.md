# Setup

## Setup OCI for Micronaut Development`

1. Create an SSH Keypair Locally

You will need a new ssh keypair to deploy the application in later steps in this lab. Create a new SSH keypair using your toolchain, for example:

   ```
   ssh-keygen -t rsa -N "" -b 2048 -C "id_oci" -f ~/.ssh/id_oci
   ```

1. Create Infrastructure by downloading the Terraform configuration for this lab (stack.zip) from:

**NOTE:** Some platforms automatically unzip a .zip when downloaded. In that case you will have to zip it back up.

   https://github.com/recursivecodes/micronaut-data-jdbc-graal-atp/releases/latest/download/stack.zip

1. In the Oracle Cloud Console go to the "Solutions and Platforms" -> "Resource Manager" -> "Stacks".

   ![Resource Manager Stacks Link](images/resource_manager_link.png)

1. Click 'Create Stack' to create a new stack:

   ![Create Stack button](images/create_stack_btn.png)

1. Choose 'My Configuration', and upload the Terraform configuration zip either by browsing to the location locally where the zip exists or dragging and dropping the ZIP into the "Stack Configuration" pane:

   ![Stack Configuration - Step 1](images/stack_info_1.png)

1. You can optionally enter a name and description of the stack then then choose the compartment for the Stack, then click 'Next':

   ![Stack Configuration - Step 2](images/stack_info_2.png)

1. Within the "Configurable Variables" step under "Required Configuration" accept the default configuration:

   ![Stack Configuration - Step 3](images/stack_var_1.png)

1. Under "Optional Configuration" accept the default configuration making sure that "INSTANCE SHAPE" is set to "VM.Standard.E2.1.Micro":

   ![Stack Configuration - Step 4](images/stack_var_2.png)

1. Upload your public SSH key that was created in the first step. You can do so by dragging and dropping the public key file (the file that ends with `.pub`) or by choosing `PASTE SSH KEYS` then copying and pasting the contents of the public key file.

   For example running the following command from a terminal window will copy the contents of your public key into the clipboard which can then be pasted:

   ```
   cat ~/.ssh/id_oci.pub | pbcopy
   ```

   ![Upload SSH Public Key](images/stack_var_3.png)

1. On the next page accept the defaults and click 'Next'. 

   ![Review and Create Stack](images/stack_var_4.png)

1. Finally review and create your stack.

   ![Review and Create Stack](images/review_stack.png)

1. On the Stack Details page, click 'Terraform Actions' and select 'Plan'.

   ![Terraform Plan](images/stack_plan.png)

1. Review the plan output and ensure no failures occurred.

   ![Review Terraform Plan Log](images/plan_log.png)

1. On the Stack Details page, Click 'Terraform Actions' and select 'Apply'.

   ![Applying the Stack](images/stack_apply.png)

1. Choose the plan you just created, then click 'Apply'.

   ![Applying the Stack](images/stack_apply_2.png)

1. Monitor the logs and ensure the Stack plan has been successfully applied then review the plan output variables by clicking "Outputs" on the left hand side of the Job Details panel:

   ![Apply Job Outputs](images/tf_output.png)

1. Collect the following values from the output:

   * `compartment_ocid` - This is the compartment OCID used to identify the compartment where the database is setup
   * `tns_name` - This is the TNS name of the Autonomous Database instance
   * `atp_admin_password` - This is the adminstrative password of the Autonmous Database Instance
   * `atp_schema_password` - This is the schema password of the Autonmous Database Instance
   * `atp_wallet_password` - This is the wallet password of the Autonmous Database Instance
   * `atp_db_ocid` - This is the unique OCID of the Autonmous Database Instance
   * `region` - This is the region where the instance is running

You will need the values of these variables in the next step to configure your database. However, if you forget to take note of them you can retrieve them later by going to the Oracle Cloud Console and going to "Resource Manager" -> "Stacks" then click the name of your Stack then under "Jobs" select the "apply-" job that ran and under "Resources" on the left you can navigate to "Outputs" where you will find the variables again.


## Create DB Schema

1. Click on the Cloud Shell button to start a Cloud Shell intance:

   ![Open Cloud Shell](images/cloudshell.png)

2. From Cloud Shell, download the script and run it:

   ```shell script
   wget -O setup.sh https://github.com/recursivecodes/micronaut-data-jdbc-graal-atp/releases/latest/download/setup.sh
   chmod +x setup.sh
   ./setup.sh
   ```

3. Enter the values that you copied from the Terraform output when prompted. The script will produce several snippets of output to be used to build, run and deploy.

## Download Wallet

The Oracle Autonomous Database uses an extra level of security in the form of a wallet containing access keys for your new Database.

TODO: Todd provides steps to download the Wallet through the UI
