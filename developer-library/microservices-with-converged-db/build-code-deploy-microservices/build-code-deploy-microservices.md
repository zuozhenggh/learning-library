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

## **STEP 1**: Build frontend Helidon microservice

1.  You need to compile, test and package the Helidon frontend
    application code into a `.jar` file using maven. The maven package is already installed in the
    Cloud Shell.

    Inside Cloud Shell go to the frontend Helidon microservice
    folder.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/frontend-helidon</copy>
    ```

2.  Run `maven` to build the package using the following command. Since this is
    the first time maven is executed, nothing is cached, thus it will first
    download all the necessary libraries and bundles.

    ```
    <copy>mvn clean install</copy>
    ```

  The build should be completed in 1-2 minutes, and a target folder with the related Java files is created.

  ![](images/2826286b95e74bd51237859bd7d3d891.png " ")

3. Execute the following command to investigate the target folder.

    ```
    <copy>ls -al target/</copy>
    ```

  ![](images/a88b7e437c7a46e3b9878adb62942107.png " ")



## **STEP 2**: Set values for workshop in the environment

1. Run `./setJaegerAddress.sh` and verify successful outcome.

 It may be necessary to run this script multiple times if the Jaeger load balancer has not been provisioned yet.

   ```
   <copy>./setJaegerAddress.sh</copy>
   ```


2. Run `./addAndSourcePropertiesInBashrc.sh`

   ```
   <copy>./addAndSourcePropertiesInBashrc.sh</copy>
   ```

3. Source the edited `.bashrc` file with the following command.

   ```
      <copy>source ~/.bashrc</copy>
   ```
      ![](images/185c88da326994bb858a01f37d7fb3e0.png " ")


## **STEP 3**: Build and push the Docker image and access the frontEnd UI microservice

1.  You are ready to build a docker image of the frontend Helidon application.
    Change directory into `/frontend-helidon` folder:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/frontend-helidon</copy>
    ```

  ![](images/418a175c8093375d4264d6cd5897ead9.png " ")

2.  Run the build script which will build the frontend-helidon application, store it in a docker image and push it to Oracle Registry

    ```
    <copy>./build.sh</copy>
    ```

  ![](images/807b7c494dab6ccb6864c60344ca7e0e.png " ")

  After a couple of minutes, the image should have been successfully pushed into the repository.

  ![](images/cb413dce71ae945decf19e468a94a89e.png " ")

3.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

4. You should see the newly created image in the list. If you don't see it, click the refresh icon in the upper right corner of the Create Repository pane. Click the repository with the new image.

  ![](images/b4a27ed98282369ffa60e48e6cea591b.png " ")

5.  To simplify the usage of this image - and to avoid the need to do `docker login` in
    the deployment yaml file or git CI/CD - we will change the image from Private
    to Public, by clicking **Actions > Change to Public**.

  ![](images/3df6ee1cf8469d3277b107b4aca6efab.png " ")

  ![](images/62015eda55591496a1becfe11063fac5.png " ")

6.  Go back to the Cloud Shell and run the deploy script from the same directory
    as build. This will create a new pod and service for this image in the OKE
    cluster `msdataworkshop` namespace:

    ```
    <copy>./deploy.sh</copy>
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

  `http://<external-IP>:8080`

  ![](images/frontendhome.png " ")

10. Run the `build.sh` script to build and push the rest of the
    microservices images into the repository

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION ; ./build.sh</copy>
    ```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

  In a couple of minutes, you should have successfully built and pushed all the images into the OCIR repository.

  ![](images/bdd2f05cfc0d1aac84b09dbe5b48993a.png " ")

11.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

12. Mark all the images as public (**Actions** > **Change to Public**), just as you did previously for the frontend image:

  ![](images/71310f61e92f7c1167f2016bb17d67b0.png " ")

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Dev Lead for Data and Transaction Processing, Oracle Microservices Platform, Helidon
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
