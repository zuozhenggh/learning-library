# Using Prediction in an Application

## Introduction

Now that you created a model using Zeppelin Notebooks, you can integrate that model with existing applications and processes. It’s worth repeating that this is a critical step. Machine learning models aren’t delivering value until they are being actively used by the company in existing applications and processes.

We will start this lab with some more setup, loading both data and an APEX application, the Suspicious Claims application. 

Estimated time: 20 - 30 minutes

### Objectives

In this lab, you will:
- Import an APEX application.
- Review the application to see how you can make predictions on the fly.

### Prerequisites

This lab assumes you have completed the following labs:
- Login to Oracle Cloud/Sign Up for Free Tier Account
- Connect and Provision ADB
- Create a Machine Learning Model

## **Step 1:** Import the APEX Application

1. Download the pre-built APEX application from [here](files/f100.sql).

1. On the browser tab with your ADW instance, click on the Tools tab and select **Open APEX**.

    ![](images/adw-tools-open-apex.png)

2. Enter the admin password you created for the database.

    ![](images/sign-in-apex.png)

3. On the Welcome screen click **Create Workspace**.

    ![](images/welcome-apex.png)

4. Select your **OMLUSER** using the drop down, enter **OMLAPP** as the workspace name, then click **Create Workspace**.

    ![](images/create-omlapp-ws.png)

5. Sign out of the admin view and into your workspace by clicking on **OMLAPP**.

    ![](images/signout-apex-admin.png)

6. Sign into the **OMLAPP** workspace. Click the **Remember workspace name and username** checkbox to save yourself time in the future.

    ![](images/sign-in-apex-omlapp.png)

7. On the Welcome Screen, click **Set APEX Account Password**, enter an e-mail address, scroll down and enter a password you'll remember, then click **Apply Changes**.

    ![](images/set-apex-passwd.png)

    ![](images/update-profile.png)

    ![](images/enter-apex-passwd.png)

8. Click **App Builder**.

    ![](images/app-builder.png)

9. Click **Import**.

    ![](images/import-app.png)

10. Select the file `f100.sql` or drag it from where you downloaded it to the drop target and click **Next** twice.

    ![](images/import-app-2.png)

11. Click **Install Application**.

    ![](images/install-app.png)

12. On the Install Application screen, click **Next** and then **Install**.

    ![](images/install-app-2.png)

13. On the success screen, click **Run Application**.

    ![](images/run-app.png)

14. Sign in using your password for OMLUSER.

    ![](images/sign-in-app.png)

    ![](images/suspicious_claim.png)

## **Step 2:** Run the application

1. Click on Suspicious Claim, then open the faceted charts.

    ![](images/suspicious-claim-facets.png)

  These charts graph the typical age range, vehicle type, policy holder, and past number of claims.

2. In the Percent Fraud facet, click on 60-80 to narrow to that range.

    ![](images/suspicious-claim-facets-60.png)

    Note that the first row of the table illustrates that this claim seems unusual and could be suspicious, because it is a Honda that is 5 years old, and yet the claimed worth is more than $69,000.

3. Click Key Factors from the left to show graphs of the key factors used to predict fraud from this data.

    ![](images/key-factors.png)

4. Using the application, the claims adjuster can use their judgement to flag a claim. For example, by selecting the record and editing the Fraud Found value, the adjuster can flag the claim.

    ![](images/flag-fraud-1.png)

    ![](images/flag-fraud-2.png)

5. You may see that the table automatically resorted. Click the Policy Number column and select Sort Ascending.

    ![](images/flag-fraud-3.png)

6. The claim against policy 1 is now set to Fraud Found = Yes.

    ![](images/flag-fraud-4.png)

This concludes this lab and this workshop.

## Acknowledgements

- **Author** - Charlie Berger, Senior Director of Product Management, Machine Learning, Cognitive Analytics and AI
- **Last Updated By/Date** - Tom McGinn, Product Manager, DB Product Management, February 2021

## Need Help?
Please submit an e-mail to **livelabs-help-db_us@oracle.com**. Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
