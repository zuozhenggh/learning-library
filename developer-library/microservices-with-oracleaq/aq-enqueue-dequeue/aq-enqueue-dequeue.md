# Advanced Queues

## Introduction

This lab will give an understanding of Advanced Queues creation using different payloads, enqueue AQ, dequque AQ, and cleanups.

- Estimated Time: 10 minutes

### Objectives

- Create Advanced Queues
- Enqueue for Advanced Queues
- Dequeue for Advanced Queues

### Prerequisites

- This workshop assumes you have an Oracle cloud account and configured setup in Lab 1.

## Task 1: Create Advanced Queues(AQ)

![createAQ](./images/create-aq.png " ")

- Single consumer classic queue with Payload as ADT, RAW and JSON using PL/SQL.

- Multi-Consumer classic queue with Payload as RAW using PL/SQL.  

```bash
<copy>cd $ORACLEAQ_HOME; source createAQ.sh;
</copy>
```

## Task 2: AQ Enqueue

![enqueueAQ](./images/enqueue-aq.png " ")

- Enqueue for Single consumer classic queue with Payload as ADT and RAW using PL/SQL.

- Enqueue for multi-consumer classic queue with Payload as RAW using PL/SQL.

```bash
<copy>cd $ORACLEAQ_HOME; source enqueueAQ.sh;
</copy>
```

## Task 3: Basic Dequeue

![dequeueAQ](./images/dequeue-aq.png " ")

- Dequeue for Single consumer classic queue with Payload as ADT and RAW using PL/SQL.

- Dequeue for multi-consumer classic queue with Payload as RAW using PL/SQL.

```bash
<copy>cd $ORACLEAQ_HOME; source dequeueAQ.sh;
</copy>
```

## Task 4: AQ creation, Enqueue and Dequeue using Java

1. Point to Point

    ```bash
    <copy> curl http://localhost:8081/oracleAQ/pointToPointAQ 
    </copy>
    ```

2. Publisher Subscriber

    ```bash
    <copy> curl http://localhost:8081/oracleAQ/pubSubAQ 
    </copy>
    ```

[VISIT THE GITHUB CODE HERE](https://github.com/oracle/microservices-datadriven/tree/main/workshops/oracleAQ/aqJava/src/main/java/com/examples/workflowTEQ/EnqueueDequeueAQ.java)

## Task 5: Cleanups

  ![cleanupAQ](./images/cleanup-aq.png " ")

- Stop classic Queues

- Drop classic Queues

- Drop Queue Tables

```bash
<copy>cd $ORACLEAQ_HOME; source cleanupAQ.sh;
</copy>
```

Proceed to the next [lab](#next).

## Acknowledgements

- **Author** - Mayank Tayal, Developer Advocate

- **Last Updated By/Date** - Mayank Tayal, February 2021
