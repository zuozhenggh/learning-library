# Fixing the issue in code
## Before You Begin
### Introduction

Welcome to the Automated Code Inspection workshop. This workshop will walk you through application lifecycle management with embedded code review using SonarQube. It will showcase how SonarQube can save time and improve code quality directly inside the agile development process.

### Objectives

- Run the job to see the new analysis in SonarQube.
- Create issue in Developer Cloud Service
- Fix the issue in code
- Close issue in Developer Cloud Service.

### Required Artifacts

For this lab you will need Oracle Cloud account and Developer Cloud service instance.

## **STEP 1**: Check for the Issue in SonarQube

1. Continuing the previous lab, go to the issues page in sonarQube, for this workshop we will solve the issue type **Bug**.

    ![](./300/1.png)

2. As you can see there are two issues shown under bug category with severity Critical and Major.

    ![](./300/2.png)

3. Click on the first issue and check for the error message. As you see the error message, you can select the type of issue, severity, whether the issue is solved or still open, who is it assign to and how many minutes it might take to fix the issue.

    ![](./300/3.png)

## **STEP 2**: Create issue in Visual Builder Studio

1. We will generate new issue based on the error messagee seen in the previous step. Click on **Issues** in the left panel and then click on **Create Issue**.

    ![](./300/4.png)

2. Fill out the form as shown in the below image.
    ```
    <copy>
    Summary: Solve bug in TwitterService.java
    Description: Error on line 86
    Owner: Set to Your Name
    </copy>
    ```

    ![](./300/LabGuide300-adf2be32.png)

3. We will generate another issue. Fill out the form as shown in the below image.
    ```
    <copy>
    Summary: Solve bug in SampleStreamExample.java
    Description: Error on line 114
    Owner: Set to Your Name
    </copy>
    ```

    ![](./300/Lab300_bug.png)

## **STEP 3**: Edit Code in Visual Builder Studio Git Repo

1. Click on **Git** in left panel to see the code repository.

    ![](./300/6.png)

2. Go to the file SampleStreamExample.java , path as shown in following image and  click on pencil icon to edit.
    ![](./300/7.png)

3. Go to line 114 and add word **throw** before the line.

    ![](./300/8.png)

4. Repeat the process and go to file TwitterService.java, path as shown in following image and click on pencil icon to edit.

    ![](./300/9.png)

5. Go to line 86 and remove **return**.
Reason of error: Using return, break, throw, and so on from a finally block suppresses the propagation of any unhandled Throwable which was thrown in the try or catch block.

    ![](./300/10.png)

## **STEP 4**: Check the SonarQube for Issue Fix

1. With the job already configured to run automatically on commit, go to SonarQube server dashboard. And you can see there are zero bugs shown.

    ![](./300/11.png)

2. To confirm open issues page and click on bug.

    ![](./300/12.png)

## **STEP 5**: Close the Issue in Developer Cloud Service

1. Go back to Developer cloud service and click on **Issues** in left panel.

    ![](./300/13-1.png)

2. Select the issue and then click on **Update Selected**

    ![](./300/13.png)

3. In the form check the **Status** and select **Resolved**. Also check **Resolution** and select **Fixed** from dropdown. Click **Next** when finished.

    ![](./300/14.png)

    ![](./300/15.png)

4. Click **Save** to close the issue.

    ![](./300/LabGuide300-3814f43a.png)

 **You are now ready to move to the next lab: Lab 4: Deploy Microservice to Cloud**

## Acknowledgements

- **Authors/Contributors** - Varun Yadav
- **Last Updated By/Date** - October 21, 2021
- **Workshop Expiration Date** - October 15, 2021

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 