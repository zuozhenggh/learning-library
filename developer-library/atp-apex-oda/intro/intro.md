# Oracle APEX and Digital Assistant

![Oracle](images/banner.png)

## Introduction to Conversational Approach to Your Applications

This workshop walks you through the steps to use **Autonomous Database** and **Application Express (APEX)** to store information, offer a **REST API** with **Oracle REST Data Services (ORDS)** and enable you to interact with your customers by keeping a conversation with **Digital Assistant**.

Estimated total workshop time 2 hours.

## Who Should Do This Workshop

You want to **store information in a easy and powerful database** and provide **a 24/7 conversational experience** with people using your services.

You want to **learn Oracle Digital Assistant**.

You are also interested in exploring modern and quick **APEX** development and build **secure and powerful REST APIs**.

## **Step 1**: Requirements

In order to walk through this workshop you need to develop the integration with **REST API**. You need [Node.js](https://nodejs.org/en/) for that.

Node.js is an asynchronous event-driven JavaScript runtime. **Node.js** is designed to build scalable network applications.

Additionally you need to be familiar with the use of **Command Prompt/Terminal** so we will show you briefly the way to use it for Windows users.

As a **Windows user** you need to type on the **Windows Search** Icon:

```
cmd
```

and select **Command Prompt**.

![Windows search Terminal](./images/cmd_1.png)

That will open the Command Prompt/Terminal so you are ready to go.

![Terminal](./images/cmd_2.png)

[Here you can find a basic guidance of commands that you can use on the terminal.](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)

Don't worry all the commands that we will need on the workshop are part of the code so you don't need to learn any additional one.

## **Step 2**: Node.js Installation

We are going to **install** Node.js, if you have done this you can skip this step.

![Node.js](./images/nodejs.png)

[Download Node.js LTS](https://nodejs.org/en/download/) from the official website. It is fine if the version is higher than the one in the screenshot.

![Node Download](./images/node_download.png)

1. We are going to install on **Windows** but it works in a similar way in **Linux** and **MacOS**.

    ![Node Install Start](./images/node_install_start.png)

    You can go with the default setup for the installation.

2. Final step, click **Install**:

    ![Node Install](./images/node_install.png)

3. Installation **completed**.

    ![Node Install End](./images/node_install_end.png)

4. The last step sometimes take a while on Windows because the lack of libraries, plus sometimes perform a Windows Update. Another reminder to swap to Linux ;) Be patient and carry on.

    ![Node Native Modules Installation](./images/node_native_module.png)

    Check if the installation went **well**. Open a Command Prompt, or Terminal in Linux and MacOS and run the following commands:

    ```bash
    node -v
    ```

    ```bash
    npm -v
    ```

    ```bash
    npx @oracle/bots-node-sdk -v
    ```

    Like this:

    ![Node Versions](./images/node_versions.png)

At this point, you are ready to start learning!

## **Acknowledgements**

- **Author** - Victor Martin - Principal Cloud Engineer - EMEA Oracle Digital, Priscila Iruela - Database Business Development - EMEA Oracle Digital
- **Contributors** - Melanie Ashworth-March - Master Principal Sales Consultant - EMEA Oracle Solution Center
- **Last Updated By/Date** - 

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.