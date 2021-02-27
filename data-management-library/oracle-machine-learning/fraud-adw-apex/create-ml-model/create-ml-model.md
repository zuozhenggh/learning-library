# Build a Machine Learning Model

## Introduction

This is the lab where you’re going to do the work of building and training a machine learning model that will help identify fraudulent auto claims.

### Before You Begin

Remember that we are trying to help predict when an auto claim is fraudulent. We use Oracle Machine Learning's 1-Class Support Vector Machine to train on "normal" records and apply the 1-Class SVM model to our insurance claims to flag those claims that are most dissimilar from the training population.

[](youtube:IkOz2rrB7hU)

In this lab, you will use Apache Zeppelin notebooks to do this work.

Estimated time: 20 - 30 minutes

### Objectives

- Import an Apache Zeppelin notebook.
- Become familiar with Oracle Machine Learning Algorithms.
- Create a machine learning model to determine factors that predict fraud.

### Prerequisites

This lab assumes you have completed the following labs:
- Login to Oracle Cloud/Sign Up for Free Tier Account
- Connect and Provision ADB

## **Step 1:** Import ML Notebooks

We have built the steps that are normally followed when exploring data and building a machine learning model. This has been saved to the file you can download. We will import this notebook and review it. It is important to note that you *must execute all the steps in this notebook*. Executing the steps takes only a few minutes.

1. From the tab on your browser with your ADW instance, in the Tools tab, select **Open Oracle ML Administration** and (if required) login with the admin credentials.

    ![](images/adw-open-ml-user-admin.png)

    ![](images/oml-signin-admin.png)

2. Click the home button to login in with the OMLUSER.

    ![](images/oml-user-homebutton.png)

3. Sign in with the omluser using the password you created.

    ![](images/signin-to-oml.png)

4. Click on Notebooks from the Quick Actions menu.

    ![](images/open-notebooks.png)

5. Click on **Import**.

    ![](images/import-notebook.png)

6. Download the [Auto Insurance Claims Fraud - Unsupervised Learning.json](files/Auto-Insurance-Claims-Fraud-Unsupervised-Learning.json?download=1) file.

7. Download the [Auto Insurance Claims Fraud - Supervised Learning.json](files/Auto-Insurance-Claims-Fraud-Supervised-Learning.json?download=1) file.

6. Go to the directory where you downloaded and unzipped the files and import the **Auto-Insurance-Claims-Fraud-Unsupervised-Learning.json** notebook.

    ![](images/import-unsuper-notebook.png)

7. Repeat and import the **Auto-Insurance-Claims-Fraud-Unsupervised-Learning.json** notebook.

    ![](images/import-super-notebook.png)

## **Step 2:** - Working Unsupervised Auto Claims

1.  Select the **Auto Insurance Claims Fraud - Unsupervised Learning** notebook to open it.

    ![](./images/unsuper-learning-notebook.png  " ")

5.  Before you start working the **Auto Insurance Claims Fraud - Unsupervised Learning** you need to set the interpreter binging. Click on the gear icon.

    ![](./images/unsuper-learning-notebook-binding-1.png  " ")

6.  Click the low and medium bindings to disable them and click **Save**.

    ![](./images/unsuper-learning-notebook-binding-2.png  " ")

7.  Click on the **Run All Paragraphs** icon to run all paragraphs in the notebook, then click **OK**.

    ![](./images/run-all.png  " ")

    ![](images/run-all-ok.png)

8.  Click on the **Show/Hide the Output** icon to show the output and ensure that all the paragraphs are in **Finished** state.

    ![](./images/show-hide-output-2.png  " ")

    Click the **Show/Hide the Output** icon again to return to the paragraphs.

## **Step 3:** About this Notebook

This step discusses the result of each portion of the notebook.

1. In the first table, the claims data illustrates the model input attributes.

    ![](images/unsuper-1.png)

2. The next section illustrates how we can graph our understanding of the data.

    ![](images/unsuper-2.png)

3. Next, we'll build the model to train on.

    ![](images/unsuper-3.png)

4. Using the model, we can display the most suspicious claims in descending order.

    ![](images/unsuper-4.png)

5. Then explore those suspicious claims.

    ![](images/unsuper-5.png)

6. Finally, build the table of suspicious claims.

    ![](images/unsuper-6.png)

## **Step 4:** Run the Supervised notebook

1. Click on the menu icon in the upper left corner and select Notebooks.

    ![](images/menu.png)

    ![](images/open-notebooks-menu.png)

2. Click **Auto Insurance Claims - Supervised Learning** to open the notebook, and set the bindings and run the notebook.

    ![](images/super-notebook.png)

3. This Notebook uses labeled data to build models that better target known insurance claims fraud.

    ![](images/super-1.png)

4. As with the unsupervised model, we graph our data understanding, split the model, identify influential attributes, and build supervised classification models.

    ![](images/super-2.png)

    ![](images/super-3.png)

    ![](images/super-4.png)

    ![](images/super-5.png)

Please proceed to the next lab.

## Acknowledgements

- **Author** - Charlie Berger, Senior Director of Product Management, Machine Learning, Cognitive Analytics and AI
- **Last Updated By/Date** - Tom McGinn, Product Manager, DB Product Management, February 2021

## Need Help?
Please submit an e-mail to **livelabs-help-db_us@oracle.com**. Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
