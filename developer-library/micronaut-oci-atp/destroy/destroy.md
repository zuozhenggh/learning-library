# Cleaning Up Cloud Resources

## Introduction

This lab takes you through shutting down and destroying the resources created as part of the this lab including VMs and Autonomous Database Instances.

Estimated Lab Time: &lt;5&gt; minutes

### Objectives

In this lab you will:

* Use your Terraform Stack to tear down OCI resources

## Destroying 

To clean up all of the OCI resources created by Terraform at the start of this lab navigate perform the following steps:

1. Navigate to the Stack you created in the Oracle Cloud Console by going to "Resource Manager" -> "Stacks" and selecting your stack under "Stacks"

2. Under "Terraform Actions" select "Destroy" then click the "Destroy" button

![Destroy Stack](images/destroy_stack.png)

The Terraform automation will tear down the VMs and the Autonmous Database created as the start of this lab. 