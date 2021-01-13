# Graph Studio: Query and visualize a graph using PGQL paragraphs in a notebook

## Introduction

In this lab you will query the newly create graph (i.e. `bank_graph`) in PGQL paragraphs of a notebook.

The following video shows the steps you will execute in this lab.

TBD "video link" Graph Studio: Query a graph.

Estimated Lab Time: 15 minutes. 

### Objectives

Learn how to
- use Graph Studio notebooks and PGQL paragraphs to query and visualize a graph.

### Prerequisites

- Labs 1 and 2 of this workshop. That is, you are logged into Graph Studio and the `BANK_GRAPH` has been created and loaded into memory. 

## **STEP 1**: Create a notebook  

1. First check that the `BANK_GRAPH` has been loaded into memory. Click the `Graphs` menu icon and verify that `BANK_GRAPH` is loaded into memory. If it isn't then click on the action menu on that row and select `Load into memory`. 

2. Next click on the `Notebooks` menu icon and then on `Create`, on the top right side of that page, to create a new notebook.  
Name it `Learn/Bank_Graph_PGQL_Queries`.  

![](./images/24-create-notebook.png " ")  

The notebook will open to a blank paragraph.  

![](images/25-blank-notebook.png)

Graph Studio notebooks currently support three type of paragraphs:  
- %md for Markdown 
- %pgql-pgx for Property Graph Query Language ([PGQL](https://pgql-lang.org)) 
- %java-pgx for executing built-in graph algorithms with the Property Graph Java API  
  
3. Let's enter a Markdown paragraph which outlines the notebook content. Copy and paste the following text into the first blank paragraph.   
```
<copy>
%md
### Sample notebook with `%pgql-pgx` paragraphs to:
- Query and visualize 100 elements of the `BANK_GRAPH`
- List the top 10 accounts with the most number of deposits (incoming transfers) 
- 
</copy>

```
4. 

## **Step 2**: Query the `BANK_GRAPH` and visualize the results 


Congratulations on successfuly completing this workshop.

## Acknowledgements
* **Author** - Jayant Sharma, Product Management
* **Contributors** -  Jayant Sharma, Product Management
* **Last Updated By/Date** - Jayant Sharma, Jan 2021
  
## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-graph). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
