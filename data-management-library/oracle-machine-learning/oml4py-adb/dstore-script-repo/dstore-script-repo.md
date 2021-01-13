# Datastore and Script Repository

## Introduction

This lab walks you through the steps to ...

Estimated Lab Time: n minutes

### About Datastore and Script Repository
**Datastores** exist in the user’s Oracle Database schema. A datastore, and the objects it contains, persist in the database until explicitly deleted. By using a datastore, you can store Python objects in a named datastore entry. This named datastore can then be used in subsequent Python sessions, and even be made available to other users or programs by granting/revoking read permissions.

Python objects, including OML4Py proxy objects, exist for the duration of the current Python session unless you explicitly save them. You can save one or more Python objects, including OML proxy objects, to a named datastore and then load those objects in a later Python session. This is also useful when using embedded Python execution.
By using a datastore, you can:
* Save OML4Py and other Python objects for use across Python sessions
* Grant or revoke read privilege access to a datastore or its objects to one or more users. You can restore the saved objects in another Python session.
* Easily pass multiple and non-scalar arguments to Python functions for use in embedded Python execution from Python, REST, and SQL  API. **Note:** SQL and REST APIs support passing scale values, such as datastore name or numeric values, only.
* List available datastores and explore datastore contents

**Script Repository:**

With the script repository, you can:
* Create and store user-defined Python functions as scripts in Oracle Database
* Grant or revoke the read/run privilege to a script
* List available scripts
* Load a script function into the Python environment
* Drop a script from the script repository

You can make scripts either private or global. A private script is available only to the owner. A global script is available to any user. For private scripts, the owner of the script may grant the read privilege to other users or revoke that privilege.

### Objectives

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

## **STEP 1**: Import libraries supporting OML4Py and create data table

To use OML4Py, first import the package `oml`. Also import the pandas package for pandas-specific functionality.

**Note:** This lab requires the `PYQADMIN` role to use some functionalities in this lab, and in the Embedded Python Execution.

1. Run the following script. The script imports the `oml` module and the `Pandas` package.

    ```
    %python

    import pandas as pd
    import oml

    pd.set_option('display.max_rows', 500)
    pd.set_option('display.max_columns', 500)
    pd.set_option('display.width', 1000)
    ```  

## **STEP 2:** Create Pandas DataFrames and load them into Autonomous Database

In this step, you will work with three data set - IRIS data set, Diabetes data set, and Boston data set. Here, you will learn how to:

* Load these three data sets and for each combine the target and predictors into a single DataFrame
* Create and display the columns for each data set
* Use the dataframe to explore the datastore functionality

1. Run the following script to create the Iris table:

     ```
     <copy>%python

     from sklearn import datasets
     from sklearn import linear_model
     import pandas as pd

     iris = datasets.load_iris()
     x = pd.DataFrame(iris.data, columns = ['SEPAL_LENGTH','SEPAL_WIDTH',
     'PETAL_LENGTH','PETAL_WIDTH'])
     y = pd.DataFrame(list(map(lambda x: {0: 'setosa', 1: 'versicolor',
     2:'virginica'}[x], iris.target)), columns = ['SPECIES'])

     try:
        oml.drop(table='IRIS')
     except:
        pass

    IRIS = oml.create(pd.concat([x, y], axis=1), table = 'IRIS')
    iris = pd.concat([x, y], axis=1)
    print(IRIS.columns)</copy>
     ```
  ![Image alt text](images/create_iris_table.png "Create the Iris table")

2. Run the following script to create the Diabetes table:
   ```
   %python

   diabetes = datasets.load_diabetes()
   x = pd.DataFrame(diabetes.data, columns=diabetes.feature_names)
   y = pd.DataFrame(diabetes.target, columns=['disease_progression'])

   DIABETES_TMP = oml.push(pd.concat([x, y], axis=1))
   print(DIABETES_TMP.columns)
   ```
  ![Image alt text](images/create_diabetes_table.png "Create the Diabetes table")  


3. Run the following script to create the Boston table:

    ```
    %python

    boston = datasets.load_boston()
    x = pd.DataFrame(boston.data, columns = boston.feature_names.tolist())
    y = pd.DataFrame(boston.target, columns = ['Value'])

    BOSTON_TMP = oml.push(pd.concat([x, y], axis=1))
    print(BOSTON_TMP.columns)
    ```
    ![Image alt text](images/create_boston_table.png "Create the Boston table")

## **STEP 3:** Save Python objects to datastore

In this step, you will save the actual Iris data set and the temporary BOSTON proxy object to a datastore named `ds_pydata`, overwriting if the named datastore already exists.

**Note:** You can store actual data objects in a datastore, but large data objects should remain as database tables for performance and scalability.

By storing the `BOSTON_TMP` object, the temporary table will not be deleted when the session terminates.

1. Run the following script to save the `iris` and `boston` tables in the Autonomous Database:

  ```
  %python

  oml.ds.save(objs={'iris':iris, 'oml_boston':BOSTON_TMP},
  name="ds_pydata", description = "python datasets", overwrite=True)
  ```
2. Save the Diabetes tables into the Database. Add a third object, the temporary DIABETES proxy object, to that same datastore. Run the following script:
  ```
  %python
  oml.ds.save(objs={'oml_diabetes':DIABETES_TMP}, name="ds_pydata", append=True)
  ```
