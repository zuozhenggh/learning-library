# Setup for Local Development

## Introduction

In this lab you are going to get create a Micronaut application locally and configure the application to communicate with an Autonomous Database instance.

If at any point you run into trouble completing the steps, the full source code for the application can be cloned from Github using the following command:

    <copy>
    git clone https://github.com/graemerocher/micronaut-hol-example.git
    </copy>

Estimated Lab Time: 5 minutes

### Objectives

In this lab you will:

* Create a new Micronaut application
* Configure the Micronaut application to connect to Autonomous database

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account

## **STEP 1**: Create a new Micronaut application

1. There are several ways you can get started creating a new Micronaut application. If you have the Micronaut CLI installed (see the [Installation instructions](https://micronaut-projects.github.io/micronaut-starter/latest/guide/#installation) for how to install) you can use the `mn` command to create a new application. Which will setup an application that uses the Oracle driver and Micronaut Data JDBC.


    ```
    <copy>
      mn create-app example-atp --features oracle,data-jdbc
    cd example-atp
    </copy>
    ```


Note: By default Micronaut will use the [Gradle](https://gradle.org/) build tool, however you can add `--build maven` if you prefer Maven.

2. If you do not have the Micronaut CLI installed and are running on Linux or OS X you can alternatively `curl` and `unzip`:

    ```
    <copy>
    curl https://launch.micronaut.io/example-atp.zip\?features\=oracle,data-jdbc -o example-atp.zip
    unzip example-atp.zip -d example-atp
    cd example-atp
    </copy>
    ```

3. If none of these options are viable you can also navigate to [Micronaut Launch](https://micronaut.io/launch/) in a browser and click the `Features` button and select the `oracle` and `data-jdbc` features then click `Generate` which will produce a zip you can download and unzip.

## **STEP 2**: Configure the Micronaut Application

1. The final step to configure the Micronaut application to work with Autonomous Database is to open the `src/main/resources/application.yml` file and modify the default datasource connection settings as follows:

    ```yaml
    <copy>
    datasources:
      default:
        url: jdbc:oracle:thin:@mnociatp_high
        driverClassName: oracle.jdbc.OracleDriver
        username: mnocidemo
        dialect: ORACLE
    </copy>    
    ```
2. Delete the existing `src/main/resources/application-test.yml` file so that you can run tests against the Autonomous database instance.

    ```
    <copy>
    $ rm src/main/resources/application-test.yml
    </copy>
    ```

3. To configure the datasource password you should set an environment variable named `DATASOURCES_DEFAULT_PASSWORD` to the output value `atp_schema_password` produced by the Terraform script in the previous section.

It is recommended to never hard code passwords in configuration so using an environment variable is the preferred approach.

In addition you should also set an environment variable called `TNS_ADMIN` to the location of your wallet created in Step 2.

For example:

   ```
   <copy>
   export TNS_ADMIN=[Your absolute path to wallet]
   export DATASOURCES_DEFAULT_PASSWORD=[Your atp_schema_password]
   </copy>
   ```

You may now *proceed to the next lab*.

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
