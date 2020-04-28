* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:** {{Compartment}}

Note: Credentials can be accessed at any time by clicking on the icon at the top of the screen with the key on it.

# Binary Classification, an Employee Attrition Model

## Table of Contents

* [Working with Qloudable](#working-with-qloudable)
* [Overview](#overview)
* [Pre-requisites](#pre-requisites)
* [Open a notebook](#open-a-notebook)
* [Working with JupyterLab](#working-with-jupyterlab)
* [Binary Classification Model](#binary-classification-model)

## Working with Qloudable

* Chrome and Edge are the recommended browsers
* To make use of the limited screen space we recommend setting the browser zoom to 80%
* Mac OS Users should use Ctrl+C / Ctrl+V to copy and paste inside the OCI Console

## Overview

The Oracle Data Science Service is a fully managed, self-service platform for data science teams to build, train, and manage machine learning (ML) models in Oracle Cloud Infrastructure.

### The Data Science Service

* Provides infrastructure and data science tools, such as open source technologies, libraries, and packages for machine learning and artificial intelligence. It also offers Oracle ML products, such as Oracle Labs AutoML and model explanation tools.
* Provides data scientists with a collaborative and project-driven workspace that includes an end-to-end cohesive user experience and supports the lifecycle of predictive models.
* Helps data scientists concentrate on methodology and domain expertise to deliver more models to production in the Oracle Cloud Infrastructure.

### Data Science Concepts

Review the following concepts and terms to help you get started with Data Science.

**PROJECT**

Projects are collaborative workspaces for organizing and documenting Data Science assets such as notebook sessions and models.

**NOTEBOOK SESSION**

Data Science notebook sessions are interactive coding environments for building and training models. Notebook sessions come with many pre-installed open source and Oracle developed machine learning and data science packages.

**ACCELERATED DATA SCIENCE SDK**

The Oracle Accelerated Data Science (ADS) SDK is a Python library that is included as part of the Oracle Cloud Infrastructure Data Science service. ADS has many functions and objects that automate or simplify many of the steps in the Data Science workflow, including connecting to data, exploring and visualizing data, training a model with AutoML, evaluating models, and explaining models. In addition, ADS provides a simple interface to access the Data Science service model catalog and other Oracle Cloud Infrastructure services including Object Storage. To familiarize yourself with ADS, see the Accelerated Data Science Library.

**MODEL**

Models define a mathematical representation of your data and business processes. The model catalog is a place to store, track, share, and manage models.


## Pre-requisites

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training
1. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm
1. Familiarity with Oracle Accelerated Data Science SDX (ADS): https://docs.cloud.oracle.com/en-us/iaas/tools/ads-sdk/latest/index.html
1. Familiarity with JupyterLab: https://jupyterlab.readthedocs.io/
1. Familiarity with python: https://www.python.org/

## Open a notebook

### Sign in to OCI Console

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Enter your tenant name.
1. Sign in using your user name and password. Use the login option under **Oracle Cloud Infrastructure**
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="Login Screen">
1. Once you have successfully logged in, you will see the console home page.

### Configure Compartment

Your account has a root compartment and some compartments that are part of that. To access the notebook, you will need to select the compartment that has been assigned to you. The following instructions will help you do this.

1. Click on the OCI Services menu. This is the hamburger menu (3 horizontal lines) in the top left corner.
1. Scroll down the menu to Data Science. The menu will expand.
1. Click on Projects and Projects screen will open.
1. Note, you will not see any projects listed on the Projects page until you select your compartment.
1. On the left-hand side you will see a compartment. This is the root compartment. Click on the drop-down. If there is a + sign beside the compartment name, click the + sign to expand the list of compartments. A list of compartments will be presented.
1. Select your compartment: {{Compartment}}. If you have done this correctly, you will see a project listed under the Projects page.
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Data_Science_Service/img/compartment.png" alt="compartment">

### Opening the notebook

JupyterLab notebooks are grouped in projects. Now that the correct compartment is selected, the notebook can be accessed using the following steps.

1. From the Projects page, click on the project "initial-datascience-project-XXXX". This will take you to the Notebook Sessions page for that project.
1. Under the list of notebooks, you will see a notebook with a name like "initial-datascience-session-XXXX". Click on that link and Notebook Session Information page will open
1. Click on the button "Open" to launch the notebook. A new tab in the browser will open.
1. You may have to login again.

* **User Name:** {{User Name}}
* **Password:** {{Password}}

## Working with JupyterLab

Now that JupyterLab is open, it can be seen that the screen is split into two sections. By default, the left side has the file browser open but it can change based on what navigation icons are selected on the far left side of the screen. The right side of the screen contains the workspace. It will have a notebook, terminal, console, launcher, etc..

The size of the two sections can be adjusted by clicking on the bar between them and dragging it to the right or left. The left section of the screen can be collapsed by clicking on any menu item to the left so that it will toggle the component. To view it again, click on the icon. For example, click on the large file folder icon.

There is a menu across the top of the screen. For this lab, the most interesting menu item is "Run". It will allow you to execute the different code cells in the document. It is recommended that you manually execute the cells one at a time as you get to them. It is, generally important, that you execute them in order. To do this from the keyboard, press shift+enter in a cell and it will execute it and advance to the next cell. This same action can be done by clicking on Run then "Run Selected Cells".

## Binary Classification Model

To open the notebook, that will be used in this lab, have the file browser open. You should be at the top level of the file structure. You can tell this as you will see a folder called "ads-examples".

1. Double Click on the "ads-examples" folder. The directory will change. 
1. Look for the file ads_binary-classification-attrition.ipynb. You can click and drag the bar on the right side of the file browser to expand the window if you cannot see the file names completely.
1. Double click on the ads_binary-classification-attrition.ipynb. It will open in a new tab.
1. Read through the document. When you encounter a chunk of code, click in the cell and press shift+Enter to execute it. When the cell is running a [*] will appear in the top left of the cell. When it is finished, a number will appear in [ ].
1. Execute the cells in order. If you run into problems and want to start over again, click on "Kernel" then "Restart Kernel and Clear All Outputs..."
1. Step through the lab and look at the tools that are provided by Oracle Accelerated Data Science (ADS) SDK. This automates a number of time-consuming and repetitive processes by analyzing the data and creating appropriate outputs. Or you can run all of the cells by clicking on Run menu option then chose "Restart Kernel and Run All Cells"

**Congratulations! You have successfully completed the lab**

If you have time, there are some other notebooks that you may find interesting.

* ads_data_visualizations.ipynb: It provides a comprehensive overview of the data visualization tools in ADS. This includes smart data visualization for columns based on data types and values.
* ads_transforming_data-3.ipynb: Learn about the ADSDatasetFactory and how it can clean and transform data.
* ads_model_feature_1.ipynb: See the capabilities of the ADSModel class. See how ADSModel makes the ADS pipeline completely modular and adaptable to 3rd party models.

When you are done, you can close the lab by clicking on the x with a circle around it in the top right corner.
