# Workshop Introduction and Overview #

Estimated time for entire workshop: 90 minutes

## Introduction to Oracle Auto Partitioning ##

Automatic partitioning in Autonomous Database analyzes the application workload and automatically applies partitioning to tables and their indexes to improve performance or to allow better management of large tables.

Finding appropriate partitioning strategies requires deep knowledge of the application workload and the data distribution. When you perform manual partitioning, you must analyze your workload and make choices about how to apply partitioning to tables and indexes to improve the performance of applications. Automatic partitioning enables Autonomous Database users to benefit from partitioning without performing manual schema and workload analysis.

Automatic partitioning uses a single-column partition key combined with single-level partitioning. Automatic partitioning does not support more complex partitioning strategies such as multi-column partitioned tables or composite partitioning.

Automatic partitioning chooses from the following partition methods:

- AUTOMATIC INTERVAL: This choice is best suited for ranges of partition key values.
- LIST AUTOMATIC: This partitioning method applies to distinct partition key values.
- HASH: Applies partitioning on the partition key's hash values.

## How it Works

When invoked, automatic partitioning performs the following operations in Autonomous Database.

<h3>1/ Identify candidate tables for automatic partitioning by analyzing the workload for selected candidate tables.</h3>

- By default, automatic partitioning uses the workload information collected in an Autonomous Database for analysis. 
- Depending on the size of the workload, a sample of queries might be considered.

<h3>2/ Evaluate partition schemes based on workload analysis and quantification and verification of the performance benefits:</h3>

- Candidate empty partition schemes with synthesized statistics are created internally and analyzed for performance.
- The candidate scheme with the highest estimated IO reduction is chosen as the optimal partitioning strategy and is internally implemented to test and verify performance.
- If a candidate partition scheme does not improve performance beyond specified performance and regression criteria, automatic partitioning is not recommended.
<h3>3/ Implement the optimal partitioning strategy, if configured to do so, for the tables analyzed by the automatic partitioning procedures.</h3>

## Workshop Summary

The workshop is designed to be used in a 19c Always Free Autonomous Database (ADB) instance where a table needs to be larger than 5 GBytes to be considered for auto partitioning. In non-free ADB services, tables must be at least 64GB.

The steps are:

- Create a 5GB non-partitioned table called APART, filled with random data
- Run a test workload on the APART table
- Run the auto partitioning _validate_ API to confirm that the table meets auto partitioning requirements
- Execute the auto partitioning _recommend_ task in report-only mode. The task will build a partitioned copy of the table and compare performance before vs. after partitioning.
- Use the _apply_ API to implement the auto partition recommendation. The APART table will be transformed into an ONLINE ALTER TABLE operation so that the production workload is not interrupted. 
