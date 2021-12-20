## Use Oracle Database Sagas with PL/SQL Microservices

## Introduction

This lab will show you how to use Oracle Database Sagas with PL/SQL Microservices

Estimated Time:  5 minutes



### Objectives

-   Add PL/SQL saga participants
-   Test sagas 

### Prerequisites

* An Oracle Cloud paid account or free trial in a region with Oracle database 21c available. To sign up for a trial account with $300 in credits for 30 days, click [Sign Up](http://oracle.com/cloud/free).
* The OKE cluster and the Autonomous Transaction Processing databases that you created in Lab 1

### Objectives

-   Understand the concepts of Oracle Database Sagas with PL/SQL Microservices

### Prerequisites

- This lab presumes you have already completed the earlier labs.

## Task 1: Add Broker And Coordinator

1.    Add Participants with Complete/Commit and Compensate/Rollback Callbacks

   ![PL/SQL Add Participant](./images/addcoordinatoraddbroker.png " ")

## Task 1: Add Participants

1.    Add Participants with Complete/Commit and Compensate/Rollback Callbacks

   ![PL/SQL Add Participant](./images/addparticipantflight.png " ")


## Task 2: Test Enroll/Enlist and Complete/Commit

1.    Notice src and Complete/Commit path and make curl request .
   ![PL/SQL Add Participant](./images/beginandenrollplsql.png " ")
 


    ```
    <copy>select id, initiator, coordinator, owner, begin_time, status from saga$;
    </copy>
    ```


    ```
    <copy>
        begin
        dbms_saga.commit_saga('TravelAgency', saga_id);
        end;
        /
    </copy>
    ```




## Task 3: Test Enroll/Enlist and Compensate/Rollback

1.    Notice src and Compensate/Rollback path and make curl request .
   ![PL/SQL Add Participant](./images/beginandenrollplsql.png " ")

 

    ```
    <copy>select id, initiator, coordinator, owner, begin_time, status from saga$;
    </copy>
    ```


    ```
    <copy>
        begin
        dbms_saga.rollback_saga('TravelAgency', saga_id);
        end;
        /
    </copy>
    ```


You may now proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Architect and Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, December 2021
