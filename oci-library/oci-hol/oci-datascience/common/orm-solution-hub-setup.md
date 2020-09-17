# Data Science Service Setup

## Overview

To use the Data Science service, the tenancy has to be configured to grant permission to users and resources. If your tenancy is not already configured, you will need administrator access to configure it. If you created a free-tier account, your account has administrator access. There are two ways to create configure the tenancy. It can be [manually configured](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/configure-tenancy.htm) or the [Oracle Resource Manager](https://www.oracle.com/cloud/systems-management/resource-manager/). In this lab, the tenancy will be configured using the [Data Science Solution Hub](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/orm-configure-tenancy.htm), which is part of the Oracle Resource Manager. This provides an interface to choose the configuration for the Data Science service and automatically configures the tenancy.

## Basic Configuration of a Tenancy

## Advanced Configuration of a Tenancy

Configuring a tenancy using Oracle Resource Manager involves creating a solution stack, selecting the solution, providing identifying information for the new stack, and updating variables. For most tenancies, the default options will be sufficient. However, for advanced configurations changes may need to be made. It is possible to change the configuration later.

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html).
1. Open the navigation menu. Under **Solutions and Platform**, go to **Resource Manager** and click **Stacks**.
1. Choose a compartment you have permission to work in (on the left side of the page). The page updates to display only the resources in that compartment. If you are not sure which compartment to use, contact an administrator.
1. Click **Create Stack**.
1. Click **Sample Solution**, and then click **Select Solution**.
1. Select **Data Science**, and then click **Select Solution**.
1. Enter a **Name** for the new stack, or use the default.
1. Optionally, enter a **Description**.
1. From the **Create in Compartment** drop-down, select the compartment in which the stack will be created. This compartment will contain all the resources the stack creates.
1. Optionally, tags can be applied.
1. Click **Next**. The **Configure Variables** panel displays variables auto-populated from the Terraform configuration for the Data Science solution.
1. Change the IAM variables as necessary.
1. Enter the network information or use the defaults to create a VCN, or select **Use Existing VCN** to enter the information to connect to an existing network.
Optionally, select **Create a Project and Notebook Session?** and enter a project and notebook configuration. It is recommended that projects and notebooks are not created using the Solution Hub. Refer to [Creating Projects](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/manage-projects.htm#create-project) and [Creating Notebook Sessions](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/manage-notebook-sessions.htm#create-notebooks) on how to manually create these resources.
1. Select **Enable Vault Support?** to enable storing secrets, encrypted passwords, and keys, and then enter vault values to create a vault.
1. Select **Provision Functions and API Gateway?** to enable deploying models to Functions and use the API gateway.
1. Click **Next** and review the stack configuration.
1. Click **Create** to create your stack. This creates the stack but does not create the Data Science resources. The **Stack Details** page will be displayed.
1. Click **Terraform Actions**, and then click **Apply** to apply the Terraform script and create the Data Science resources. If the stack generates an error, click **Terraform Actions**, and then click **Destroy** to remove the resources that were created. Fix any issues and then repeat this step.

## Acknowledgements

* **Author**: [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist
* **Last Updated By/Date**:
* [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist, September 2020

See an issue? Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.
