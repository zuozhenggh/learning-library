d#Lab 3: Train Anomaly Detection Model And Detect

## Introduction

In this session, we will show you how to train an anomaly detection model, deploy the model, and make predictions with new data.

***Estimated Lab Time***: 30 minutes

### Objectives

In this lab, you will:
- Learn to train an anomaly detection model with created data asset
- Learn to verify the trained model performance
- Learn to deploy the model to be ready
- Upload testing data to check detection result

### Prerequisites
- A Free tier or paid tenancy account in OCI
- Understand basic model terminology FAP - False Alarm Probability
- Tenancy is whitelisted to be able to use Anomaly Detection service


## **STEP 1:** Create a Model
* Select the proper data asset
* Set training parameters
* Train a model

Select the compartment. In this lab, we will select a prebuilt compartment DS-PROJECT
![](../images/selectCompartmentModelTrain.png " ")

Once the project livelabs_demo is selected, it will navigate the User to Created Anomaly Detection Project. Select Create and Train Model
![](../images/5_create_a_new_model.png " ")

The data asset created in lab 2 should be pop up in the drop down menu. Click Next
![](../images/choose_an_existing_dataset.png " ")

This takes us to train a model menu. We can specify FAP(false alarm probability) and Train Fraction Ratio. The default values for these are 0.01 and 0.7 (implying 70%) respectively.

###FAP(False Alarm Probability)
FAP stands for False Alarm Probability. In other words, this basically specifies how much accurate the model needs to be. A high FAP model means the likelihood of an anomaly flagged by AD service to be a false alarm is high. If this is not desired, depending on the sensitivity requirements of a user, they can specify it to be low. One thing to keep in mind is by specifying a lower FAP, the model needs more time to train.

### How to calculate FAP
![](../images/fap.png " ")
As can be inferred from the formula, the more the number of false alarms higher the FAP will be.

###Train Fraction Ratio
Train Fraction Ratio specifies to the model on how much of the data to use for training. So the default value 0.7 or 70% specifies the model to use 70% of the data for training.

The default value for FAP is 0.01 which requires a long training time to achieve. In order to reduce the training time the FAP is increased to 0.05. The training fraction ratio can be left as it is.
![](../images/create_and_train_model.png " ")

Select Submit. Typically it takes 5 minutes to train a model.
![](../images/model_creation.png " ")

## **STEP 2:** Deploy a Model
* Once we have verified that our model is successfully created now it is time to deploy our model. To initiate the process, click on the model you desire to deploy. It will direct you to the model deployment form
![](../images/add_deployment.png " ")

* Click on Add Deployment.
![](../images/add_deployment_form.png " ")

* Press Submit button. Once the deployment is successful, the model is ready to be used for detecting anomalies.
![](../images/detect_anomalies.png " ")

## **STEP 3:** Detect Anomaly with new Data

* Upload to UI
To start the  process of anomaly detection select "Detect Anomalies".
![](../images/ud1.png " ")

Select a file from local filesystem or drag and drop the desired file.
![](../images/ud2.png " ")

Now press detect.

* See result in graph
Once the test file is submitted, you have the option to select the column to see anomalies for.
![](../images/select_column.png " ")

Use the drop wizard to select column. The columns for which the model has detected anomalies will be labelled as such.
![](../images/select_column_drop.png " ")

 Lets select temperature_3 to see where the model has detected an anomaly.
 ![](../images/graph.png " ")

The part of the signal where the model has determined to be an anomaly is highlighted. There is also an option to download the anomaly detection result.

* Download anomaly file
 ![](../images/graph_highlighted.png " ")

