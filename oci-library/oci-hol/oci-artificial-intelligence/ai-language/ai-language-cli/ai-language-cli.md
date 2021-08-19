# Lab 2: Access OCI Language with OCI CLI

## Introduction

OCI Language can be called from the OCI Command Line Interface (CLI).

In this lab session, we will show several code snippets to access our service with CLI.

You do not need to execute those codes, but review them to understand what information and steps are needed to implement your own integration.

*Estimated Lab Time*: 10 minutes

### Objectives:

* Learn how to use CLI to communicate with our language service endpoints.

### Prerequisites:
* Familiar with Python programming is required
* Have a Python environment ready in local
* Familiar with local editing tools, vi and nano
* Installed with Python libraries: `oci` and `requests`

## CLI Setup

The CLI is a small-footprint tool that you can use on its own or with the Console to complete Oracle Cloud Infrastructure tasks. The CLI provides the same core functionality as the Console, plus additional commands. Some of these, such as the ability to run scripts, extend Console functionality.



## **TASK 1:** Navigate to the Cloud Shell

### 1: Navigate to Cloud Shell

Log into OCI Cloud Console. Navigate to Cloud Shell Icon on the top right and click it.
![](./images/cloudShellIcon.png " ")

### 2: Enter Language CLI Command

Enter any one of the Language Pre-Deployed CLI commands you want to execute.

![](./images/cloudShellCommand.png " ")
Below is the command for Language Detection used in the above image:
```
<copy>oci ai language detect-language --text "Zoom interface is really simple and easy to use. The learning curve is very short thanks to the interface. It is very easy to share the Zoom link to join the video conference. Screen sharing quality is just ok. Zoom now claims to have 300 million meeting participants per day. It chose Oracle Corporation co-founded by Larry Ellison and headquartered in Redwood Shores , for its cloud infrastructure deployments over the likes of Amazon, Microsoft, Google, and even IBM to build an enterprise grade experience for its product. The security feature is significantly lacking as it allows people to zoom bomb"</copy>
```

### 2: View Result

The Language service displays the results as shown below:
![](./images/clousShellResult.png " ")



<!-- ## **TASK 3:**To Install CLI in your Local
To install and use the CLI, follow [CLI](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)


For information about using the CLI, see [Command Line Interface (CLI)](https://docs.oracle.com/iaas/Content/API/Concepts/cliconcepts.htm#Command_Line_Interface_CLI).
For a complete list of flags and options available for CLI commands, see the [Command Line Reference](https://docs.oracle.com/iaas/tools/oci-cli/latest/oci_cli_docs/). -->


## **TASK 2:** Try issuing some of the OCI Language commands

### 1. Language Detection
```
<copy>oci ai language detect-language --text, -? | -h | --help
```
### 2. Named Entity Recognition
```
<copy>oci ai language detect-entities --text, -? | -h | --help, --is-pii
```
### 3. Key Phrase Extraction
```
<copy>oci ai language detect-key-phrases --text, -? | -h | --help
```
### 4. Aspect-Based Sentiment Analysis
```
<copy>oci ai language detect-sentiments --text, -? | -h | --help
```
### 5. Text Classification
```
<copy>oci ai language detect-text-classification --text, -? | -h | --help
```


To know more about CLI, follow [CLI](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)

Congratulations on completing this lab!

[Proceed to the next section](#next).


