## Use Oracle Database Sagas with Java Microservices

## Introduction

This lab will show you how to use Oracle Database Sagas with Java Microservices.

The following shows a side by side comparison of the work required by the developer when not using Oracle Database Saga support contrasted with taking advantage of the support.

   ![Java Add Participant](./images/javacodecomparison.png " ")

Estimated Time:  10 minutes

### Objectives

-   Add Java saga participants
-   Test sagas 

### Prerequisites

* An Oracle Cloud paid account or free trial in a region with Oracle database 21c available. To sign up for a trial account with $300 in credits for 30 days, click [Sign Up](http://oracle.com/cloud/free).
* The OKE cluster and the Autonomous Transaction Processing databases that you created in Lab 1

### Objectives

-   Understand the concepts of Oracle Database Sagas with Java Microservices

### Prerequisites

- This lab presumes you have already completed the setup lab.

## Task 1: Add and start Java Participants (FlightJava, HotelJava, and CarJava)
       
1. Notice the AQjmsSagaMessageListener interface and implementation for/of the TravelParticipantApplication.java

   ![Java Add Participant](./images/AQJmsSagaMessageListener.png " ")
   
   ![Java Add Participant](./images/AQJmsSagaMessageListener-methods.png " ")
   
   ![Java Add Participant](./images/javasagamessagelistnerimpl.png " ")
   
2.    Enter the Cloud Shell, and issue the following command to build the travel participant Java service.

        ```
        <copy>cd ~/microservices-datadriven/travelbooking/travelparticipant-java; mvn clean install</copy>
        ```

3.    Issue the following command to run the travel participant Java service.

        ```
        <copy>cd ~/microservices-datadriven/travelbooking/travelparticipant-java; java -jar target/travelparticipant.jar</copy>
        ```

      This will build and start a travel participant java service.

4.    You will be prompted for the following.
        - database password (the one you used when creating the participant/`sagadb2` PDB)
        - TNS_ADMIN (accept the default)
        - participant type (FlightJava, HotelJava, or CarJava).

5.    You will then be asked whether the one-time setup call `add_participant` is needed for the participant type you selected. 
If this is the first time you have started this participant type then select 'y', otherwise simply hit enter to use the default ('n')

6.    The output should look like the following.

7.   The participant is now running and listening for messages for the saga.

8.   Repeat steps 3 and 4 for any of the other participant types (FlightJava, HotelJava, or CarJava) you didn't select. 

     You can have as few or as many participants as you like in the saga. 
     For example, you can just have a HotelJava participant for simplicity.
    
     If you do have more than one participant, it is convenient to open a new browser tab and Cloud Shell for each.


## Task 2: Add and start Java TravelAgency Initiatory/Participant

1.    Notice use of the OSaga API and the AQjmsSagaMessageListener interface and implementation for/of the TravelAgencyApplication.java

2.    Enter the Cloud Shell, and issue the following command to build the travel agency Java service.

        ```
        <copy>cd ~/microservices-datadriven/travelbooking/travelagency-java; mvn clean install</copy>
        ```

3.    Issue the following command to run the travel agency Java service.

        ```
        <copy>cd ~/microservices-datadriven/travelbooking/travelagency-java; java -jar target/travelagency.jar</copy>
        ```

4.    You will be prompted for the following.
        - database password (the one you used when creating the participant/`sagadb2` PDB)
        - TNS_ADMIN (accept the default)

5.    You will then be asked whether the one-time setup call `add_participant` is needed for `TravelAgencyJava`. 
If this is the first time you have started the `TravelAgencyJava` then select 'y', otherwise simply hit enter to use the default ('n')


You may now proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Architect and Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, December 2021
