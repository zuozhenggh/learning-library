# Deploy the Infrastructure

## Introduction

In this lab exercise, we will introduce you to modern practices for deploying Cloud Native Applications through an automated CI/CD pipeline, and the first one is `GitOps`.

GitOps is a paradigm for application development and operations. It provides a developer-centric experience for operating infrastructure. It consists of declarative description of an immutable infrastructure and its desired state, stored in a Git repository. 

To deploy/provision application and infrastructure, you need to update your git repository and then create a pull/merge request so that someone can review your code and accept the changes. Those changes should be deployed to your servers/infrastructure through an automation process.

As part of this lab, you will turn into a SRE/Platform Administrator and will provision all the Infrastructure resources used by your applications through Infrastructure As Code (IaC) using [Terraform](https://www.terraform.io) on [Oracle Cloud Infrastructure Resource Manager service (ORM)](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm) with GitHub Actions.  

If you are not familiar with Terraform, this is an open-source tool that allow you to write infrastructure as code using declarative configuration files. OCI Resource Manager allows you to share and manage Terraform configurations and state files across multiple teams and platforms. You can connect Resource Manager to your Git repository by setting up a Configuration Source Provider.

![Diagram](./images/sre_infrastructure_onboarding.png)

Estimated Lab time: 20 minutes

### Objectives

In this lab, you will:

* Create an IAM compartment to isolate and organize your CI/CD cloud resources
* Create a GitHub workflow that will automatically create a ORM project pointing to a git repository and provision the infrastructure.
* Provision Infrastructure: Network, IAM, Kubernetes Cluster on OKE, DevOps project

### Prerequisites

* An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
* GitHub account

## **STEP 1**: Create a Compartment

1. Got to Navigation Menu -> Identity & Security -> Identity -> Compartments

1. To create a compartment in the tenancy (root compartment) click Create Compartment.
Otherwise, click through the hierarchy of compartments until you reach the detail page of the compartment in which you want to create the compartment. On the Compartment Details page, click Create Compartment.
![Create Compartment](./images/create-compartment-btn.png)

1. Enter the compartment name and description:
![Name/description](./images/create-compartment-form.png)


## **STEP 2**: Import Git "deploy" repository 

Oracle has published a [Reference Architecture](https://docs.oracle.com/en/solutions/build-pipeline-using-devops/index.html) which contains a [quickstart](https://github.com/oracle-quickstart/oci-arch-devops) repository that we will use to automate the provisioning of OCI DevOps service and all target services/environments. Let's *import* that repository to your GitHub account.

1. Open up a new browser tab and go to [GitHub](https://github.com).

1. On the top navigation bar, click on the plus sign and then  Import Repository.
![plus sign](./images/github-plus.png)
![import repository](./images/github-import-repo.png)

1. Enter the URL of the OCI Architecture DevOps repo: `https://github.com/oracle-quickstart/oci-arch-devops`


1. Enter a name for the new *deploy* repository. To better identify it, let's name it: `oci-devops-platform-deploy`. 

1. Set privacy settings to `Private` and then click on Begin import button in the bottom of the page to create a new repo.
![import project](./images/github-import-project.png)
![import finished](./images/github-import-finished.png)

1. Open up the new project on your browser.



## **STEP 3**: Generate GitHub Personal Access Token

ORM need to be able to read the content of your repository in order to provision the infrastructure. In order to connect your GitHub account with ORM you first need to generate a Personal Access Token with the proper permissions. 

1. Follow GitHub documentation on how to create your PAT: https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token
![new pat entry](./images/github-new-pat-initial.png)

1. Select the top level `repo` scope to enable access to your private repositories.
![new pat form](./images/github-new-pat.png)

1. Click on generate token, then copy the token value and store it safely as we are going to use it soon and it won't be displayed again.
![pat created](./images/github-pat-created.png)


## **STEP 4**: Provisioning the Infrastructure

We are going to use [GitHub Actions](https://github.com/features/actions) to automate the provisioning of the Infrastructure using the OCI Command Line Interface (CLI) and the ORM Stack that will hold the state of the infrastructure.

### Create OCI API key

Whether you're using an Oracle client (e.g. CLI) or a client you built yourself, you need to do the following:

1. Create a user in IAM for the person or system who will be calling the API, and put that user in at least one IAM group with any desired permissions, e.g. create the `cicd` user which belongs to CICD/Administrators group. For now, we are assuming your current user has Administrator privileges to manage your CI/CD pipelines.

1. Next, generate OCI API key file. If you're adding an API key for yourself: Open the Profile menu (User menu icon) and click User Settings.

1. If you're an administrator adding an API key for another user: Open the navigation menu and click Identity & Security. Under Identity, click Users. Locate the user in the list, and then click the user's name to view the details.
    
1. Go to API Keys on the left hand side menu. Then, click on Add API Key. In the dialog, select Generate API Key Pair.
Click to Download both `Public` and `Private` key files and save it.

1. Click Add. The `Configuration File Preview` window will open up and it contains the following information:

```
[DEFAULT]
user=ocid1.user.oc...
fingerprint=1c:75:ee:...
tenancy=ocid1.tenancy.oc...
region=us-ashburn-1
key_file=<path to your private keyfile> # TODO
```

1. You can keep this page opened to continuous to the next lab.

### Create GitHub secrets

Secrets are used to store sensitive information used by your workflows. They are encrypted variables and can be defined at organization, repository or repository environment level. We will create secrets to store IAM information used by the OCI CLI thorough the workflow. 

1. Go back to the Github repository -> Settings --> Secrets. Let's create the following secret variables from the following Variable Name:

|Secret Name|Notes|Secret Value|
|--|--|--|
|OCI_USER_OCID|user variable|ocid1.user.oc...|
|OCI_FINGERPRINT|fingerprint variable|1c:75:ee:...|
|OCI_TENANCY_OCID|tenancy variable|ocid1.tenancy.oc...|
|OCI_KEY_FILE|content of the private API KEY file (PEM format)|-----BEGIN RSA PRIVATE KEY-----|
|OCI_GITHUB_ACCESS_TOKEN|Use GitHub PAT created previously|abcxyz...|

Note: copy the content of the API  Key file running the following command (Linux/Mac):

```
cat <your-pem-public-file>.pem | pbcopy
```

### Create Workflow file

1. Let's create the workflow file. Open up the GitHub repo on your browser and go to the `.github/workflows` folder. Then click on Add File -> Create New File.

1. Create a file named `oci-platform-build.yaml` with the following content:

    ```yaml
    name: oci-build-platform

    on:
      push:
        branches: [ master ]
        paths: ['devops_oke/']      
    jobs:
      build-resource-manager:
        name: Build Infrastructure
        runs-on: ubuntu-latest
        env: 
            STACK_NAME: "oci-build-platform-cicd"
            PROVIDER_NAME: "GitHub Source Provider"
            BRANCH_NAME: "master"
            API_ENDPOINT: "https://github.com/"
            REPO_URL: "https://github.com/<your-user>/oci-devops-platform-deploy"
            WORKING_DIRECTORY: "devops_oke"
            TF_VERSION: "0.14.x"
            REGION: "us-ashburn-1"
            COMPARTMENT_OCID: "<cicd-compartment-ocid"
            APP_NAME: "HelloWorld"
        steps:
          
          - name: 'Checkout'
            uses: actions/checkout@v2

          - name: 'Write OCI CLI Config & PEM Key Files'
            run: |
              mkdir /home/runner/.oci
              echo "[DEFAULT]" >> /home/runner/.oci/config
              echo "user=${{secrets.OCI_USER_OCID}}" >> /home/runner/.oci/config
              echo "fingerprint=${{secrets.OCI_FINGERPRINT}}" >> /home/runner/.oci/config
              echo "region=${{env.REGION}}" >> /home/runner/.oci/config
              echo "tenancy=${{secrets.OCI_TENANCY_OCID}}" >> /home/runner/.oci/config
              echo "key_file=/home/runner/.oci/key.pem" >> /home/runner/.oci/config
              echo "${{secrets.OCI_KEY_FILE}}" >> /home/runner/.oci/key.pem
              
          - name: 'Install OCI CLI'
            run: |
              curl -L -O https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh
              chmod +x install.sh
              ./install.sh --accept-all-defaults
              echo "/home/runner/bin" >> $GITHUB_PATH
              exec -l $SHELL
              
          - name: 'Fix OCI Config File Permissions'
            run: |
              oci setup repair-file-permissions --file /home/runner/.oci/config
              oci setup repair-file-permissions --file /home/runner/.oci/key.pem
              
          - name: 'Test CLI setup'
            run: |
              cat /home/runner/.oci/config
              cat /home/runner/.oci/key.pem
              ls -la /home/runner/.oci/
              echo "CLI_OK=$(oci os ns get | jq '.data')" >> $GITHUB_ENV

          - name: 'Check CLI'
            if: ${{env.CLI_OK == ''}}
            run: |
              echo "CLI not setup properly. Exiting"
              exit 1              
                

          - name: 'Create ORM configuration source-provider'
            if: ${{env.SOURCE_PROVIDER_ID == ''}}
            run: |
              echo "SOURCE_PROVIDER_ID=$(oci resource-manager configuration-source-provider create-github-access-token-provider \
                --access-token ${{secrets.OCI_GITHUB_ACCESS_TOKEN}} \
                --api-endpoint "${{env.API_ENDPOINT}}" \
                --display-name "${{env.PROVIDER_NAME}}" \
                --compartment-id ${{env.COMPARTMENT_OCID}} | jq '.data.id' -r)" >> $GITHUB_ENV

          - name: 'Check ORM configuration source-provider'
            if: ${{env.SOURCE_PROVIDER_ID == ''}}
            run: |
              echo "Could not locate ORM configuration source-provider. Exiting"
              exit 1
              
          - name: 'Fetch Existing Stack'
            run: |
              echo "STACK_ID=$(oci resource-manager stack list --all --compartment-id ${{env.COMPARTMENT_OCID}} | jq '.data[] | select(."display-name"==env.STACK_NAME).id' -r)" >> $GITHUB_ENV
              echo "$STACK_ID"          

          - name: 'Create Stack'
            if: ${{env.STACK_ID == ''}}
            run: |
              echo "STACK_ID=$(oci resource-manager stack create-from-git-provider \
                --compartment-id ${{env.COMPARTMENT_OCID}} \
                --config-source-configuration-source-provider-id ${{env.SOURCE_PROVIDER_ID}} \
                --config-source-branch-name ${{env.BRANCH_NAME}} \
                --config-source-repository-url ${{env.REPO_URL}} \
                --config-source-working-directory ${{env.WORKING_DIRECTORY}} \
                --display-name "${{env.STACK_NAME}}" \
                --terraform-version ${{env.TF_VERSION}} \
                --variables '{"tenancy_ocid": "${{secrets.OCI_TENANCY_OCID}}", "compartment_ocid": "${{env.COMPARTMENT_OCID}}", "region": "${{env.REGION}}", "app_name": "${{env.APP_NAME}}"}' | jq '.data.id' -r)" >> $GITHUB_ENV


          - name: 'Check Stack'
            if: ${{env.STACK_ID == ''}}
            run: |
              echo "Could not locate Stack. Exiting"
              exit 1

          - name: 'Create Plan Job'
            if: ${{env.STACK_ID != ''}}
            timeout-minutes: 5     
            run: |
              echo "PLAN_JOB_ID=$(oci resource-manager job create-plan-job \
                --stack-id $STACK_ID --wait-for-state SUCCEEDED --wait-for-state FAILED | jq '.data.id' -r)" >> $GITHUB_ENV
                
          - name: 'Fetch Plan Job status'
            if: ${{env.PLAN_JOB_ID != ''}}
            run: |
              echo "${{env.PLAN_JOB_ID}}"
              echo "PLAN_JOB_STATUS=$(oci resource-manager job get \
                --job-id $PLAN_JOB_ID | jq '.data."lifecycle-state"' -r)" >> $GITHUB_ENV

          - name: 'Plan Job Failed'
            if: ${{env.PLAN_JOB_STATUS != 'SUCCEEDED'}}
            run: |
              echo "Plan Job has not succeeded at this point. Review job $PLAN_JOB_ID"
              echo "$(oci resource-manager job get-job-logs --job-id ${{env.PLAN_JOB_ID}})"
              exit 1    
      
          - name: 'Apply Plan Job'
            if: ${{env.PLAN_JOB_ID != ''}}
            run: | 
              echo "APPLY_JOB_ID=$(oci resource-manager job create-apply-job \
                --execution-plan-strategy FROM_PLAN_JOB_ID \
                --execution-plan-job-id $PLAN_JOB_ID \
                --stack-id $STACK_ID \
                --wait-for-state SUCCEEDED --wait-for-state FAILED | jq '.data.id' -r)" >> $GITHUB_ENV

          - name: 'Fetch Apply Job status'
            if: ${{env.APPLY_JOB_ID != ''}}
            run: |
              echo "${{env.APPLY_JOB_ID}}"
              echo "APPLY_JOB_STATUS=$(oci resource-manager job get \
                --job-id $APPLY_JOB_ID | jq '.data."lifecycle-state"' -r)" >> $GITHUB_ENV
                
          - name: 'APPLY Job Failed'
            if: ${{env.APPLY_JOB_STATUS != 'SUCCEEDED'}}
            run: |
              echo "Apply Job has not succeeded at this point. Review job $APPLY_JOB_ID"
              echo "$(oci resource-manager job get-job-logs --job-id ${{env.APPLY_JOB_ID}})"
              exit 1             
    ```

1. Update the following variables in the `env` section of the file with the information from your own environment:
    - REPO_URL
    - COMPARTMENT_OCID

1. Commit the file. This will trigger the pipeline upon the commit.

1. Click on `Actions` menu and check the progress of `oci-build-platform` workflow. If any additional workflow is available on your actions, you can delete or ignore it at this moment.

1. After 90s the workflow should complete and it should `FAIL`. This is expected as the Terraform template was originally designed to run through the Terraform CLI, not ORM. You need to make some changes to the terraform configuration to use ORM.

1. Go back to the code on GitHub, open up `devops_oke` folder. There are 2 files we need to change:
    - providers.tf
    - variables.tf
  
  
1. Edit `providers.tf` file. Replace the 3 declaration of oci providers by these 2:
    ```
    provider "oci" {
      alias        = "home_region"
      tenancy_ocid = var.tenancy_ocid
      region       = lookup(data.oci_identity_regions.home_region.regions[0], "name")
    }

    provider "oci" {
      alias        = "current_region"
      tenancy_ocid = var.tenancy_ocid
      region       = var.region
    }
    ```
    Note: this is required due to the fact that ORM injects the standard provider with the authentication based upon the identity associated with the CLI.


1. Let's commit these changes to the code.
    - create new feature branch
    - set the branch name to `release-infra`
    - select proposed changes to create a pull request

1. Next, edit `variables.tf` file. Make sure you selected `release-infra` on the branches selector. Then you can remove the following variables:
    - user_ocid
    - fingerprint
    - private_key_path

1. Commit the change into the `release-infra` branch. This will update the pull request. 

1. Finally, click on `Merge pull request` button. Provide your comments and then click on Confirm merge. You can finally check the workflow progress on the Action tab.

1. It may take about 20 minutes to complete the provisioning workflow. Upon success, you will have provisioned all the infrastructure resources in the Oracle Cloud Infrastructure. This is the final step we used to provision the infrastructure. You can go back to OCI Console and check the resources that were created, including the OCI DevOps service.

You may now [proceed to the next lab](#next).