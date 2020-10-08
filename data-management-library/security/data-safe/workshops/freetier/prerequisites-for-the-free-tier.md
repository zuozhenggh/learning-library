
# Prerequisites for the Oracle Data Safe Workshop on the Free Tier               

## Introduction

This lab describes the steps that you need to take prior to starting the Oracle Data Safe Workshop when using an Oracle Cloud Free Tier account. The steps assume that you are the tenancy administrator.

If you already have an Oracle Cloud Free Tier account, you can skip step 1. Be sure to enable Oracle Data Safe and create a compartment.

**Note** The Oracle Data Safe service is not available to you if your Free Tier trial period has ended and you are now using Always Free resources.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you'll:

- Create your own free trial account
- Sign in to the Oracle Cloud Infrastructure Console with your account credentials
- Enable Oracle Data Safe
- Create a compartment


### Prerequisites

Be sure you have the following before starting:

- A valid email address
- Ability to receive SMS text verification (only if your email is not recognized)


## **STEP 1**: Create Your Free Trial Account

If you already have an Oracle Cloud Free Tier account, you can skip this step.

- In a browser, enter the following URL: <a  href="https://myservices.us.oraclecloud.com/mycloud/signup?language=en" >oracle.com/cloud/free</a>.
- Click **Start for free**.

  ![](images/349900290.png)

- Enter your email address.
- Select your country/territory.
- Click **Next**.
- Enter a **cloud account name**. You can choose almost any name you want. Remember the name you enter because you need this name later on to sign in to Oracle Cloud Infrastructure.
- Click **Enter Password**.
- Enter your mobile phone number, and then click Next: Verify Mobile Number. In a few seconds, you should receive a verification code through SMS-text.
- Enter the verification code in the appropriate field, and then click **Verify**.
- Click **Add Credit Card Details**. You are not charged any money unless you elect to upgrade the account later.
- Enter the billing information and card details, and then click **Finish**.
- Validate your address.
- Enter a password. Remember this password so that you can sign in to Oracle Cloud Infrastructure later.
- Click **Review Terms and Conditions**.
- Read and agree to the terms and conditions by selecting the check box.
- Click **Complete Sign-Up**.

Your account is provisioning and should be available in a few seconds! When it's ready, you're automatically taken to a sign-in page. You'll also receive a confirmation email containing sign-in information.


## **STEP 2**: Sign in to the Oracle Cloud Infrastructure Console with your account credentials

If you've signed out of the Oracle Cloud Infrastructure Console, follow these steps to sign in again.

- In a browser, enter the URL [cloud.oracle.com](https://cloud.oracle.com).
- In the toolbar, click **View Accounts**, and then select **Sign in to Cloud**.

   ![Sign in to Cloud option](images/349900291.png)


- Enter your **Cloud Account Name**, and then click **Next**. This is the name you chose while creating your account in the previous section. It is not your email address. If you've forgotten the name, please refer to the confirmation email.

  ![Cloud Account Name page](images/349900292.png)


- Enter your username and password for your Oracle Cloud account, and then click **Sign In**. Your username is your email address. The password is what you chose when you signed up for an account.  

  ![SIGN IN page for Oracle Cloud Infrastructure](images/349900293.png)

- You are now signed in to the Oracle Cloud Infrastructure Console! The main page in the Oracle Cloud Infrastructure Console shows you a dashboard. In the upper-left corner, there is a navigation menu (looks like a hamburger menu).  

  ![Oracle Cloud Infrastructure Console](images/349900294.png)


## **STEP 3** Enable Oracle Data Safe

For this workshop, you need to enable the Oracle Data Safe service in at least one region of your tenancy. Be aware that you cannot disable Oracle Data Safe after it's enabled.

- At the top of the page on the right, select the region in which you want to enable Oracle Data Safe, for example, **US East (Ashburn)**.

- From the navigation menu, select **Data Safe**. The **Overview** page is displayed.

- Click **Enable Data Safe** and wait a couple of minutes for the service to enable. When it's enabled, a confirmation message is displayed in the upper right corner.


## **STEP 4:** Create a compartment

You need to create a compartment in your tenancy to store your Autonomous Database and Oracle Data Safe resources. In the labs, this compartment is referred to as "your compartment."

  - From the navigation menu, select **Identity**, and then **Compartments**. The Compartments page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.

  - Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

  - Enter a name for the compartment, for example, `dsc01` (short for Data Safe compartment 1).
  - Enter a description for the compartment, for example, **Compartment1 for the Oracle Data Safe Workshop**.
  - Click **Create Compartment**.

You are ready to start the labs. Begin with the [**Introduction**](../introduction/introduction.md).

If you have a question during this workshop, you can use the **[Autonomous Data Warehouse Forum](https://cloudcustomerconnect.oracle.com/resources/32a53f8587/summary)** on **Cloud Customer Connect** to post questions, connect with experts, and share your thoughts and ideas about Oracle Data Safe. Are you completely new to the **Cloud Customer Connect** forums? Visit our **[Getting Started forum page](https://cloudcustomerconnect.oracle.com/pages/1f00b02b84)** to learn how to best leverage community resources.



## Learn More

- <a  href="https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=&amp;cad=rja&amp;uact=8&amp;ved=2ahUKEwiV9crfq4LsAhV1lnIEHbzbABwQFjAAegQIARAC&amp;url=https%3A%2F%2Fdocs.cloud.oracle.com%2Fiaas%2F&amp;usg=AOvVaw0AhysJe8ZnjMdve29qGMtZ" >Oracle Cloud Infrastructure documentation</a>
- <a  href="https://www.googleadservices.com/pagead/aclk?sa=L&amp;ai=DChcSEwjpqdLfq4LsAhVMwMgKHXwlCVUYABAAGgJxdQ&amp;ohost=www.google.com&amp;cid=CAASEuRoiOXrrdCP5n-DJ1ywMcKyYQ&amp;sig=AOD64_22iprJaffo5nOe9sztGr9oHNidFQ&amp;q&amp;adurl&amp;ved=2ahUKEwiV9crfq4LsAhV1lnIEHbzbABwQ0Qx6BAgNEAE" >Try Oracle Cloud</a>


## Acknowledgements

- Author - Jody Glover, UA Developer, Oracle Database team
- Last Updated By/Date - Jody glover, Oracle Database team, October 2, 2020


## See an Issue?

Please submit feedback using this <a  href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" >form</a>. Please include the **workshop name**, **lab**, and **step** in your request. If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the **Feedback Comments** section.
