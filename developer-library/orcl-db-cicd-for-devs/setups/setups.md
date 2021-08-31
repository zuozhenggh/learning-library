# Oracle Database CI/CD for Developers: Setups

## Introduction

This part of the lab will guide you through some setup items that have to be performed before we can start the lab.

Estimated Lab Time: 20 minutes

### Objectives

- Create a Compartment
- Create an Autonomous Database
- Create a Notification Topic
- Create a DevOps Project and Repository

### Prerequisites

- You have completed [Lab 1, Clone and Create a Github Repository](../repo/repo.md).

## Task 1: Create a Compartment

We are going to create a **Compartment** for this lab so that our database is in a specific compartment for this LiveLab and can also be easily found and used for additional LiveLabs.

1. To create a compartment, use the OCI web console drop down menu and select **Identity & Security**, then **Compartments**.

    ![Use OCI menu for compartments](./images/comp-1.png)

2. On the Compartments page, click the **Create Compartment** button.

    ![Create Compartment Button](./images/comp-2.png)

3. Using the **Create Compartment** modal, set the following values:

    **Name:** livelabs

    ````
    <copy>
    livelabs
    </copy>
    ````

    ![Create Compartment Name Field](./images/comp-3.png)

    **Description:** livelabs

    ````
    <copy>
    livelabs
    </copy>
    ````
    ![Create Compartment Name Field](./images/comp-4.png)

    **Parent Compartment:** Use the root compartment (Should be auto-selected, your root compartment will be named different, but will have (root) after it)

    ![Create Compartment Parent Compartment Field](./images/comp-5.png)

4. When your Create Compartment modal looks like the following image (root compartment name will be different but have (root) after the name), click the **Create Compartment** button.

    ![Create Compartment Modal](./images/comp-6.png)

## Task 2: Create an Autonomous Database

1. Use the OCI web console drop down menu to go to **Oracle Database** and then **Autonomous Database**.

    ![ADB from the menu](./images/adb-1.png)

2. On the Autonomous Database page, change your compartment to the livelabs compartment using the **Compartment** dropdown on the left side of the page.

    ![ADB compartment dropdown](./images/adb-2.png)

3. With the livelabs compartment selected, click the **Create Autonomous Database** button on the top of the page.

    ![Create Autonomous Database button](./images/adb-3.png)


4. In the **Create Autonomous Database** page, we start in the **Provide basic information for the Autonomous Database** section. Here we can ensure our **Compartment** is **livelabs** and give our database a **Display Name**. We can use **ORDS ADB** as the Display Name.

    **Display Name:** ORDS ADB

    ````
    <copy>
    ORDS ADB
    </copy>
    ````
    ![Display Name Field](./images/adb-4.png)

    For the **Database Name**, we can use **ORDSADB**.

      **Database Name:** ORDSADB

    ````
    <copy>
    ORDSADB
    </copy>
    ````
    ![Display Name Field](./images/adb-5.png)  

    The **Provide basic information for the Autonomous Database** section should look like the following image:

   ![Provide basic information for the Autonomous Database section](./images/adb-6.png)  

5. For Database **Workload Type**, choose **Transaction Processing**.

   ![Database Workload](./images/adb-7.png)  

6. In the **Deployment Type** section, choose **Shared Infrastructure** if not already selected for you.

   ![Deployment Type](./images/adb-8.png)  

7. Next we have the **Configure the database** section. Start here by clicking the **Always Free** toggle button so that it is switched to the right side as seen in the following image.

   ![Always Free toggle button](./images/adb-9.png)  

8. Use the **Choose database version** dropdown to choose **21c** as the database version.

   ![Choose database version dropdown](./images/adb-10.png)

9. Your **Configure the database** section should look like the following image.

   ![Complete Configure the database section](./images/adb-11.png)

10. The next section is **Create administrator credentials**. Here, provide a password that conforms to the password complexity rules of:

    ```
    Password must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number.
    The password cannot contain the double quote (") character or the username "admin".
    ```

    If the password does conform to these rules and matches in both fields, the section should look like the following image.

   ![admin password section](./images/adb-12.png)

11. For the **Choose network access** section, select **Secure access from everywhere** if not already selected. Leave the **Configure access control rules** checkbox unchecked.

   ![admin password section](./images/adb-13.png)

12. The **Choose a license type** section should default to **License Included**.

   ![Choose a license type section](./images/adb-14.png)

13. When the **Create Autonomous Database** is completely filled out, click the **Create Autonomous Database** button on the bottom left of the page.

   ![Create Autonomous Database button](./images/adb-15.png)

14. Your Autonomous Database should be done creating in just a few short minutes. 

## Task 3: Create a Notification Topic

1. Use the OCI web console drop down menu to go to **Developer Services** and then **Notifications**.

    ![Notifications from the menu](./images/note-1.png)

2. On the Notifications page, change your compartment to the **livelabs** compartment using the **Compartment** dropdown on the left side of the page.

    ![Notifications compartment dropdown](./images/note-2.png)

3. With the livelabs compartment selected, click the **Create Topic** button on the top of the page.

    ![Create topic button](./images/note-3.png)

4. Using the **Create Topic** slider,

    ![Create Topic Slider](./images/note-4.png)

   set the Name to **devopsTopic**.

     **Name:** devopsTopic

    ````
    <copy>
    devopsTopic
    </copy>
    ````

   ![Name field](./images/note-5.png)  

5. Next, click the **Create** button on the bottom of the slider.

   ![Create topic button](./images/note-6.png)  

## Task 4: Create a DevOps Project and Repository

1. Use the OCI web console drop down menu to go to **Developer Services** and then **DevOps**.

    ![DevOps from the menu](./images/devops-1.png)

2. On the DevOps Projects page, change your compartment to the **livelabs** compartment using the **Compartment** dropdown on the left side of the page.

    ![DevOps compartment dropdown](./images/devops-2.png)

3. With the livelabs compartment selected, click the **Create DevOps Project** button in the **Welcome to DevOps Projects** banner on the top of the page.

    ![Create Autonomous Database button](./images/devops-3.png)

4. Using the **Create New DevOps Project** slider,

    ![Create devops Slider](./images/devops-4.png)

   set the Project name to **cicdProject**.

     **Project Name:** cicdProject

    ````
    <copy>
    cicdProject
    </copy>
    ````

   ![Project Name field](./images/devops-5.png)

5. While still in the **Create New DevOps Project** slider, click the **Select Topic** button.

   ![Select Topic button](./images/devops-6.png)

6. Using the **Select Topic** slider, 

   ![Select Topic slider](./images/devops-7.png)

   keep the **Create using topic name** radio button selected

   ![Create using topic name radio button](./images/devops-8.png)

   ensure the **Compartment select list** is set top **livelabs**

   ![compartment select list](./images/devops-9.png)

   and the **Topic select list** is set to **devopsTopic**
   
   ![Topic select list](./images/devops-10.png)

7. Now click the **Select Topic button** on the bottom of the **Select Topic** slider.

   ![Select Topic button](./images/devops-11.png)

8. Back on the **Create New DevOps Project** slider, with the **Project Name** and **Topic** selected, click the **Create DevOps Project** button.

   ![Create DevOps Project** button](./images/devops-12.png)

## Conclusion

In this lab you created a Compartment and an Autonomous Database.

## Acknowledgements

- **Authors** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Brian Spendolini, August 2021