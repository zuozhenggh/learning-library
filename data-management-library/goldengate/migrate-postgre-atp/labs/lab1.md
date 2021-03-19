## Introduction



### Prerequisites

- You have successfully finished ** Prerequisites ** lab

## Objectives

In this first lab, we will prepare our work environment and create our lab resources using Terraform script.

## **Step 1**: Clone lab repository

Let's begin our lab. First we'll make a copy of lab repository and go to cloned directory.

```
git clone https://github.com/hol-workshop/migrate_to_atp.git

cd migrate_to_atp
```

![](/files/1.Git.PNG)

## **Step 2**: Create terraform.tfvars file

Now we need to create a file to help terraform understanding your environment. Let's modify following parameters in your notepad and copy it.

```
tenancy_ocid  = "your_tenancy_value_here"
ssh_public_key  = "~/.ssh/oci.pub"
region = "your-region-value here"
compartment_ocid = "your-tenancy-value_here"
```

Enter below command in your current working migrate_to_atp directory:

**`vi terraform.tfvars`**

*This will create a new file, you have to press **i** key to enable editing, then "shift+insert" to paste copied parameter. When you are done editing press **:wq** keys then hit enter for save & quit.*

Good practice is, always keep it in your side notepad,

## **Step 3**: Let's terraform 

Now, time to play terraform. Run below command to download necessary terraform files from OCI provider.

```
terraform init
```

Plan and apply steps shouldn't ask any input from you. If it asks you to provide such as compartment_ocid, then again check previous files.

```
terraform plan

terraform apply --auto-approve
``` 

Make a copy of your output results in your notepad also for later use.

![](/files/1.git_1.PNG)

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir, Solution Engineer
* **Contributors** - John Craig, Patrick Agreiter
* **Last Updated By/Date** -