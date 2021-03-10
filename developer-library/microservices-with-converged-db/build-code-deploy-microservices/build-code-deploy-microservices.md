# Build Code from GitHub and Deploy Microservices

## Introduction

This lab will show you how to build images, push them to Oracle Cloud
Infrastructure Registry and deploy the microservices on our Kubernetes cluster.
You will also clone a GitHub repository.

### Objectives

  -   Clone a GitHub repository
  -   Build and push an image to OCI Registry
  -   Deploy and access the front-end microservice

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* The OKE cluster and the ATP databases that you created in Lab 1


## **STEP 1**: Set values for workshop in the environment

1. Run `./addAndSourcePropertiesInBashrc.sh`

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION; ./addAndSourcePropertiesInBashrc.sh</copy>
    ```

2. Source the `.bashrc` file with the following command.

    ```
    <copy>source ~/.bashrc</copy>
    ```

## **STEP 2**: Configure the address of the Jaeger service

1. Run `./setJaegerAddress.sh` and verify successful outcome.

 It may be necessary to run this script multiple times if the Jaeger load balancer has not been provisioned yet.

   ```
   <copy>cd $MSDATAWORKSHOP_LOCATION; ./setJaegerAddress.sh</copy>
   ```

2. Source the `.bashrc` file with the following command.

   ```
      <copy>source ~/.bashrc</copy>
   ```

  ![](images/185c88da326994bb858a01f37d7fb3e0.png " ")


## **STEP 3**: Build and push the Docker images

1. Run the `build.sh` script to build and push the
    microservices images into the repository

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION ; ./build.sh</copy>
    ```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

  In a couple of minutes, you should have successfully built and pushed all the images into the OCIR repository.

  ![](images/bdd2f05cfc0d1aac84b09dbe5b48993a.png " ")

2.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

3. Mark all the images as public (**Actions** > **Change to Public**):

  ![](images/71310f61e92f7c1167f2016bb17d67b0.png " ")

## **STEP 4**: Start the frontend-helidon service

5.  Run the deploy script from the same directory
    as build. This will create a new pod and service for this image in the OKE
    cluster `msdataworkshop` namespace:

    ```
    <copy>d $MSDATAWORKSHOP_LOCATION/frontend-helidon;./deploy.sh</copy>
    ```

   ![](images/5b817258e6f0f7b55d4ab3f6327a1779.png " ")

7.  Once successfully created, check that the frontend pod is running:

    ```
    <copy>kubectl get pods --all-namespaces</copy>
    ```

  ![](images/bf1ec14ebd4cb789fca7f77bb2d4b2d3.png " ")

  Alternatively, you can execute the `pods` shortcut command:

  ![](images/d575874fe6102633c10202c74bf898bc.png " ")

8. Check that the load balancer service is running, and write down the external IP
    address and port.

    ```
    <copy>kubectl get services --all-namespaces</copy>
    ```

  ![](images/ce67dfe171836b79a14533f479039ff5.png " ")

  Alternatively, you can execute the `services` shortcut command.

  ![](images/72c888319c294bed63ad9db029b68c5e.png " ")

9. You are ready to access the frontend page. Open a new browser tab and enter the external IP and port URL:

  `https://<EXTERNAL-IP>:443`

  We created a self-signed certificate to protect the frontend-helidon service.  This certificate will not be recognized by your browser and so a warning will be displayed.  It will be necessary to instruct the browser to trust this site in order to display frontend.  In a production implementation a certificate that is officially signed by a certificate authority should be used.
  
  ![](images/frontendhome.png " ")

The may now proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Dev Lead for Data and Transaction Processing, Oracle Microservices Platform, Helidon
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

## Need Help?  
Having an issue or found an error?  Click the question mark icon in the upper left corner to contact the LiveLabs team directly.
