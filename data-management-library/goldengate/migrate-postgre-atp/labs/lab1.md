# LAB 1

## Introduction

The first lab is the most important lab of all, in fact in this step we will create all of our resources:

- Virtual Cloud Network
- Source Postgreqsql database
- Goldengate for non-Oracle deployment
- Goldengate Microservices deployment
- Target Autonomous database

![](/files/architecture.png)

### Prerequisites

- You have successfully finished **Prerequisites** lab

## Objectives

In this first lab, we will prepare our work environment and create our lab resources using Terraform script.
In case if you are running this lab in your existing tenancy, **make sure** you have following compute quotas and resources available to use:

1. ATP for Target database - 1 OCPU, 1 TB storage
2. Virtual Machine for Source Database - VM.StandardE2.1
3. Virtual Machine for Goldengate Postgresql - VM.Standard2.1  
4. Virtual Machine for Goldengate Microservices - VM.Standard2.1

## **Step 1**: Clone lab repository

Let's begin our lab. First we'll make a copy of lab repository and go to cloned directory. In your cloud-shell web terminal, issue below commands.

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

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - 3/22/2021