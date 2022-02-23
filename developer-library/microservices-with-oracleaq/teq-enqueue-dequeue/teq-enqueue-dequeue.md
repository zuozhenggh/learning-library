# TEQ Enqueue and Dequeue

## Introduction

Transactional Event Queues(TEQ) samples to create queues using different payloads, Enqueue, dequeue, and cleanups using PL/SQL.

- Estimated Time: 10 minutes

### Objectives

- Create Transactional Event Queue
- Enqueue Transactional Event Queue
- Dequeue Transactional Event Queue

### Prerequisites

- This workshop assumes you have an Oracle cloud account and configured setup in Lab 1.

## Task 1: Create TEQ

![teqCreate](./images/create-teq.png " ")

- Multi-consumer TEQ with Payload as RAW using PL/SQL.

- Multi-Consumer TEQ with Payload as Object Type using PL/SQL.

- Multi-Consumer TEQ with Payload as JSON Type using PL/SQL.

```bash
<copy>cd $ORACLEAQ_HOME; source createTEQ.sh;
</copy>
```

## Task 2: Basic Enqueue in TEQ

![enqueueTEQ](./images/enqueue-teq.png " ")

- Enqueue for multi-consumer TEQ with Payload as RAW using PL/SQL.

- Enqueue for multi-Consumer TEQ with Payload as Object Type using PL/SQL.

```bash
<copy>cd $ORACLEAQ_HOME; source enqueueTEQ.sh;
</copy>
```

## Task 3: Basic Dequeue in TEQ

![dequeueTEQ](./images/dequeue-teq.png " ")

- Enqueue for multi-consumer TEQ with Payload as RAW using PL/SQL.

- Enqueue for multi-Consumer TEQ with Payload as Object Type using PL/SQL.

```bash
<copy>cd $ORACLEAQ_HOME; source dequeueTEQ.sh;
</copy>
```

## Task 4: TEQ Enqueue and Dequeue using Java

```bash
<copy> curl http://localhost:8081/oracleAQ/pubSubTEQ </copy>
```

[VISIT THE GITHUB CODE HERE](https://github.com/oracle/microservices-datadriven/tree/main/workshops/oracleAQ/aqJava/src/main/java/com/examples/workflowTEQ/EnqueueDequeueTEQ.java)

## Task 5: Cleanups

![cleanupTEQ](./images/cleanup-teq.png " ")

- Stop classic Queues
- Drop classic Queues

```bash
<copy>cd $ORACLEAQ_HOME; source cleanupTEQ.sh;
</copy>
```

Proceed to the next [lab](#next).

## Acknowledgements

- **Author** - Mayank Tayal, Developer Advocate
- **Last Updated By/Date** - Mayank Tayal, February 2021
