# Setup

## Introduction

In this lab, we will provision and setup the resources to execute microservices in your tenancy.  

Estimated Time: 25 minutes

### Objectives

* Clone the setup and microservices code
* Execute setup

### Prerequisites

- This workshop assumes you have an Oracle cloud account and have signed in to the account.

## Task 1: Provision 2 ATP 21c PDBs

Cloud Shell is a small virtual machine running a "bash" shell which you access through the Oracle Cloud Console. Cloud Shell comes with a pre-authenticated command line interface in the tenancy region. It also provides up-to-date tools and utilities.

1. Click the Cloud Shell icon in the top-right corner of the Console.

  ![Open Cloud Shell](images/open-cloud-shell.png " ")

  NOTE: Cloud Shell uses websockets to communicate between your browser and the service. If your browser has websockets disabled or uses a corporate proxy that has websockets disabled you will see an error message ("An unexpected error occurred") when attempting to start Cloud Shell from the console. You also can change the browser cookies settings for a specific site to allow the traffic from *.oracle.com


## Task 2: Launch Cloud Shell and Make a Clone of the Workshop Source Code in your home directory

Cloud Shell is a small virtual machine running a "bash" shell which you access through the Oracle Cloud Console. Cloud Shell comes with a pre-authenticated command line interface in the tenancy region. It also provides up-to-date tools and utilities.

1. Click the Cloud Shell icon in the top-right corner of the Console.

  ![Open Cloud Shell](images/open-cloud-shell.png " ")

  NOTE: Cloud Shell uses websockets to communicate between your browser and the service. If your browser has websockets disabled or uses a corporate proxy that has websockets disabled you will see an error message ("An unexpected error occurred") when attempting to start Cloud Shell from the console. You also can change the browser cookies settings for a specific site to allow the traffic from *.oracle.com

2. Clone from the GitHub repository using the following command.  

    ```
    <copy>git clone -b 22.1.3 --single-branch https://github.com/oracle/microservices-datadriven.git
    </copy>
    ```

   You should now see the directory `microservices-datadriven` in the home directory.

3. Run the following command to edit your .bashrc file so that you will return to the workshop directory when you connect to cloud shell in the future and also to include the Java 11 (GraalVM) in the path.

    ```
    <copy>
    echo "cd ~/microservices-datadriven/travelbooking" >>~/.bashrc
    echo "export JAVA_HOME=~/graalvm-ce-java11-20.1.0" >>~/.bashrc
    echo "export PATH=$JAVA_HOME/bin:$PATH" >>~/.bashrc
    source ~/.bashrc
    </copy>
    ```

## Task 3: Create DB Links Between the ATP PDBs and Setup Oracle Database Saga Infrastructure

Cloud Shell is a small virtual machine running a "bash" shell which you access through the Oracle Cloud Console. Cloud Shell comes with a pre-authenticated command line interface in the tenancy region. It also provides up-to-date tools and utilities.

1. Click the Cloud Shell icon in the top-right corner of the Console.


You may now **proceed to the next lab.**.

## Acknowledgements

* **Authors** - Paul Parkinson, Architect and Developer Advocate
* **Last Updated By/Date** - Paul Parkinson, December 2021
