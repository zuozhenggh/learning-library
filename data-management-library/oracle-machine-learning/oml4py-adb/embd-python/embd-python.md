# Run user-defined functions using Embedded Python Execution

## Introduction

This lab walks you through the steps to use OML4Py Embedded Python Execution functions. You will also learn about the Script repository.

Estimated Lab Time: 20 minutes

### About Embedded Python Execution
Embedded Python Execution enables you to run user-defined Python functions in Python engines spawned in the Autonomous Database environment. These engines run alongside an OML Notebooks Python interpreter session.

The OML4Py Embedded Python Execution functions are:

* `oml.do_eval` - Calls a Python function in Python engines spawned by the Autonomous Database environment.
* `oml.group_apply` - Partitions a database table by the values in one or more columns and runs the provided user-defined Python function on each partition.
* `oml.index_apply` - Calls a Python function multiple times, passing in a unique index of the invocation to the user-defined function.
* `oml.row_apply` - Partitions a database table into sets of rows and runs the provided user-defined Python function on the data in each set.
* `oml.table_apply` - calls a Python function on data in the database as a single pandas.DataFrame in a single Python engine.

**Note:** Embedded Python Execution functions are also available through the Oracle Machine Learning for Python REST API for Embedded Python Execution.

### About the Python Script Repository
OML4Py stores named user-defined functions called scripts in the script repository.

* `oml.script.create` - Creates a script, which contains a single Python function definition, in the script repository.
* `oml.script.dir` - Lists the scripts present in the script repository.
* `oml.script.drop` - Drops a script from the script repository.
* `oml.script.load` - Loads a script from the script repository into a Python session.
* `oml.grant` - Grants read privilege permission to another user to a datastore or script owned by the current user.
* `oml.revoke` - Revokes the read privilege permission that was granted to another user to a datastore or script owned by the current user.

To illustrate using the Python Script Repository, you will define a function build_lm1 that will fit a regression model. Using this function, you will then create a script named MyLM_function.

### Objectives

In this lab, you will:
* Use the OML4Py Embedded Python Execution functions
* Use the Python Script Repository

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).


## **STEP 1**: Import OML4Py and supporting libraries and Create Data Table

In Step 1 to Step 5, you learn about Embedded Python Execution.
Step 6 to 15, you will work with Python Script Repository.

1. Import `oml` module.

    ```
    <copy>%python

    import oml

    import warnings
    warnings.filterwarnings('ignore')</copy>
    ```  
2. Run the following script to create a table `IRIS` using the iris data set:
    ```
    <copy>%python

    from sklearn.datasets import load_iris
    from sklearn import linear_model
    import pandas as pd

    iris = load_iris()
    x = pd.DataFrame(iris.data,
    columns = ["SEPAL_LENGTH", "SEPAL_WIDTH", "PETAL_LENGTH", "PETAL_WIDTH"])
    y = pd.DataFrame(list(map(lambda x: {0:'setosa', 1: 'versicolor', 2:'virginica'}[x], iris.target)),
    columns = ['SPECIES'])
    iris_df = pd.concat([x,y], axis=1)

    try:
      oml.drop(table="IRIS")
    except:
      pass
    IRIS = oml.create(iris_df, table="IRIS")
    IRIS.head(4)</copy>
    ```

    ![Image alt text](images/iris_table.png "Iris table")

## **STEP 2:** Build and Score a Linear Model from sklearn in Python
In this step, you will validate your Python script, validate the user-defined function before invoking the embedded Python APIs.  You will also build a linear regression model LinearRegression.

1. Run the following script to import the model `linear_model` from sklearn.
    ```
    <copy>%python

    from sklearn import linear_model

    lm = linear_model.LinearRegression()
    X = iris_df[["PETAL_WIDTH"]]
    y = iris_df[["PETAL_LENGTH"]]
    mod = lm.fit(X, y)
    print("Model:",mod)</copy>
    ```
    ![Image alt text](images/LinearRegression_model.png "Model")

2. Run the script to predict the petal width using the `predict` function:
    ```
    <copy>%python

    pred = mod.predict(iris_df[["PETAL_WIDTH"]])
    pred[0:10]</copy>
    ```
    ![Image alt text](images/model_prediction.png "Prediction of petal width")

