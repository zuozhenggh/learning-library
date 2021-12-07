**Classic Queues**

Oracle Advanced queue with classic queue examples to demonstrate classic queue creation using different payloads, Enqueue , dequeue and cleanups.

**Task 1: Create classic queues**

- Single consumer classic queue with Payload as RAW and  ADT using PL/SQL and Java.

- Multi-Consumer classic queue with Payload as RAW and  ADT using PL/SQL and Java.
    
        <copy>

        cd $OracleAQ_HOME; source basicCreateQueue.sh;

        </copy>
    

**Task 2: Basic Enqueue**

- Enqueue for Single consumer classic queue with Payload as RAW using PL/SQL and Java.

- Enqueue for multi-consumer classic queue with Payload as RAW using PL/SQL and Java.
    
        <copy>

        cd $OracleAQ_HOME; source basicEnqueue.sh;

        </copy>

**Task 3: Basic Dequeue**

- Dequeue for Single consumer classic queue with Payload as RAW using PL/SQL and Java.

- Dequeue for multi-consumer classic queue with Payload as RAW using PL/SQL and Java.
    
         <copy>

        cd $OracleAQ_HOME; source basicDequeue.sh;

        </copy>

**Task 4: Clean ups**

- Stop classic Queues
   
- Drop classic Queues 
   
- Drop Queue Tables

        <copy>

        cd $OracleAQ_HOME; source basicCleanups.sh;

        </copy>
    
    
    
**Acknowledgements**

**Author -** Mayank Tayal, Developer Advocate 

**Adapted for Cloud by -** 

**Documentation -** 

**Contributors -** 

**Last Updated By/Date -** Mayank Tayal, December 2021
