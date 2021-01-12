# Use AutoML

## Introduction

This lab walks you through the steps to ...

Estimated Lab Time: n minutes

### About AutoML
AutoML (Automatic Machine Learning) provides built-in data science expertise about data analytics and modeling that you can employ to build machine learning models.

### Objectives

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

*Use this section to describe any prerequisites, including Oracle Cloud accounts, set up requirements, etc.*

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default*

## **STEP 1**: Import libraries supporting OML4Py

Step 1 opening paragraph.

1. Run the following script to import `oml` module, Pandas package, `automl` and set the display options:

  To create a link to local file you want the reader to download, use this format:

2. Create data set as Pandas DataFrame and load into ADB. In this example, you load the wine data set, combining target and predictors into a single DataFrame that matches the form the data would have as a database table. These DataFrame objects can then be loaded into Oracle Database using the create function.

    ![Image alt text](images/sample1.png "Image title")



## **STEP 2:** Automatic Algorithm Selection

1. Run the following script to prepare the wine data set:


2. Run the following script to compute classification algorithm ranking for the wine data set:



  The script returns the SVM Gaussian, SVM Linear, Neural Network and Random Forest. Among these, SVM Gaussian is ranked first.


## **STEP 3:** Automatic Feature Selection
In this step, you determine the features that best support the selected algorithm. You first define a FeatureSelection object with score metric accuracy.  You also invoke reduce function to specify the desired algorithm determined above and the train and test data set proxy objects.

You see the set of selected columns.

1. Run the following script to define the Feature Selection object `fs_wine_cl`:




### Try it Yourself: Try other algorithms, such as svm_linear, to see if different columns are selected.

## **STEP 4:** Automatic Model Tuning
At this point, you are ready to build and tune the models you want to use.

First, you define a ModelTuning object for classification.
Then, you invoke tune to produce the tuned model using the algorithms selected above and the reduced column data.

The result of model tuning is a dictionary with the 'best model' and 'all evals', which contains a list of all hyperparameter choices tried and their corresponding score

1. Run the following script to define the model tuning object my_wine_cl for classification.  



2. Run the following script to specify a model tuning search space:


3.

## **STEP 5:** Automatic Model Selection
As a short cut, you may choose to go directly to model selection on the training data. Model Selection automatically selects the best algorithm (using Algorithm Selection) from the set of supported algorithms, then builds, tunes, and returns the model.

1. Run the following script to select the best model:




### Try it Yourself:
**Hint:**
* Using the wine data set, prepare the data set with target 'alcohol'.
* Use AutoML to select a regression algorithm using the 'r2' score metric,
* Then feature selection, and model tuning.
* Finally, view the model object.





*At the conclusion of the lab add this statement: note this is the last lab in the workshop*
Congratulations! You have completed this workshop!

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
