# Enable Oracle Data Safe and Create a Compartment        

## Introduction

This lab shows you how to enable Oracle Data Safe in a region of your tenancy and create a compartment.

**Note** The Oracle Data Safe service is not available to you if your Free Tier trial period has ended and you are now using Always Free resources.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you'll:

- Enable Oracle Data Safe
- Create a compartment


### Prerequisites

Be sure you have the following before starting:

- An Oracle Cloud account

### Assumptions

- You are signed in to the Oracle Cloud Infrastructure Console using the Free Tier option.



## **STEP 1** Enable Oracle Data Safe

For this workshop, you need to enable the Oracle Data Safe service in at least one region of your tenancy. Be aware that you cannot disable Oracle Data Safe after it's enabled.

- At the top of the page on the right, select the region in which you want to enable Oracle Data Safe, for example, **US East (Ashburn)**.

- From the navigation menu, select **Data Safe**. The **Overview** page is displayed.

- Click **Enable Data Safe** and wait a couple of minutes for the service to enable. When it's enabled, a confirmation message is displayed in the upper right corner.


## **STEP 2:** Create a compartment

You need to create a compartment in your tenancy to store your Autonomous Database and Oracle Data Safe resources. In the labs, this compartment is referred to as "your compartment."

  - From the navigation menu, select **Identity**, and then **Compartments**. The Compartments page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.

  - Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

  - Enter a name for the compartment, for example, `dsc01` (short for Data Safe compartment 1).

  - Enter a description for the compartment, for example, **Compartment1 for the Oracle Data Safe Workshop**.

  - Click **Create Compartment**.

You can continue to the next lab, [**Introduction**](../introduction/introduction.md).

If you have a question during this workshop, you can use the **[Autonomous Data Warehouse Forum](https://cloudcustomerconnect.oracle.com/resources/32a53f8587/summary)** on **Cloud Customer Connect** to post questions, connect with experts, and share your thoughts and ideas about Oracle Data Safe. Are you completely new to the **Cloud Customer Connect** forums? Visit our **[Getting Started forum page](https://cloudcustomerconnect.oracle.com/pages/1f00b02b84)** to learn how to best leverage community resources.



## Learn More

- <a  href="https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=&amp;cad=rja&amp;uact=8&amp;ved=2ahUKEwiV9crfq4LsAhV1lnIEHbzbABwQFjAAegQIARAC&amp;url=https%3A%2F%2Fdocs.cloud.oracle.com%2Fiaas%2F&amp;usg=AOvVaw0AhysJe8ZnjMdve29qGMtZ" >Oracle Cloud Infrastructure documentation</a>
- <a  href="https://www.googleadservices.com/pagead/aclk?sa=L&amp;ai=DChcSEwjpqdLfq4LsAhVMwMgKHXwlCVUYABAAGgJxdQ&amp;ohost=www.google.com&amp;cid=CAASEuRoiOXrrdCP5n-DJ1ywMcKyYQ&amp;sig=AOD64_22iprJaffo5nOe9sztGr9oHNidFQ&amp;q&amp;adurl&amp;ved=2ahUKEwiV9crfq4LsAhV1lnIEHbzbABwQ0Qx6BAgNEAE" >Try Oracle Cloud</a>


## Acknowledgements

- Author - Jody Glover, UA Developer, Oracle Database team
- Last Updated By/Date - Jody glover, Oracle Database team, October 8, 2020


## See an Issue?

Please submit feedback using this <a  href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" >form</a>. Please include the **workshop name**, **lab**, and **step** in your request. If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the **Feedback Comments** section.
