# Change Application
## Before You Begin

This lab walks you through the steps

## Background



## What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys

## **STEP 1**: Copy Background Image

1.  Copy a background image from your compute instance into the filesystem of the container.
   
    ````
    <copy>docker cp /home/opc/AlphaOfficeSetup/dark_blue.jpg alphaofficeui:/pipeline/source/public/Images</copy> 
    ````

## **STEP 2**: Install VIM editor

1.  If wvbirder's container does not have vim installed, you will configure it. First you need to login to the container.

    ````
    <copy>docker exec -it alphaofficeui bash</copy> 
    ````

    Run below command to confirm if vim exists.

    ````
    <copy>which vim</copy> 
    ````

    If the path of vim is displayed empty, install vim by running the below commands, else skip to step 3.

    ````
    <copy>apt-get update</copy>
    ````

    ````
    <copy>apt-get install vim</copy> 
    ````

## **STEP 3**: Change Application

1.  Verify the dark_blue.jpg file is in the container.
   
    ````
    <copy>ls /pipeline/source/public/Images</copy>
    ````

2.  Use vim to edit the html file for the main page in your application. Change the highlighted areas to your name.
   
    ````
    <copy>vim /pipeline/source/public/alpha.html</copy> 
    ````

3.  Let's edit the css file as well and change the background color of the app and exit.

    ````
    <copy>vim /pipeline/source/public/css/alpha.css</copy>
    ````
    
    ````
    <copy>exit</copy> 
    ````

## **STEP 4**: Commit Docker Image

1.  Let's commit this new docker image to your docker hub now.  Wvbirder thanks but we have our own Docker account.
   
    ````
    <copy>docker commit alphaofficeui (your-dockerhub-account)/(image-name)</copy>
    ````

2.  Now let's list the images. Note that your image is now listed.

    ````
    <copy>docker images</copy> 
    ````

## **STEP 5**: Start Container Based on Image

1.  To start a container based on your image.  First we need to stop the existing container.
   
    ````
    <copy>docker stop alphaofficeui</copy>
    ````

2.  Let's start the container.
    
    ````
    <copy>docker rm alphaofficeui</copy> 
    ````

## **STEP 6**: View Image

1.  Let's download, extract and install the new container from your docker account.
    
    ````
    <copy>docker run -d --name=alphaofficeui -p=8085:8085 (your-dockerhub-account)/(image-name)</copy> 
    ````

2.  Go back to your broswer to view the application.  http://Public IP address:8085

## **STEP 7**: Push Image to Docker Hub Account

1.  Now let's push this image to your docker hub account
    
    ````
    <copy>docker push (your-dockerhub-account)/(image-name)</copy> 
    ````

2.  Open up a new browswer tab and login to hub.docker.com.  Verify your new account is there.

Congratulations, this lab is now complete!

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Adapted for Cloud by** -  
* **Last Updated By/Date** - Anoosha, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).