# Lab: Running the Notebook

## Introduction

This guide will tell you how to run the Retail Segmentation demo notebook on the infrastruction that we have just provisioned.

## Task 1: Placing Files into the Notebook

1. Return to your datascience notebook that you have created and press Open.

2. Place the config file associated with your oracle account and tenancy into the ./.oci directory within the directory on Oracle Data Science.

Note: You can easily upload files to OCI Data Science by dragging a file from your local folder onto the file directory box on the left.

For tips on how to create a config file, go to (add link)

The code below should help you move the config file to ./.oci

```Bash
mv config ./.oci
```

3. Place your wallet.zip into the directory and unzip it into a folder of your choice.

While it doesn't matter if you unzip it into a folder, it is better organized that way.

Make sure to remember what directory you place the unzipped contents in for later.

The code below will help you unzip the folder and move it to a separate folder of your choice. Removing -d and the destination folder will unzip the folders in the current directory.
(insert code markdown) unzip Wallet_Your_DB_Name.zip -d destination_folder

5. Download the Retail Segmentation notebook from this link and place it into the directory in Oracle Datascience.

## Task 2: Installing the Kernel

6. Press the + button on the top left to open up the launch, and double click the environment explorer.

7. Search for "General Machine Learning" on the top right, and then select General Machine Learning for CPU's.

The kernel may already be displayed by defauly even before you search.
Also, other machine learning libraries such as Tensorflow for CPU should work as well so long as it is CPU for CPU instanes and GPU for GPU instances.

8. Click the down arrow on the right to expand the box for the kernel.

9. Click the copy button next to the line of code under install.

10. Open a terminal from the launch and run the line of code.

If it asks you for version number just press enter, and if it asks you to say yes, press y and then press enter,

## Task 3: Running the Retail Segmentation Notebook

1. Open the data science notebook by double clicking it in the directory on the left hand side.

2. Now, you must fill in the information in the third block of code.

TNS_ADMIN will equal the directory which you put the wallet folder in.
ADW_SID refers to a value within the tnsnames.ora file in the unzipped wallet folder.
Set it to the value that ends with "low" which should look something like "databasename"_low
ADW_USER and ADW_PASSWORD will be the username and password that you had created earlier using OML User Administration.

3. For the fourth block of code, underneath what you had just edited, make sure the string within the first set of quotes points to the location of the data file you had downloaded. 

4. With this, you should be able to press run all, at the top, which will execute the code sequentially, and produce results.
