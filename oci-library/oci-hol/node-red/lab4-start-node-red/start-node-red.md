# Installing Node-RED

## Setting Prerequisites

In order to install Node-RED, a few other tools need to be installed first.
* Node.js
* Git
* the grunt-cli npm module installed globally

## Installing Node.js

First, we need to install Node.js. Make sure you are connected to the compute instance via SSH. To configure the Node.js and the Oracle Instant Client repository:
`sudo yum install -y oracle-nodejs-release-el7 oracle-release-el7`
To install the latest Node.js:
`sudo yum install nodejs`

## Installing Git

Git is required in order to clone the latest Node-RED repository. To install Git run:
`sudo yum install git`

## Install grunt-cli

To install the grunt-cli module globally:
`sudo npm install -g grunt-cli`

## Install Node-RED

### Clone the source repository
Now it is time to install Node-RED. Start by cloning the Node-RED source repository from Github:
`git clone https://github.com/node-red/node-red.git`

This will create a`node-red` directory. Change into the `node-red` directory and continue with the next step.

### Install the dependencies

Next we want to install any dependencies. 
`npm install`

### Building Node-RED
Finally, we can build the application. To build Node-RED:
`grunt build`

You are done with the installation of Node-RED. Before we run Node-RED, we want to first update the Network Security List in OCI and the `iptables` of the OAL installatio. Continue with the next lab.