3. Run the following script to assess model quality using mean squared error and R^2:
    ```
    <copy>%python

    from sklearn.metrics import mean_squared_error, r2_score

    print('Coefficients: \n', mod.coef_)
    print("Mean squared error: %.2f"
    % mean_squared_error(iris_df[["PETAL_LENGTH"]], pred))

    print('Variance score (1 is perfect prediction): %.2f' % r2_score(iris_df[["PETAL_LENGTH"]], pred))</copy>
    ```
    ![Image alt text](images/coeff_sqe.png "Coefficients and mean square error computation")

4. Run the following script to generate a scatterplot of the data along with a plot of the regression line:
    ```
    <copy>%python

    import matplotlib.pyplot as plt

    plt.scatter(iris_df.loc[:,"PETAL_WIDTH"], iris_df.loc[:,"PETAL_LENGTH"])
    plt.plot(iris_df[["PETAL_WIDTH"]], pred, color='blue', linewidth=3)
    plt.grid(True)
    plt.title('Prediction of Petal Length')
    #plt.xticks(()) # Disable ticks
    #plt.yticks(())
    plt.xlabel('Petal Width')
    plt.ylabel('Petal Length')

    plt.show()</copy>
    ```
   ![Image alt text](images/scatterplot_iris.png "Prediction of petal length and petal width")

## **STEP 3:** Build the model using Embedded Python Execution
In this step, you will build the same linear model, but using the embedded Python execution Python engines under control of the Autonomous Database environment. You will perform the following tasks:

* Define the function `build_lm_1`, that returns the model as the result. This is referred to as a user-defined function.
* Next, score the training data and plot the model against the data points.
  **Note:**  The embedded Python execution can return images as well as structured content in the Python API. In the SQL API, as you'll see in another script, you choose between structured data, images, or XML output. Run this function to ensure it returns what is expected; - in this case, it is both an image and a model.


### Define the user-defined function `build_lm_1`    

1. Run the script to define the user-defined function `build_lm_1`:   
    ```
    <copy>%python

    def build_lm_1(dat):
      import oml
      from sklearn import linear_model
      import matplotlib.pyplot as plt

      lm = linear_model.LinearRegression()
      X = dat[["PETAL_WIDTH"]]
      y = dat[["PETAL_LENGTH"]]
      mod = lm.fit(X, y)

      pred = mod.predict(dat[["PETAL_WIDTH"]])
      plt.scatter(dat.loc[:,"PETAL_WIDTH"], dat.loc[:,"PETAL_LENGTH"])
      plt.plot(dat[["PETAL_WIDTH"]], pred, color='blue', linewidth=3)
      plt.grid(True)
      plt.title('Prediction of Petal Length')

      plt.xlabel('Petal Width')
      plt.ylabel('Petal Length')
      plt.show()
      return mod</copy>
      ```
2. Run this script to plot the model `build_lm_1` against the data points:
    ```
    <copy>%python

    build_lm_1(iris_df)</copy>
    ```
    ![Image alt text](images/petal_length_prediction.png "Petal length prediction")
### Use the table_apply Function

3. Use the `table_apply` function: The table_apply function takes the proxy object IRIS as input data and loads that data to the user-defined function as a pandas DataFrame. The user-defined function is passed as a Python string. You see that the model comes back as an OML object, which you can pull to the client and see that it's the linear model.
    ```
    %python

    build_lm_1 = """def build_lm_1(dat):
        import oml
        from sklearn import linear_model
        import matplotlib.pyplot as plt

        lm = linear_model.LinearRegression()
        X = dat[["PETAL_WIDTH"]]
        y = dat[["PETAL_LENGTH"]]
        mod = lm.fit(X, y)

        pred = mod.predict(dat[["PETAL_WIDTH"]])
        plt.scatter(dat.loc[:,"PETAL_WIDTH"], dat.loc[:,"PETAL_LENGTH"])
        plt.plot(dat[["PETAL_WIDTH"]], pred, color='blue', linewidth=3)
        plt.grid(True)
        plt.title('Prediction of Petal Length')

        plt.xlabel('Petal Width')
        plt.ylabel('Petal Length')
        plt.show()
        return mod"""
    ```
4. By invoking `table_apply`, a Python engine is spawned and the user-defined function `build_lm_1` is invoked on that engine with the data referenced by IRIS being passed in as a pandas DataFrame. Part of the return value is the image, which is automatically displayed.
    ```
    <copy>%python

    mod = oml.table_apply(data=IRIS, func = build_lm_1)</copy>
    ```
    ![Image alt text](images/table_apply_output.png "Petal length prediction")

