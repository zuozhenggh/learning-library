# Provision an Oracle Restart environment

## Introduction
Oracle Fleet Patching and provisioning can provision Grid Infrastructure software on remote targets using the command `rhpctl add workingcopy`.

Estimated lab time: 15 minutes

```
[grid@fpps01 ~]$ rhpctl add workingcopy -help GRIDHOMEPROV

Creates and configures a new cluster with Oracle Clusterware.

Usage: rhpctl add workingcopy -workingcopy <workingcopy_name>
        {-image <image_name> |
         -series <series_name>}
        {-root |
         -cred <cred_name> |
         -sudouser <sudo_user_name> -sudopath <sudo_binary_path> |
         -auth <plugin_name>
                [-arg1 <name1>:<value1>
                        [ -arg2 <name2>:<value2>...]]}
        [-setupssh] -responsefile <response_file>
        [-clusternodes <nodelist>]
        [-user <user_name> ]
        [-oraclebase <oraclebase_path>]
        [-path <where_path>]
        [-asmclientdata <data_path>]
        [-gnsclientdata <data_path>]
        [-clustermanifest <data_path>]
        [-agpath <read_write_path> -aupath <gold_image_path>]
        [-ignoreprereq |
         -fixup]
        [-schedule <timer_value>]
        [-scan <scan_name>]
        [-diskDiscoveryString <disk_discovery_string>]

    -workingcopy <workingcopy_name>        Name of the working copy to be created
    -image <image_name>                    Image name from the configured images
    -series <series_name>                  Image series from which the latest image will be taken when adding a working copy.
    -responsefile                          response file to be used to perform Oracle Grid Infrastructure provisioning
    -clusternodes <node_name>:<node_vip>[:<node_role>][,<node_name>:<node_vip>[:<node_role>]...]
                                           Comma-separated list of node information on which Oracle Clusterware will be provisioned
    -user <user_name>                      Name of the user for whom the software home is being provisioned
    -root                                  Use root credentials to access the remote node
    -sudouser <username>                   perform super user operations as sudo user name
    -sudopath <sudo_binary_path>           location of sudo binary
    -cred <cred_name>                      Credential name to associate the user/password credentials to access a remote node
    -auth <plugin_name> [<plugin_args>]    Use an authentication plugin to access the remote node
    -client <cluster_name>                 Client cluster name
    -oraclebase <oraclebase_path>          ORACLE_BASE path for provisioning Oracle database home or Oracle Grid Infrastructure home
    -path <path>                           The absolute path for provisioning software home (For database images, this will be the ORACLE_HOME)
    -ignoreprereq                          To ignore the CVU pre-requisite checks
    -fixup                                 Execute fixup script. Valid only for Grid Infrastructure provisioning.
    -setupssh                              sets up passwordless SSH user equivalence on the remote nodes for the provisioning user
    -asmclientdata <data_path>             File that contains the ASM client data
    -gnsclientdata <data_path>             File that contains the GNS client data
    -clustermanifest <data_path>           Location of Cluster Manifest File
    -agpath <read_write_path>              Read/write path for the persistent Oracle home path
    -aupath <gold_image_path>              Read-only gold image path for the persistent Oracle home path
    -schedule { <timer_value> | NOW }      Preferred time to execute the operation. If an absolute timer_value is specified, it should be in ISO-8601 format. For example: 2016-12-21T19:13:17+05. If offset is specified as the timer value, it should be in the format +dd:mm:yy:hh:mm:ss. For example: +02:22:22. If NOW is specified, job will be scheduled immediately.
    -scan <scan_name>                      SCAN name
    -diskDiscoveryString <disk_discovery_string>
                                           disk discovery string
```

### Software Only provisioning
If the target server already has a GI stack (either Oracle Restart or a full GI stack), then the new working copy is provisioned as Software Only: the existing stack is untouched.
In this case, once the new home is installed, the existing Grid Infrastructure stack can be patched or upgraded by using respectively `rhpctl move gihome` or `rhpctl upgrade gihome`. FPP automates all the steps, including the stop, move, rootupgrade and start of the Clusterware stack.

### New Cluster or Restart provisioning
If you need to provision the GI working copy on a brand new cluster, once the servers have been set up to host the cluster (this is a step that you need to take care of, either manually or using your favorite OS configuration management tool), all you need to do is to run `rhpctl add workingcopy` specifying the response file to be passed to gridSetup.sh.

