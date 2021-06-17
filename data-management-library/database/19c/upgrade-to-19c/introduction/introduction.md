# Upgrade to 19c Hands-On-Lab (HOL) #

TODO: New menu without Lab 5

## Workshop Overview ##

**19c Database** is the current version that Oracle promotes to customers and partners as the version to upgrade to. Oracle 19c is the long term support version and will be supported for at least 4 years after the initial release. After this, Extended support and Sustaining support will be available.

This hands-on workshop focuses on **Upgrading your environment to 19c** demonstrating 3 scenarios that you can use (both on-premise and in the cloud) to upgrade your environment to 19c in a Container/Multitenant setup.

## Workshop Requirements

- A provisioned LiveLabs Environment
    - On the Attendee Page, you should see the Remote Desktop or NoVNC URL

The labs have been setup to work with the Remote Desktop or NoVNC environment using a HTML5 compatible browser. Most proxy systems will work with this setup.

If you want to run (parts) of the workshop using a direct SSH connection, you need to have direct access to the Internet or a proxy that supports tunneling.

## Agenda

- **Lab 0 :** Verify the environment

This lab introduces the student lab environment and contains the steps to setup the student desktop for connecting to the lab virtual machine.

- **Lab 1 :** Install 19c software and create a new 19c database

We need a 19c database and listener as target for our remaining labs. Also, creating a new 19c Oracle Home and Database has changed since Oracle 12.2. This lab demonstrates how to create a new 19c software home and create a database using this home.

- **Lab 2 :** Upgrade using the new AutoUpgrade tool

The Auto Upgrade tool is a wrapper around the regular upgrade steps and scripts. But the configuration fail is easy to setup and allows multiple databases to be upgraded at the same time while still keeping track of the status. If things go wrong, you can rollback the upgrade or restart the upgrade after you have solved the blocking issue.

- **Lab 3 :** Upgrade using Full Transportable Tablespaces

Instead of upgrading your database using scripts, you can simply migrate the tablespaces containing your data to a new version. The FTTS demonstrates Learn to perform exploratory data analysis of database-resident data and apply best practice techniques to prepare the data for machine learning. This hands-on lab highlights the OML4py Transparency Layer, and demonstrates that many familiar Python functions automatically translate to SQL and run inside the database for optimal performance and execution.

- **Lab 4 :** Upgrade using unplugging a PDB from the old version and plug it into a new version

One of the nice new features of Multitenancy is to simply unplug and plug a Pluggable Database into a new version. In 19c, you still need to run upgrade scripts so this lab demonstrates what is needed to upgrade using this option.

## Access the labs

- Use **Lab Contents** menu on the left side of the screen to access the labs.
    - If the menu is not displayed, click the menu button ![](./images/menu-button.png) on the top left to make it visible.

- From the menu, click on the lab that you like to proceed with. For example, if you like to proceed to **Lab 0**, click **Lab 0: Verify the environment**.

![](./images/menu.png "")

- You may close the menu by clicking ![](./images/menu-close.png "")

## Acknowledgements ##

- **Author** - Robert Pastijn, Database Product Management, PTS EMEA - April 2020
- **Updated** - Adopted to Livelabs - Robert Pastijn - June 2021