5. Run the following script to print the object, model, type and coefficient.
    ```
    <copy>%python

    print("Object:",mod)
    print("Model:",mod)
    print("Type:",type(mod))
    print("Coefficient", mod.coef_)</copy>
    ```
    ![Image alt text](images/print.png "Print model details")

### Use the row_apply Function
6. Use the embedded python execution function `row_apply` to run a user-defined function on chunks of rows, which is useful to perform scoring in parallel for native Python models. In this step, define the user-defined function `score_lm_1` to make predictions (score data) using the data set and model passed in as arguments. It returns the predictions as a DataFrame object.
    ```
    <copy>%python

    def score_lm_1(dat, model):
      import pandas as pd
      from sklearn import linear_model
      pred = model.predict(dat[["PETAL_WIDTH"]])
      return pd.concat([dat[['SPECIES', 'PETAL_LENGTH']],
      pd.DataFrame(pred, columns=['PRED_PETAL_LENGTH'])], axis=1)</copy>
    ```
7. Use the `row_apply` to call this user-defined function and return a single DataFrame proxy object as the result. The `row_apply` function takes as arguments the proxy object `IRIS`, that we want 10 rows scored at a time (resulting in 15 function calls), the user-defined function, the linear model object, and that we want the result to be returned as a single table by specifying the table definition.
    ```
    <copy>%python

    res = oml.row_apply(IRIS, rows=10, func=score_lm_1, model=mod,
    func_value=pd.DataFrame([('a', 1, 1)],
    columns=['SPECIES', 'PETAL_LENGTH', 'PRED_PETAL_LENGTH']))
    res.head()</copy>
    ```
    ![Image alt text](images/row_apply.png "Output of row_apply function")
## **STEP 4:** Build One Model per Species using Group_Apply Function
This step shows how to use the `oml.group_apply` function for model building. The `oml.group_apply` function passes the `oml.DataFrame` specified by the data argument to the user-defined function as its first argument. The index argument to `oml.group_apply` specifies the columns of `oml.DataFrame` by which the database groups the data for processing by the user-defined Python function. The `oml.group_apply` function can use data-parallel execution, in which one or more Python engines perform the same Python function on different groups of data.

In this step, you build three models, one specific to each species and return them as a dictionary.

1. Run the following script to build three models, one each for the species - Versicolor, Setosa, and Virginica. Here, you use the `oml.group_apply` function to invoke the user-defined function `build_lm_g` three times (one for each species) using two Python engines (parallel=2)
    ```
    <copy>%python

    def build_lm_g(dat):
      import oml
      from sklearn import linear_model
      lm = linear_model.LinearRegression()
      X = dat[["PETAL_WIDTH"]]
      y = dat[["PETAL_LENGTH"]]
      mod = lm.fit(X, y)
      return mod

    mod = oml.group_apply(IRIS[:,["PETAL_LENGTH","PETAL_WIDTH","SPECIES"]],
      index=oml.DataFrame(IRIS['SPECIES']),
      func=build_lm_g,
      parallel=2)

    print("Type:",type(mod))
    mod</copy>
    ```
    ![Image alt text](images/model_group_apply.png "Models build using group_apply function")


2. Change the user-defined function to save the models in a datastore. The datastore allows storing Python objects in the database under the provided name. The object assumes the name it is assigned in Python, here “mod_” and the corresponding Species value.
    ```
    <copy>%python

    def build_lm_2(dat, dsname):
      import oml
      from sklearn import linear_model
      lm = linear_model.LinearRegression()
      X = dat[["PETAL_WIDTH"]]
      y = dat[["PETAL_LENGTH"]]
      lm.fit(X, y)
      name = "mod_" + dat.loc[dat.index[0],'SPECIES']
      oml.ds.save(objs = {name: lm}, name=dsname, append=True)
      return name</copy>
    ```
3. Run the following script to print the outcome, which contains a dictionary of three elements each assigned the model object name.
    ```
    <copy>%python

    try:
      oml.ds.delete('ds-1')
    except:
      print("Datastore not found")

    res = oml.group_apply(IRIS[:,["PETAL_LENGTH","PETAL_WIDTH","SPECIES"]],
      index=oml.DataFrame(IRIS['SPECIES']),
      func=build_lm_2, dsname="ds-1")

    print("Outcome:",res)</copy>
    ```
    ![Image alt text](images/print_outcome.png "Print outcome")

**Note:** If the datastore exists, then delete it so that the `group_apply` function completes successfully. The `group_apply` function takes the data, the index parameter that specifies the column or columns to partition on, the user-defined function, and that we wish to automatically connect to the database from the Python engine. Connecting to the database is necessary when using the datastore functionality.    