### Objectives
In this lab, you will:
- Prepare the response file
- Provision the Restart environment on a new target using the response file
- Connect to the target and verify the restart environment


### Prerequisites
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
      - Lab: Generate SSH Keys (Free-tier and Paid Tenants only)
      - Lab: Create the environment with Resource Manager (Free-tier and Paid Tenants only)
      - Lab: Get the Public IP of the FPP Server (Livelabs Tenant only)
      - Lab: Get Acquainted with the Environment and the rhpctl Command line tool
      - Lab: Import Gold Images

## **Step 1:** Prepare the response file

1. On the FPP Server, prepare a response file containing the following content:

      ```
      # ~grid/fppc.rsp
      oracle.install.responseFileVersion=/oracle/install/rspfmt_crsinstall_response_schema_v19.0.0
      INVENTORY_LOCATION=/u01/app/oraInventory
      oracle.install.option=HA_CONFIG
      ORACLE_BASE=/u01/app/grid
      oracle.install.asm.OSDBA=dba
      oracle.install.asm.OSOPER=oper
      oracle.install.asm.OSASM=asmadmin
      oracle.install.asm.SYSASMPassword=WelcomeWelcome##123
      oracle.install.asm.diskGroup.name=DATA
      oracle.install.asm.diskGroup.redundancy=EXTERNAL
      oracle.install.asm.diskGroup.AUSize=4
      oracle.install.asm.diskGroup.disks=/dev/oracleasm/asm-disk1
      oracle.install.asm.diskGroup.diskDiscoveryString=/dev/oracleasm/*
      oracle.install.asm.monitorPassword=WelcomeWelcome##123
      ```

2. Alternatively, you can download it directly on the host:

      ```
      $ wget  https://github.com/lcaldara-oracle/learning-library/raw/master/data-management-library/database/fpp/03-gi-home/files/fppc.rsp
      ```

## **Step 2:** Provision the Restart environment on a new target using the response file
1. On the FPP Server, run the following command to provision and configure the GI home on the target. The password is `FPPll##123`. (Est. 8 minutes)

      ```
      $ rhpctl add workingcopy -workingcopy WC_gi_19_10_0_FPPC \
      -image gi_19_10_0_oci -responsefile ~/fppc.rsp \
      -path /u01/app/grid/WC_gi_19_10_0_FPPC -user oracle -oraclebase /u01/app/oracle \
      -targetnode fppc -sudouser opc -sudopath /bin/sudo -ignoreprereq

      Enter user "opc" password: FPPll##123
      fpps01.pub.fpplivelab.oraclevcn.com: Storing metadata in repository for working copy "WC_gi_19_10_0_FPPC" ...
      fpps01.pub.fpplivelab.oraclevcn.com: Creating snapshot "tmpgi_19_10_0_ociWC_gi_19_10_0_FPPC" ...
      fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user oracle...
      fpps01.pub.fpplivelab.oraclevcn.com: Copying software contents to Local File System ...
      fpps01.pub.fpplivelab.oraclevcn.com: Changing the home ownership to user oracle...
      fpps01.pub.fpplivelab.oraclevcn.com: Starting clone operation...
      fppc:
      fppc:
      fppc: [INFO] [INS-32183] Use of clone.pl is deprecated in this release. Clone operation is equivalent to performing a Software Only installation from the image.
      fppc: You must use /u01/app/grid/WC_gi_19_10_0_FPPC/gridSetup.sh script available to perform the Software Only install. For more details on image based installation, refer to help documentation.
      fppc:
      fppc: Starting Oracle Universal Installer...
      fppc:
      fppc: ..................................................   5% Done.
      fppc: ..................................................   10% Done.
      fppc: ..................................................   15% Done.
      fppc: ..................................................   20% Done.
      fppc: ..................................................   25% Done.
      fppc: ..................................................   30% Done.
      fppc: ..................................................   35% Done.
      fppc: ..................................................   40% Done.
      fppc: ..................................................   45% Done.
      fppc: ..................................................   50% Done.
      fppc: ..................................................   55% Done.
      fppc: ..................................................   60% Done.
      fppc: ..................................................   65% Done.
      fppc: ..................................................   70% Done.
      fppc: ..................................................   75% Done.
      fppc: ..................................................   80% Done.
      fppc: ..................................................   85% Done.
      fppc: ..........
      fppc: Copy files in progress.
      fppc:
      fppc: Copy files successful.
      fppc:
      fppc: Link binaries in progress.
      fppc: ..........
      fppc: Link binaries successful.
      fppc:
      fppc: Setup files in progress.
      fppc: ..........
      fppc: Setup files successful.
      fppc:
      fppc: Setup Inventory in progress.
      fppc:
      fppc: Setup Inventory successful.
      fppc: ..........
      fppc: Finish Setup successful.
      fppc: The cloning of WC_gi_19_10_0_FPPC was successful.
      fppc: Please check '/u01/app/oraInventory/logs/cloneActions2021-03-31_01-22-27PM.log' for more details.
      fppc:
      fppc: Setup Oracle Base in progress.
      fppc:
      fppc: Setup Oracle Base successful.
      fppc: ..................................................   95% Done.
      fppc:
      fppc: As a root user, execute the following script(s):
      fppc:   1. /u01/app/oraInventory/orainstRoot.sh
      fppc:   2. /u01/app/grid/WC_gi_19_10_0_FPPC/root.sh
      fppc:
      fppc:
      fppc:
      fppc: ..................................................   100% Done.
      fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed clone operation.
      fpps01.pub.fpplivelab.oraclevcn.com: Executing root script on nodes [fppc].
      fppc: Changing permissions of /u01/app/oraInventory.
      fppc: Adding read,write permissions for group.
      fppc: Removing read,write,execute permissions for world.
      fppc:
      fppc: Changing groupname of /u01/app/oraInventory to oinstall.
      fppc: The execution of the script is complete.
      fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed root script on nodes [fppc].
      fpps01.pub.fpplivelab.oraclevcn.com: Executing configuration script on nodes [fppc]
      fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed configuration script on nodes [fppc]
      fpps01.pub.fpplivelab.oraclevcn.com: Executing root script on nodes [fppc].
      fppc: Check /u01/app/grid/WC_gi_19_10_0_FPPC/install/root_fppc_2021-03-31_13-24-06-546102180.log for the output of root script
      fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed root script on nodes [fppc].
      fpps01.pub.fpplivelab.oraclevcn.com: Executing post configuration script on nodes [fppc]
      fpps01.pub.fpplivelab.oraclevcn.com: Successfully executed post configuration script on nodes fppc]
      fpps01.pub.fpplivelab.oraclevcn.com: Oracle home provisioned.
      fpps01.pub.fpplivelab.oraclevcn.com: Working copy creation completed.
      [grid@fpps01 ~]$
      ```

