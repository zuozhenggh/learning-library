# Use Case: Customer 360 analysis #

## Overview
This example shows how integrating multiple datasets, using a graph, facilitates additional analytics can lead to new insights. We will use three small datasets for illustrative purposes. The first contains accounts and account  owners. The second is purchases by the people who own those accounts. The third is transactions between these accounts.

The combined dataset is then used to perform the following common graph query and analyses: pattern matching, detection of cycles, finding important nodes, community detection, and recommendation.

**Note:** This lab assumes you have successfully completed the previous steps (Labs 3.1 through 3.7).


## Graph Query and Analysis in JShell

**Skip the following if you completed the Create Graph step and the graph server and client are up.**  
>Open an SSH connection to the compute instance. `su` to the `oracle` user or whichever user deployed the graph server and client kit and was added to the oraclegraph group in Lab 3.3.
>Start the graph server.
>
```
<copy>/opt/oracle/graph/pgx/bin/start-server</copy>
```
>
>Once it has started and you see the notification `INFO: Starting ProtocolHandler ["http-nio-7007"]` open a new SSH connection, if necessary, to the compute instance.  
>`su` to the `oracle` user or whichever user deployed the graph server and client kit and was added to the >oraclegraph group in Lab 3.  
>
>Start the JShell in the graph server. Copy and paste the following command to do that.
```
<copy>/opt/oracle/graph/bin/opg-jshell --base_url http://localhost:7007</copy>
```
>
>That starts up a shell which connects to the server instance running on the graph server.
>Once it starts up you should see the following:
>
```
For an introduction type: /help intro
Oracle Graph Server Shell 20.2.0
PGX server version: 20.0.2 type: SM
PGX server API version: 3.7.2
PGQL version: 1.3
Variables instance, session, and analyst ready to use.
opg-jshell>
```
**End of portion to skip when server and client are up.**

Check to see which graphs have been loaded into the graph server. 

```
<copy>session.getGraphs();</copy>
```

If the `Customer_360' graph exists in the in-memory graphbserver then load it into the client shell.
```
<copy>var graph = session.getGraph("Customer_360");</copy>
```

If it **does not exist** then read it from the database. 
The necessary steps are:
- Set up the JDBC connection. **Modify the URL for your instance**  
For <db_service> use  database service name from the tnsnames file in the ADB Wallet you downloaded when setting up your ADB instance.  
For <wallet_location> specify the directory where you unzipped the downlaoded wallet in the compute instance.
- Specifcy a graph config.
- Read the graph into memory.

```
<copy>
var jdbcUrl = "jdbc:oracle:thin:@<db_service>?TNS_ADMIN=<unzipped_wallet_location>";
var user = "customer_360";
var pass = "Welcome1_C360";
var conn = DriverManager.getConnection(jdbcUrl, user, pass) ;

// now load the graph into memory to run some more analyses
// specify the graph config (i.e. vertex and edge properties and datatypes)
Supplier<GraphConfig> pgxConfig = () -> { return GraphConfigBuilder.forPropertyGraphRdbms()
 .setJdbcUrl(jdbcUrl)
 .setUsername(user)
 .setPassword(pass)
 .setName("Customer_360")
 .addVertexProperty("type", PropertyType.STRING)
 .addVertexProperty("name", PropertyType.STRING)
 .addVertexProperty("location", PropertyType.STRING)
 .addVertexProperty("gender", PropertyType.STRING)
 .addVertexProperty("student", PropertyType.STRING)
 .addVertexProperty("account_no", PropertyType.STRING)
 .addVertexProperty("age", PropertyType.INTEGER)
 .addVertexProperty("balance", PropertyType.DOUBLE)
 .addEdgeProperty("since", PropertyType.STRING)
 .addEdgeProperty("date", PropertyType.STRING)
 .addEdgeProperty("amount", PropertyType.DOUBLE)
 .setLoadVertexLabels(false)
 .setLoadEdgeLabel(true)
 .setKeystoreAlias("alias")
 .build(); }

// load the graph. Can take 4-5 minutes depending on network bandwidth

var graph = session.readGraphWithProperties(pgxConfig.get()) ;
</copy>
```

Now we can query this graph and run some analyses on it.

### Pattern Matching

PGQL Query is convenient for detecting specific patterns.

Find accounts that had an inbound and an outbound transfer, of over 500, on the same day. The PGQL query for this is:

```
<copy>graph.queryPgql(
  " SELECT a.account_no, a.balance, t1.amount, t2.amount, t1.date " +
  " MATCH (a)<-[t1:transfer]-(a1) " +
  "    , (a)-[t2:transfer]->(a2) " +
  " WHERE t1.date = t2.date " +
  "  AND t1.amount > 500 " +
  "  AND t2.amount > 500 "
).print();
</copy>

