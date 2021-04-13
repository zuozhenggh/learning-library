## MyToDoReact version 1.0.
Copyright (c) 2021 Oracle, Inc.

Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# Lab 3 -- Backend (Java/Helidon)

## **Summary**

As with most React applications (https://reactjs.org/), this todo application uses remote APIs to handle data persistence. The backend exposes 5 REST APIs including:
- 1) retrieving the current list of todo items
- 2) Adding a new todo item
- 3) finding a todo item by its id
- 4) updating an existing todo item
- 5) deleting a todo item.

![](images/Backend-APIs.png " ")

The backend is implemented using the following Java classes (under ./backend/src/...):   
- Main.java: starts and configure the main entry points.
- ToDoItem.java: maps a Todo Item instance to/from JSON  document
- ToDoItemStorage.java: storing the Todo item in a persistent storage using the Oracle database
- ToDoListAppService.java: implements the Helidon service and exposes the REST APIs

## **STEP 0**: Chmod all shell scripts

```
  <copy>chmod +x *.sh</copy>
```

## **STEP 1**: Build and push the Docker images

1. Set the environment variable "DOCKER_REGISTRY" to push the docker image to the OCI image registry.
 Example: <region-key>.ocir.io/<object-storage-namespace>/<firstname.lastname>/<repo-name>"
 If the variable is not set or set to an empty string the push will fail (but the docker image will be built).

2. Pick a database service alias from ./backend/target/classes/wallet/tnsnames.ora i.e., mtdrdb_tp

![](images/tnsnames-ora.png " ")

3. Edit ./backend/target/classes/application.yaml to set the database service and user password

   ![](images/application-yaml.png " ")


4. Copy the edited ./backend/target/classes/application.yaml to backend./src/main/resources/application.yaml

5. Run the `build.sh` script to build and push the
    microservices images into the repository

    ```
    <copy>cd $MTDRWORKSHOP_LOCATION/backend; ./build.sh</copy>
    ```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

  In a couple of minutes, you should have successfully built and pushed the images into the OCIR repository.

  ![](images/bdd2f05cfc0d1aac84b09dbe5b48993a.png " ")

6.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

7. Mark all the images as public (**Actions** > **Change to Public**):

  ![](images/71310f61e92f7c1167f2016bb17d67b0.png " ")


## **STEP 2**: Deploy on Kubernetes and Check the Status

1. Run the `deploy.sh` script

```
  <copy>cd $MTDRWORKSHOP_LOCATION/backend; ./deploy.sh</copy>
```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

2. kubectl create -f app.yaml
```
  <copy>kubectl create -f app.yaml</copy>
```

service/todolistapp-helidon-se-service created
deployment.apps/todolistapp-helidon-se-deployment created

3. Check the status using the following commands
$ kubectl get services
```
  <copy>kubectl get services</copy>
```

![](images/K8-service-Ext-IP.png " ")

Notice the External IP

4. $ kubectl get pods
```
  <copy>kubectl get pods</copy>
```
NAME                                                 READY   STATUS    RESTARTS   AGE
todolistapp-helidon-se-deployment-7fd6dcb778-c9dbv   1/1     Running   0          5m40s
todolistapp-helidon-se-deployment-7fd6dcb778-gjdfv   1/1     Running   0          5m39s

5. Continuously tailing the log of one of the pods

$ kubectl logs -f <pod name>
  Examaple kubectl lgs -f todolistapp-helidon-se-deployment-7fd6dcb778-c9dbv

  Returns:
  http://130.61.66.27/todolist

## **STEP 4**: Configure the API Gateway

1.

## **STEP 5**: UnDeploy
If the image has changed, delete the service and the pods by running undeploy.sh

1. Run the `undeploy.sh` script
```
  <copy>cd $MTDRWORKSHOP_LOCATION/backend; ./undeploy.sh</copy>
```
2. Rebuild the image + Deploy + (Re)Configure the API Gateway

## Acknowledgements
* **Workshop by** - Kuassi Mensah, Dir. Product Management, Java Database Access
* **Application by** - Jean de Lavarene, Sr. Director of Development, JDBC/UCP
* **Original scripts by** - Paul Parkinson, Developer Evangelist, Microservices

## Need Help?
Please submit feedback or ask for help using this [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/building-microservices-with-oracle-converged-database). Please login using your Oracle Sign On and click the **Ask A Question** button to the left.  You can include screenshots and attach files.  Communicate directly with the authors and support contacts.  Include the *lab* and *step* in your request.