3. Save the iris DataFrame to a new datastore, and then list the datastores. Notice we see the datastore name, the number of objects in the datastore, the size in bytes consumed, when the datastore was create/updated, and any description provided by the user. The two datastores `ds_iris_data` and `ds_pydata` are present, with the latter containing three objects.

   ```
   %python

   oml.ds.save(objs={'iris':iris},
   name="ds_iris_data", description = "iris dataset", overwrite=True)

   oml.ds.dir()
   ```
  ![Image alt text](images/iris_df_in_ds.png "Save Iris DataFrame in a Datastore ")

## **STEP 4:** Save model ojects in a datastore

This step illustrates how to store other types of objects in datastores. For this, you will create regression models using sklearn and OML4Py.

1. Run the following script to build two regression models - `regr1` and `regr2`. The `regr1` uses the open  source function `LinearRegression()` and the `regr2` uses the OML function `oml.glm()`.

  **Note:** This highlights that both open source models and in-database model proxy objects can be stored in a datastore. Like tables created using `oml.push` function, default-named model proxy objects are dropped at the end of the database connection unless they are saved in a datastore.

  ```
  %python

  regr1 = linear_model.LinearRegression()
  regr1.fit(boston.data, boston.target)

  regr2 = oml.glm("regression")
  X = BOSTON_TMP.drop('Value')
  y = BOSTON_TMP['Value']
  regr2 = regr2.fit(X, y)
  ```    

2. Run the following script to save the objects `regr1` and `regr2` to a datastore, and allow the read privilege to be granted to them.

  ```
  %python

  oml.ds.save(objs={'regr1':regr1, 'regr2':regr2},
  name="ds_pymodel", grantable=True, overwrite=True)

  oml.ds.dir()
  ```
  ![Image alt text](images/regr1_regr2.png "Save Objects to a Datastore")  
3. Now grant the read privilege to all users by specifying `user=None`. Finally, list the datastores to which the read privilege has been granted.

  ```
  %python

  oml.grant(name="ds_pymodel", typ="datastore", user=None)

  oml.ds.dir(dstype="grant")
  ```
  ![Image alt text](images/grant_read_priv.png "Grant read privilege to all users")    

## **STEP 5:**  Load datastore objects into memory

In this step, you load all Python objects from a datastore to the global workspace and sort the result by name. Notice that they have the name specified in the dictionary when saved.

1. Run the following script to load the datastore `ds_pydata` into memory:

  ```
  %python

  sorted(oml.ds.load(name="ds_pydata"))
  ```    
  ![Image alt text](images/load_ds_into_memory.png "Load datastore ds_pydata into memory")      

2. Run the following command to load the named Python object (regression model) `regr2`, from the datastore to the global workspace.

   ```
   %python

   oml.ds.load(name="ds_pymodel", objs=["regr2"])
   ```    
  ![Image alt text](images/load_regr2_gbl_ws.png "Load Python object into global workspace")

3. Run the following command to load the named Python object (regression model) `regr1`, from the datastore to the user's workspace.

  ```
  %python

  oml.ds.load(name="ds_pymodel", objs=["regr1"], to_globals=False)
  ```
  ![Image alt text](images/load_regr1_usr_ws.png "Load Python object into user's workspace")

## **STEP 6:** View datastores and other details

This step shows how to work with datastores.

1. Run the following script to get the list of datastore and a count of the objects in it:

  ```
  %python

  oml.ds.dir(dstype="all")[['owner', 'datastore_name', 'object_count']]
  ```        
  ![Image alt text](images/list_datastores.png "List of Datastores and Count of Objects")

2. Run the following script to list the datastores to which other users have been granted the read privilege:

  ```
  %python

  oml.ds.dir(dstype="grant")
  ```
  ![Image alt text](images/datastore_with_read_priv.png "Load Python object into user's workspace")

## **STEP 7:** View contents of a datastore

This step shows how to view/describe the content of a datastore. This example considers the `ds_pydata` datastore. Notice that the three proxy objects are listed.

1. Run the following script to list the content of a datastore:

  ```
  %python

  oml.ds.describe(name='ds_pydata')
  ```        

  ![Image alt text](images/datastore_content.png "View Datastore Content")

  The script returns the description of three proxy objects - `iris`, `oml_boston`, and `oml_diabetes`. It lists the class, size, length, row and column count for each object.     

## **STEP 8:** Manage datastore privileges

This step shows how to revoke read privilege, show datastores to which the read privilege has been granted, and again grant read privilege to a user.

1. Run the following script to revoke the read privilege from every user:

   ```
   %python

   oml.revoke(name="ds_pymodel", typ="datastore", user=None)

   oml.ds.dir(dstype="grant")
   ```

    ![Image alt text](images/revoke_priv.png "Revoke privilege")        
2. Run the following script to grant read privilege to OMLUSER2:

    ```
    %python

    oml.grant(name="ds_pymodel", typ="datastore", user="OMLUSER2")

    oml.ds.dir(dstype="grant")
    ```
    ![Image alt text](images/grant_priv.png "Grant privilege")        

## **STEP 9:** Delete Datastore Content

This step shows how to use the `oml.ds.delete` function to delete datastores or datastore content.

1. Run the following script to delete datastore content:

  ```
  %python

  oml.ds.delete(name="ds_pydata", objs=["iris", "oml_boston"])

  oml.ds.delete(name="ds_pydata")

  oml.ds.delete(name="_pymodel", regex_match=True)

  oml.ds.dir()
  ```
  ![Image alt text](images/delete_datastore.png "Delete Datastore")

  The script first deletes the contents of datastore `ds_pydata`, and then deletes the datastore itself. It also deletes the datastore `ds_pymodel` using pattern matching.

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
