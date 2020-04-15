# Docker Networking Basics
## Before you begin

Now that you know how to start, stop and relocate a container, this lab walks you through the steps on how to get information about the network.

### Background



### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys
* A Docker image built

## **STEP 1**: Inspect the Network Bridge

Inspecting the network bridge shows network information about all the containers running on the default bridge.

1.  Inspect the network bridge that docker created for you out of the box. We see that our restclient container is assigned IP Address 172.17.0.2. You can ping that address from your compute instance.

    ````
    <copy>docker network inspect bridge</copy>
    ````

    ![](images/network.png)

## **STEP 2**: Ping IP Address from Compute Instance

1.  Ping IP address for your restclient container from your compute instance.

    ````
    <copy>ping 172.17.0.2 -c3</copy>
    ````

2.  Stop your restclient container:

    ````
    <copy>docker stop restclient</copy>
    ````  

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Adapted for Cloud by** -  
* **Last Updated By/Date** - Anoosha, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
