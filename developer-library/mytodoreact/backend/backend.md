# Backend

## Introduction

In this lab, you will deploy the pre-built Helidon Java backend Docker image to OKE, then configure the API Gateway.

Estimated time: 25-minutes

### Understanding the Java/backend application

As with most React applications (https://reactjs.org/), this application uses remote APIs to handle data persistence. The backend implements 5 REST APIs including:
- Retrieving the current list of todo items
- Adding a new todo item
- Finding a todo item by its id
- Updating an existing todo item
- Deleting a todo item.

The APIs are documented using Swagger @ http://130.61.67.158:8780/swagger-ui/#/

The backend is implemented using the following Java classes (under ./backend/src/...):   
- Main.java: starts and configure the main entry points.
- ToDoItem.java: maps a Todo Item instance to/from JSON  document
- ToDoItemStorage.java: stores the Todo item in a persistent store i.e., the Oracle Autonomous database
- ToDoListAppService.java: implements the Helidon service and exposes the REST APIs

  ![](images/Backend-APIs.png " ")


### Objectives

* Set values for environment variables
* Build and deploy the Docker image of the application
* Deploy the image on the Oracle Kubernetes Engine (OKE)
* Describe the steps for Undeploying
* Configure the API Gateway
* Test the backend application

### Prerequisites

- This lab requires the completion of lab 1 and the provision of the OCI components.


## Task 1: Set values for workshop environment variables

1. Set the root directory of the workshop
	```
	<copy>export MTDRWORKSHOP_LOCATION=~/mtdrworkshop</copy>
	```
2. Run source addAndSourcePropertiesInBashrc.sh

	The following command will set the values of environment variables in mtdrworkshop.properties and source ~/.bashrc

	```
	<copy>cd $MTDRWORKSHOP_LOCATION; source addAndSourcePropertiesInBashrc.sh</copy>
	```

## Task 2: Build and push the Docker images to the OCI Registry

1. Ensure that the "DOCKER_REGISTRY" variable is set

 Example: `<region-key>.ocir.io/<object-storage-namespace>/<firstname.lastname>/<repo-name>`
 If the variable is not set or is an empty string, the push will fail (but the docker image will be built).

2. Make sure to be in backend/target/classes/wallet directory then execute
	
      ```
	   <copy>unzip ~/mtdrworkshop/setup-dev-environment/wallet.zip</copy>
	   ```

3. Pick mtdrb_tp service alias (see the list of aliases in
   ./backend/target/classes/wallet/tnsnames.ora)

   ![](images/tnsnames-ora.png " ")

4. Edit ./backend/target/classes/application.yaml to set the database service and user password
  ![](images/application-yaml.png " ")

5. Copy the edited ./backend/target/classes/application.yaml to ./backend/src/main/resources/application.yaml

6. Edit ./backend/src/main/java/com/oracle/todoapp/Main.java
    - Locate the following code fragment
    ![](images/CORS-Main.png " ")
    - Replace `eu-frankfurt-1` in  `"https://objectstorage.eu-frankfurt-1.oraclecloud.com"` by your region

    - Save the file

7. Run `build.sh` script to build and push the
    microservices images into the repository

    ```
    <copy>cd $MTDRWORKSHOP_LOCATION/backend; ./build.sh</copy>
    ```
  In a couple of minutes, you should have successfully built and pushed the images into the OCIR repository.

8. Check your container registry from the root compartment
    - Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

    ![](images/21-dev-services-registry.png " ")

   ![](images/Registry-root-compart.png " ")

9. Mark Access as Public  (if Private)  
   (**Actions** > **Change to Public**):

   ![](images/Public-access.png " ")

## Task 3: Deploy on Kubernetes and Check the Status

1. Run the `deploy.sh` script

	```
	<copy>cd $MTDRWORKSHOP_LOCATION/backend; ./deploy.sh</copy>
	```

   ![](images/deploy-sh.png " ")

2. Check the status using the following commands:

	The following command returns the Kubernetes service of MyToDo application with a load balancer exposed through an external API
	```
	<copy>kubectl get services</copy>
	```

	![](images/K8-service-Ext-IP.png " ")

3. $ kubectl get pods
	```
	<copy>kubectl get pods</copy>
	```

	![](images/k8-pods.png " ")

4. Continuously tailing the log of one of the pods

  $ kubectl logs -f <pod name>
  Example kubectl lgs -f todolistapp-helidon-se-deployment-7fd6dcb778-c9dbv

  Returns:
  http://130.61.66.27/todolist

## Task 4: UnDeploy (optional)

  If you make changes to the image, you need to delete the service and the pods by running undeploy.sh then redo Steps 2 & 3.

1. Run the `undeploy.sh` script
	```
		<copy>cd $MTDRWORKSHOP_LOCATION/backend; ./undeploy.sh</copy>
	```

   ![](images/deploy-sh.png " ")

2. Rebuild the image + Deploy + (Re)Configure the API Gateway


## Task 5: Configure the API Gateway

The API Gateway protects any RESTful service running on Container Engine for Kubernetes, Compute, or other endpoints through policy enforcement, metrics and logging.
Rather than exposing the Helidon service directly, we will use the API Gateway to define cross-origin resource sharing (CORS).

1. From the hamburger menu navigate to **Developer Services** > **Gateways**
   ![](images/gateways.png " ")

2. Select **Create Gateway**
   ![](images/click-create-gateway.png " ")

2. Configure the basic info: name, compartment, VCN and Subnet
    - VCN: pick one of the virtual circuit networks
    - Subnet pick the public subnet   
	
	Then click "Create".
   ![](images/create-gateway.png " ")

3. The todolist gateway was successfully created.
    ![](images/gateway.png " ")

4. Click on Deployments
   ![](images/deployment-menu.png " ")

5. Click **Create Deployment**
   ![](images/deployment.png " ")

6. Configure Cross-origin resource sharing (CORS) policies.
	- CORS is a security mechanism that will prevent running application loaded from origin A  from using resources from another origin B.
	- Allowed Origins: is the list of all servers (origins) that are allowed to access the API deployment typically your Kubernetes cluster IP.
	- Allowed methods: GET, PUT, DELETE, POST, OPTIONS are all needed.
		
	![](images/Origins-Methods.png " ")

7. Configure the Headers
    ![](images/Headers.png " ")

8. Configure the routes: we will define two routes:
    - /todolist for the first two APIs: GET, POST and OPTIONS
    ![](images/Route-1.png " ")

    - /todolist/{id} for the remaining three APIs: (GET, PUT and DELETE)
	![](images/Route-2.png " ")


## Task 6: Testing the backend application through the API Gateway

1. Navigate to the newly created Gateway Deployment Detail and copy the endpoint
   ![](images/gateway-endpoint.png " ")

2. Testing through the API Gateway endpoint
  postfix the gateway endpoint with "/todolist" as shown in the image below
   ![](images/Backend-Testing.png " ")

  It should display the Todo Item(s) in the TodoItem table. At least the row you have created in Lab 1.

Congratulations, you have completed lab 2; you may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** -  - Kuassi Mensah, Dir. Product Management, Java Database Access
* **Contributors** - Jean de Lavarene, Sr. Director of Development, JDBC/UCP
* **Last Updated By/Date** - Kamryn Vinson, July 2021