+---------------------------------------------------------------+
| a.account_no | a.balance | t1.amount | t2.amount | t1.date    |
+---------------------------------------------------------------+
| xxx-yyy-202  | 200       | 900       | 850       | 2018-10-06 |
+---------------------------------------------------------------+
```

### Detection of Cycles

Next we use PGQL to find a series of transfers that start and end at the same account such as A to B to A, or A to B to C to A.

The first query could be expressed as:

```
<copy>graph.queryPgql(
"  SELECT a1.account_no, t1.date, t1.amount, a2.account_no, t2.date, t2.amount " +
"  MATCH (a1)-[t1:transfer]->(a2)-[t2:transfer]->(a1) " +
" WHERE t1.date < t2.date"
).print();
</copy>

+---------------------------------------------------------------------------------+
| a1.account_no | t1.date    | t1.amount | a2.account_no | t2.date    | t2.amount |
+---------------------------------------------------------------------------------+
| xxx-yyy-201   | 2018-10-05 | 200       | xxx-yyy-202   | 2018-10-10 | 300       |
+---------------------------------------------------------------------------------+
```

![](../../customer_360_analysis/images/detection.jpg)

The second query just adds one more transfer to the pattern (list) and could be expressed as:


```
<copy>graph.queryPgql(
"  SELECT a1.account_no, t1.amount, a2.account_no, t2.amount " +
"       , a3.account_no, t3.amount " + 
"  MATCH (a1)-[t1:transfer]->(a2)-[t2:transfer]->(a3)-[t3:transfer]->(a1) " +
"  WHERE t1.date < t2.date " +
"    AND t2.date < t3.date "
).print();
</copy>

+-----------------------------------------------------------------------------------+
| a1.account_no | t1.amount | a2.account_no | t2.amount | a3.account_no | t3.amount |
+-----------------------------------------------------------------------------------+
| xxx-yyy-201   | 500       | xxx-yyy-203   | 400       | xxx-yyy-204   | 300       |
+-----------------------------------------------------------------------------------+
```

![](../../customer_360_analysis/images/detection2.jpg)


### Influential Accounts

Filter customers from the graph. (cf. [Filter Expressions](https://docs.oracle.com/cd/E56133_01/latest/prog-guides/filter.html))

```
<copy>var sg = graph.filter(new EdgeFilter("edge.label()='transfer'")); </copy>
```  
Run [pagerank](https://docs.oracle.com/cd/E56133_01/latest/reference/analytics/algorithms/pagerank.html) algorithm.

```
<copy>analyst.pagerank(sg); </copy>
```

Show the result.

```
<copy>sg.queryPgql(
" SELECT a.account_no, a.pagerank " +
" MATCH (a) " + 
" ORDER BY a.pagerank DESC "
).print();
</copy>

+-------------------------------------+
| a.account_no | a.pagerank           |
+-------------------------------------+
| xxx-yyy-201  | 0.18012007557258927  |
| xxx-yyy-204  | 0.1412461615467829   |
| xxx-yyy-203  | 0.1365633635065475   |
| xxx-yyy-202  | 0.12293884324085073  |
| xxx-zzz-212  | 0.05987452026569676  |
| xxx-zzz-211  | 0.025000000000000005 |
+-------------------------------------+
```

### Community Detection

Let's find which subsets of accounts form communities. That is, there are more transfers among accounts in the same subset than there are between those and accounts in another subset. We'll use the built-in weekly / strongly connected components algorithm.

The first step is to create a subgraph that only has the accounts and the transfers among them. This is done by creating and applying an edge filter (for edges with the table "transfer') to the graph.

Filter customers from the graph.
```
<copy>var sg = graph.filter(new EdgeFilter("edge.label()='transfer'")); </copy>
```  

[Weakly connected component](https://docs.oracle.com/cd/E56133_01/latest/reference/analytics/algorithms/wcc.html) algorithm detects only one partition.

```
<copy>
var result = analyst.wcc(sg);
// The partition value is stored in a property named wcc
sg.queryPgql(
" SELECT a.wcc, COUNT(a) MATCH (a) GROUP BY a.wcc"
).print();
</copy>
```

Run a strongly connected components algorithm, SCC Kosaraju, instead.

[Strongly connected component](https://docs.oracle.com/cd/E56133_01/latest/reference//analytics/algorithms/scc.html) algorithm detects three partitions.

```
<copy>
result = analyst.sccKosaraju(sg);
// List partitions and number of vertices in each
sg.queryPgql(
" SELECT a.scc_kosaraju, COUNT(a) MATCH (a) GROUP BY a.scc_kosaraju"
).print();
</copy>

