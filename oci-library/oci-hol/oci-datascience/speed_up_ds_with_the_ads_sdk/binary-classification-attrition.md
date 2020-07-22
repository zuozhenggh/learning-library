# Binary Classification Model [TODO]

## Selecting the Compartment

Your account has a root compartment and some compartments that are part of it. To access the notebook, you will need to select the compartment that has been assigned to you. The following instructions will help you do this.

1. Click on the OCI Services menu. This is the hamburger menu (3 horizontal lines) in the top left corner.
2. Scroll down the menu to Data Science. The menu will expand.
3. Click on Projects. The Projects screen will open.
4. Note, you will not see any projects listed on the Projects page until you select your compartment.
5. On the left-hand side you will see a compartment drop-down. Click on this.
6. In the compartment drop-down you will see the root compartment with a + sign. Click on the + sign and the list of choices will expand.
7. Select your compartment. If you have done this correctly, you will see a project listed under the Projects page.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Data_Science_Service/img/compartment.png" alt="image-alt-text">

## Opening the Notebook

JupyterLab notebooks are grouped into projects. Now that the correct compartment is selected, the notebook can be accessed using the following steps.

1. From the Projects page, click on the project "initial-datascience-project-XXXX". This will take you to the Notebook Sessions page for that project.
2. Under the list of notebooks, you will see a notebook with a name like "initial-datascience-session-XXXX". Click on that link and Notebook Session Information page will open
3. Click on the button "Open" to launch the notebook. A new tab in the browser will open.
4. You may have to login again.

## Working with JupyterLab

Now that JupyterLab is open, it can be seen that the screen is split into two sections. By default, the left side has the file browser open but it can change based on what navigation icons are selected on the far left side of the screen. The right side of the screen contains the workspace. It will have a notebook, terminal, console, launcher, Notebook Examples, etc..

Click on the file folder icon just below the JupyterLab logo on the left most section to close and open the file browser section. It can be closed as it is not needed for this lab.

There is a menu across the top of the screen. For this lab, the most interesting menu item is *Run*. It will allow you to execute the different code cells in the document. It is recommended that you manually execute the cells one at a time as you get to them. It is, generally important, that you execute them in order. To do this from the keyboard, press shift+enter in a cell and it will execute it and advance to the next cell. Alternatively, you can run all of the cells at once. To do this, click on Run then "Run Selected Cells".

## Binary Classification Model

To open the notebook, that will be used in this lab, have the launcher open. It will be open by default but if it got closed it can be accessed with *File*->*New Launcher*. 

1. Click on the *Notebook Examples*. A drop down will appear.
2. Select for *binary-classification-attrition.ipynb*. 
3. Click on the *Load Example*. It will open in a new tab.
4. Read through the document. When you encounter a chunk of code, click in the cell and press shift+Enter to execute it. When the cell is running a [*] will appear in the top left of the cell. When it is finished, a number will appear in [ ], for example [1].
5. Execute the cells in order. If you run into problems and want to start over again, click on *Kernel* then *Restart Kernel and Clear All Outputs...*
6. Step through the lab and look at the tools that are provided by Oracle Accelerated Data Science (ADS) SDK. This automates a number of time-consuming and repetitive processes by analyzing the data and creating appropriate outputs.

## Next Steps

**Congratulations! You have successfully completed the lab**

If you have time, there are some other notebooks that you may find interesting. They can be accessed by selecting *File*->*New Launcher* and then clicking on the *Notebook Examples*.

* **data_visualizations.ipynb**: It provides a comprehensive overview of the data visualization tools in ADS. This includes smart data visualization for columns based on data types and values.
* **transforming_data.ipynb**: Learn about the ADSDatasetFactory and how it can clean and transform data.
* **model_from_other_library.ipynb**: See the capabilities of the ADSModel class. See how ADSModel makes the ADS pipeline completely modular and adaptable to 3rd party models.

When you are done, you can close the lab by clicking on the "Finish Lab" button.
