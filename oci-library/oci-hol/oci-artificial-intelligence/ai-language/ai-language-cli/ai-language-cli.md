# Lab 2: Access AI Language Service with OCI CLI

## Introduction

Our language services also support to use CLI tool.

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

## Python CLI Setup

The CLI is a small-footprint tool that you can use on its own or with the Console to complete Oracle Cloud Infrastructure tasks. The CLI provides the same core functionality as the Console, plus additional commands. Some of these, such as the ability to run scripts, extend Console functionality.



### **TASK 1:** Install CLI

To install and use the CLI, follow [CLI](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)


### **TASK 2:** AI Language Service Pre-Deployed CLI Command

```Python
oci ai language detect-language --text, -? | -h | --help
 
 
oci ai language detect-entities --text, -? | -h | --help, --is-pii
 
 
oci ai language detect-key-phrases --text, -? | -h | --help
 
 
oci ai language detect-sentiments --text, -? | -h | --help
 
 
oci ai language detect-text-classification --text, -? | -h | --help
```

For information about using the CLI, see [Command Line Interface (CLI)](https://docs.oracle.com/iaas/Content/API/Concepts/cliconcepts.htm#Command_Line_Interface_CLI).
For a complete list of flags and options available for CLI commands, see the [Command Line Reference](https://docs.oracle.com/iaas/tools/oci-cli/latest/oci_cli_docs/).


Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Rajat Chawla  - Oracle AI Services
    * Ankit Tyagi -  Oracle AI Services
* **Last Updated By/Date**
    * Rajat Chawla  - Oracle AI Services, July 2021