This will download a file named anomalies.json Lets peek at the contents
 ```json
 {
  "anomalies": {
    "temperature_2": [
      {
        "timestamp": "2019-01-07T21:24:10.000+00:00",
        "estimatedValue": -0.8288514355093327,
        "actualValue": -0.9668546827677871
      },
      {
        "timestamp": "2019-01-07T21:25:09.000+00:00",
        "estimatedValue": -0.9642025580122765,
        "actualValue": -0.5951845543726701
      },
      {
        "timestamp": "2019-01-07T21:26:02.000+00:00",
        "estimatedValue": -0.635414659734792,
        "actualValue": -1.1004140146576293
      },
      {
        "timestamp": "2019-01-07T21:27:02.000+00:00",
        "estimatedValue": -1.1405350452695593,
        "actualValue": -1.0437079075522782
      },
      {
        "timestamp": "2019-01-07T21:28:10.000+00:00",
        "estimatedValue": -1.2140615757417812,
        "actualValue": -0.7588250424377889
      },
      {
        "timestamp": "2019-01-07T21:29:06.000+00:00",
        "estimatedValue": -1.1934684762843635,
        "actualValue": -0.6622950856002755
      },
      {
        "timestamp": "2019-01-07T21:30:09.000+00:00",
        "estimatedValue": -2.478276741703271,
        "actualValue": -2.86873032051319
      },
      {
        "timestamp": "2019-01-07T21:31:07.000+00:00",
        "estimatedValue": -1.1170899307186755,
        "actualValue": -2.9787643449781758
      },
      {
        "timestamp": "2019-01-07T21:54:02.000+00:00",
        "estimatedValue": -0.46913836454294355,
        "actualValue": -0.1818702987807544
      },
      {
        "timestamp": "2019-01-07T21:55:04.000+00:00",
        "estimatedValue": -0.60856976303723,
        "actualValue": 0.1349151809026957
      },
      {
        "timestamp": "2019-01-07T21:56:03.000+00:00",
        "estimatedValue": -0.3250998768833654,
        "actualValue": 0.16483956815126233
      },
      {
        "timestamp": "2019-01-07T21:57:03.000+00:00",
        "estimatedValue": -0.4169997956503889,
        "actualValue": -0.09141636894896348
      },
      {
        "timestamp": "2019-01-07T21:58:05.000+00:00",
        "estimatedValue": 0.5415503864711468,
        "actualValue": 0.05849590414812823
      },
      {
        "timestamp": "2019-01-07T21:59:03.000+00:00",
        "estimatedValue": 0.36794552695738736,
        "actualValue": 0.047311577628485355
      },
      {
        "timestamp": "2019-01-07T22:00:03.000+00:00",
        "estimatedValue": -0.33220940600932025,
        "actualValue": 0.07145888335246428
      },
      {
        "timestamp": "2019-01-07T22:01:03.000+00:00",
        "estimatedValue": 0.6060950893420104,
        "actualValue": 3.029309810148419
      },
      {
        "timestamp": "2019-01-07T22:02:04.000+00:00",
        "estimatedValue": 1.1532551181553785,
        "actualValue": 3.038691195904264
      }
    ],
    "temperature_3": [
      {
        "timestamp": "2019-01-07T21:25:09.000Z",
        "estimatedValue": -0.9175015397548474,
        "actualValue": -0.7286121501292225
      },
      {
        "timestamp": "2019-01-07T21:26:02.000Z",
        "estimatedValue": -0.5754824915124053,
        "actualValue": -0.8715973770672041
      },
      {
        "timestamp": "2019-01-07T21:27:02.000Z",
        "estimatedValue": -1.0289944554417314,
        "actualValue": -0.6537624059306748
      },
      {
        "timestamp": "2019-01-07T21:28:10.000Z",
        "estimatedValue": -1.0422368082693483,
        "actualValue": -0.7941492028804823
      },
      {
        "timestamp": "2019-01-07T21:29:06.000Z",
        "estimatedValue": -1.1427163364020252,
        "actualValue": -0.8713350176048646
      },
      {
        "timestamp": "2019-01-07T21:30:09.000Z",
        "estimatedValue": -2.2806596377913646,
        "actualValue": -2.969391704072731
      },
      {
        "timestamp": "2019-01-07T21:31:07.000Z",
        "estimatedValue": -0.9000745817442789,
        "actualValue": -2.8692496787296853
      },
      {
        "timestamp": "2019-01-07T21:54:02.000Z",
        "estimatedValue": -0.3138576614296879,
        "actualValue": -0.1306604163645831
      },
      {
        "timestamp": "2019-01-07T21:55:04.000Z",
        "estimatedValue": -0.522372957424641,
        "actualValue": -0.24356808593710755
      },
      {
        "timestamp": "2019-01-07T21:56:03.000Z",
        "estimatedValue": -0.27749106072173313,
        "actualValue": -0.23763427036555224
      },
      {
        "timestamp": "2019-01-07T21:57:03.000Z",
        "estimatedValue": -0.26381393788163565,
        "actualValue": -0.3350101010434371
      },
      {
        "timestamp": "2019-01-07T21:58:05.000Z",
        "estimatedValue": 0.653165803208419,
        "actualValue": -0.11342634283328369
      },
      {
        "timestamp": "2019-01-07T21:59:03.000Z",
        "estimatedValue": 0.4835100766325686,
        "actualValue": 0.009396930473847816
      },
      {
        "timestamp": "2019-01-07T22:00:03.000Z",
        "estimatedValue": -0.18709759915034652,
        "actualValue": 0.14430348115098618
      },
      {
        "timestamp": "2019-01-07T22:01:03.000Z",
        "estimatedValue": 0.7319274991768412,
        "actualValue": 2.9807631561178547
      },
      {
        "timestamp": "2019-01-07T22:02:04.000Z",
        "estimatedValue": 1.3548717653499107,
        "actualValue": 3.049010279530258
      }
    ],
    "pressure_2": [
      {
        "timestamp": "2019-01-07T22:04:03.000+00:00",
        "estimatedValue": 0.5014895636573994,
        "actualValue": 1.6334379720706242
      },
      {
        "timestamp": "2019-01-07T22:05:07.000+00:00",
        "estimatedValue": -0.5285874553725212,
        "actualValue": 1.4661385443962462
      },
      {
        "timestamp": "2019-01-07T22:06:05.000+00:00",
        "estimatedValue": -1.1663263985024896,
        "actualValue": 0.0490478171262037
      },
      {
        "timestamp": "2019-01-07T22:07:06.000+00:00",
        "estimatedValue": -2.347703439766677,
        "actualValue": -3.1899739406153196
      },
      {
        "timestamp": "2019-01-07T22:08:08.000+00:00",
        "estimatedValue": -0.7656199601914135,
        "actualValue": -0.7961303437489068
      },
      {
        "timestamp": "2019-01-07T22:09:10.000+00:00",
        "estimatedValue": -1.0094694332480365,
        "actualValue": 0.6997339833791824
      },
      {
        "timestamp": "2019-01-07T22:10:05.000+00:00",
        "estimatedValue": -0.8479968141427298,
        "actualValue": -0.8644751237229334
      },
      {
        "timestamp": "2019-01-07T22:11:03.000+00:00",
        "estimatedValue": 2.6883284144255497,
        "actualValue": 9.637427929543756
      },
      {
        "timestamp": "2019-01-07T22:12:02.000+00:00",
        "estimatedValue": 2.7912052622700343,
        "actualValue": 8.636504808483837
      },
      {
        "timestamp": "2019-01-07T22:13:05.000+00:00",
        "estimatedValue": 3.201928431223891,
        "actualValue": 7.592321707893466
      }
    ]
  }
}
 ```

We see that the results for all the anomalies are within their own key. And each value is a further a tuple that contains the timestamp, actual value and what the model expects the value to be.

In the results pay attention to the  difference between the estimatedValue and actualValue. Generally some error is expected but in this particular values are what the AD service deemed to be anomalous.

Congratulations on completing this lab!

You now have completed the full cycle of using the training data to create a model and deploy, and also making predictions with testing data.

The next 2 sessions are optional for advanced users, which cover the topic on using REST API to integrate our services and how to prepare the training and testing data from raw data in different scenarios.

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
* **Last Updated By/Date**
    * Haad Khan - Senior Data Scientist, May 2021