Here, the model object names are `mod_versicolor`, `mod_virginica`, and `mod_setosa`.
When you load the datastore, you get the three models loaded into the client Python engine, assigned to their respective variables.
**Note:** Embedded Python execution can also leverage functions from third-party packages. These packages need to be installed on the database server machine, but can then be used inside the user-defined function as shown here using LinearSVC.

Again, we create this script in the Python script repository and then invoke it by name using `table_apply`. We then pull the model to the client and view its type.

### Call a function N times
4. The `index_apply` function allows the same function to be called a specified number of times. The first argument to the user-defined function is an index number for the function execution. For example, if the `times` argument is `10`, each function call will receive a distinct value between 1 and 10. This can be used, for instance, for selecting behavior within the function or setting a random seed for Monte Carlo analysis.
    ```
    <copy>%python

    def compute_random_mean(index):
        import numpy as np
        import scipy
        from statistics import mean
        np.random.seed(index)
        res = np.random.random((100,1))*10
        return mean(res[1])

    print("Test: ", compute_random_mean(3))

    res = oml.index_apply(times=12, func=compute_random_mean)
    res</copy>
    ```
    ![Image alt text](images/index_apply.png "Use index_apply to call function n times")

## **Try it yourself**
Use the `group_apply` function to count the number of each species in the data set.

## **STEP 5:** Return Multiple Images from Embedded Python Execution
This step shows how to create a function `RandomRedDots` that creates a simple DataFrame and generates two plots of random red dots. You create a function named `RandomRedDots` in the Python Script Repository, and then run the native Python function.

**Note:** To know about **Python Script Repository**, go to step 6 in this lab.

1. Run the following script to import the python packages - Numpy, Pandas, and Matplotlib; define and create the function `RandomRedDots`:
    ```
    <copy>%python

    RandomRedDots = """def RandomRedDots (num_dots_1 = 100, num_dots_2 = 10):
      import numpy as np
      import pandas as pd
      import matplotlib.pyplot as plt

      d = {'id': range(1,10), 'val': [x/100 for x in range(1,10)]}
      df = pd.DataFrame(data=d)
      plt.scatter(range(0,num_dots_1), np.random.rand(100),c='r')
      plt.title("Random Red Dots")
      plt.show()
      plt.scatter(range(0,num_dots_2), np.random.rand(10),c='r')
      plt.title("Random Red Dots")
      plt.show()
      return df"""


    oml.script.create("RandomRedDots", func=RandomRedDots, is_global=True, overwrite=True)

    print(RandomRedDots)</copy>
    ```
    ![Image alt text](images/randomreddots_def.png "RandomRedDot Definition")

2. Use the `oml.do_eval` function to call the function `RandomRedDots` that you created in step 1:
    ```
    <copy>%python

    res = oml.do_eval(func="RandomRedDots")
    print("Type: ", type(res))

    res</copy>
    ```
    The function returns the following:
    ![Image alt text](images/randomreddots.png "RandomRedDots")

3. Create separate figure objects, add subplots, and then create the scatter plot. You will then store this in the script repository as `RandomRedDots2` and call the function to see the results.
    ```
    <copy>%python

    RandomRedDots2 = """def RandomRedDots2 (num_dots_1 = 100, num_dots_2 = 10):
      import numpy as np
      import pandas as pd
      import matplotlib.pyplot as plt

      d = {'id': range(1,10), 'val': [x/100 for x in range(1,10)]}
      df = pd.DataFrame(data=d)
      fig = plt.figure(1)
      ax = fig.add_subplot(111)
      ax.scatter(range(0,num_dots_1), np.random.rand(num_dots_1),c='r')
      fig.suptitle("Random Red Dots")

      fig2 = plt.figure(2)
      ax2 = fig2.add_subplot(111)
      ax2.scatter(range(0,num_dots_2), np.random.rand(num_dots_2),c='r')
      fig2.suptitle("Random Red Dots")
      return df"""

    oml.script.create("RandomRedDots2", func=RandomRedDots2, is_global=True, overwrite=True)

    print(RandomRedDots2)</copy>
    ```
As expected, you get both plots.
**Note:** When you call `RandomRedDots2` using embedded Python execution, you will get both plots as shown in the result.

    ![Image alt text](images/randomreddots.png "RandomRedDots")


