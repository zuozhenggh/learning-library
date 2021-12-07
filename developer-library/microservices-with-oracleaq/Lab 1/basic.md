**Classic Queues**

Oracle Advanced queue with classic queue examples to demonstrate classic queue creation using different payloads, Enqueue , dequeue and cleanups.

**Task 1: Create classic queues**

- Single consumer classic queue with Payload as RAW and  ADT using PL/SQL and Java.

- Multi-Consumer classic queue with Payload as RAW and  ADT using PL/SQL and Java.
    
        

        cd $OracleAQ_HOME; source basicCreateQueue.sh;

  
    

**Task 2: Basic Enqueue**

- Enqueue for Single consumer classic queue with Payload as RAW using PL/SQL and Java.

- Enqueue for multi-consumer classic queue with Payload as RAW using PL/SQL and Java.
    
        

        cd $OracleAQ_HOME; source basicEnqueue.sh;

       

**Task 3: Basic Dequeue**

- Dequeue for Single consumer classic queue with Payload as RAW using PL/SQL and Java.

- Dequeue for multi-consumer classic queue with Payload as RAW using PL/SQL and Java.
    
        

        cd $OracleAQ_HOME; source basicDequeue.sh;

       

**Task 4: Clean ups**

- Stop classic Queues
   
- Drop classic Queues 
   
- Drop Queue Tables

       

        cd $OracleAQ_HOME; source basicCleanups.sh;

        
    
    
    
**Acknowledgements**

**Author -** Mayank Tayal, Developer Advocate 

**Adapted for Cloud by -** 

**Documentation -** 

**Contributors -** 

**Last Updated By/Date -** Mayank Tayal, December 2021
