# Import Gold Images

## Introduction
Oracle Fleet Patching and Provisioning stores Oracle Home images into its ACFS filesystems.
You can build your images with the required release updates and one-off patches and import them into FPP. From there, you can provision the same image everywhere in your server fleet: this ensure that all your Oracle Homes are standard and compliant with your patching requirements.

## Step 1: Import the local FPP Homes as Gold Images
Import the Oracle Homes that are already installed and configured on the FPP Server as new gold images.

First, the Grid Infrastructure image: (Est.: 5 minutes)
```
[grid@fpps01 ~]$ rhpctl import image -image gi_19_10_0_oci -path /u01/app/19.0.0.0/grid -imagetype ORACLEGISOFTWARE
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 4
fpps01.pub.fpplivelab.oraclevcn.com: Creating a new ACFS file system for image "gi_19_10_0_oci" ...
fpps01.pub.fpplivelab.oraclevcn.com: Copying files...
fpps01.pub.fpplivelab.oraclevcn.com: Copying home contents...
fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user grid...
fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user grid...
[grid@fpps01 ~]$ date
```
Notice the `-imagetype ORACLEGISOFTWARE` that tells FPP which image it is about to import

Then, the Oracle Database image: (Est.: 4-5 minutes)
```
[grid@fpps01 ~]$ rhpctl import image -image db_19_10_0_oci -path /u01/app/oracle/product/19.0.0.0/dbhome_1
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 5
fpps01.pub.fpplivelab.oraclevcn.com: Creating a new ACFS file system for image "db_19_10_0_oci" ...
fpps01.pub.fpplivelab.oraclevcn.com: Copying files...
fpps01.pub.fpplivelab.oraclevcn.com: Copying home contents...
fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user oracle...
fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user grid...
[grid@fpps01 ~]$
```
The image type `ORACLEDBSOFTWARE` is the default, so you do not need to specify it.

## Step 2: Import an additional DB Home from a zip file
First, download the zip file from this location (Est.: 3 minutes):
```
[grid@fpps01 ~]$ wget --no-proxy https://objectstorage.us-phoenix-1.oraclecloud.com/p/0m155SXnm5so7gqYVlJPiJqsJrWQyivsRqsJSIw-5vjrnD2MwQNRGPewmRKhYaYt/n/oracassandra/b/ludovico.caldara/o/13727/db19300.zip
```

Then, import it: (Est.: 7-8 minutes)
```
[grid@fpps01 ~]$ rhpctl import image -image db_19_9_0 -zip $PWD/db19300.zip
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 6
fpps01.pub.fpplivelab.oraclevcn.com: Creating a new ACFS file system for image "db_19_9_0" ...
fpps01.pub.fpplivelab.oraclevcn.com: Extracting files to directory /rhp_storage/images/idb_19_9_0600988/swhome...
fpps01.pub.fpplivelab.oraclevcn.com: Files successfully extracted
fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user grid...
fpps01.pub.fpplivelab.oraclevcn.com: Starting clone operation...
========================================
fpps01.pub.fpplivelab.oraclevcn.com:
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LANG = "en_US.UTF-16"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
[INFO] [INS-32183] Use of clone.pl is deprecated in this release. Clone operation is equivalent to performing a Software Only installation from the image.
You must use /rhp_storage/images/idb_19_9_0600988/swhome/runInstaller script available to perform the Software Only install. For more details on image based installation, refer to help documentation.
Starting Oracle Universal Installer...
You can find the log of this install session at:
 /u01/app/oraInventory/logs/cloneActions2021-03-30_10-17-40AM.log
..................................................   5% Done.
..................................................   10% Done.
..................................................   15% Done.
..................................................   20% Done.
..................................................   25% Done.
..................................................   30% Done.
..................................................   35% Done.
..................................................   40% Done.
..................................................   45% Done.
..................................................   50% Done.
..................................................   55% Done.
..................................................   60% Done.
..................................................   65% Done.
..................................................   70% Done.
..................................................   75% Done.
..................................................   80% Done.
..................................................   85% Done.
..........
Copy files in progress.
Copy files successful.

Link binaries in progress.
..........
Link binaries successful.

Setup files in progress.
..........
Setup files successful.

Setup Inventory in progress.
Setup Inventory successful.
..........
Finish Setup successful.
The cloning of onnbeefb3qdpa9fl was successful.
Please check '/u01/app/oraInventory/logs/cloneActions2021-03-30_10-17-40AM.log' for more details.

Setup Oracle Base in progress.
Setup Oracle Base successful.
..................................................   95% Done.

As a root user, execute the following script(s):
        1. /rhp_storage/images/idb_19_9_0600988/swhome/root.sh

Execute /rhp_storage/images/idb_19_9_0600988/swhome/root.sh on the following nodes:
[fpps01]


..................................................   100% Done.
fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed clone operation.
fpps01.pub.fpplivelab.oraclevcn.com: Executing detach home operation...
========================================
fpps01.pub.fpplivelab.oraclevcn.com:
Starting Oracle Universal Installer...

Checking swap space: must be greater than 500 MB.   Actual 16027 MB    Passed
The inventory pointer is located at /etc/oraInst.loc
You can find the log of this install session at:
 /u01/app/oraInventory/logs/DetachHome2021-03-30_10-19-53AM.log
'DetachHome' was successful.
fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed detach home operation.
```

We have already patched it for you with the DB 19.9.0 Release Update, so you do not have to do it yourself. However, in real life this is a task that you would have to do.

Because it comes from a non-verified source, FPP will uncompress the image and verify it by configuring it and relinking it.
This is an extra step to make sure that the image is usable and can be provisioned as working copy on the remote targets without problem. This, however, require 2-3 additional minutes.

## Step 3: Query the Gold Images
Once the images have been imported into the FPP Server, you can query them:

```
[grid@fpps01 ~]$ rhpctl query image
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 7
Image name: gi_19_10_0_oci
Image name: db_19_10_0_oci
Image name: db_19_9_0
[grid@fpps01 ~]$
```

Get the detail of a specific image:
```
[grid@fpps01 ~]$ rhpctl query image -image db_19_9_0
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 8
Image name: db_19_9_0
Owner: grid@dbSysaoe2qhga
Site: dbSysaoe2qhga
Access control: USER:grid@dbSysaoe2qhga
Access control: ROLE:OTHER
Access control: ROLE:GH_IMG_PUBLISH
Access control: ROLE:GH_IMG_ADMIN
Access control: ROLE:GH_IMG_VISIBILITY
Parent Image:
Software home path: /rhp_storage/images/idb_19_9_0600988/.ACFS/snaps/idb_19_9_0/swhome
Image state: PUBLISHED
Image size: 8285 Megabytes
Image Type: ORACLEDBSOFTWARE
Image Version: 19.0.0.0.0:19.9.0.0.0
Groups configured in the image: OSDBA=dba,OSOPER=oper,OSBACKUP=backupdba,OSDG=dgdba,OSKM=kmdba,OSRAC=racdba
Image platform: Linux_AMD64
Interim patches installed: 31772784,31771877
Contains a non-rolling patch: FALSE
Complete: TRUE
[grid@fpps01 ~]$
```

You have successfully imported the gold images int the FPP Server. You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Ludovico Caldara
- **Contributors** -
- **Last Updated By/Date** -  Ludovico Caldara, April 2021
