# Deploy Application
## Before you begin

This lab walks you through the steps to

### Backround



### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys

## **STEP 1**: Run the Docker Image in Container

1.  Download the docker image, twitterfeed, extract it and run the container.  The download is from the wvbirder docker hub account where this application is staged.

    ````
    <copy>docker run -d --name=twitterfeed -p=9080:9080 wvbirder/twitterfeed</copy> 
    ````

2.  Check to see which containers are running.  
    
    ````
    <copy>docker ps</copy>
    ````

3.  Open up a broswer to see the application with the stream of texts.  http://Public IP address:9080/statictweets

## **STEP 2**: Run Restclient with Oracle Database as Datasource

1.  Let's run the restclient with the Oracle Database as the datasource.
   
    ````
    <copy>docker run -d -it --rm --name restclient -p=8002:8002 --link orcl:oracledb-ao -e ORACLE_CONNECT='oracledb-ao/orclpdb1.localdomain' -e DS='oracle' wvbirder/restclient</copy> 
    ````

2.  Go back to your broswer to see the application with the stream of texts.  http://Public IP address:8002/products

## **STEP 3**: Run AlphaOfficeUI Application

1.  An application called AlphaOfficeUI has been staged in wvbirders docker hub account.  Let's download it, extract and run it.
   
    ````
    <copy>docker run -d --name=alphaofficeui -p=8085:8085 wvbirder/alpha-office-ui-js</copy> 
    ````

2.  Go back to your broswer to see the application running on port 8085.  http://Public IP address:8085.  Click on one of the products to see the details and the twitterfeed comments. 

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Adapted for Cloud by** -  
* **Last Updated By/Date** - Anoosha, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
