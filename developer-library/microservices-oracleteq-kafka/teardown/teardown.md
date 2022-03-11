# Teardown

## Introduction

In this lab, we will tear down the resources created in your tenancy and the directory in the Oracle cloud shell.

Estimates Time: 10 minutes

### Objectives

- Clean up your tenancy

### Prerequisites

- Have successfully completed the earlier labs

## **Task 1:** Delete the Workshop Resources

1. Run the following command to delete the resources created in you tenancy. It will delete everything except the compartment.

    It will take several minutes to run. The script will delete the Object Storage bucket,  Oracle Autonomous Database.

    ```bash
        <copy>
        source $LAB_HOME/cloud-setup/destroy.sh
        </copy>
    ```

## **Task 2:** Delete the Directory

1. Delete the directory in your cloud shell where you installed the workshop.

    ```bash
     <copy>rm -rf <directory name, e.g. lab8022></copy>
    ```

## **Task 3:** Delete the Compartment

In the Oracle Cloud Infraestructure Console navigate to the Compartments screen in the Identity section. Select the compartment that was created for the workshop and delete it. Important, even when the script in step 1 has completed, it can take some time for Oracle Cloud Infrastructure to fully remove all the resources. It will not be possible to delete the compartment until this has completed.

## Acknowledgements

- **Authors** - Paulo Simoes, Developer Evangelist; Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
- **Contributors** - Mayank Tayal, Developer Evangelist; Sanjay Goil, VP Microservices and Oracle Database
- **Last Updated By/Date** - Paulo Simoes, February 2022