5. Use the `oml.do_eval` function to call the function `RandomRedDots2`:
    ```
    <copy>%python

    res = oml.do_eval(func="RandomRedDots2", num_dots_1 = 600, num_dots_2 = 200)
    type(res)</copy>
    ```

    ![Image alt text](images/randomreddots2.png "Image title")

    ![Image alt text](images/randomreddots2a.png "Image title")

6.  Run the following script to return only the structured contents as an OML Dataframe, which keeps the result in the database - returning a proxy object to the result. You pull the results to the notebook explicitly to display it locally.
    ```
    <copy>%python

    import pandas as pd

    res = oml.do_eval(func=RandomRedDots, func_value=pd.DataFrame({"id":[0],"val":[0]}))
    type(res)</copy>
    ```
    ![Image alt text](images/randomreddots_l.png "Image title")
## **Try it yourself**
Create a single plot composed of two subplots

**Hint:** This approach is somewhat simpler, but yields only a single image. Generating two images may be desired when using the SQL API so that each image is returned as a separate row.  



## **Try it yourself**
Load a function stored in the Python Script Repository in the Python client engine, view its source, and then call the function.

**Hint:** You may use the function `RandomRedDots2`

## **STEP 6:** Use the Python Script Repository
Step 6 to 15, you will work with Python Script Repository.

OML4Py stores named user-defined functions called scripts in the script repository.

* `oml.script.create` - Creates a script, which contains a single Python function definition, in the script repository.
* `oml.script.dir` - Lists the scripts present in the script repository.
* `oml.script.drop` - Drops a script from the script repository.
* `oml.script.load` - Loads a script from the script repository into a Python session.
* `oml.grant` - Grants read privilege permission to another user to a datastore or script owned by the current user.
* `oml.revoke` - Revokes the read privilege permission that was granted to another user to a datastore or script owned by the current user.

To illustrate using the Python Script Repository, you will define a function `build_lm1` that will fit a regression model. Using this function, you will then create a script named `MyLM_function`.

1. First, run the script to load the iris data set and save it to a temporary table `IRIS_2`:
    ```
    <copy>%python

    iris = datasets.load_iris()
    x = pd.DataFrame(iris.data, columns = ['SEPAL_LENGTH','SEPAL_WIDTH',
    'PETAL_LENGTH','PETAL_WIDTH'])
    y = pd.DataFrame(list(map(lambda x: {0: 'setosa', 1: 'versicolor', 2:'virginica'}[x], iris.target)),
    columns = ['SPECIES'])

    IRIS2 = oml.push(pd.concat([x, y], axis=1))</copy>
    ```
2. Define the function `build_lm1`:
    ```
    <copy>%python

    def build_lm1(dat):
      from sklearn import linear_model
      regr = linear_model.LinearRegression()
      import pandas as pd
      dat = pd.get_dummies(dat, drop_first=True)
      X = dat[["SEPAL_WIDTH", "PETAL_LENGTH", "PETAL_WIDTH",
      "SPECIES_versicolor", "SPECIES_virginica"]]
      y = dat[["SEPAL_LENGTH"]]
      regr.fit(X, y)
      return regr</copy>
    ```

3. Define the function as a string:

   **Note:** To store a user-defined function in the script repository, it must be presented as a string.
    ```
    <copy>%python

    build_lm_str = """def build_lm_str(dat):
      from sklearn import linear_model
      regr = linear_model.LinearRegression()
      import pandas as pd
      dat = pd.get_dummies(dat, drop_first=True)
      X = dat[["SEPAL_WIDTH", "PETAL_LENGTH", "PETAL_WIDTH",
      "SPECIES_versicolor", "SPECIES_virginica"]]
      y = dat[["SEPAL_LENGTH"]]
      regr.fit(X, y)
      return regr"""</copy>
    ```

4. To view the string that you just created, run the following command:
    ```
    <copy>%python

    print(build_lm_str)</copy>
    ```
    ![Image alt text](images/print_function.png "Print build_lm_str function")


## **STEP 7:** Create Scripts in Repository
In this step, you will use the function `oml.script.create` to create a script `MyLM_function2`.

1. Run the `oml.script.drop` function first to check if a script by the name `MyLM_function2` exists, and drop it if it exists. Then use the `oml.script.create` function to create the script `MyLM_function2`:
    ```
    <copy>%python

    try:
      oml.script.drop("MyLM_function2")
    except:
      pass

    oml.script.create("MyLM_function2", func=build_lm_str, overwrite=True)</copy>
    ```

