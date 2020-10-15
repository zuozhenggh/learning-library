# Enable Oracle Data Safe and Create a Compartment        

## Introduction

For this workshop, you need to enable the Oracle Data Safe service in at least one region of your tenancy. Be aware that you cannot disable Oracle Data Safe after it's enabled. This lab also shows you how to create a compartment in Oracle Cloud Infrastructure Identity and Access Management (IAM), which you later use to store your Autonomous Database and Oracle Data Safe resources.

**Note:** The Oracle Data Safe service is not available to you if your Free Tier trial period has ended and you are now using Always Free resources.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you'll:

- Enable Oracle Data Safe in a region of your tenancy
- Create a compartment in IAM


### Prerequisites

Be sure you have the following before starting:

- An Oracle Cloud account

### Assumptions

- You are using Oracle Cloud Infrastructure's Free Tier.
- You are signed in to the Oracle Cloud Infrastructure Console.



## **STEP 1:** Enable Oracle Data Safe

- At the top of the page on the right, select a region in your tenancy (usually your Home region), for example, **US East (Ashburn)**.

  ![Select Home region](images/select-region.png)

- From the navigation menu, select **Data Safe**.

  ![Select Data Safe from the Navigation menu](images/navigation-menu-select-data-safe.png)

  The **Overview** page is displayed.

- Click **Enable Data Safe** and wait a couple of minutes for the service to enable.

  ![Enable Data Safe button](images/enable-data-safe-button.png)

- When it's enabled, a confirmation message is displayed in the upper-right corner.


## **STEP 2:** Create a compartment

You need to create a compartment in your tenancy to store your Autonomous Database and Oracle Data Safe resources. In the labs, this compartment is referred to as "your compartment."

  - From the navigation menu, select **Identity**, and then **Compartments**. The **Compartments** page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.

  - Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

  - Enter a name for the compartment, for example, `dsc01` (short for Data Safe compartment 1).

  - Enter a description for the compartment, for example, **Compartment for the Oracle Data Safe Workshop**.

  ![Create Compartment dialog box](images/create-compartment.png)

  - Click **Create Compartment**.

Continue to the next lab, [**Provision and Register an Autonomous Database**](../provision-register-autonomous-database/provision-register-autonomous-database.md).

If you have a question during this workshop, you can use the **[Autonomous Data Warehouse Forum](https://cloudcustomerconnect.oracle.com/resources/32a53f8587/summary)** on **Cloud Customer Connect** to post questions, connect with experts, and share your thoughts and ideas about Oracle Data Safe. Are you completely new to the **Cloud Customer Connect** forums? Visit our **[Getting Started forum page](https://cloudcustomerconnect.oracle.com/pages/1f00b02b84)** to learn how to best leverage community resources.



## Learn More

- <a  href="https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=&amp;cad=rja&amp;uact=8&amp;ved=2ahUKEwiV9crfq4LsAhV1lnIEHbzbABwQFjAAegQIARAC&amp;url=https%3A%2F%2Fdocs.cloud.oracle.com%2Fiaas%2F&amp;usg=AOvVaw0AhysJe8ZnjMdve29qGMtZ" >Oracle Cloud Infrastructure documentation</a>
- <a  href="https://www.googleadservices.com/pagead/aclk?sa=L&amp;ai=DChcSEwjpqdLfq4LsAhVMwMgKHXwlCVUYABAAGgJxdQ&amp;ohost=www.google.com&amp;cid=CAASEuRoiOXrrdCP5n-DJ1ywMcKyYQ&amp;sig=AOD64_22iprJaffo5nOe9sztGr9oHNidFQ&amp;q&amp;adurl&amp;ved=2ahUKEwiV9crfq4LsAhV1lnIEHbzbABwQ0Qx6BAgNEAE" >Try Oracle Cloud</a>


## Acknowledgements

* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, October 15, 2020


## See an Issue?

Please submit feedback using this <a  href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" >form</a>. Please include the **workshop name**, **lab**, and **step** in your request. If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the **Feedback Comments** section.
