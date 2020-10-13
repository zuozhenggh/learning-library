## **Installing STAR-CCM+**

## Adding specific libraries

***If you used the CFD Ready Cluster from marketplace, this step is not needed***

There are a couple of library that need to be added to the Oracle Linux image on all the compute nodes.

```
    sudo yum -y install libSM libX11 libXext libXt
```

## Download the binaries

You can download the STAR-CCM+ installer from the Siemens PLM website or push it to your machine using scp.

```
    scp /path/own/machine/STAR-CCM_version.zip opc@1.1.1.1:/home/opc/
```

Another possibility is to upload the installer into object storage.

1. In the main menu of the console, select Object Storage.
2. Choose the correct region on the top right
3. Select the correct compartment on the left-hand side
4. Create a bucket if you do not have one already created
5. In the bucket, select upload object and specify the path of the installer.
6. Select the 3 dots on the right-hand side of the installer object and select Create Pre-Authenticated Request
7. If you lose the URL, you cannot get it back, but you can regenerate a new Pre-Authenticated Request

Download the installer form object storage with

```
    wget PAR_URL
```

Untar or unzip the installer depending on your version
```
    tar -xf installer.tgz
    unzip installer.tgz
```
## Install

Launch the installer on a shared location. By default, an HPC cluster has a NFS-share mounted on all the compute nodes.

```
    mkdir /mnt/nfs-share/install
    /path/installscript.sh -i silent -DINSTALLDIR=/mnt/nfs-share/install/
```

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.