2. Run the `oml.script.dir` to list the scripts available only to the current user:
    ```
    <copy>%python

    oml.script.dir(sctype='user')</copy>
    ```
    The script returns the following information as shown in the screenshot:

    ![Image alt text](images/list_script.png "List scripts available to the current user")

3. Use the `oml.grant` function to grant read privilege to the `MyLM_function2` script to the user OMLUSER2.
    ```
    <copy>%python

    oml.grant(name="MyLM_function2", typ="pyqscript", user="OMLUSER2")</copy>
    ```
    **Note:** `typ` is a parameter that specifies either ‘datastore’ or ‘pyqscript’ to grant
the read privilege. ‘pyqscript’ requires Embedded Python.

4. Use the `oml.script.dir` function to list the scripts to which read privilege has been granted:
    ```
    <copy>%python

    oml.script.dir(sctype="grant")</copy>
    ```

    The script list the following informaiton, as shown in the screenshot:
    ![Image alt text](images/list_script_with_read_priv.png "List scripts with read privilege")
5. Run the `oml.script.load` to load the function `MyLM_function2` from the script repository into a Python session.
    ```
    <copy>%python

    import inspect

    MyLM_function2 = oml.script.load("MyLM_function2")
    MyLM_function2.get_source()

    print(str(MyLM_function2))
    print(MyLM_function2.get_source().read())</copy>
    ```
    ![Image alt text](images/load_function.png "Load function")


## **STEP 8:** Call function using Embedded Python execution


1. Use the `oml.script_create` function to save the callable function object as a script:
    ```
    <copy>%python

    loaded_str = MyLM_function2.get_source().read()
    type(loaded_str)</copy>
    ```

2. xxx
    ```
    <copy>%python

    oml.ds.save(objs={"loaded_str":loaded_str}, name="namedpystrfunc", overwrite=True)
    oml.ds.describe("namedpystrfunc")</copy>
    ```


## **STEP 9:** Store a function as a global  function
A global function is one that can be accessed by any user.

In this step, you will define and save a global function `build_lm3`. You will then call that function `build_lm3` to build another model.

1. Define and save the function `build_lm3`:
    ```
    <copy>%python

    build_lm3 = """def build_lm3(dat):
      from sklearn import linear_model
      regr = linear_model.LinearRegression()
      X = dat[["PETAL_WIDTH"]]
      y = dat[["PETAL_LENGTH"]]
      regr.fit(X, y)
      return regr"""</copy>
    ```

2. Call the function `build_lm3` to build the model or model `MyGlobalML_function`:
    ```
    <copy>%python

    oml.script.create("MyGlobalLM_function", func=build_lm3, is_global=True, overwrite=True)</copy>
    ```
3. Use the Embedded Python Execution function `table_apply` to run the user-defined function `MyGlobalML_function`:
    ```
    <copy>%python

    res = oml.table_apply(IRIS, func="MyGlobalLM_function",
    oml_input_type="pandas.DataFrame")
    res</copy>
    ```


## **STEP 10:** Load Functions from the Script Repository
In this step, you will load the `MyLM_function1` and `MyGlobalLM_function` scripts, and build the models to the local Python session. For MYLM, build the model on the IRIS data set and pull the coefficients. For GlobalMYLM, build and display the model.
1. Use the script oml.script.load to
    ```
    <copy>%python

    MYLM = oml.script.load(name="MyLM_function2")
    GlobalMYLM = oml.script.load(name="MyGlobalLM_function")

    iris_local = IRIS.pull()

    lm_model1 = MYLM(iris_local)
    lm_model2 = GlobalMYLM(iris_local)

    print("Model1 Type: ", lm_model1)
    print("Model1 Coefficients: ", lm_model1.coef_)</copy>
    ```
2. Use the function `oml.script.dir` to list all the available scripts:
    ```
    <copy>%python

    oml.script.dir(sctype="all")</copy>
    ```    

## **STEP 11:** Drop scripts from the Script Repository
In this step, you will perform the following:

* Drop one of the private scripts.
* Drop the global script.
* List the available scripts again.

**Note:** You can make the script either private or global. A global script is available to any user. A private script is available only to the owner or to users to whom the owner of the script has granted the read privilege.

1. Run the following script to drop the private script `MyLM_function2`, drop the global script `MyGlobalML_function`, and then list the available scripts:
    ```
    <copy>%python

    oml.script.drop("MyLM_function2")
    oml.script.drop("MyGlobalLM_function", is_global=True)
    oml.script.dir(sctype="all")</copy>
    ```



You may now [proceed to the next lab](#next).

## Learn More


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