+---------------------------+  
| a.scc_kosaraju | COUNT(a) |  
+---------------------------+  
| 1              | 4        |  
| 2              | 1        |  
| 0              | 1        |  
+---------------------------+  
```

List the other accounts in the same conneted component (partition) as John's account.

The partition (or component) id is added as a property named scc_kosaraju for use in PGQL queries.

```
<copy>
sg.queryPgql(
" SELECT a.scc_kosaraju as component, COUNT(a.account_no), MAX(a.account_no) " +
" MATCH (a) " +
" GROUP BY component " +
" ORDER BY component"
).print();
</copy>

+-------------------------------------------------------+  
| component   | COUNT(a.account_no) | MAX(a.account_no) |  
+-------------------------------------------------------+  
| 0           | 1                   | xxx-zzz-001       |  
| 1           | 4                   | xxx-yyy-204       |  
| 2           | 1                   | xxx-zzz-002       |  
+-------------------------------------------------------+  
```

![](../../customer_360_analysis/images/community.jpg)


### Recommendation

Lastly let's use Personalized PageRank to find stores that John may purchase from given that people he is connected to have made purchases from those stores.

Filter customers and merchants from the graph.
```
<copy>var sg = graph.filter(new EdgeFilter("edge.label()='purchased'"));</copy>
```

Add reverse edges.

```
<copy>
var cs = sg.<Long>createChangeSet();
var rs = sg.queryPgql("SELECT id(a), id(x) MATCH (a)-[]->(x)");
for (var r : rs) {
   var e = cs.addEdge(r.getLong(2),r.getLong(1)).setLabel("purchased_by");
}
sg = cs.build();
sg.queryPgql(
" SELECT ID(r), x.name, LABEL(r), a.account_no" +
"  MATCH (x)-[r:purchased_by]->(a)" +
" LIMIT 3"
).print();
</copy>

+---------------------------------------------------+
| ID(r) | x.name      | LABEL(r)     | a.account_no |
+---------------------------------------------------+
| 11    | Apple Store | purchased_by | xxx-yyy-201  |
| 16    | Apple Store | purchased_by | xxx-yyy-202  |
| 19    | Apple Store | purchased_by | xxx-yyy-203  |
+---------------------------------------------------+
```

![](../../customer_360_analysis/images/recommendation1.jpg)


![](../../customer_360_analysis/images/recommendation2.jpg)

We will focus on the account no. xxx-yyy-201 (John's account) and run PPR.

```
<copy>
sg.queryPgql("select id(a) match (a) where a.account_no='xxx-yyy-201'").print();
</copy>

+---------------------+
| id(a)               |
+---------------------+
| 3244710687574720295 |
+---------------------+
```

```
<copy>
var vertexSet = sg.<Long>createVertexSet();
vertexSet.addAll(3244710687574720295L);
var ppr = analyst.personalizedPagerank(sg, vertexSet);
</copy>
```

Show the result. (cf. [EXISTS and NOT EXISTS subqueries](https://pgql-lang.org/spec/1.3/#exists-and-not-exists-subqueriess))

```
<copy>
sg.queryPgql(
"  SELECT ID(x), x.name, x.pagerank " +
"  MATCH (x) " +
"  WHERE x.type = 'merchant' " +
"    AND NOT EXISTS ( " +
"     SELECT * " +
"     MATCH (x)-[:purchased_by]->(a) " +
"     WHERE ID(a) = 3244710687574720295 " +
"    ) " +
"  ORDER BY x.pagerank DESC"
).print();
</copy>

+----------------------------------------------------------+
| ID(x)               | x.name       | x.pagerank          |
+----------------------------------------------------------+
| 6541727421521309923 | Asia Books   | 0.04932640133302745 |
| 8574591124594145469 | Kindle Store | 0.04932640133302745 |
| 8664546881222905044 | ABC Travel   | 0.01565535511504672 |
+----------------------------------------------------------+
```

## Publish the Graph for use with the visualization component

Run the following to publish the graph while still in the JShell.
```
<copy>
// publish the customer_360 graph so that other sessions , e.g. the GraphViz webapp can use it
graph.publish(VertexProperty.ALL, EdgeProperty.ALL) ;
</copy>
```


## Acknowledgements ##

- **Author** -  Jayant Sharma - Product Manager, Spatial and Graph  
With a little help from colleagues (Albert Godfrind and Ryota Yamanaka).