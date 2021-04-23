# Prerequisites

In order to complete the following labs you might need to install some of the following tools, if you don't already have them installed on your local machine.

## Objectives
* Install SQL Developer.
* Install Visual Studio Code.

**Note**: Only if you are going to run the code locally, you should also:
* Install NodeJS.
* Install OracleJET Tools.
* Install Oracle Instant Client.

## Installing SQL Developer

Go to [oracle.com](https://www.oracle.com/tools/downloads/sqldev-downloads.html) and download the proper package for your operating system. It is recommended that you choose the version with the JDK included. You might need to login using an Oracle account in order to start downloading the installation files.

## Installing Visual Studio Code

Go to [visualstudio.com](https://code.visualstudio.com/Download) and download the proper package for your operating system. Install Visual Studio Code according to the steps in the installation window.

## [Optional] Installing NodeJS

Go to [nodejs.org](https://nodejs.org/en/download/) and download the proper package for your operating system. Install it according to the steps in the installation window.

## [Optional] Installing OracleJET Tools

After installing **NodeJS** open a command line window and run the following command. You might need administration rights to run them.
```
<copy>
npm install -g @oracle/ojet-cli
</copy>
```
## [Optional] Installing Oracle Instant Client
Go to [oracle.com](https://www.oracle.com/database/technologies/instant-client/downloads.html) and download the proper package for your operating system. Create a new folder for it (for example _C:\\oracle_). Extract the downloaded archive and copy the contents into this folder. Now, if you navigate to _C:\\oracle\\instantclient\_19\_9_ you should be able to see a _network\\admin_ folder. This is the folder in which you would need to copy the wallet files to connect to the database. If you don't have these two folders, you need to create them.

You should also add _C:\\oracle\\instantclient_19_9_ in your environment variables.

More information about Instant Client can be found [here](https://www.oracle.com/database/technologies/instant-client/).

## Acknowledgements
**Authors/Contributors** - Giurgiteanu Maria Alexandra, Gheorghe Teodora Sabina, Paraschiv Laura, Digori Gheorghe
