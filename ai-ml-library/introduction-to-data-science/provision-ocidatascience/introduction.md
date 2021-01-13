# Provision the Data Science service and its dependencies

## Introduction

You will provision the OCI Data Science service and its dependencies.

This is only required if you plan to do "Lab 100: Linear Regression" and/or "Lab 200: Neural Networks".

This guide shows how to use the Resource Manager to provision the service using Resource Manager. This process is mostly automated. However, if you prefer a step-by-step manual approach to control every aspect of the provisioning, please follow the following instructions instead: [manual provisioning steps](https://docs.cloud.oracle.com/en-us/iaas/data-science/data-science-tutorial/tutorial/get-started.htm#concept_tpd_33q_zkb).

Time: 25 minutes

## **STEP 1:** Create a stack for Resource Manager

### 1. In your Oracle Cloud console, open the menu.

![](./images/openmenu.png)

### 2. Select Resource Manager -> Stacks.

![](./images/resourcemanager.png)

### 3. Click the "Create Stack" button.

![](./images/createstackbutton.png)

## **STEP 2:** Configure the stack

Now we are going to choose a predefined Stack for the Data Science service and all its prerequisites.

### 1. Choose "Sample Solution" and click the button "Select Solution".

![](./images/newimage1.png)

### 2. Check the "Data Science" solution and click "Select Solution".

![](./images/newimage2.png)

### 3. Choose a compartment that you've created or use Root.

![](./images/newimage3.png)

### 4. Click "Next".

![](./images/newimage4.png)

### 5. Configure the Project and Notebook Session

Select "Create a Project and Notebook Session".

We recommend you choose VM.Standard2.8 (*not* VM.Standard.*E*2.8) as the shape. This is a high performance shape, which will be especially useful when we run AutoML later on.

![](./images/newimage5b.png)

### 6. Disable the option "Enable Vault Support".

![](./images/newimage6.png)

### 7. Disable the option "Provision Functions and API Gateway".

![](./images/disablefunctions.png)

### 8. Click "Next".

![](./images/newimage7.png)

### 9. Click "Create".

![](./images/create.png)

## **STEP 3:** Run the stack

### 1. Run the job

Go to "Terraform Actions" and choose "Apply".

![](./images/applytf.png)

### 2. Click Apply once more to confirm the submission of the job.

Provisioning should take about 20 minutes after which the status of the Job should become "Succeeded".

## Next
[Proceed to the next section](#next).

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
