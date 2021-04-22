### Lab 4: Train and Deploy an AD Model and Detect

## Introduction
## Create a Model
* Select the proper data asset
* Set training parameters
* Train a model
Once the project livelabs_demo is selected, it will navigate the User to Created Anomaly Detection Project. Select Create and Train Model
![](../images/5_create_a_new_model.png " ")

Select Next
![](../images/create_a_new_data_asset.png " ")

Now that we have a data asset to train a model, let train an anomaly detection model. Since we have a Data Asset now, navigate back to the Create and Train a model screen
![](../images/5_create_a_new_model.png " ")

This time, the data asset previously created should show up on the default panel. Select Next
![](../images/choose_an_existing_dataset.png " ")

This takes us to train a model menu. Among options like naming the model and providing description which are option since they relate to housekeeping we also have an option to specify FAP(false accuracy probability) and Train Fraction Ratio. The default values for these are 0.01 and 0.7 implying 70% respectively.

The default value 0.01 is very less so in order to save on the training time, we will dial up the FAP to 0.05. The training fraction ratio can be left as it is.
![](../images/create_and_train_model.png " ")

Select Submit. If the steps till now are done right, we should see the following screen.
![](../images/model_creation.png " ")

### Deploy a Model
* Once we have verified that our model is successfully created now it is time to deploy our model. To initiate the process, click on the model you desire to deploy. It will direct you to the model deployment form
![](../images/add_deployment.png " ")

* Click on Add Deployment.
![](../images/add_deployment_form.png " ")

* Press Submit button. Once the deployment is successful, the model is ready to be used for detecting anomalies.
![](../images/detect_anomalies.png " ")

### Detect Anomaly with new Data
* Upload to UI
* See result in graph
* Download anomaly file
