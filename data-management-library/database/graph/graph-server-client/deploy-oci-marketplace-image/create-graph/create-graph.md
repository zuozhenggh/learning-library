# Create the Graph

## Introduction

Now, the tables are created and populated with data. Let's create a graph representation of them.

Estimated time: 5 minutes

### Objectives

Learn how to create a graph from relational data sources by:
- Restarting the graph server
- Starting a client (Python shell) that connects to the server
- Using PGQL Data Definition Language (DDL) (e.g. CREATE PROPERTY GRAPH) to instantiate a graph

### Prerequisites

- This lab assumes you have successfully completed the lab - Create and populate tables.

## **STEP 1:** Start the Python client

Start a client shell instance that connects to the server

```
<copy>
opgpy -b https://localhost:7007 --username customer_360
</copy>
```

You should see the following if the client shell starts up successfully.

```
enter password for user customer_360 (press Enter for no password):
Oracle Graph Client Shell 21.1.0
>>>
```

## **STEP 2:** Create the graph

Set up the create property graph statement, which creates the graph from the existing tables.

```    
<copy>
statement = '''
CREATE PROPERTY GRAPH "customer_360"
  VERTEX TABLES (
    customer
  , account
  , merchant
  )
  EDGE TABLES (
    account
      SOURCE KEY(id) REFERENCES account
      DESTINATION KEY(customer_id) REFERENCES customer
      LABEL owned_by
  , parent_of
      SOURCE KEY(customer_id_parent) REFERENCES customer
      DESTINATION KEY(customer_id_child) REFERENCES customer
  , purchased
      SOURCE KEY(account_id) REFERENCES account
      DESTINATION KEY(merchant_id) REFERENCES merchant
  , transfer
      SOURCE KEY(account_id_from) REFERENCES account
      DESTINATION KEY(account_id_to) REFERENCES account
  )
'''
</copy>
```

Now execute the PGQL DDL to create the graph.

```
// drop when this graph exists first
<copy>
graph.destroy()
</copy>
```

```
// Now create the graph 
<copy>
session.prepare_pgql(statement).execute()
</copy>
```

The expected result is:
```
False
```

## **STEP 3:** Check the newly created graph

Check that the graph was created. Copy, paste, and run the following statements in the Python shell.

Attach the graph to check that the graph was created.
```
<copy>
graph = session.get_graph("customer_360")
graph
</copy>
```

```
PgxGraph(name: customer_360, v: 15, e: 24, directed: True, memory(Mb): 0)
```

Run some PGQL queries.

The list of the vertex labels:
```
<copy>
graph.query_pgql("""
  SELECT DISTINCT LABEL(v) FROM MATCH (v)
""").print()
</copy>
```

How many vertices with each label:
```
<copy>
graph.query_pgql("""
  SELECT COUNT(v), LABEL(v) FROM MATCH (v) GROUP BY LABEL(v)
""").print()
</copy>
```

The list of the edge labels:
```
<copy>
graph.query_pgql("""
  SELECT DISTINCT LABEL(e) FROM MATCH ()-[e]->()
""").print()
</copy>
```

How many edges with each label:
```
<copy>
graph.query_pgql("""
  SELECT COUNT(e), LABEL(e) FROM MATCH ()-[e]->() GROUP BY LABEL(e)
""").print()
</copy>
```

![](images/check_graph.png)

You may now proceed to the next lab.

## Acknowledgements

- **Author** - Jayant Sharma, Product Manager, Spatial and Graph
- **Contributors** - Thanks to Jenny Tsai for helpful, constructive feedback that improved this workshop. Arabella Yao, Product Manager Intern, Database Management
- **Last Updated By/Date** - Ryota Yamanaka, Feburary 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-graph). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
