# Deploy the Grabdish Application

## Introduction

This lab will show you how to deploy the Grabdish microservices on the ORDS server and in the database.

Estimated Time: 5 minutes

### Objectives

-   Deploy the microservices

### Prerequisites

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [Sign Up](http://oracle.com/cloud/free).
* The Autonomous Transaction Processing database and ORDS compute instance that you created in Lab 1

## Task 1: Deploy All the Microservices

1.  Run the deploy script:

    ```
    <copy>deploy</copy>
    ```

   ![](images/deploy-all.png " ")

2.  Once successfully complete, move on to task 2.

## Task 2: Access the FrontEnd UI

You are ready to access the frontend page. Open a new browser tab and enter the external IP URL:

`https://<EXTERNAL-IP>`

Note that for convenience a self-signed certificate is used to secure this https address and so it is likely you will be prompted by the browser to allow access.

You will be prompted to authenticate to access the Front End microservices. The user is `grabdish` and the password is the one you entered in Lab 1.

![Application Login UI](images/frontendauthlogin.png " ")

You should then see the Front End home page. You've now accessed your first microservice of the lab!

![Application Front End UI](images/ui-home-page.png " ")

We created a self-signed certificate to protect the frontend-helidon service. This certificate will not be recognized by your browser and so a warning is displayed. It will be necessary to instruct the browser to trust this site to display the frontend. In a production implementation a certificate that is officially signed by a certificate authority should be used.

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Contributors** - Paul Parkinson, Architect and Developer Evangelist;
* **Last Updated By/Date** - Richard Exley, April 2022