## **Step 3:** Connect to the target and verify the Restart Environment
1. From either the FPP Server or your SSH client, connect as `opc` to the FPP target public IP address and become `oracle`:

      ```
      $ ssh opc@fppc
      opc@fppc's password: FPPll##123
      Last login: Wed Mar 31 13:23:58 2021
      [opc@fppc ~]$ sudo su - oracle
      Last login: Wed Mar 31 13:27:56 GMT 2021
      [oracle@fppc ~]$
      ```

2. Set the environment.

      ```
      $ . oraenv
      ORACLE_SID = [oracle] ?
      ORACLE_HOME = [/home/oracle] ? /u01/app/grid/WC_gi_19_10_0_FPPC
      The Oracle base has been set to /u01/app/oracle
      ```

3. Verify that Restart is up and running:

      ```
      $ crsctl stat res -t
      --------------------------------------------------------------------------------
      Name           Target  State        Server                   State details
      --------------------------------------------------------------------------------
      Local Resources
      --------------------------------------------------------------------------------
      ora.DATA.dg
                  ONLINE  ONLINE       fppc                     STABLE
      ora.LISTENER.lsnr
                  ONLINE  ONLINE       fppc                     STABLE
      ora.asm
                  ONLINE  ONLINE       fppc                     Started,STABLE
      ora.ons
                  OFFLINE OFFLINE      fppc                     STABLE
      --------------------------------------------------------------------------------
      Cluster Resources
      --------------------------------------------------------------------------------
      ora.cssd
            1        ONLINE  ONLINE       fppc                     STABLE
      ora.diskmon
            1        OFFLINE OFFLINE                               STABLE
      ora.evmd
            1        ONLINE  ONLINE       fppc                     STABLE
      --------------------------------------------------------------------------------
      [oracle@fppc ~]$
      ```

Congratulations! You have successfully configured an Oracle Restart environment with a single command. Easy, huh? You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Ludovico Caldara
- **Contributors** - Kamryn Vinson
- **Last Updated By/Date** -  Kamryn Vinson, April 2021