# Lab 6 - Query and Analyze the Customer 360 graph

## Overview
In this lab you will load, query, and analyze a graph from the database tables containing customer, account, purchase, and relationship data. 

Estimated time: 7 minutes

## **Step 1:** Configure the graph server to load the graph

The following configuration files determine the graph server startup settings and optionally the graphs that are pre-loaded. 

The pgx-rdbms.conf file under `{$REPO_HOME}/docker/conf/` specifies which graph to pre-load.

The configuration of the graph itself, i.e. how and what to load, is in the JSON file rdbms.json under `{$REPO_HOME}/graphs/customer_360/`.

![](images/load_conf.jpg)

`pgx-rdbms.conf`

```
$ oracle-pg/docker/conf/pgx-rdbms.conf
"preload_graphs": [
  {"path": "/graphs/customer_360/rdbms.json", "name": "Customer360_db"},
```

`rdbms.json`

```
{
  "format":"pg",
  "db_engine":"rdbms",
  "jdbc_url":"jdbc:oracle:thin:@oracle-db:1521/orclpdb1",
  "username":"customer_360",
  "keystore_alias":"database1",
  "max_num_connections":8,
  "name":"customer_360",
  "vertex_props": [
    {"name":"type", "type":"string"},
    {"name":"name", "type":"string"},
    {"name":"age", "type":"integer"},
    {"name":"location", "type":"string"},
    {"name":"gender", "type":"string"},
    {"name":"student", "type":"string"},
    {"name":"account_no", "type":"string"},
    {"name":"balance", "type":"integer"}
  ],
  "edge_props": [
    {"name":"since", "type":"string"},
    {"name":"amount", "type":"integer"},
    {"name":"date", "type":"string"}
  ],
  "loading":{
    "load_edge_label":true
  }
}
```

Note that edge labels are also loaded.

## **Step 2:** Start the graph server and verify that the graph was loaded

Start the database and Graph Server
Run Docker containers for Graph Server, Graph Client, and Zeppelin.

    $ <copy>cd oracle-pg/docker/ </copy>
    $ <copy>docker-compose -f docker-compose-rdbms.yml -d up</copy>


To test the database graph loading configuration (i.e. rdbms.json) start JShell and execute the code below.

```
$ <copy>docker exec -it graph-client opg-rdbms-jshell -b http://graph-server:7007</copy>
var graph = session.readGraphWithProperties("/graphs/customer_360/rdbms.json")
```

## **Step 3:** Query and Analyze in Zeppelin

Open Zeppelin and execute all the paragraphs in "Customer 360" analytics example notebook.

[http://localhost:8080/](http://localhost:8080/)


Proceed to the next lab on graph visualization.

## Acknowledgements ##

- **Author** -  Jayant Sharma - Product Manager.
- **Contributors** - Ryota Yamanaka.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.


