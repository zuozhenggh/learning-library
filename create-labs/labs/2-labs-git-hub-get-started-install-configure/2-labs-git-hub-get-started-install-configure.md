#  Setting Up the GetHub Environment and Installing GitHub Desktop Client

## Introduction

GitHub is a cloud-based version control system designed for software developers. At the core is Git, a version control system that manages file versions and tracks who made which changes. The Hub is a cloud-based repository that manages storage of the files and provides a folder structure.

In this lab, you will learn how to create a GitHub Account and add it to Oracle, setup the GitHub Development Environment, and Install GitHub Desktop.

### Objectives

* Create a GitHub Account
* Add the GitHub Account to oracle
* Set up the GitHub Environment
* Install GitHub Desktop Client
### What Do You Need?

* A fair knowledge of GitHub Web UI and the GitHub Desktop client
* Prior knowledge of any editor is an advantage.

+ **Introduction**
GitHub is a cloud-based version control system designed for software developers. At the core is Git, a version control system that manages file versions and tracks who made which changes. The Hub is a cloud-based repository that manages storage of the files and provides a folder structure.

## **Step 1:** Getting Your GitHub Account Added to the Oracle Organization

In this step, you will create your GitHub account and add it to Oracle.

1. Create a free GitHub Account here: [GitHub Web UI](https://github.com/) if you don't have one.
2. Use Your Oracle ID to register. Do not create a secondary new account to join GitHub. Ensure that your GitHub account is associated to your @oracle.com email ID.
3. Go to [GitHub Settings](https://github.com/settings/profile) and configure the following:
  * Set your Name as it appears in your Aria employee page.
  * Set a Custom Profile.
4. Set up a 2 Factor Authentication here: [GitHub Security](https://github.com/settings/security).

## **Step 2:** Requesting Membership to Oracle GitHub Organization (OGHO)
1. Send a membership request from your oracle.com email address to opensource_ww_grp@oracle.com.
2. Await the invitation from them. Note that you will receive an email only if your account follows the guidelines in Step 1.
3. Accept the invitation that you receive or go to the organization page you requested membership for, and accept the invitation at the top of the page.

## **Step 3:** Publicize your Membership
1. In the top right corner of [GitHub Profile Settings](https://github.com/settings/profile), click your profile photo, then click **Your profile**.
  ![](./images/get-started-profile1.png " ")
2. On the left side of your profile page, under **Personal Settings**, click **Organizations** to display the **Organizations** page and then click the icon for your organization.
  ![](./images/get-started-profile2.png " ")
3. Under your organization name, click **People**.
4. Locate your username in the list of members. If the list is large, you can search for your username in the search box.
5. In the menu to the right of your username, choose a new visibility option:
  * To publicize your membership, choose **Public**.
  * To hide your membership, choose **Private**.
  ![](./images/get-started-profile-public.png " ")
6. Send an email to [github_info_ww_grp](github_info_ww_grp@oracle.com) that you have made your membership public.
  **Note**: Employees who have not made their membership public will be removed from the organization within 30-days of the initial request to be added.
Now you are an official member of the main Oracle Organization on GitHub (OGHO).

## **Step 4:** Setup the GitHub Development Environment and Install GitHub Desktop
The GitHub Desktop application is a UI client for Windows and Mac that simplifies the complex set of GitHub command line arguments. GitHub Desktop is a fast and easy way to contribute to projects and it simplifies your development workflow and to track changes. It is much easier than using the Git command line.

It is highly recommended if you are new to GitHub.
To setup the GitHub Development Environment and install GitHub Desktop

1. Download and install GitHub Desktop from [GitHub Desktop](https://desktop.github.com/).

2. When the software is successfully installed, open the GitHub Desktop.
  ![](./images/get-started-git-hub-dektop.png " ")

## **Step 5:** Fork the learning-library Repository into Your GitHub Account
  The GitHub Web UI is organized by projects, each with its own repository or "repo" that is accessed through a unique URL.

  To create workshops and labs, we use the oracle project and one of its repositories named **learning-library**.
  A fork is a personal copy of a repository at a point in time.
  Forking creates a duplicate copy of the production oracle/learning-library repository to your GitHub account. For example, if the username is achepuri, a fork of the learning-library repository in the oracle project will create a copy to [achepuri/learning-library](https://github.com/achepuri/learning-library).
  To fork the learning-library repository:
1. Log in to the [GitHub Web UI](http://github.com), using your GitHub account.
2. Navigate to the [oracle/learning-library repository](https://github.com/oracle/learning-library).
3. Click **Fork**.
![](./images/get-started-git-hub-webUI-fork.png " ")

In the following example, user achepuri is creating a fork based on the learning-library repository.
![](./images/get-started-git-hub-webui-forked-library.png " ")
In the next step, you will clone this forked repository.

## **Step 5:** Clone the Forked repository
A clone is a copy of your forked repository that lives on your local computer instead of on [GitHub Web UI](http://github.com).
When you make a clone, you can edit the files in your preferred editor, such as **Atom**, and use **GitHub Desktop client** to keep track of your changes without having to be online. The repository you cloned is still connected to the remote version (your fork) so that you can push your local changes to the remote to keep them synced when you're online.


**This concludes this lab. Please proceed to the next lab in the Contents menu on the right.**

## Want to Learn More?

* [Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Security Lists](https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Concepts/securitylists.htm)
* [Security Rules](https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Concepts/securityrules.htm)
* [Configure Security Rules for the Network](https://docs.oracle.com/en/cloud/paas/big-data-service/user/configure-security-rules-network.html)
* [VCN and Subnets](https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingVCNs.htm)
* [Cloudera Manager](https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cloudera_manager.html)
* [Using Hue](https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/hue_using.html)

## Acknowledgements

* **Author:**
    + Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
* **Technical Contributor:**
    + Martin Gubar, Director, Oracle Big Data Product Management
* **Last Updated By/Date:** Lauran Serhal, August 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
