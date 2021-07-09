# Loading data from object storage using Data Tools (& API)

## Introduction

This lab takes you through the steps needed to link to, and load, data from the MovieStream data lake on Oracle Object Store into an Oracle autonomous database instance in preparation for exploration and analysis.

You can load data into your autonomous database (Autonomous Data Warehouse [ADW] or Autonomous Transaction Processing [ATP]) using Oracle Database tools, as well as Oracle and 3rd party data integration tools. You can load data:

+ from files in your local device,
+ from tables in remote databases, or
+ from files stored in cloud-based object storage (Oracle, S3, Azure, Google)

> **Note:** While this lab uses ADW, the steps are identical for loading data into an ATP database.

Estimated Time: 30 minutes

### Objectives <optional>


-   Learn how to define Object Store credentials for your autonomous database
-   Learn how to load data from the Object Store
-   Learn how to troubleshoot data loads


## **Step 1**: Load Data from Object Store using the Database Actions Data Load Tool

1. In your ADW database's details page, click the Tools tab. Click **Open Database Actions**

	  ![Click on Tools, then Database Actions](images/launchdbactions.png)

2. On the login screen, enter the username MOVIEWORK, then click the blue **Next** button.

3. Enter the password for the MOVIEWORK user you set up in the previous lab.

4. Under **Data Tools**, click on **DATA LOAD**

    ![Click DATA LOAD](images/dataload.png)

5. In the **Explore and Connect** section, click on **CLOUD LOCATIONS** to set up the connection from your autonomous database to Object Store.

    ![Click CLOUD LOCATIONS](images/cloudlocations.png)

5. Example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

## **STEP 2:** <what is the action in this step>

1. Sub step 1 - tables sample

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
